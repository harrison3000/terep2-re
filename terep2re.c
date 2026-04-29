#include <win16.h>
#include <stdio.h>
#include <i86.h>

#pragma aux initgame value [ax] modify [bx cx dx si di es];
extern int far initgame();

#pragma aux render value [ax] modify [bx cx dx si di es];
extern int far render();

#pragma aux getMem16 value [ax] parm [bx];
extern int far getMem16();

extern int far physics();

#pragma aux handlekey parm [ax] modify [bx];
extern int far handlekey(int pnp);

char szAppName[] = "Terep Win16";

int cnt = 0;

typedef struct imageeee {
    BITMAPINFOHEADER info;
    RGBQUAD palette[256];
} st_image;

st_image paleta;

long FAR PASCAL _export WndProc(HWND hwnd, UINT message, UINT wParam, LONG lParam) {

    switch (message) {
        case WM_PAINT:{
            unsigned int idx = 0;
            int seg = getMem16(0xdb10);

            render();

            char far *video = MK_FP(seg, 0);

            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hwnd, &ps);
            StretchDIBits(hdc,
                0,0, 320, 200,
                0,0, 320, 200,
                video, (void far *)&paleta,
                DIB_RGB_COLORS, SRCCOPY
            );
            EndPaint(hwnd, &ps);
            return 0;
        }
        case WM_TIMER:
            physics();
            cnt = !cnt;
            if(cnt){
                InvalidateRect(hwnd, 0, TRUE);
            }
            return 0;
        
        case WM_KEYDOWN:
        case WM_KEYUP:
        //SYSKEY necessary for F10
        case WM_SYSKEYDOWN:
        case WM_SYSKEYUP:
        {
            WORD keyFlags = HIWORD(lParam);
            WORD scanCode = keyFlags & 0x7f ;            
            if(keyFlags & KF_UP){
                //key released
                scanCode += 0x80;
            }

            handlekey(scanCode);
            
            return 0;
        }

        case WM_DESTROY:
            PostQuitMessage(0);
            return 0;
    }
    return DefWindowProc(hwnd, message, wParam, lParam);
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

    int ptr = 0x1a4d;
    for(int i =0; i<256;i++){
        paleta.palette[i].rgbRed = getMem16(ptr);
        paleta.palette[i].rgbGreen = getMem16(ptr + 1);
        paleta.palette[i].rgbBlue = getMem16(ptr + 2);
        ptr += 3;
    }
}

int PASCAL WinMain(HANDLE hInstance, HANDLE hPrevInstance, LPSTR lpszCmdLine, int nCmdShow) {
    WNDCLASS wndclass;

    if (!hPrevInstance) {
        wndclass.style = CS_HREDRAW | CS_VREDRAW;
        wndclass.lpfnWndProc = WndProc;
        wndclass.cbClsExtra = 0;
        wndclass.cbWndExtra = 0;
        wndclass.hInstance = hInstance;
        wndclass.hIcon = LoadIcon(NULL, IDI_APPLICATION);
        wndclass.hCursor = LoadCursor(NULL, IDC_ARROW);
        wndclass.hbrBackground = GetStockObject(WHITE_BRUSH);
        wndclass.lpszMenuName = NULL;
        wndclass.lpszClassName = szAppName;

        RegisterClass(&wndclass);
    }

    MessageBox(NULL, "The game is about to start, hold on to your hats", "Pre-loading warning", MB_ICONASTERISK);

    int err = initgame();
    int ncars = getMem16(0x5bba);
    if(err){
        MessageBox(NULL, "Error initializing... what failed? your guess is as good as mine", "Fail", MB_ICONSTOP);
        return 1;
    }else if(ncars <= 0){
        MessageBox(NULL, "Error initializing... no cars loaded", "Fail", MB_ICONSTOP);
        return 1;
    }else{
        char theMsg[60];
        sprintf(theMsg, "OK, maybe, cars loaded: %d", ncars);

        MessageBox(NULL, theMsg, "OK, I guess",MB_ICONEXCLAMATION);
    }

    load_palette();

    HWND hwnd = CreateWindow(szAppName, "Terep2 RE",
                        WS_OVERLAPPEDWINDOW,
                        CW_USEDEFAULT, CW_USEDEFAULT,
                        340, 240,
                        NULL, NULL, hInstance, NULL);
    
    SetTimer(hwnd, 100, 1000/120, NULL);

    ShowWindow(hwnd, nCmdShow);
    UpdateWindow(hwnd);

    MSG msg;
    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    return msg.wParam;
}
