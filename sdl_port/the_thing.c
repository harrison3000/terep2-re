#include <SDL3/SDL.h>
#include <SDL3/SDL_events.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <x86intrin.h> 

#include "keys.h"

#include "../insulator/insulator.h"

#define W 1440
#define H 900

int main(int argc, char **argv){
    GameSession *g;

    new_session(&g);

    const char *basedir = "./";
    if(argc > 1){
        basedir = argv[1];
    }

    auto ok = init_game(g, basedir);

    if(n_loaded_cars(g) <= 0){
        printf("no cars loaded\n");
        exit(3);
    }

    set_resolution(g, W, H);

    //TODO check n loaded cars
    printf("phase 1 ok, %d\n", ok);

    auto videoSeg = (uint8_t*)get_raw_fb(g);
    printf("video data: %08x\n", videoSeg);

    SDL_Init(SDL_INIT_VIDEO);
    SDL_Window *win = SDL_CreateWindow("SDL3 Palette", W, H, 0);
    SDL_Renderer *ren = SDL_CreateRenderer(win, NULL);
    
    // Textura de 8 bits indexados (paletizada)
    SDL_Texture *tex = SDL_CreateTexture(ren, SDL_PIXELFORMAT_INDEX8, SDL_TEXTUREACCESS_STREAMING, W, H);

    // Paleta de 256 cores (exemplo: 0 = Preto, 1 = Vermelho, 2 = Verde...)
    SDL_Color colors[256];
    uint8_t *ptr = get_palette(g);
    for(int i = 0;i<256;i++){
        colors[i].r = ptr[0];
        colors[i].g = ptr[1];
        colors[i].b = ptr[2];
        colors[i].a = 255;
        ptr += 3;
    }

    SDL_Palette *pal = SDL_CreatePalette(256);
    SDL_SetPaletteColors(pal, colors, 0, 256);
    SDL_SetTexturePalette(tex, pal);


    bool running = true;
    SDL_Event e;

    uint64_t total_time = 0;
    uint64_t frame = 0;
    double ftavg = 0;

    const Uint64 ns_per_frame = 1000000000 / 60; // ~16.6 ms em nanossegundos
    while (running) {
        Uint64 start = SDL_GetTicksNS();
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_EVENT_QUIT) running = false;
            if (e.type == SDL_EVENT_KEY_DOWN) {
                if (e.key.key == SDLK_ESCAPE) running = false;
                //TODO do the keys thing
            }
            if(e.type == SDL_EVENT_KEY_DOWN || e.type == SDL_EVENT_KEY_UP){
                auto ec = get_pc_scancode(&e);
                if(ec != 0){
                    send_key_event(g, ec);
                }
            }
        }

        uint64_t a = __rdtsc();
        render_frame(g);
        uint64_t b = __rdtsc();

        total_time += (b -a);
        frame++;
        if(frame % 64 == 0){
            double tt = total_time;
            tt *= 0.000001;
            ftavg = ftavg * 0.9 + tt * 0.1;
            printf("\rFrame time: %.03f, \tavg: %.03f     ", tt, ftavg);
            fflush(stdout);
            total_time = 0;
        }

        SDL_UpdateTexture(tex, NULL, videoSeg, W);
        SDL_RenderClear(ren);
        SDL_RenderTexture(ren, tex, NULL, NULL);
        SDL_RenderPresent(ren);

        //physics run at 120 ticks per sec
        calculate_physics(g);
        calculate_physics(g);

        // Limita a 60 FPS
        Uint64 elapsed = SDL_GetTicksNS() - start;
        if (elapsed < ns_per_frame) {
            SDL_DelayNS(ns_per_frame - elapsed);
        }
    }

    SDL_DestroyPalette(pal);
    SDL_DestroyTexture(tex);
    SDL_DestroyRenderer(ren);
    SDL_DestroyWindow(win);
    SDL_Quit();    

    finalize_game(g);


    return 0;
}
