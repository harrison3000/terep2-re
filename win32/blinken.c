#include <stdlib.h>
#include <stdio.h>
#include <windows.h>
#include <stdint.h>

#define SETCOLORR(i,r,g,b) {                                                \
        RGBQUAD tmp = {.rgbRed = (r), .rgbGreen = (g), .rgbBlue = (b),};    \
        blinkenImg.palette[(i)] = tmp;                                      \
    }

// NOTE(gmb): Not the most elegant solution, but it will do for debug
typedef struct {
    BITMAPINFOHEADER info;
    RGBQUAD palette[256];
} st_image;
st_image blinkenImg;
extern volatile uintptr_t all_segments[];
extern void prepare_bitmap_info(int w, int h, st_image *bminfo, uint8_t *palette);
extern int started;

void blinkenInit(void){
    srand(0);   // NOTE(gmb): ensure same colors
    uint8_t pRandom[256*3];
    for(int i =0; i < 256*3; i++){
        pRandom[i] = rand() & 0xFF;
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
