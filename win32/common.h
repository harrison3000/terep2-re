#pragma once

#include <windows.h>
#include <stdint.h>

typedef struct {
    BITMAPINFOHEADER info;
    RGBQUAD palette[256];
} st_image;

void prepare_bitmap_info(int w, int h, st_image *bminfo, uint8_t *palette);
void blinkenInit(void);

LRESULT CALLBACK BlinkenWndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);

void drawTheFramebuffer(HDC hdc);
void getScaleDimension(int scale, int *w, int *h, int *s);
void write_backbuffer();

typedef struct {
    HDC        Memhdc;
    HBITMAP    Membitmap;
    HBITMAP    Memdefaultbitmap; //the 1x1 default bitmap
    int        w, h, s;

    BOOL backbuffer_invalid;

    void *framebuffer;
    st_image gameImg;
} rend_state;

BOOL sound_init(void);
void sound_deinit(void);
void sound_reset(void);
void sound_on(void);
void sound_off(void);
void adlib_callback(uint16_t);