#include <asm/ldt.h>
#include <asm/unistd.h>
#include <csignal>
#include <errno.h>
#include <sys/syscall.h>
#include <thread>
#include <unistd.h>
#include <cstdlib>
#include <cstdio>
#include <cstdint>
#include <map>
#include <ucontext.h>
#include <sys/mman.h>
#include <linux/prctl.h> 
#include <sys/prctl.h>
#include <fcntl.h>
#include <string>

#define DEFAULT_LEN (1 << 16)

extern "C" void asm_f_init();

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
        prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, backingData, DEFAULT_LEN, name);
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
            char *filename = &memchar[dx];
            auto fullpath = basedir + filename;

            auto fd = open(fullpath.c_str(), O_RDONLY);
            printf("trying to open: %s, returned: %d\n", filename, fd);
            ax = fd;
            return fd >= 0;
        }

    }

    printf("\nunhandled Dos call: %04x\n", ax);

    exit(6);

    return false;
}

int main(int argc, char **argv){
    auto a = new descritron;
    auto data = a->new_descriptor("the main data");
    auto datamem = a->getMem(data);
    readfile("memdumps/data.bin", datamem);
    
    if(argc > 1){
        basedir = argv[1];
    }
    
    printf("lets go\n");

    std::thread ch([](){
        asm_f_init();
    });
    
    auto datawindow = (volatile uint16_t*)((uintptr_t)datamem + 0xff00);

    printf("\n");

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
        printf("\r0: %04x, 1: %04x    ", datawindow[0], datawindow[1]);
        usleep(100000);
    }

    ch.join();

    return 0;
}

