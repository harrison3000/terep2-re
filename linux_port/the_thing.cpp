#include <asm/ldt.h>
#include <asm/unistd.h>
#include <errno.h>
#include <stdint.h>
#include <sys/syscall.h>
#include <thread>
#include <unistd.h>
#include <cstdlib>
#include <cstdio>
#include <cstdint>
#include <map>
#include <sys/mman.h>
#include <linux/prctl.h> 
#include <sys/prctl.h>
#include <fcntl.h>
#include <string>

#include <SDL3/SDL.h>

#define W 320
#define H 200

#define DEFAULT_LEN (1 << 16)

extern "C" void asm_f_init();
extern "C" void asm_render();
extern "C" void asm_physics();
extern "C" void asm_keys();

struct descritron {
  unsigned int current = 0;
  std::map<int, void*> sels;

  int new_descriptor(const char* name){
    current++;
    
    void *backingData = mmap(0, DEFAULT_LEN, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_POPULATE|MAP_PRIVATE,-1,0);
    if(backingData == MAP_FAILED){
        printf("Impossible error mapping memory: %d\n", errno);
        exit(1);
    }
    if(name != NULL){
        char nome[64];
        snprintf(nome,63,"%s, num: %d", name, current);
        prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, backingData, DEFAULT_LEN, nome);
    }

    auto theaddr = (uint64_t)backingData;
    struct user_desc descritor = {
        .entry_number = current << 1,
        .base_addr = (unsigned int)theaddr,
        .limit = DEFAULT_LEN,
        .seg_32bit = 0,
        .contents = MODIFY_LDT_CONTENTS_DATA,
        .limit_in_pages = false,
        .useable = 1,
    };

    int a = syscall(SYS_modify_ldt, 1, &descritor, sizeof(descritor));
    if(a != 0){
        printf("Error writing ldt: %d\n", errno);
        exit(1);
    }

    auto seletor = (current << 4) + 0b111;
    sels[seletor] = backingData;

    printf("Allocated mem! Name: %s, Entry: %d, Selector: %04x, Addr: %08x\n", name, current, seletor, backingData);

    return seletor;
  }

  void *getMem(int seletor){
    return sels[seletor];
  }
};

descritron global_descr;

std::string basedir;

void readfile(const char *name, void * dest){
    auto f = open(name, O_RDONLY);
    if(f < 0){
        printf("Error opening: %s\n", name);
        exit(3);
    }
    read(f, dest, DEFAULT_LEN);
    close(f);
}

bool doscall(void* mem, volatile uint16_t &ax, volatile uint16_t &bx, volatile uint16_t &cx, volatile uint16_t &dx){
    int op = ax & 0xff00;
    auto memchar = (char*)mem;
    switch(op){
        case 0x3d00:{
            //open
            std::string filename(&memchar[dx]);
            if(filename == ""){
                printf("Tried to load a empty filename, probably better to bail out\n");
                return false;
            }

            auto fullpath = basedir + filename;

            auto fd = open(fullpath.c_str(), O_RDONLY);
            printf("* trying to open: %s, returned: %d\n", filename.c_str(), fd);
            ax = fd;
            return fd >= 0;
        }
        case 0x4800:{
            auto seletor = global_descr.new_descriptor("dos alloc");
            printf("* game asked for %d paragraphs (%d bytes), we gave it a full 64k block anyway\n", bx, bx * 16);
            ax = seletor;
            return true;
        }
        case 0x3f00:{
            auto fd = bx;
            auto addr = memchar + dx;
            auto r = read(fd, (void *)addr, cx);
            ax = r;
            printf("Read %ld bytes from handle: %d into address: %04x (relative to DS)\n", r, fd, dx);
            return r >= 0;
        }
        case 0x4200:{
            int off = cx;
            off <<= 16;
            off += dx;

            auto offset = lseek(bx, off, ax & 0xf);
            dx = offset >> 16;
            ax = offset;
            return offset >= 0; 
        }
        case 0x3e00:{
            auto ok = close(bx);
            return ok == 0;
        }
    }

    printf("\nunhandled Dos call: %04x\n", ax);

    exit(6);

    return false;
}

void call_init(void *datamem, volatile uint16_t* datawindow){
    std::thread ch([](){
        asm_f_init();
    });

    while(1){
        if(datawindow[0] == 0xd3ca){
            auto ok = doscall(datamem, datawindow[1], datawindow[2], datawindow[3], datawindow[4]);

            datawindow[5] = ok ? 3 : 1;
            datawindow[0] = 0x1234;
            continue;
        }
        if(datawindow[0] == 0xbeef){
            break;
        }
        //TODO some kind of timeout
    }

    printf("init ");
    
    ch.join();

    printf("ended!\n");
}

int main(int argc, char **argv){
    auto data = global_descr.new_descriptor("the main data");
    auto datamem = global_descr.getMem(data);
    readfile("memdumps/data.bin", datamem);
    
    if(argc > 1){
        basedir = argv[1];
    }

    strcpy(&((char*)datamem)[0xf700], "GAMBIARRA FOREVER 32!");

    auto datawindow = (volatile uint16_t*)((uintptr_t)datamem + 0xff00);

    printf("lets go\n");

    call_init(datamem, datawindow);

    auto videoSeg = (uint8_t *)global_descr.getMem(datawindow[0x50/2]);
    printf("video data: %04x, %08x\n", datawindow[0x50/2], videoSeg);
    
    SDL_Init(SDL_INIT_VIDEO);
    SDL_Window *win = SDL_CreateWindow("SDL3 Palette", W, H, 0);
    SDL_Renderer *ren = SDL_CreateRenderer(win, NULL);
    
    // Textura de 8 bits indexados (paletizada)
    SDL_Texture *tex = SDL_CreateTexture(ren, SDL_PIXELFORMAT_INDEX8, SDL_TEXTUREACCESS_STREAMING, W, H);

    // Paleta de 256 cores (exemplo: 0 = Preto, 1 = Vermelho, 2 = Verde...)
    SDL_Color colors[256];
    uint8_t *ptr = &((uint8_t*)datamem)[0x1a4d];
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
        }

        asm_render();
        for(int i = 0; i < W*H; i++){
            pixels[i] = videoSeg[i];
        }

        SDL_UpdateTexture(tex, NULL, pixels, W);
        SDL_RenderClear(ren);
        SDL_RenderTexture(ren, tex, NULL, NULL);
        SDL_RenderPresent(ren);

        //physics run at 120 ticks per sec
        asm_physics();
        asm_physics();

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
