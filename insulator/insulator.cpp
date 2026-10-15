#include "insulator.hpp"
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <string>

#include "../lifted/gpu/types.hpp"
#include "../lifted/public_declrs.hpp"


struct d3c_enviroment {
    FILE *f;
    std::string lastRP;
    int current_seg = 0;
    const char* basedir;
    bool superbad = false;
    int totalrd;
};


void DOS3Call(cpu_ctx *cpu){
    auto e = (d3c_enviroment*)cpu->extra_data;

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
            if(e->f != NULL){
                printf("WARN: trying to open 2 files at once\n");
                e->superbad = true;
            }

            auto fullpath = e->basedir + filename;

            //FIXME needs to be case insensitive!
            auto fd = fopen(fullpath.c_str(), "rb");
            auto ok = fd != 0 ? "OK" : "BAD";
            printf("* trying to open: %s, returned: %s\n", filename.c_str(), ok);
            e->f = fd;
            cpu->CF = fd == 0;
            cpu->AX = 97;
            return;
        }
        case 0x4800:{
            //memory alocation
            e->current_seg++; 
            uintptr_t offset = e->current_seg * 68 * 1024; //68kb, a bit more than 64 so we have a margin
            cpu->segments[e->current_seg] = cpu->mem_base + offset;
            printf("game asked for %d paragraphs (%d bytes), we gave it a full 64k block anyway\n", cpu->BX, cpu->BX * 16);
            cpu->AX = e->current_seg;
            cpu->CF=0;
            return;
        }
        case 0x3f00:{
            if(cpu->BX != 97){
                printf("* WAT?\n");
                e->superbad = true;
                cpu->CF = 1;
                return;
            }
            if(cpu->DS != 0){
                printf("Something wrong isnt right\n");
                exit(2);
            }
            auto addr = cpu->mem_base + cpu->DX;
            auto r = fread((void *)addr, 1, cpu->CX, e->f);

            char currRP[256];
            snprintf(currRP, 256, "Read %ld bytes from file into DS:%04x", r, cpu->DX);
            if(e->lastRP != currRP){
                e->lastRP = currRP;
                printf("%s\n", currRP);
            }else{
                //read msg same as the last, just print a single period
                printf(".");
            }

            if(r != cpu->CX){
                //short read
                printf("!");
            }

            e->totalrd += r;
            cpu->CF = r < 0;
            cpu->AX = r;
            return;
        }
        case 0x4200:{
            uint32_t off = cpu->CX;
            off <<= 16;
            off += cpu->DX;
            int32_t soff = off;
            int w = cpu->AX & 0xf;

            uint32_t fsok = fseek(e->f, soff, w);
            uint32_t offset = ftell(e->f);
            printf("* SEEK: whence: %d, offset: %d, ftell result: %d\n", w, soff, offset);

            cpu->CF = fsok != 0;
            cpu->DX = offset >> 16;
            cpu->AX = offset;
            return;
        }
        case 0x3e00:{
            int ok = fclose(e->f);
            e->f = NULL;
            e->lastRP = "";
            printf("* File closed\n* Total read: %d\n=====================\n", e->totalrd);
            e->totalrd = 0;
            cpu->CF = ok != 0;
            return;
        }
    }

    printf("\nunhandled Dos call: %04x\n", cpu->AX);

    exit(6);

    return;
}

void sound_thing(cpu_ctx *cpu){
    //TODO implement sound
}

struct GameSession{
    cpu_ctx *cpu;
};

void new_session(GameSession **d){
    auto g = new GameSession;
    *d = g;

    g->cpu = initCPU();
}

bool init_game(GameSession *g, const char* basedir){
    auto e = d3c_enviroment{
        .basedir = basedir,
    };

    g->cpu->extra_data = (uintptr_t)(&e);
    f_init(g->cpu);
    //TODO actually send the superbad value to the caller
    g->cpu->extra_data = 0;
    return g->cpu->AX == 0;
}

void finalize_game(GameSession *g){
    finalizeCpu(g->cpu);
    delete g;
}


void send_key_event(GameSession *g, uint8_t key){
    g->cpu->AX = key;
    FUN_keyboard_56df(g->cpu);
}

void calculate_physics(GameSession *g){
    FUN_timer_5680(g->cpu);

}

void render_frame(GameSession *g){
    FUN_main_render(g->cpu);
}


//these will be deleted ASAP!
uintptr_t get_memory(GameSession *g, uintptr_t offset){
    return g->cpu->mem_base + offset;
}

uintptr_t get_segment(GameSession *g, uintptr_t seletor){
    return g->cpu->segments[seletor];
}