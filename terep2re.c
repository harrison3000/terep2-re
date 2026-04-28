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

#pragma aux handlekey parm [ax bx];
extern int far handlekey(int pnp, int scc);

char szAppName[] = "Terep Win16";

int cnt = 0;

long FAR PASCAL _export WndProc(HWND hwnd, UINT message, UINT wParam, LONG lParam) {

    switch (message) {
        case WM_PAINT:{
            unsigned int idx = 0;
            int seg = getMem16(0xdb10);

            render();

            char far *video = MK_FP(seg, 0);

            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hwnd, &ps);
            // Example pixel manipulation: 320x240 loop
            int x, y;
            for (y = 0; y < 240; y++) {
                for (x = 0; x < 320; x++) {
                    if(idx >= 64000){
                        break;
                    }

                    char val = video[idx];
                    idx++;
                    SetPixel(hdc, x, y, RGB(val, val, val));
                }
            }
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
        {
            WORD keyFlags = HIWORD(lParam);
            WORD scanCode = LOBYTE(keyFlags); 
            BOOL isKeyReleased = (keyFlags & KF_UP) == KF_UP;
            handlekey(isKeyReleased, scanCode);
            return 0;
        }

        case WM_DESTROY:
            PostQuitMessage(0);
            return 0;
    }
    return DefWindowProc(hwnd, message, wParam, lParam);
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
