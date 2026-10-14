#include "insulator.hpp"
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <unistd.h>
#include <fcntl.h>

#include "../lifted/gpu/types.hpp"
#include "../lifted/public_declrs.hpp"

void DOS3Call(cpu_ctx *cpu){
    auto bd = (const char*)cpu->extra_data;

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

            auto fullpath = bd + filename;

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
    g->cpu->extra_data = (uintptr_t)basedir;
    f_init(g->cpu);
    g->cpu->extra_data = 0;
    return g->cpu->AX == 0;
}

//TODO deleter