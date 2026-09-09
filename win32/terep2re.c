
#include <stdlib.h>
#include <stdio.h>
#include <windows.h>
#include <shlobj.h>
#include <process.h>
#include <stdint.h>

#define DEFAULT_LEN (1 << 16)

#define ID_BTN_FOLDER 101
#define ID_CHK_BLINKEN 102
#define ID_CHK_RUN_P   103
#define ID_BTN_SNGLSTP 104

typedef struct {
    uint16_t msg, ax, bx, cx, dx, cf;
} call_portal_t;

extern void asm_f_init();
extern void asm_render();
extern void asm_physics();
extern void asm_keys(uint16_t);

extern volatile uintptr_t all_segments[];
extern volatile call_portal_t call_portal[];
extern volatile uint8_t  base_mem[];

void call_init(HWND hwnd, char path[]);

#define HZ_PHYSICS 120 //TODO check if this is right
#define USECS_PER_TICK (1000000/HZ_PHYSICS)
#define HZ_DISPLAY 60

typedef struct {
    BITMAPINFOHEADER info;
    RGBQUAD palette[256];
} st_image;

st_image gameImg;
st_image blinkenImg;

LARGE_INTEGER tickfreq;

//get system uptime in uSecs
int64_t GetTimeee(){
    LARGE_INTEGER t;
    QueryPerformanceCounter(&t);

    int64_t ret = (t.QuadPart * 1000000LL) / tickfreq.QuadPart;
    return ret;
}

int started = 0;

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    static int showblinken = 0;
    static int run_physics = 1;
    static HWND hCheckblk = NULL;
    static HWND hCheckrun = NULL;
    static int64_t last_p_update = -1;

    if (msg == WM_CREATE) {
        CreateWindow("BUTTON", "Select track", 
                     WS_VISIBLE | WS_CHILD | BS_PUSHBUTTON,
                     10, 10, 120, 30, hwnd, (HMENU)ID_BTN_FOLDER, NULL, NULL);
        
        hCheckblk = CreateWindow("BUTTON", "Show blinkenlights",
                     WS_VISIBLE | WS_CHILD | BS_AUTOCHECKBOX,
                     140, 10, 180, 30, hwnd, (HMENU)ID_CHK_BLINKEN, NULL, NULL);

        hCheckrun = CreateWindow("BUTTON", "Run physics",
                     WS_VISIBLE | WS_CHILD | BS_AUTOCHECKBOX,
                     330, 10, 110, 30, hwnd, (HMENU)ID_CHK_RUN_P, NULL, NULL);

        SendMessage(hCheckrun, BM_SETCHECK, BST_CHECKED, 0);

        CreateWindow("BUTTON", "Single step", 
                     WS_VISIBLE | WS_CHILD | BS_PUSHBUTTON,
                     450, 10, 100, 30, hwnd, (HMENU)ID_BTN_SNGLSTP, NULL, NULL);
    } 
    else if (msg == WM_COMMAND && LOWORD(wParam) == ID_BTN_FOLDER) {
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
                call_init(hwnd, path);
            }
            CoTaskMemFree(pidl); /* Frees da memory */
        }
    } 
    else if (msg == WM_COMMAND && LOWORD(wParam) == ID_CHK_BLINKEN) {
        showblinken = (SendMessage(hCheckblk, BM_GETCHECK, 0, 0) == BST_CHECKED);
        if(!showblinken){
            InvalidateRect(hwnd, 0, TRUE);
        }
        SetFocus(hwnd);
    }
    else if (msg == WM_COMMAND && LOWORD(wParam) == ID_CHK_RUN_P) {
        last_p_update = -1; //pretends we just started
        run_physics = (SendMessage(hCheckrun, BM_GETCHECK, 0, 0) == BST_CHECKED);
        SetFocus(hwnd);
    }
    else if (msg == WM_COMMAND && LOWORD(wParam) == ID_BTN_SNGLSTP) {
        if(started){
            asm_physics();
        }
        SetFocus(hwnd);
    }
    else if (msg == WM_PAINT && started){
        PAINTSTRUCT ps;
        HDC hdc = BeginPaint(hwnd, &ps);

        int videoSegSel = base_mem[0xdb10];
        char *video = all_segments[videoSegSel];

        StretchDIBits(hdc,
            0, 50, 320*2, 200*2,
            0,  0, 320, 200,
            video, (void *)&gameImg,
            DIB_RGB_COLORS, SRCCOPY
        );

        if(showblinken){
            SetBkMode(hdc, TRANSPARENT);
            SetTextColor(hdc, RGB(0, 0, 0));
            char text[256];

            for(int i = 0; i < 256; i++){
                char* isds = (i == 0) ? " (DS)" : "";
                uintptr_t ptr = all_segments[i];
                if(ptr == 0){
                    break;
                }

                RECT rc;
                rc.left = (i % 4) * 280 + 680;
                rc.top  = (i / 4) * 300 + 40;
                rc.right = rc.left + 250;
                rc.bottom = rc.top + 30;

                snprintf(text, sizeof(text), "Segment: %02d%s, Addr: %08x", i, isds, ptr);
                DrawText(hdc, text, -1, &rc, DT_LEFT);

                SetDIBitsToDevice(hdc,
                    rc.left, rc.top + 25, 256, 256,
                    0, 0, 0, 256,
                    ptr, (void *)&blinkenImg,
                    DIB_RGB_COLORS
                );
            }
        }

        EndPaint(hwnd, &ps);
    }
    else if (msg == WM_TIMER && wParam == 122 && started){
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
    }
    else if (msg == WM_KEYDOWN || msg == WM_KEYUP ||msg == WM_SYSKEYDOWN ||msg == WM_SYSKEYUP) {
        WORD keyFlags = HIWORD(lParam);
        WORD scanCode = keyFlags & 0x7f ;            
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
    else if (msg == WM_DESTROY) {
        PostQuitMessage(0);
    }
    end:
    return DefWindowProc(hwnd, msg, wParam, lParam);
}

void blinkenInit();

int WINAPI WinMain(HINSTANCE hInst, HINSTANCE hPrev, LPSTR lpCmd, int nShow) {
    WNDCLASS wc = {0};
    MSG msg;
    HWND hwnd;

    wc.lpfnWndProc = WndProc;
    wc.hInstance = hInst;
    wc.lpszClassName = "Terep2Win32";
    wc.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);

    RegisterClass(&wc);
    
    QueryPerformanceFrequency(&tickfreq);

    RECT rc = {0, 0, 640, 400 + 50}; /* Tamanho interno desejado */
    DWORD dwStyle = WS_OVERLAPPEDWINDOW | WS_VISIBLE;

    AdjustWindowRect(&rc, dwStyle, FALSE);

    /* Janela aproximada de 800x600 */
    hwnd = CreateWindow("Terep2Win32", "TeREp2", 
                        dwStyle,
                        CW_USEDEFAULT, CW_USEDEFAULT,
                        rc.right - rc.left,
                        rc.bottom - rc.top,
                        NULL, NULL, hInst, NULL);

    blinkenInit();

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

int mydoscall(HWND hwnd, char path[]);

void __watcall GameInitThread(void *param) {
    asm_f_init();
    _endthread();
}

void call_init(HWND hwnd, char path[]){
    {
        char ultrapath[MAX_PATH];
        snprintf(ultrapath, MAX_PATH, "%s\\car1.dat", path);
        FILE * f = fopen(ultrapath, "rb");
        if(f == NULL){
            MessageBox(NULL, "The selected directory doesn't seem to contain a track.", "Huh, car1.dat not found, try again!", MB_ICONSTOP);
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
            int ok = mydoscall(hwnd, path);

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

    prepare_bitmap_info(320, 200, &gameImg,&base_mem[0x1a4d]);
    asm_render(); //just to avoid garbage in the framebuffer, maybe not even necessary

    SetTimer(hwnd, 122, 1000/HZ_DISPLAY, NULL);
}

int mydoscall(HWND hwnd, char path[]){
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
            printf(" * WAT?\n");
            return 0;
        }
        volatile char *addr = &base_mem[dx];

        int32_t r = fread(addr, 1, cx, f);
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

#define SETCOLORR(i, r,g,b) {     \
    RGBQUAD tmp = {.rgbRed = r, .rgbGreen = g, .rgbBlue = b,};\
    blinkenImg.palette[i] = tmp;  \
}

void blinkenInit(){
    uint8_t pRandom[256*3];
    for(int i =0; i < 256*3; i++){
        pRandom[i] = rand();
    }

    prepare_bitmap_info(256, 256, &blinkenImg, pRandom);

    SETCOLORR(0, 0,     0,   0);
    SETCOLORR(1, 255,   0,   0);
    SETCOLORR(2, 255, 128,   0);
    SETCOLORR(3, 0,   255, 255);

    SETCOLORR(126, 255, 255,   0);
    SETCOLORR(127,   0,   0, 255);
    SETCOLORR(128,   0, 255,   0);
    SETCOLORR(129, 128,   0, 255);

    SETCOLORR(254, 255,   0, 255);
    SETCOLORR(255, 255, 255, 255);
}
