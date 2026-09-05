
#include <windows.h>
#include <shlobj.h>

#define ID_BTN_FOLDER 101

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    if (msg == WM_CREATE) {
        /* Botão no canto superior esquerdo (x:10, y:10, w:120, h:30) */
        CreateWindow("BUTTON", "Select track", 
                     WS_VISIBLE | WS_CHILD | BS_PUSHBUTTON,
                     10, 10, 120, 30, hwnd, (HMENU)ID_BTN_FOLDER, NULL, NULL);
    } 
    else if (msg == WM_COMMAND && LOWORD(wParam) == ID_BTN_FOLDER) {
        char path[MAX_PATH];
        BROWSEINFO bi = {0};
        LPITEMIDLIST pidl;

        bi.hwndOwner = hwnd;
        bi.lpszTitle = "Select a track directory:";
        bi.ulFlags = BIF_RETURNONLYFSDIRS | BIF_USENEWUI | BIF_NONEWFOLDERBUTTON;

        pidl = SHBrowseForFolder(&bi);
        if (pidl) {
            if (SHGetPathFromIDList(pidl, path)) {
                MessageBox(hwnd, path, "Selected track", MB_OK);
            }
            CoTaskMemFree(pidl); /* Limpa a memória alocada pela shell */
        }
    } 
    else if (msg == WM_DESTROY) {
        PostQuitMessage(0);
    }
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

