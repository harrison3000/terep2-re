
#include <stdio.h>
#include <windows.h>
#include <shlobj.h>
#include <process.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>

#define DEFAULT_LEN (1 << 16)

#define ID_BTN_FOLDER 101

extern void asm_f_init();
extern void asm_render();
extern void asm_physics();
extern void asm_keys(int16_t);

extern volatile uint32_t all_segments[];
extern volatile uint16_t data_callregs[];
extern volatile uint8_t  base_mem[];

void call_init(HWND hwnd, char path[]);

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

    MessageBox(NULL, "This is the end", "Nice", MB_OK);
}

int mydoscall(HWND hwnd, char path[]){
    volatile uint16_t *ax = &data_callregs[1];
    uint16_t bx = data_callregs[2];
    uint16_t cx = data_callregs[3];
    volatile uint16_t *dx = &data_callregs[4];

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
            char ultrapath[MAX_PATH];

            snprintf(ultrapath, MAX_PATH, "%s\\%s", path, filename);

            int fd = open(ultrapath, O_RDONLY);
            printf("* trying to open: %s, returning: %d\n", ultrapath, fd);
            *ax = fd;
            return fd >= 0;
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
    
    }

    char error[256];

    snprintf(error, 256, "\nERROR: unhandled call: %04x\n", *ax);

    printf("\n%s\n", error);
    MessageBox(NULL, error, "Error", MB_ICONERROR);
    exit(69);
    return 0;
}

