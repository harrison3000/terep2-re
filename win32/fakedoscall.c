
#include <stdint.h>
#include <stdio.h>
#include <windows.h>
#include "common.h"

extern volatile uintptr_t all_segments[];
extern volatile call_portal_t call_portal[];
extern volatile uint8_t  base_mem[];

#define DEFAULT_LEN (1 << 16)

void mydoscall(void);
int innermydoscall(char path[]);

extern char *tmp_g_path;

void mydoscall(){
    char *path = tmp_g_path;
    int ok = innermydoscall(path);
    call_portal->ok = ok;
}

int innermydoscall(char path[]){
    uint16_t ax = call_portal->ax;
    uint16_t bx = call_portal->bx;
    uint16_t cx = call_portal->cx;
    uint16_t dx = call_portal->dx;

    static FILE* f = 0;
    static int fidx = 5;
    static int32_t totalrd = 0;

    int op = ax & 0xff00;
    
    if (op == 0x3d00){
        //open
        printf("* OPEN syscall called at EIP: %08x  \n", call_portal->caller);

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
            call_portal->ax = 2;
        }else{
            printf("OK\n");
            fidx++;
            call_portal->ax = fidx;
        }            
        return f != NULL;
    }
    if (op == 0x4800){
        static int seletor = 0;
        seletor++;
        void* mem = malloc(DEFAULT_LEN);
        all_segments[seletor] = (uintptr_t)mem;
        printf("* Aloc: %d, %08x, called at EIP: %08x\n", seletor, mem, call_portal->caller);
        printf("* game asked for %d paragraphs (%d bytes), we gave it a %d bytes block anyway\n", bx, bx * 16, DEFAULT_LEN);
        call_portal->ax = seletor;
        return 1;
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
            printf("* READ syscall called at EIP: %08x  \n", call_portal->caller);
            printf("* Read %ld bytes into address: %08x (%04x relative to DS)!\n", r, addr, dx);
        }
        if(r != cx){
            printf("* Short read, %d, %d\n", r, cx);
        }
        totalrd += r;
        call_portal->ax = r;            
        return r >= 0;
    }
    if (op == 0x4200){
        uint32_t off = cx;
        off <<= 16;
        off += dx;

        uint32_t fsok = fseek(f, off, ax & 0xf);
        uint32_t offset = ftell(f);
        call_portal->dx = offset >> 16;
        call_portal->ax = offset;
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
    printf("* UNKNOWN syscall called at EIP: %08x  \n", call_portal->caller);

    printf("\n%s\n", error);
    MessageBox(NULL, error, "Error", MB_ICONERROR);
    exit(69);
    return 0;
}
