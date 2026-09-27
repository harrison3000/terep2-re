#include <cstdint>
#include <cstdio>
#include <cstring>

#include "../lifted/gpu/types.hpp"
#include "../lifted/declrs.hpp"

extern "C" int lifted_f_init(void);
extern "C" void lifted_keys(int);
extern "C" void lifted_physics(void);
extern "C" void lifted_render(void);

extern "C" uint8_t *getBaseMem();
extern "C" void *getVideoSeg();

extern "C" int innermydoscall(uint16_t *regs, char *base_mem);

const uint8_t initialdata[] = {
    #embed "../memdumps/data.bin"
};

uint8_t all_the_mem[2*1024*1024];

cpu_ctx the_ctx;

void DOS3Call(cpu_ctx *cpu){
    if(cpu->AH == 0x48){
        //memory alocation
        static int current_seg = 0;
        current_seg += 68; // a bit more for safety
        printf("game asked for %d paragraphs (%d bytes), we gave it a full 64k block anyway\n", cpu->BX, cpu->BX * 16);
        cpu->AX = current_seg;
        cpu->CF=0;
        return;
    }

    uint16_t regs[4];
    regs[0] = the_ctx.AX;
    regs[1] = the_ctx.BX;
    regs[2] = the_ctx.CX;
    regs[3] = the_ctx.DX;

    int ok = innermydoscall(regs, (char*)all_the_mem);

    the_ctx.AX = regs[0];
    the_ctx.BX = regs[1];
    the_ctx.CX = regs[2];
    the_ctx.DX = regs[3];

    the_ctx.CF = !ok;
}

int lifted_f_init(){
    the_ctx.mem_base = (uintptr_t)all_the_mem;

    memcpy(all_the_mem, initialdata, sizeof(initialdata));
    strcpy(&((char*)all_the_mem)[0xf700], "GAMBIARRA LIFTED!");

    f_init(&the_ctx);
    return the_ctx.AX;
}

void lifted_physics(){
    FUN_timer_5680(&the_ctx);
}

void lifted_render(){
    FUN_main_render(&the_ctx);
}

void lifted_keys(int k){
    the_ctx.AX = k;
    FUN_keyboard_56df(&the_ctx);
}

uint8_t *getBaseMem(){
    return all_the_mem;
}

void *getVideoSeg(){
    auto p = all_the_mem + 0xdb10;
    auto v = ((uint16_t*)p)[0];
    return &all_the_mem[v * 1024];
}