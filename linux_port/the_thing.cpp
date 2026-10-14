#include <SDL3/SDL.h>
#include <SDL3/SDL_events.h>
#include <cstdio>
#include <stdint.h>




#include "keys.hpp"

#include "../insulator/insulator.hpp"

#define W 320
#define H 200





int main(int argc, char **argv){
    GameSession *g;

    new_session(&g);

    printf("phase 1 ok\n");

}
/*


    if(argc > 1){
        basedir = argv[1];
    }

    strcpy(&((char*)memory)[0xf700], "GAMBIARRA FOREVER 32!");

    printf("lets go\n");

    mem_dumper(memory, "before init");

    f_init(cpu);
    printf("AX after init: %04x\n", cpu->AX);

    mem_dumper(memory, "after init");

    FUN_main_render(cpu);

    mem_dumper(memory, "after first render");

    auto videoSegSel = ((uint16_t *)memory)[0xdb10 / 2];
    auto videoSeg = (uint8_t*)(cpu->mem_base + videoSegSel * 1024);
    printf("video data: %04x, %08x\n", videoSegSel, videoSeg);
    
    SDL_Init(SDL_INIT_VIDEO);
    SDL_Window *win = SDL_CreateWindow("SDL3 Palette", W, H, 0);
    SDL_Renderer *ren = SDL_CreateRenderer(win, NULL);
    
    // Textura de 8 bits indexados (paletizada)
    SDL_Texture *tex = SDL_CreateTexture(ren, SDL_PIXELFORMAT_INDEX8, SDL_TEXTUREACCESS_STREAMING, W, H);

    // Paleta de 256 cores (exemplo: 0 = Preto, 1 = Vermelho, 2 = Verde...)
    SDL_Color colors[256];
    uint8_t *ptr = &((uint8_t*)memory)[0x1a4d];
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

    uint8_t pixels[W * H] = {0}; // Pixeldata 8-bit

    bool running = true;
    SDL_Event e;

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
                auto ec = get_pc_scancode(e);
                if(ec != 0){
                    cpu->AX = ec;
                    FUN_keyboard_56df(cpu);
                }
            }
        }

        FUN_main_render(cpu);
        for(int i = 0; i < W*H; i++){
            pixels[i] = videoSeg[i];
        }

        SDL_UpdateTexture(tex, NULL, pixels, W);
        SDL_RenderClear(ren);
        SDL_RenderTexture(ren, tex, NULL, NULL);
        SDL_RenderPresent(ren);

        //physics run at 120 ticks per sec
        FUN_timer_5680(cpu);
        FUN_timer_5680(cpu);

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

    return 0;
}

void _adlib_callback(){
    uint16_t ax = call_portal->ax;
    //sound thing goes here
    printf("ADLIB callback called: %04x\n", ax);
}
    */