#include "common.h"

#include <stdio.h>

#define SETCOLORR(i,r,g,b) {                                            \
    RGBQUAD tmp = {.rgbRed = (r), .rgbGreen = (g), .rgbBlue = (b),};    \
    blinkenImg.palette[(i)] = tmp;                                      \
}

st_image blinkenImg;
extern volatile uintptr_t all_segments[];
extern int started;

void blinkenInit(void){
    prepare_bitmap_info(256, 256, &blinkenImg, NULL);

    for(int i =0; i < 256; i++){
        //TODO find a better formula
        int r = (i * 4)  & 0xFF;
        int g = (i * 2)  & 0xFF;;
        int b = (i * 16)  & 0xFF;
        SETCOLORR(i, r, g, b);    
    }

    SETCOLORR(0, 0,     0,   0);
    SETCOLORR(255, 255, 255, 255);
}

LRESULT CALLBACK BlinkenWndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    switch (msg) {
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
                    rc.left = (i % 4) * 280 + 20;
                    rc.top  = (i / 4) * 300 + 20;
                    rc.right = rc.left + 250;
                    rc.bottom = rc.top + 30;

                    snprintf(text, sizeof(text), "Segment: %02d%s, Addr: %08x", i, isds, ptr);
                    DrawText(hdc, text, -1, &rc, DT_LEFT);

                    SetDIBitsToDevice(hdc,
                                      rc.left, rc.top + 25, 256, 256,
                                      0, 0, 0, 256,
                                      (void *)ptr, (void *)&blinkenImg,
                                      DIB_RGB_COLORS);
                }
            }

            EndPaint(hwnd, &ps);
        }
        break;

        case WM_CLOSE:
        {
            ShowWindow(hwnd, SW_HIDE);
            return 0;
        }
    }

    return DefWindowProc(hwnd, msg, wParam, lParam);
}
