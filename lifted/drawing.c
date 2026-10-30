#include <stdint.h>
#include "gpu/gpu.h"

typedef struct {
   uint16_t a, b;
} intpair;

#define FB_ACCESS(_line, _col) ({ \
   unsigned int idx = _line * 320 + _col; \
   &cpu->framebuffer[idx]; \
})[0]


//draws flat polygons
//does the same thing as 2d61
void draw_flat(cpu_ctx *cpu){
  int ini = MEM_WORD(0xdbc4);
  int end = MEM_WORD(0xdbc6);
  if(ini == end){
    return;
  }

  uint16_t color = MEM_WORD(0xdb12);
  intpair *prs = (intpair*)&MEM_WORD(0xdbc8);

  for(int l = ini; l <= end; l++){
    auto p = prs[l];
    if(p.b < p.a){
      INST_XCHG(p.a, p.b);
    }
      
    for(int c = p.a; c < p.b; c++){
      FB_ACCESS(l, c) = color & 0xff;
    }
  }


  return;
}