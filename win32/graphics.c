#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <windows.h>
#include "common.h"
#include "resource.h"

extern volatile uintptr_t all_segments[];
extern volatile call_portal_t call_portal[];
extern volatile uint8_t  base_mem[];

extern st_image gameImg;

static inline RGBQUAD blend_rgb(RGBQUAD a, RGBQUAD b);

void drawTheFramebuffer(HDC hdc,int scale){
    int videoSegSel = base_mem[0xdb10];
    void *video = (void*)all_segments[videoSegSel];
    uint8_t* ivideo = (uint8_t *)video;

    if(scale == T2_SCALE_P2){
        StretchDIBits(hdc,
            0,  0, 320*2, 200*2,
            0,  0, 320, 200,
            video, (void *)&gameImg,
            DIB_RGB_COLORS, SRCCOPY
        );
        return;
    }
    //TODO 640*480, 480/400 is 6/5 by the way

    if(scale == T2_SCALE_S2){
        rgb_image iinfo;
        prepare_rgb_info(800, 200, &iinfo);
        static RGBQUAD *img = NULL;
        if(img == NULL){
            img = malloc(800*200 * 4);
        }

        int oidx = 0;
        for(int line = 0; line < 200; line++){            
            for(int col = 0; col < 320; col+=2){
                int iidx = line*320 + col;

                RGBQUAD a = gameImg.palette[ivideo[iidx]];
                RGBQUAD b = gameImg.palette[ivideo[iidx+1]];

                img[oidx]    = a;
                img[oidx+1]  = a;
                img[oidx+2]  = blend_rgb(a,b);
                img[oidx+3]  = b;
                img[oidx+4]  = b;
                oidx += 5;
            }
        }

        StretchDIBits(hdc,
            0,  0, 800, 200*3,
            0,  0, 800, 200,
            (void *)img, (void *)&iinfo,
            DIB_RGB_COLORS, SRCCOPY
        );

        return;
    }
    if(scale == T2_SCALE_S3){
        StretchDIBits(hdc,
            0,  0, 320*5, 200*6,
            0,  0, 320, 200,
            video, (void *)&gameImg,
            DIB_RGB_COLORS, SRCCOPY
        );
        return;
    }

    //defaults to tiny 1:1
    SetDIBitsToDevice(hdc,
        0, 0, 320, 200,
        0, 0, 0, 200,
        video, (void *)&gameImg,
        DIB_RGB_COLORS);
    
}

void getScaleDimension(int scale, int *w, int *h){
    if(scale == T2_SCALE_P2){
        *w = 320*2;
        *h = 200*2;
        return;
    }
    if(scale == T2_SCALE_S2){
        *w = 800;
        *h = 600;
        return;
    }
    if(scale == T2_SCALE_S3){
        *w = 320*5;
        *h = 200*6;
        return;
    }
    if(scale == T2_GRAPH_GL){
        *w = 1280;
        *h = 720;
        return;
    }

    *w = 320;
    *h = 200;
}

static inline RGBQUAD blend_rgb(RGBQUAD a, RGBQUAD b){
    RGBQUAD ret;
    ret.rgbRed   = (a.rgbRed   + b.rgbRed)/2;
    ret.rgbGreen = (a.rgbGreen + b.rgbGreen)/2;
    ret.rgbBlue  = (a.rgbBlue  + b.rgbBlue)/2;

    return ret;
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

void prepare_rgb_info(int w, int h, rgb_image *bminfo){
    BITMAPINFOHEADER bih = {
        .biSize = sizeof(BITMAPINFOHEADER),
        .biWidth = w,
        .biHeight = -h,
        .biPlanes = 1,
        .biBitCount = 32,
        .biCompression = BI_RGB,
    };

    bminfo->info = bih;
}