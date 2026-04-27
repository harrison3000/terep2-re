#include <win16.h>
#include <stdio.h>

#pragma aux initgame value [ax] modify [bx cx dx si di es];
extern int far initgame();

#pragma aux getMem16 value [ax] parm [bx];
extern int far getMem16();

char szAppName[] = "Terep Win16";

long FAR PASCAL _export WndProc(HWND hwnd, UINT message, UINT wParam, LONG lParam) {

    switch (message) {
        case WM_PAINT:{
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hwnd, &ps);
            // Example pixel manipulation: 320x240 loop
            int x, y;
            for (y = 0; y < 240; y++) {
                for (x = 0; x < 320; x++) {
                    SetPixel(hdc, x, y, RGB(x % 255, y % 255, (x + y) % 255));
                }
            }
            EndPaint(hwnd, &ps);
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
                        320, 240,
                        NULL, NULL, hInstance, NULL);

    ShowWindow(hwnd, nCmdShow);
    UpdateWindow(hwnd);

    MSG msg;
    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    return msg.wParam;
}
