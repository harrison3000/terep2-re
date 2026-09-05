
#include <stdio.h>
#include <windows.h>
#include <shlobj.h>
#include <process.h>
#include <stdint.h>

#define DEFAULT_LEN (1 << 16)

#define ID_BTN_FOLDER 101

extern void asm_f_init();
extern void asm_render();
extern void asm_physics();
extern void asm_keys(uint16_t);

extern volatile uint32_t all_segments[];
extern volatile uint16_t data_callregs[];
extern volatile uint8_t  base_mem[];

void call_init(HWND hwnd, char path[]);

#define HZ_PHYSICS 120 //TODO check if this is right
#define HZ_DISPLAY 60

typedef struct imageeee {
    BITMAPINFOHEADER info;
    RGBQUAD palette[256];
} st_image;

st_image paleta;

int started = 0;

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    if (msg == WM_CREATE) {
        /* Botão no canto superior esquerdo (x:10, y:10, w:120, h:30) */
        CreateWindow("BUTTON", "Select track", 
                     WS_VISIBLE | WS_CHILD | BS_PUSHBUTTON,
                     10, 10, 120, 30, hwnd, (HMENU)ID_BTN_FOLDER, NULL, NULL);
    } 
    else if (msg == WM_COMMAND && LOWORD(wParam) == ID_BTN_FOLDER) {
        if(started){
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
            CoTaskMemFree(pidl); /* Limpa a memória alocada pela shell */
        }
    } 
    else if (msg == WM_PAINT){
        PAINTSTRUCT ps;
        HDC hdc = BeginPaint(hwnd, &ps);

        int videoSegSel = base_mem[0xdb10];
        char *video = all_segments[videoSegSel];

        StretchDIBits(hdc,
            0, 50, 320*2, 200*2,
            0,  0, 320, 200,
            video, (void *)&paleta,
            DIB_RGB_COLORS, SRCCOPY
        );
        EndPaint(hwnd, &ps);
        asm_render();
    }
    else if (msg == WM_TIMER){
        if(wParam == 120 && started){
            asm_physics();
        }
        if(wParam == 122){
            InvalidateRect(hwnd, 0, TRUE);
        }
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

int WINAPI WinMain(HINSTANCE hInst, HINSTANCE hPrev, LPSTR lpCmd, int nShow) {
    WNDCLASS wc = {0};
    MSG msg;
    HWND hwnd;

    wc.lpfnWndProc = WndProc;
    wc.hInstance = hInst;
    wc.lpszClassName = "Terep2Win32";
    wc.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);

    RegisterClass(&wc);

    /* Janela aproximada de 800x600 */
    hwnd = CreateWindow("Terep2Win32", "TeREp2", 
                        WS_OVERLAPPEDWINDOW | WS_VISIBLE,
                        CW_USEDEFAULT, CW_USEDEFAULT, 800, 600, 
                        NULL, NULL, hInst, NULL);

    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    return msg.wParam;
}

void load_palette(){
    BITMAPINFOHEADER bih = {
        .biSize = sizeof(BITMAPINFOHEADER),
        .biWidth = 320,
        .biHeight = -200,
        .biPlanes = 1,
        .biBitCount = 8,
        .biCompression = BI_RGB,
        .biSizeImage = 320 * 200,
    };

    paleta.info = bih;

    volatile uint8_t *ptr = &base_mem[0x1a4d];
    for(int i =0; i<256;i++){
        paleta.palette[i].rgbRed = ptr[0];
        paleta.palette[i].rgbGreen = ptr[1];
        paleta.palette[i].rgbBlue = ptr[2];
        ptr += 3;
    }
}

int mydoscall(HWND hwnd, char path[]);

void __watcall GameInitThread(void *param) {
    asm_f_init();
    _endthread();
}

void call_init(HWND hwnd, char path[]){
    //TODO checar se tem o arquivo mesmo

    uintptr_t handle = _beginthread(GameInitThread, 0, 0);

    if (handle == (uintptr_t)-1) {
        MessageBox(NULL, "Error initializing", "Error", MB_ICONERROR);
        return;
    }
    started = 1;

    while(1){
        if(data_callregs[0] == 0xd3ca){
            int ok = mydoscall(hwnd, path);

            data_callregs[5] = ok ? 3 : 1;
            data_callregs[0] = 0x1234;
            continue;
        }
        if(data_callregs[0] == 0xbeef){
            break;
        }
        //TODO some kind of timeout
    }

    if(data_callregs[1]){
        MessageBox(NULL, "Init reported some kind of error", "Bad", MB_ICONERROR);
        exit(55);
    }

    int ncars = base_mem[0x5bba];
    if(ncars <= 0){
        MessageBox(NULL, "Error initializing... no cars loaded", "Fail", MB_ICONSTOP);
        exit(1);
    }

    load_palette();
    asm_render(); //just to avoid garbage in the framebuffer, maybe not even necessary

    SetTimer(hwnd, 120, 1000/HZ_PHYSICS, NULL);
    SetTimer(hwnd, 122, 1000/HZ_DISPLAY, NULL);
}

int mydoscall(HWND hwnd, char path[]){
    volatile uint16_t *ax = &data_callregs[1];
    uint16_t bx = data_callregs[2];
    uint16_t cx = data_callregs[3];
    volatile uint16_t *dx = &data_callregs[4];

    static FILE* f = 0;
    static int fidx = 5;
    static int32_t totalrd = 0;

    int op = *ax & 0xff00;
    switch (op) {
        case 0x3d00:{
            //open
            volatile char *filename = &base_mem[*dx];
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
                *ax = 2;
            }else{
                printf("OK\n");
                fidx++;
                *ax = fidx;
            }            
            return f != NULL;
        }
        case 0x4800:{
            static int seletor = 0;
            seletor++;
            void* mem = malloc(DEFAULT_LEN);
            all_segments[seletor] = (uint32_t)mem;
            printf("* Aloc: %d, %08x\n", seletor, mem);
            printf("* game asked for %d paragraphs (%d bytes), we gave it a %d bytes block anyway\n", bx, bx * 16, DEFAULT_LEN);
            *ax = seletor;
            return 1;
        }
        case 0x3f00:{
            if(bx != fidx){
                printf(" * WAT?\n");
                return 0;
            }
            volatile char *addr = &base_mem[*dx];

            int32_t r = fread(addr, 1, cx, f);
            if(r != cx){
                printf("* Short read, %d, %d\n", r, cx);
            }
            totalrd += r;
            *ax = r;            
            return r >= 0;
        }
        case 0x4200:{
            uint32_t off = cx;
            off <<= 16;
            off += *dx;

            uint32_t fsok = fseek(f, off, *ax & 0xf);
            uint32_t offset = ftell(f);
            *dx = offset >> 16;
            *ax = offset;
            return fsok == 0; 
        }
        case 0x3e00:{
            int ok = fclose(f);
            f = NULL;
            printf("* Total read: %ld\n", totalrd);
            totalrd = 0;
            return ok == 0;
        }
    
    }

    char error[256];

    snprintf(error, 256, "\nERROR: unhandled call: %04x\n", *ax);

    printf("\n%s\n", error);
    MessageBox(NULL, error, "Error", MB_ICONERROR);
    exit(69);
    return 0;
}

