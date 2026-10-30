#include <stdint.h>
#include "gpu/gpu.h"

typedef struct {
   uint16_t a, b;
} intpair;

#define FB_ACCESS(_line, _col) ({ \
   unsigned int idx = _line * 320 + _col; \
   &cpu->framebuffer[idx]; \
})[0]

//the functions here were made by analysing the ghidra decompiler and the ASM and rewritten by hand


//draws flat polygons
//does the same thing as 2d61
//BUG: some seams are leaking... oh well, we will fix it later
void draw_flat(cpu_ctx *cpu){
  int ini = MEM_WORD(0xdbc4);
  int end = MEM_WORD(0xdbc6);
  if(ini == end){
    return;
  }

  uint16_t color = MEM_WORD(0xdb12);
  intpair *prs = (intpair*)&MEM_WORD(0xdbc8);
  bool transp = color >= 0xf0f0;
  uint8_t *transp_tbl = &MEM_BYTE(0x2e51);
  if(transp){
    color -= 0xf000;
  }

  for(int l = ini; l <= end; l++){
    auto p = prs[l];
    if(p.b < p.a){
      INST_XCHG(p.a, p.b);
    }
      
    for(int c = p.a; c < p.b; c++){
      if(transp){
        uint8_t col = FB_ACCESS(l, c);
        FB_ACCESS(l, c) = transp_tbl[col];
      }else{
        FB_ACCESS(l, c) = color & 0xff;
      }
    }
  }


  return;
}

//31d1 reimplementation
void draw_gradient(cpu_ctx *cpu){
  int ini = MEM_WORD(0xdbc4);
  int end = MEM_WORD(0xdbc6);
  if(ini == end){
    return;
  }

  intpair *prs  = (intpair*)&MEM_WORD(0xdbc8);
  intpair *cprs = (intpair*)&MEM_WORD(0xdee8);

  for(int l = ini; l <= end; l++){
    auto p = prs[l];
    auto col = cprs[l];
    if(p.b < p.a){
      INST_XCHG(p.a, p.b);
      INST_XCHG(col.a, col.b);
    }

    for(int c = p.a; c < p.b; c++){
      //FIXME this is very wrong!
      //I`ll fix later
      FB_ACCESS(l, c) = col.a >> 8;
    }
  }

}