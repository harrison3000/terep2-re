#pragma once

#include <windows.h>
#include <stdint.h>

typedef struct {
    uint16_t ax, bx, cx, dx, ok;
    uint16_t _alignment;
    uint32_t caller;
} call_portal_t;

typedef struct {
    BITMAPINFOHEADER info;
    RGBQUAD palette[256];
} st_image;

typedef struct {
    BITMAPINFOHEADER info;
    RGBQUAD palette[1];
} rgb_image;

void prepare_bitmap_info(int w, int h, st_image *bminfo, uint8_t *palette);
void prepare_rgb_info(int w, int h, rgb_image *bminfo);
void blinkenInit(void);

LRESULT CALLBACK BlinkenWndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);

void drawTheFramebuffer(HDC hdc,int scale);
void getScaleDimension(int scale, int *w, int *h);