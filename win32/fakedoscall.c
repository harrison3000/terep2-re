
#include <stdint.h>
#include <stdio.h>
#include <windows.h>
#include "common.h"

extern char *tmp_g_path;

int innermydoscall(uint16_t *regs, char *base_mem){
    char *path = tmp_g_path;

    uint16_t ax = regs[0];
    uint16_t bx = regs[1];
    uint16_t cx = regs[2];
    uint16_t dx = regs[3];

    static FILE* f = 0;
    static int fidx = 5;
    static int32_t totalrd = 0;

    int op = ax & 0xff00;
    
    if (op == 0x3d00){
        //open

        volatile char *filename = &base_mem[dx];
        if(filename[0] == 0){
            //empty file name, happens when track has 5 cars
            printf("Tried to load a empty filename, probably better to bail out\n");
            return 0;
        }
        if(f != NULL){
            printf("WARN: trying to open 2 files at once\n");
        }
        char ultrapath[MAX_PATH];

        snprintf(ultrapath, MAX_PATH, "%s\\%s", path, filename);

        printf("* trying to open: %s...  ", ultrapath);
        f = fopen(ultrapath, "rb");
        if(f == NULL){
            printf("FAILED\n");
            regs[0] = 2;
        }else{
            printf("OK\n");
            fidx++;
            regs[0] = fidx;
        }            
        return f != NULL;
    }
    if (op == 0x3f00){
        if(bx != fidx){
            printf("* WAT?\n");
            return 0;
        }
        volatile char *addr = &base_mem[dx];
        int32_t r = fread((void*)addr, 1, cx, f);
        if(dx != 0xf008){
            //show this message only for carX.dat loading
            printf("* Read %ld bytes into address: %08x (%04x relative to DS)!\n", r, addr, dx);
        }
        if(r != cx){
            printf("* Short read, %d, %d\n", r, cx);
        }
        totalrd += r;
        regs[0] = r;            
        return r >= 0;
    }
    if (op == 0x4200){
        uint32_t off = cx;
        off <<= 16;
        off += dx;

        uint32_t fsok = fseek(f, off, ax & 0xf);
        uint32_t offset = ftell(f);
        regs[3] = offset >> 16;
        regs[0] = offset;
        return fsok == 0; 
    }
    if (op == 0x3e00){
        int ok = fclose(f);
        f = NULL;
        printf("* Total read: %ld\n=====================\n", totalrd);
        totalrd = 0;
        return ok == 0;
    }

    char error[256];

    snprintf(error, 256, "\nERROR: unhandled call: %04x\n", ax);

    printf("\n%s\n", error);
    MessageBox(NULL, error, "Error", MB_ICONERROR);
    exit(69);
    return 0;
}
