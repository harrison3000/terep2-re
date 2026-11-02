#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <windows.h>
#include "common.h"
#include "resource.h"


extern rend_state rs;

//double buffering implementation based on this: https://www.robertelder.ca/doublebuffering/
//if I got something wrong blame him 😂😂😂😂 (actually, dont, I am joking.... or am I?)

static void freeResources(){
    if(rs.Membitmap && rs.Memhdc){
        SelectObject(rs.Memhdc, rs.Memdefaultbitmap);
    }

    if(rs.Membitmap){
        DeleteObject(rs.Membitmap);
        rs.Membitmap = NULL;
    }
    if(rs.Memhdc){
        DeleteDC(rs.Memhdc);
        rs.Memhdc = NULL;
    }
    rs.backbuffer_invalid = 1;
}

void drawTheFramebuffer(HDC hdc){
    if(rs.backbuffer_invalid || !rs.Memhdc || !rs.Membitmap){
        printf("DEBUG: recreated the backbuffer");
        freeResources();
        rs.Memhdc = CreateCompatibleDC(hdc);
        rs.Membitmap = CreateCompatibleBitmap(hdc, rs.w, rs.h);
        rs.Memdefaultbitmap = SelectObject(rs.Memhdc, rs.Membitmap);
        rs.backbuffer_invalid = 0;
    }

    BitBlt(hdc, 
        0, 0, rs.w, rs.h,
        rs.Memhdc,
        0,0, SRCCOPY
    );
}

void write_backbuffer(){
    if(rs.backbuffer_invalid){
        //not touch dat
        return;
    }

    void* fb = rs.framebuffer;

    if(rs.s == 1){
        //according to microsoft "The bitmap identified by the hbmp parameter must not be selected into a device context when the application calls this function."
        SelectObject(rs.Memhdc, rs.Memdefaultbitmap);
        SetDIBits(rs.Memhdc, rs.Membitmap,
            0, rs.h,
            fb, (void*)&rs.gameImg,
            DIB_RGB_COLORS
        );
        SelectObject(rs.Memhdc, rs.Membitmap);
    }else{
        StretchDIBits(rs.Memhdc,
            0, 0, rs.w * rs.s, rs.h * rs.s,
            0, 0, rs.w, rs.h,
            fb, (void*)&rs.gameImg,
            DIB_RGB_COLORS, SRCCOPY
        );
    }

}


void getScaleDimension(int scale, int *w, int *h, int *s){
    #define SC_RES(_id, _w, _h, _s) \
    if(scale == _id){ \
        *w = _w; \
        *h = _h; \
        *s = _s; \
        return;  \
    }


    SC_RES(T2_SCALE_P2, 320, 200, 2)
    SC_RES(T2_SCALE_S1, 640, 400, 1)
    SC_RES(T2_SCALE_S2, 800, 600, 1)
    SC_RES(T2_SCALE_S3, 960, 600, 1)
    SC_RES(T2_SCALE_S4, 1280, 720, 1)
    SC_RES(T2_SCALE_S5, 1440, 900, 1)

    *w = 320;
    *h = 200;
    *s = 1;
}

void prepare_bitmap_info(int w, int h, st_image *bminfo, uint8_t *palette){
    BITMAPINFOHEADER bih = {
        .biSize = sizeof(BITMAPINFOHEADER),
        .biPlanes = 1,
        .biBitCount = 8,
        .biCompression = BI_RGB,
    };

    bih.biWidth = w;
    bih.biHeight = -h,
    bih.biSizeImage = w * h;

    bminfo->info = bih;

    if(palette == NULL){
        return;
    }

    uint8_t *ptr = palette;
    for(int i =0; i<256;i++){
        bminfo->palette[i].rgbRed   = ptr[0];
        bminfo->palette[i].rgbGreen = ptr[1];
        bminfo->palette[i].rgbBlue  = ptr[2];
        ptr += 3;
    }
}
