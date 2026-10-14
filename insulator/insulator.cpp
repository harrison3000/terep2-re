#include "insulator.hpp"
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <string>

#include "../lifted/gpu/types.hpp"
#include "../lifted/public_declrs.hpp"


struct d3c_enviroment {
    FILE *f;
    char lastRP[512];
    int current_seg = 0;
    const char* basedir;
    bool superbad = false;
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

            auto fullpath = e->basedir + filename;

            auto fd = fopen(fullpath.c_str(), "r");
            auto ok = fd != 0 ? "OK" : "BAD";
            printf("* trying to open: %s, returned: %s\n", filename.c_str(), ok);
            e->f = fd;
            cpu->CF = fd == 0;
            cpu->AX = 97;
            return;
        }
        case 0x4800:{
            //memory alocation
            e->current_seg += 68; // a bit more for safety
            printf("game asked for %d paragraphs (%d bytes), we gave it a full 64k block anyway\n", cpu->BX, cpu->BX * 16);
            cpu->AX = e->current_seg;
            cpu->CF=0;
            return;
        }
        case 0x3f00:{
            if(cpu->BX != 97){
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
            cpu->CF = r < 0;
            cpu->AX = r;
            printf("Read %ld bytes from file into address: %04x (relative to DS)\n", r, cpu->DX);
            return;
        }
        case 0x4200:{
            uint32_t off = cpu->CX;
            off <<= 16;
            off += cpu->DX;
            int32_t soff = off;

            uint32_t fsok = fseek(e->f, soff, cpu->AL);
            uint32_t offset = ftell(e->f);

            cpu->CF = fsok != 0;
            cpu->DX = offset >> 16;
            cpu->AX = offset;
            return;
        }
        case 0x3e00:{
            int ok = fclose(e->f);
            e->f = NULL;
            e->lastRP[0] = 0;
            //printf("* File closed\n* Total read: %ld\n=====================\n", totalrd);
            //totalrd = 0;
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
    g->cpu->extra_data = 0;
    return g->cpu->AX == 0;
}

//TODO deleter