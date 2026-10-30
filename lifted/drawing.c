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
//the terep2vb project was consulted for some very high level info
//for example, what each span is, but no code was copied

//BUG: some seams are leaking, textures of polygons near the camera go crazy


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

//3827 reimplementation
void draw_textured(cpu_ctx *cpu){
  int ini = MEM_WORD(0xdbc4);
  int end = MEM_WORD(0xdbc6);
  if(ini == end){
    return;
  }

  intpair *prs  = (intpair*)&MEM_WORD(0xdbc8);
  intpair *prsa = (intpair*)&MEM_WORD(0xdee8);
  intpair *prsb = (intpair*)&MEM_WORD(0xe208);

  uint8_t *transp_tbl = &MEM_BYTE(0x2e51);

  uint8_t *texture = (uint8_t*)cpu->segments[cpu->FS];

  for(int l = ini; l <= end; l++){
    auto p = prs[l];
    auto u = prsa[l];
    auto v = prsb[l];

    if(p.b < p.a){
      INST_XCHG(p.a, p.b);
      INST_XCHG(u.a, u.b);
      INST_XCHG(v.a, v.b);
    }

    int len = p.b - p.a;
    if(len == 0){
      continue;
    }
    int us  = ((int)u.b - (int)u.a) / len;
    int vs  = ((int)v.b - (int)v.a) / len;

    int uu = u.a;
    int vv = v.a;


    for(int c = p.a; c < p.b; c++){
      uint16_t ti = (vv & 0xff00) + ((uu & 0xff00) >> 8);
      uint8_t tex = texture[ti];
      if(tex != 0xff){
        if(tex >= 0xf0){
          tex -= 0xf0;

          uint16_t ti = tex | tex << 8;
          tex = transp_tbl[ti];
        }

        FB_ACCESS(l, c) = tex;
      }

      uu += us;
      vv += vs;
    }
  }


}
