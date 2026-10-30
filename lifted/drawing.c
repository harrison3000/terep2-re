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

      FB_ACCESS(l, c) = texture[ti];

      uu += us;
      vv += vs;
    }
  }


}

/*

   SETUP_STACK();
                              //XREF[1]:     1000:3795(c)
   cpu->SI = MEM_WORD(0xdbc4);
   cpu->DI = MEM_WORD(0xdbc6);
   INST_SUB(cpu->DI, cpu->SI);
   if(cpu->DI == 0) goto LAB_LOC_5;
   INST_INC(cpu->DI);
   INST_SHL(cpu->SI, 0x2);
   INST_PUSH(cpu->ES);
   cpu->ES = 15;
   LAB_LOC_1:
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->SI;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->SI);
   INST_SHL(cpu->DI, 0x4);
   INST_PUSH(cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI + 0xdbc8);
   cpu->CX = MEM_WORD(cpu->SI + 0xdbca);
   cpu->BX = MEM_WORD(cpu->SI + 0xdee8);
   cpu->DX = MEM_WORD(cpu->SI + 0xdeea);
   cpu->BP = MEM_WORD(cpu->SI + 0xe208);
   cpu->SI = MEM_WORD(cpu->SI + 0xe20a);
   INST_SUB(cpu->SI, cpu->BP);
   INST_SUB(cpu->DX, cpu->BX);
   INST_SUB(cpu->CX, cpu->AX);
   if(SIGNED(cpu->CX) >= 0) goto LAB_LOC_2;
   INST_ADD(cpu->AX, cpu->CX);
   INST_NEG(cpu->CX);
   INST_ADD(cpu->BX, cpu->DX);
   INST_NEG(cpu->DX);
   INST_ADD(cpu->BP, cpu->SI);
   INST_NEG(cpu->SI);
   LAB_LOC_2:
   INST_ADD(cpu->DI, cpu->AX);
   INST_INC(cpu->CX);
   INST_MOVZX(cpu->ECX, cpu->CX);
   INST_MOVSX(cpu->EAX, cpu->DX);
   INST_SHL(cpu->EAX, 0x8);
   INST_CDQ();
   INST_IDIV(cpu->ECX);
   INST_PUSH(cpu->EAX);
   INST_MOVSX(cpu->EAX, cpu->SI);
   INST_SHL(cpu->EAX, 0x8);
   INST_CDQ();
   INST_IDIV(cpu->ECX);
   cpu->EDX = cpu->EAX;
   cpu->SI = cpu->CX;
   INST_POP(cpu->ECX);
   INST_MOVZX(cpu->EBX, cpu->BX);
   INST_MOVZX(cpu->EBP, cpu->BP);
   INST_SHL(cpu->EBX, 0x8);
   INST_SHL(cpu->EBP, 0x8);
   INST_CLD();
   LAB_LOC_3:
   INST_ROR(cpu->EBX, 0x10);
   INST_ROR(cpu->EBP, 0x10);
   INST_XCHG(cpu->vars->v_upper_si, cpu->SI);
   cpu->SI = cpu->BP;
   INST_SHL(cpu->SI, 0x8);
   cpu->AL = SMEM_BYTE(cpu->FS,cpu->BX + cpu->SI);
   if(cpu->AL == 0xff) goto LAB_LOC_4;
   if(cpu->AL >= 0xf0) goto LAB_LOC_6;
   cpu->framebuffer[cpu->DI] = cpu->AL;
   LAB_LOC_4:
   INST_INC(cpu->DI);
   INST_XCHG(cpu->vars->v_upper_si, cpu->SI);
   INST_ROL(cpu->EBX, 0x10);
   INST_ROL(cpu->EBP, 0x10);
   INST_ADD(cpu->EBX, cpu->ECX);
   INST_ADD(cpu->EBP, cpu->EDX);
   INST_DEC(cpu->SI);
   if(cpu->SI != 0) goto LAB_LOC_3;
   INST_POP(cpu->SI);
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x4);
   INST_DEC(cpu->DI);
   if(cpu->DI != 0) goto LAB_LOC_1;
   INST_POP(cpu->ES);
   LAB_LOC_5:
   return;
   LAB_LOC_6:
   INST_SUB(cpu->AL, 0xf0);
   cpu->AH = cpu->AL;
   cpu->AL = cpu->framebuffer[cpu->DI];
   INST_XCHG(cpu->AX, cpu->BX);
   cpu->BL = MEM_BYTE(cpu->BX + 0x2e51);
   INST_XCHG(cpu->AX, cpu->BX);
   cpu->framebuffer[cpu->DI] = cpu->AL;
   goto LAB_LOC_4; */