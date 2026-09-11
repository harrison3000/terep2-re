#include "common.h"
#include "resource.h"

#include <stdlib.h>
#include <stdio.h>
#include <shlobj.h>
#include <process.h>

#define DEFAULT_LEN (1 << 16)

typedef struct {
    uint16_t msg, ax, bx, cx, dx, cf;
} call_portal_t;

TCHAR szAppName[] = "Terep2Win32";

extern void asm_f_init(void);
extern void asm_render(void);
extern void asm_physics(void);
extern void asm_keys(uint16_t);

int mydoscall(char path[]);
void call_init(HWND hwnd, char path[], int complain);

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

//get system uptime in uSecs
int64_t GetTimeee(void){
    LARGE_INTEGER t;
    QueryPerformanceCounter(&t);

    int64_t ret = (t.QuadPart * 1000000LL) / tickfreq.QuadPart;
    return ret;
}

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    HMENU hMenu;

    switch (msg) {
        case WM_CREATE: {
            hMenu = GetMenu(hwnd);

            if (run_physics) {
                CheckMenuItem (hMenu, T2_APP_PHYS_RUN, MF_CHECKED) ;
            } else {
                CheckMenuItem (hMenu, T2_APP_PHYS_RUN, MF_UNCHECKED) ;
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

                    if (run_physics) {
                        CheckMenuItem(hMenu, T2_APP_PHYS_RUN, MF_CHECKED);
                    } else {
                        CheckMenuItem(hMenu, T2_APP_PHYS_RUN, MF_UNCHECKED);
                    }

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
                int videoSegSel = base_mem[0xdb10];
                char *video = (char*)all_segments[videoSegSel];

                StretchDIBits(hdc,
                    0,  0, 320*2, 200*2,
                    0,  0, 320, 200,
                    (void *)video, (void *)&gameImg,
                    DIB_RGB_COLORS, SRCCOPY
                );
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

#ifdef DEBUGMENU
                InvalidateRect(hBlinken, 0, FALSE);
#endif
            }
        }
        break;

        case WM_KEYDOWN:
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
                asm_keys(scanCode);
            }
        }
        break;

        case WM_DESTROY:
        {
            PostQuitMessage(0);
        }
    }

end:
    return DefWindowProc(hwnd, msg, wParam, lParam);
}

int WINAPI WinMain(HINSTANCE hInst, HINSTANCE hPrev, LPSTR lpCmd, int nShow) {
    (void)hPrev;
    (void)lpCmd;

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
        MessageBox(NULL, "This program requires Windows NT!", szAppName, MB_ICONERROR) ;
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

    // TODO(gmb): get height of the menubar (20?)
    RECT rc = {0, 0, 640, 400+20}; /* Tamanho interno desejado */
    DWORD dwStyle = WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX;

    AdjustWindowRect(&rc, dwStyle, FALSE);

    /* Janela aproximada de 800x600 */
    hwnd = CreateWindow(szAppName, "TeREp2",
                        dwStyle,
                        CW_USEDEFAULT, CW_USEDEFAULT,
                        rc.right - rc.left,
                        rc.bottom - rc.top,
                        NULL, NULL, hInst, NULL);
    if (hwnd == NULL) {
        MessageBox(NULL, "Unable to create main window.", szAppName, MB_ICONERROR);
        return 0;
    }

#ifdef DEBUGMENU
    blinkenInit();
    rc.right = 1130;
    rc.bottom = 600;
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

    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    return msg.wParam;
}

void prepare_bitmap_info(int w, int h, st_image *bminfo, uint8_t *palette){
    BITMAPINFOHEADER bih = {
        .biSize = sizeof(BITMAPINFOHEADER),
        .biPlanes = 1,
        .biBitCount = 8,
        .biCompression = BI_RGB,
    };

    bih.biWidth = w;
    bih.biHeight = -h,
    bih.biSizeImage = w * h;

    bminfo->info = bih;

    uint8_t *ptr = palette;
    for(int i =0; i<256;i++){
        bminfo->palette[i].rgbRed   = ptr[0];
        bminfo->palette[i].rgbGreen = ptr[1];
        bminfo->palette[i].rgbBlue  = ptr[2];
        ptr += 3;
    }
}

void __watcall GameInitThread(void *param) {
    (void)param;
    asm_f_init();
    _endthread();
}

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

    uintptr_t handle = _beginthread(GameInitThread, 0, 0);

    if (handle == (uintptr_t)-1) {
        MessageBox(NULL, "Error initializing", "Error", MB_ICONERROR);
        exit(1);
    }

    started = 1;
    int64_t ini = GetTimeee();

    while(1){
        if(call_portal->msg == 0xd3ca){
            int ok = mydoscall(path);

            call_portal->cf = ok ? 3 : 1;
            call_portal->msg = 0x1234;
            continue;
        }
        if(call_portal->msg == 0xbeef){
            break;
        }

        int64_t end = GetTimeee();
        if(end - ini > 2000000LL){ //2 seconds is all we need
            MessageBox(NULL, "Loading took too long", "Error", MB_ICONERROR);
            exit(1);
        }
    }

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

int mydoscall(char path[]){
    uint16_t ax = call_portal->ax;
    uint16_t bx = call_portal->bx;
    uint16_t cx = call_portal->cx;
    uint16_t dx = call_portal->dx;

    static FILE* f = 0;
    static int fidx = 5;
    static int32_t totalrd = 0;

    int op = ax & 0xff00;
    
    if (op == 0x3d00){
        //open
        volatile char *filename = &base_mem[dx];
        if(filename[0] == 0){
            //empty file name, happens when track has 5 cars
            printf("Tried to load a empty filename, probably better to bail out\n");
            return 0;
        }
        if(f != NULL){
            printf("WARN: trying to open 2 files at once\n");
        }
        char ultrapath[MAX_PATH];

        snprintf(ultrapath, MAX_PATH, "%s\\%s", path, filename);

        printf("* trying to open: %s...  ", ultrapath);
        f = fopen(ultrapath, "rb");
        if(f == NULL){
            printf("FAILED\n");
            call_portal->ax = 2;
        }else{
            printf("OK\n");
            fidx++;
            call_portal->ax = fidx;
        }            
        return f != NULL;
    }
    if (op == 0x4800){
        static int seletor = 0;
        seletor++;
        void* mem = malloc(DEFAULT_LEN);
        all_segments[seletor] = (uintptr_t)mem;
        printf("* Aloc: %d, %08x\n", seletor, mem);
        printf("* game asked for %d paragraphs (%d bytes), we gave it a %d bytes block anyway\n", bx, bx * 16, DEFAULT_LEN);
        call_portal->ax = seletor;
        return 1;
    }
    if (op == 0x3f00){
        if(bx != fidx){
            printf("* WAT?\n");
            return 0;
        }
        volatile char *addr = &base_mem[dx];
        int32_t r = fread((void*)addr, 1, cx, f);
        if(dx != 0xf008){
            //show this message only for carX.dat loading
            printf("* Read %ld bytes into address: %08x (%04x relative to DS)!\n", r, addr, dx);
        }
        if(r != cx){
            printf("* Short read, %d, %d\n", r, cx);
        }
        totalrd += r;
        call_portal->ax = r;            
        return r >= 0;
    }
    if (op == 0x4200){
        uint32_t off = cx;
        off <<= 16;
        off += dx;

        uint32_t fsok = fseek(f, off, ax & 0xf);
        uint32_t offset = ftell(f);
        call_portal->dx = offset >> 16;
        call_portal->ax = offset;
        return fsok == 0; 
    }
    if (op == 0x3e00){
        int ok = fclose(f);
        f = NULL;
        printf("* Total read: %ld\n", totalrd);
        totalrd = 0;
        return ok == 0;
    }

    char error[256];

    snprintf(error, 256, "\nERROR: unhandled call: %04x\n", ax);

    printf("\n%s\n", error);
    MessageBox(NULL, error, "Error", MB_ICONERROR);
    exit(69);
    return 0;
}


