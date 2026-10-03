#include "common.h"
#include "resource.h"

#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <shlobj.h>

#include <mmsystem.h>
#include "opl3.h"


TCHAR szAppName[] = "Terep2Win32";

extern void asm_f_init(void);
extern void asm_render(void);
extern void asm_physics(void);
extern void asm_keys(void);

void call_init(HWND hwnd, char path[], int complain);
void adjustWindowSize(HWND hwnd, int w, int h);

void doTheGLThing(HWND hwnd);

extern volatile uintptr_t all_segments[];
extern volatile call_portal_t call_portal[];
extern volatile uint8_t  base_mem[];

HWND hBlinken;

#define HZ_PHYSICS 120 //TODO check if this is right
#define USECS_PER_TICK (1000000/HZ_PHYSICS)
#define HZ_DISPLAY 60

st_image gameImg;

LARGE_INTEGER tickfreq;

int started = 0;
int run_physics = 1;
int64_t last_p_update = -1;

opl3_chip chip;

#define OPL3_SAMPLE_RATE        49716
#define SOUND_CHANNELS          2
#define SOUND_BUFFER_SIZE_CH    2048

HWAVEOUT hWaveOut;
WAVEHDR waveHeaders[SOUND_CHANNELS] = { 0 };
int16_t audioBuffers[SOUND_CHANNELS][SOUND_BUFFER_SIZE_CH] = { 0 };
#define SOUND_VOLUME_MAX    0xFFFFFFFF
#define SOUND_VOLUME_MIN    0x0

int sound_enabled = 1;

//get system uptime in uSecs
int64_t GetTimeee(void){
    LARGE_INTEGER t;
    QueryPerformanceCounter(&t);

    int64_t ret = (t.QuadPart * 1000000LL) / tickfreq.QuadPart;
    return ret;
}

#ifdef DEBUGMENU
static char console_tilte[] = TEXT("TeREp2 - Debug Console");
static void CreateDebugConsole(void) {
        BOOL ok;
        FILE *stream;

        ok = AllocConsole();
        if (!ok)
            return;

        AttachConsole(GetCurrentProcessId());
        SetConsoleTitle(console_tilte);
        freopen_s(&stream, "CON", "w", stdout);

        printf(" Debug Console for TeREp2\n\n");
}

static void DestroyDebugConsole(void) {
        FreeConsole();

        HWND hwnd = FindWindow(NULL, console_tilte);
        if (hwnd) {
            PostMessage(hwnd, WM_CLOSE, 0, 0);
        }
}
#endif // DEBUGMENU

void CALLBACK waveOutProc(HWAVEOUT hwo, UINT uMsg, DWORD_PTR dwInstance, DWORD_PTR dwParam1, DWORD_PTR dwParam2) {
    if (uMsg == WOM_DONE) {
        WAVEHDR* pHeader = (WAVEHDR*)dwParam1;
        int16_t* samples = (int16_t*)pHeader->lpData;
        for (int i = 0; i < SOUND_BUFFER_SIZE_CH / 2; i++) {
            OPL3_GenerateResampled(&chip, &samples[i * 2]);
        }
        waveOutWrite(hwo, pHeader, sizeof(WAVEHDR));
    }
}

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    static int selected_scale = T2_SCALE_P2;
    HMENU hMenu;

    switch (msg) {
        case WM_CREATE: {
#ifdef DEBUGMENU
            CreateDebugConsole();
#endif
            hMenu = GetMenu(hwnd);

            CheckMenuItem(hMenu, T2_APP_PHYS_RUN, run_physics ? MF_CHECKED : MF_UNCHECKED);
            CheckMenuItem(hMenu, T2_APP_SOUND, sound_enabled ? MF_CHECKED : MF_UNCHECKED);

            call_init(hwnd, ".", 0);
        }
        break;

        case WM_COMMAND: {
            hMenu = GetMenu(hwnd);

            switch (LOWORD(wParam)) {
                case T2_APP_OPEN: {
                    if(started){
                        //TODO a way to cleanup the specific parts of the memory to restart the game with another track
                        MessageBox(hwnd, "The game already started!", "Error", MB_ICONSTOP);
                        goto end; //behold the root of all evil!
                    }

                    char path[MAX_PATH];
                    BROWSEINFO bi = {0};
                    LPITEMIDLIST pidl;

                    bi.hwndOwner = hwnd;
                    bi.lpszTitle = "Select a track directory:";
                    bi.ulFlags = BIF_RETURNONLYFSDIRS | BIF_USENEWUI | BIF_NONEWFOLDERBUTTON;

                    pidl = SHBrowseForFolder(&bi);
                    if (pidl) {
                        if (SHGetPathFromIDList(pidl, path)) {
                            call_init(hwnd, path, 1);
                        }
                        CoTaskMemFree(pidl); /* Frees da memory */
                    }
                }
                break;

                case T2_APP_BLINKEN: {
                    ShowWindow(hBlinken, SW_SHOW);
                    UpdateWindow(hBlinken);
                }
                break;

                case T2_APP_PHYS_RUN: {
                    run_physics = !run_physics;

                    CheckMenuItem(hMenu, T2_APP_PHYS_RUN, run_physics ? MF_CHECKED : MF_UNCHECKED);

                    last_p_update = -1; //pretends we just started
                }
                break;

                case T2_APP_PHYS_STEP: {
                    if (started){
                        if (run_physics) {
                            MessageBox(NULL, "Simulation is running, please stop it to use single-step mode!", "Error", MB_ICONSTOP);
                        } else {
                           asm_physics();
                        }
                    }
                }
                break;

                case T2_APP_SOUND: {
                    sound_enabled = !sound_enabled;

                    CheckMenuItem(hMenu, T2_APP_SOUND, sound_enabled ? MF_CHECKED : MF_UNCHECKED);

                    if (sound_enabled) {
                        waveOutSetVolume(hWaveOut, SOUND_VOLUME_MAX);
                    } else {
                        waveOutSetVolume(hWaveOut, SOUND_VOLUME_MIN);
                    }
                }
                break;

                case T2_APP_EXIT: {
                    SendMessage (hwnd, WM_CLOSE, 0, 0) ;
                    return 0 ;
                } break;

                case T2_APP_ABOUT: {
                    MessageBox (hwnd, "TeREp2\n"
                                      "(c) Harrison, 2026\n"
                                      "(c) gmb, 2026\n"
                                      "(c) Nagymathe Denes, 1996-1997",
                                "About", MB_ICONINFORMATION | MB_OK) ;
                    return 0;
                } break;
            }

            if(LOWORD(wParam)/100 == 401){//gambiarra da boa!
                selected_scale = LOWORD(wParam);
                int w,h;
                getScaleDimension(selected_scale, &w, &h);
                adjustWindowSize(hwnd, w, h);
            }
        }
        break;

        case WM_PAINT: {
            PAINTSTRUCT ps;

            if (!started) {
                RECT rc;
                GetClientRect(hwnd, &rc);

                HDC hdc = BeginPaint(hwnd, &ps);

                SetBkMode(hdc, TRANSPARENT);
                SetTextColor(hdc, RGB(0, 0, 0));

                DrawText(hdc, "No game is started, please open a track.", -1, &rc, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
                EndPaint(hwnd, &ps);
            } else if(selected_scale == T2_GRAPH_GL){
                doTheGLThing(hwnd);
            } else {
                HDC hdc = BeginPaint(hwnd, &ps);
                drawTheFramebuffer(hdc, selected_scale);
                EndPaint(hwnd, &ps);
            }
        }
        break;

        case WM_TIMER: {
            if (wParam == 122 && started) {
                if(run_physics){
                    int64_t agora = GetTimeee();
                    if(last_p_update < 0){
                        last_p_update = agora;
                    }
                    int64_t diff = agora - last_p_update;

                    int64_t ticks = diff / USECS_PER_TICK;
                    int64_t sobra = diff % USECS_PER_TICK;

                    for(int i = 0; i < ticks; i++){
                        if(i > 5){
                            //nah, something isnt right here
                            //maybe the timer was delayed, lets bail
                            break;
                        }
                        asm_physics();
                    }
                    last_p_update = agora - sobra;
                }

                InvalidateRect(hwnd, 0, FALSE);
                asm_render();

#ifdef DEBUGMENU
                InvalidateRect(hBlinken, 0, FALSE);
#endif
            }
        }
        break;

        case WM_KEYDOWN:
        {
            if(wParam == VK_SPACE && !run_physics){
                asm_physics();
            }
            if(wParam == '3'){
                run_physics = !run_physics;
            }

            //no break here, intentional fallthrou
        }
        case WM_KEYUP:
        case WM_SYSKEYDOWN:
        case WM_SYSKEYUP:
        {
            WORD keyFlags = HIWORD(lParam);
            WORD scanCode = keyFlags & 0x7f;
            if(keyFlags & KF_UP){
                //key released
                scanCode += 0x80;
            }else if(scanCode == 1){
                //esc pressed
                PostQuitMessage(0);
            }

            if(started){
                call_portal->ax = scanCode;
                asm_keys();
            }
        }
        break;

        case WM_DESTROY:
        {
            // TODO (gmb): application does not terminates when this is here
            //             find a place for cleanup
/*
            waveOutReset(hWaveOut);
            for (int i = 0; i < SOUND_CHANNELS; i++) {
                waveOutUnprepareHeader(hWaveOut, &waveHeaders[i], sizeof(WAVEHDR));
            }
            waveOutClose(hWaveOut);
*/

#ifdef DEBUGMENU
            DestroyDebugConsole();
#endif
            PostQuitMessage(0);
        }
    }

end:
    return DefWindowProc(hwnd, msg, wParam, lParam);
}

int WINAPI WinMain(HINSTANCE hInst, HINSTANCE hPrev, LPSTR lpCmd, int nShow) {
    (void)hPrev;
    (void)lpCmd;

    // init sound
    OPL3_Reset(&chip, OPL3_SAMPLE_RATE);

    WAVEFORMATEX wfx;
    wfx.wFormatTag = WAVE_FORMAT_PCM;
    wfx.nChannels = SOUND_CHANNELS;
    wfx.nSamplesPerSec = OPL3_SAMPLE_RATE;
    wfx.wBitsPerSample = 16;
    wfx.nBlockAlign = wfx.nChannels * (wfx.wBitsPerSample / 8);
    wfx.nAvgBytesPerSec = wfx.nSamplesPerSec * wfx.nBlockAlign;
    wfx.cbSize = 0;

    MMRESULT mmerr = waveOutOpen(&hWaveOut, WAVE_MAPPER, &wfx, (DWORD_PTR)waveOutProc, 0, CALLBACK_FUNCTION);
    if (mmerr != MMSYSERR_NOERROR) {
        MessageBox(NULL, "Failed to open waveOut audio device!", szAppName, MB_ICONERROR);
        return 0;
    }

    if (sound_enabled) {
        waveOutSetVolume(hWaveOut, SOUND_VOLUME_MAX);
    } else {
        waveOutSetVolume(hWaveOut, SOUND_VOLUME_MIN);
    }

    for (int i = 0; i < SOUND_CHANNELS; i++) {
        waveHeaders[i].lpData = (LPSTR)audioBuffers[i];
        waveHeaders[i].dwBufferLength = sizeof(audioBuffers[i]);
        waveHeaders[i].dwFlags = 0;
        waveHeaders[i].dwLoops = 0;

        waveOutPrepareHeader(hWaveOut, &waveHeaders[i], sizeof(WAVEHDR));
        waveOutWrite(hWaveOut, &waveHeaders[i], sizeof(WAVEHDR));
    }

    // init windows
    WNDCLASS wndclassMain = {0};
    WNDCLASS wndclassBlinken = {0};
    MSG msg;
    HWND hwnd;

    wndclassMain.lpfnWndProc = WndProc;
    wndclassMain.hInstance = hInst;
    wndclassMain.lpszClassName = szAppName;
    wndclassMain.lpszMenuName = szAppName;
    wndclassMain.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);

    if (!RegisterClass (&wndclassMain)){
        MessageBox(NULL, "This program requires Windows NT!", szAppName, MB_ICONERROR);
        return 0;
    }

#ifdef DEBUGMENU
    wndclassBlinken.lpfnWndProc = BlinkenWndProc;
    wndclassBlinken.hInstance = hInst;
    wndclassBlinken.lpszClassName = "Terep2Win32Blinken";
    wndclassBlinken.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);

    if (!RegisterClass (&wndclassBlinken)){
        MessageBox(NULL, "This program requires Windows NT!", szAppName, MB_ICONERROR);
        return 0;
    }
#endif // DEBUGMENU

    QueryPerformanceFrequency(&tickfreq);

    DWORD dwStyle = WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX;

    hwnd = CreateWindow(szAppName, "TeREp2",
                        dwStyle,
                        CW_USEDEFAULT, CW_USEDEFAULT,
                        100,
                        100,
                        NULL, NULL, hInst, NULL);
    if (hwnd == NULL) {
        MessageBox(NULL, "Unable to create main window.", szAppName, MB_ICONERROR);
        return 0;
    }

#ifdef DEBUGMENU
    blinkenInit();
    RECT rc = {0, 0, 1130, 600};
    dwStyle = WS_OVERLAPPEDWINDOW;
    AdjustWindowRect(&rc, dwStyle, FALSE);

    hBlinken = CreateWindow("Terep2Win32Blinken", "TeREp2 - Blinkenlights",
                        dwStyle,
                        CW_USEDEFAULT, CW_USEDEFAULT,
                        rc.right - rc.left,
                        rc.bottom - rc.top,
                        NULL, NULL, hInst, NULL);

    if (hBlinken == NULL) {
        MessageBox(NULL, "Unable to create blinken window.", szAppName, MB_ICONERROR);
        return 0;
    }
#endif // DEBUGMENU

    ShowWindow(hwnd, nShow);
    UpdateWindow(hwnd);

    adjustWindowSize(hwnd, 640, 400);

    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    return msg.wParam;
}

void adjustWindowSize(HWND hwnd, int w, int h){
    RECT rc = {0, 0, w, h};
    //FIXME deduplicate this
    DWORD dwStyle = WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX;

    AdjustWindowRect(&rc, dwStyle, TRUE);
    SetWindowPos(hwnd, NULL, 
        0,0,
        rc.right - rc.left, rc.bottom - rc.top,
        SWP_NOMOVE | SWP_NOREPOSITION | SWP_NOZORDER
    );
    InvalidateRect(hwnd, 0, TRUE);
}

char track_path[MAX_PATH];

void call_init(HWND hwnd, char path[], int complain){
    {
        char ultrapath[MAX_PATH];
        snprintf(ultrapath, MAX_PATH, "%s\\car1.dat", path);
        FILE * f = fopen(ultrapath, "rb");
        if(f == NULL){
            if(complain){
                MessageBox(NULL, "The selected directory doesn't seem to contain a track.", "Huh, car1.dat not found, try again!", MB_ICONSTOP);
            }
            return;
        }
        fclose(f);
    }

    //TODO strip trailing slash
    strncpy(track_path, path, MAX_PATH);
    asm_f_init();

    started = 1;


    if(call_portal->ax){
        MessageBox(NULL, "Init reported some kind of error", "Bad", MB_ICONERROR);
        exit(55);
    }

    int ncars = base_mem[0x5bba];
    if(ncars <= 0){
        MessageBox(NULL, "Error initializing... no cars loaded", "Fail", MB_ICONSTOP);
        exit(1);
    }

    prepare_bitmap_info(320, 200, &gameImg, (uint8_t *)&base_mem[0x1a4d]);
    asm_render(); //just to avoid garbage in the framebuffer, maybe not even necessary

    SetTimer(hwnd, 122, 1000/HZ_DISPLAY, NULL);
}

void adlib_callback(){
    uint16_t ax = call_portal->ax;
    uint8_t reg = ax >> 8;
    uint8_t val = ax & 0xFF;

    OPL3_WriteReg(&chip, reg, val);
}
