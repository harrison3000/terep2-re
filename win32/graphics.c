#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <windows.h>
#include "common.h"
#include "resource.h"


extern st_image gameImg;

static inline RGBQUAD blend_rgb(RGBQUAD a, RGBQUAD b);

void drawTheFramebuffer(HDC hdc,int scale, void* video){
    uint8_t* ivideo = (uint8_t *)video;

    if(scale == T2_SCALE_P1){
        SetDIBitsToDevice(hdc,
        0, 0, 320, 200,
        0, 0, 0, 200,
        video, (void *)&gameImg,
        DIB_RGB_COLORS);
        return;
    }

    if(scale == T2_SCALE_P2){
        StretchDIBits(hdc,
            0,  0, 320*2, 200*2,
            0,  0, 320, 200,
            video, (void *)&gameImg,
            DIB_RGB_COLORS, SRCCOPY
        );
        return;
    }

    int w = gameImg.info.biWidth;
    int h = -gameImg.info.biHeight;

    SetDIBitsToDevice(hdc,
        0, 0, w, h,
        0, 0, 0, h,
        video, (void *)&gameImg,
        DIB_RGB_COLORS);
    
}

void getScaleDimension(int scale, int *w, int *h){
    if(scale == T2_SCALE_P2){
        *w = 320*2;
        *h = 200*2;
        return;
    }
    if(scale == T2_SCALE_S1){
        *w = 800;
        *h = 600;
        return;
    }
    if(scale == T2_SCALE_S2){
        *w = 960;
        *h = 600;
        return;
    }
    if(scale == T2_SCALE_S3){
        *w = 1280;
        *h = 720;
        return;
    }

    *w = 320;
    *h = 200;
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
