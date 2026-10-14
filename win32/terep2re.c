#include "common.h"
#include "resource.h"

#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <shlobj.h>

TCHAR szAppName[] = "Terep2Win32";

char iniFile[] = "TEREP2RE.INI";

extern void asm_f_init(void);
extern void asm_render(void);
extern void asm_physics(void);
extern void asm_keys(void);

void call_init(HWND hwnd, char path[], int complain);
void adjustWindowSize(HWND hwnd, int w, int h);

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
int debug_mode = 0;

char last_opened_dir[MAX_PATH] = "C://";
int sound_enabled = 1;
int selected_scale = T2_SCALE_P2;

//get system uptime in uSecs
int64_t GetTimeee(void){
    LARGE_INTEGER t;
    QueryPerformanceCounter(&t);

    int64_t ret = (t.QuadPart * 1000000LL) / tickfreq.QuadPart;
    return ret;
}

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

static void LoadConfig(void){
    DWORD cwd_len = GetCurrentDirectory(0, NULL);
    char *cwd = calloc(1, cwd_len);
    if (!cwd) {
        printf("ERROR: unable to create cwd\n");
        return;
    }
    GetCurrentDirectory(cwd_len, cwd);
    DWORD path_len = cwd_len + 1 + strlen(iniFile) + 1;
    char *path = calloc(1, path_len);
    if (!path) {
        printf("ERROR: unable to create path\n");
        free(cwd);
        return;
    }
    snprintf(path, path_len, "%s/%s", cwd, iniFile);

    GetPrivateProfileString("Path", "Directory", "C://", last_opened_dir, sizeof(last_opened_dir), path);
    sound_enabled = GetPrivateProfileInt("Sound", "Enabled", sound_enabled, path);
    selected_scale = GetPrivateProfileInt("Graphics", "Scale", selected_scale, path);
    debug_mode = GetPrivateProfileInt("Debug", "Enabled", debug_mode, path);
    run_physics = GetPrivateProfileInt("Debug", "RunPhysics", run_physics, path);

    free(cwd);
    free(path);
}

static void SaveConfig(void){
    DWORD cwd_len = GetCurrentDirectory(0, NULL);
    char *cwd = calloc(1, cwd_len);
    if (!cwd) {
        printf("ERROR: unable to create cwd\n");
        return;
    }
    GetCurrentDirectory(cwd_len, cwd);
    DWORD path_len = cwd_len + 1 + strlen(iniFile) + 1;
    char *path = calloc(1, path_len);
    if (!path) {
        printf("ERROR: unable to create path\n");
        free(cwd);
        return;
    }
    snprintf(path, path_len, "%s/%s", cwd, iniFile);

    char buf[32];

    WritePrivateProfileString("Path", "Directory", last_opened_dir, path);

    snprintf(buf, sizeof(buf), "%d", sound_enabled);
    WritePrivateProfileString("Sound", "Enabled", buf, path);

    snprintf(buf, sizeof(buf), "%d", selected_scale);
    WritePrivateProfileString("Graphics", "Scale", buf, path);

    snprintf(buf, sizeof(buf), "%d", debug_mode);
    WritePrivateProfileString("Debug", "Enabled", buf, path);

    snprintf(buf, sizeof(buf), "%d", run_physics);
    WritePrivateProfileString("Debug", "RunPhysics", buf, path);

    free(cwd);
    free(path);
}

static void SetGraphicsScale(HWND hwnd){
    int w,h;
    getScaleDimension(selected_scale, &w, &h);
    adjustWindowSize(hwnd, w, h);
}

static INT CALLBACK BrowseCallbackProc(HWND hwnd, UINT uMsg, LPARAM lp, LPARAM pData)
{
    if (uMsg == BFFM_INITIALIZED) {
        SendMessage(hwnd, BFFM_SETSELECTION, TRUE, pData);
    }
    return 0;
}

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    static HMENU hMenu;
    switch (msg) {
        case WM_CREATE: {
            if (debug_mode) {
                CreateDebugConsole();
            }

            hMenu = GetMenu(hwnd);
            if (hMenu) {
                if (!debug_mode) {
                    // NOTE(gmb): Debug MUST be the 4th menuitem
                    DeleteMenu(hMenu, 3, MF_BYPOSITION);
                    DrawMenuBar(hwnd);
                }

                CheckMenuItem(hMenu, T2_APP_PHYS_RUN, run_physics ? MF_CHECKED : MF_UNCHECKED);
                CheckMenuItem(hMenu, T2_APP_SOUND, sound_enabled ? MF_CHECKED : MF_UNCHECKED);
            }

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
                    bi.ulFlags = BIF_RETURNONLYFSDIRS | BIF_NONEWFOLDERBUTTON;
                    bi.lpfn = BrowseCallbackProc;
                    bi.lParam = (LPARAM)last_opened_dir;

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
                            sound_on();
                        } else {
                            sound_off();
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
                SetGraphicsScale(hwnd);
            }
        }
        break;

        case WM_PAINT: {
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hwnd, &ps);

            if (!started) {
                RECT rc;
                GetClientRect(hwnd, &rc);

                SetBkMode(hdc, TRANSPARENT);
                SetTextColor(hdc, RGB(0, 0, 0));

                DrawText(hdc, "No game is started, please open a track.", -1, &rc, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
            } else {
                drawTheFramebuffer(hdc, selected_scale);
            }

            EndPaint(hwnd, &ps);
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

                if (debug_mode) {
                    InvalidateRect(hBlinken, 0, FALSE);
                }
            }
        }
        break;

        case WM_KEYDOWN:
        {
            if(wParam == VK_F7){
                run_physics = !run_physics;
                if (debug_mode) {
                    CheckMenuItem(hMenu, T2_APP_PHYS_RUN, run_physics ? MF_CHECKED : MF_UNCHECKED);
                }
            }
            if(wParam == VK_F8 && !run_physics){
                asm_physics();
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

            // NOTE(gmb): F10 activates the menu bar by default,
            //            we do not need that
            if(wParam == VK_F10){
                return 0;
            }
        }
        break;

        case WM_DESTROY:
        {
            // TODO (gmb): application does not terminates when this is here
            //             find a place for cleanup
            // sound_deinit();

            SaveConfig();

            if (debug_mode) {
                DestroyDebugConsole();
            }

            PostQuitMessage(0);
        }
    }

end:
    return DefWindowProc(hwnd, msg, wParam, lParam);
}

int WINAPI WinMain(HINSTANCE hInst, HINSTANCE hPrev, LPSTR lpCmd, int nShow) {
    (void)hPrev;
    (void)lpCmd;

    LoadConfig();
    // to be sure
    if (!debug_mode) {
        run_physics = 1;
    }

    BOOL sound_ok = sound_init();
    if (!sound_ok) {
        MessageBox(NULL, "Failed to initialise sound!", szAppName, MB_ICONERROR);
        return 0;
    }

    if (sound_enabled) {
        sound_on();
    } else {
        sound_off();
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

    if (debug_mode) {
        wndclassBlinken.lpfnWndProc = BlinkenWndProc;
        wndclassBlinken.hInstance = hInst;
        wndclassBlinken.lpszClassName = "Terep2Win32Blinken";
        wndclassBlinken.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);

        if (!RegisterClass (&wndclassBlinken)){
            MessageBox(NULL, "This program requires Windows NT!", szAppName, MB_ICONERROR);
            return 0;
        }
    }

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

    if (debug_mode) {
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
    }

    ShowWindow(hwnd, nShow);
    UpdateWindow(hwnd);

    adjustWindowSize(hwnd, 640, 400);
    SetGraphicsScale(hwnd);

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

char *tmp_g_path;

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

    strncpy(last_opened_dir, path, sizeof(last_opened_dir));
    tmp_g_path = path;
    asm_f_init();
    tmp_g_path = 0;

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
