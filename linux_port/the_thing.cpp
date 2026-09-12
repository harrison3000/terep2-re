#include <SDL3/SDL_events.h>
#include <errno.h>
#include <stdint.h>
#include <unistd.h>
#include <cstdlib>
#include <cstdio>
#include <cstdint>
#include <fcntl.h>
#include <cstring>
#include <string>

#include <SDL3/SDL.h>

#include "keys.hpp"

#include "../lifted/declrs.hpp"
#include "../lifted/gpu/types.hpp"

#define W 320
#define H 200


std::string basedir("./");

const uint8_t initialdata[] = {
    #embed "../memdumps/data.bin"
};

void DOS3Call(cpu_ctx *cpu){
    int op = cpu->AX & 0xff00;
    switch(op){
        case 0x3d00:{
            //open
            auto addr = cpu->mem_base + cpu->DX;
            std::string filename((char*)addr);
            if(filename == ""){
                printf("Tried to load a empty filename, probably better to bail out\n");
                cpu->CF = 1;
                return;
            }

            auto fullpath = basedir + filename;

            auto fd = open(fullpath.c_str(), O_RDONLY);
            printf("* trying to open: %s, returned: %d\n", filename.c_str(), fd);
            cpu->CF = fd < 0;
            cpu->AX = fd;
            return;
        }
        case 0x4800:{
            //memory alocation
            static int current_seg = 0;
            current_seg += 68; // a bit more for safety
            printf("game asked for %d paragraphs (%d bytes), we gave it a full 64k block anyway\n", cpu->BX, cpu->BX * 16);
            cpu->AX = current_seg;
            cpu->CF=0;
            return;
        }
        case 0x3f00:{
            auto fd = cpu->BX;
            if(cpu->DS != 0){
                printf("Something wrong isnt right\n");
                exit(2);
            }
            auto addr = cpu->mem_base + cpu->DX;
            auto r = read(fd, (void *)addr, cpu->CX);
            cpu->CF = r < 0;
            cpu->AX = r;
            printf("Read %ld bytes from handle: %d into address: %04x (relative to DS)\n", r, fd, cpu->DX);
            return;
        }
        case 0x4200:{
            int off = cpu->CX;
            off <<= 16;
            off += cpu->DX;

            auto offset = lseek(cpu->BX, off, cpu->AL);
            cpu->CF = offset < 0;
            cpu->DX = offset >> 16;
            cpu->AX = offset;
            return;
        }
        case 0x3e00:{
            auto ok = close(cpu->BX);
            cpu->CF = ok != 0;
            return;
        }
    }

    printf("\nunhandled Dos call: %04x\n", cpu->AX);

    exit(6);

    return;
}


int main(int argc, char **argv){
    auto cpu = new cpu_ctx;
    auto memory = malloc(2 * 1024 * 1024);
    cpu->mem_base = (uintptr_t)memory;

    memcpy(memory, initialdata, sizeof(initialdata));

    if(argc > 1){
        basedir = argv[1];
    }

    strcpy(&((char*)memory)[0xf700], "GAMBIARRA FOREVER 32!");

    printf("lets go\n");

    f_init(cpu);

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
