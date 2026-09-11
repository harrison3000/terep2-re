#ifndef COMMON_H
#define COMMON_H

#include <windows.h>
#include <stdint.h>

typedef struct {
    BITMAPINFOHEADER info;
    RGBQUAD palette[256];
} st_image;

void prepare_bitmap_info(int w, int h, st_image *bminfo, uint8_t *palette);
void blinkenInit(void);

LRESULT CALLBACK BlinkenWndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);

#endif // COMMON_H
