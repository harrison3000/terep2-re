#include "gpu/gpu.hpp"
#include "declrs.hpp"
#include "variables.hpp"


void f_init(cpu_ctx *cpu){
   MEM_WORD(0x5bba) = -2; //just to be sure

   MEM_WORD(0xec50) = 0x78; //= 00C8h
   MEM_DWORD(0x6a) = 0x1800; //= 00000C00h
   MEM_WORD(0xe9e2) = 0x800; //= 0320h
   MEM_WORD(0xe9e4) = 0xf000; //= F000h
   MEM_WORD(0xdbc0) = 0x0;
   MEM_WORD(0xdbb8) = 0xa0; //= 00A0h
   MEM_WORD(0xdbc2) = 0x13f; //= 013Fh
   MEM_WORD(0xdbbc) = 0x0;
   MEM_WORD(0xdbba) = 0x50; //= 0064h
   MEM_WORD(0xdbbe) = 0xc7; //= 00C7h
   cpu->DX = 0x1a3d;
   cpu->AL = 0x0;
   cpu->AH = 0x3d;
   DOS3Call(cpu);
   cpu->BX = cpu->AX;
   JUMP«JC» goto LAB_LOC_1;
   cpu->DX = 0xe9e2;
   cpu->CX = 0x2;
   cpu->AH = 0x3f;
   DOS3Call(cpu);
   cpu->DX = 0xe9e4;
   cpu->CX = 0x2;
   cpu->AH = 0x3f;
   DOS3Call(cpu);
   cpu->AH = 0x3e;
   DOS3Call(cpu);
   LAB_LOC_1:
   cpu->AH = 0x48;
   cpu->BX = 0x1000;
   DOS3Call(cpu);
   JUMP«JC» goto LAB_LOC_6;
   MEM_WORD(0x1a45) = cpu->AX;
   cpu->GS = cpu->AX;
   cpu->AH = 0x48;
   cpu->BX = 0x1000;
   DOS3Call(cpu);
   JUMP«JC» goto LAB_LOC_6;
   MEM_WORD(0x1a47) = cpu->AX;
   cpu->FS = cpu->AX;
   cpu->AH = 0x48;
   cpu->BX = 0x1000;
   DOS3Call(cpu);
   JUMP«JC» goto LAB_LOC_6;
   MEM_WORD(0x1a49) = cpu->AX;
   cpu->AH = 0x48;
   cpu->BX = 0x1000;
   DOS3Call(cpu);
   JUMP«JC» goto LAB_LOC_6;
   MEM_WORD(0x1a4b) = cpu->AX;
   FUN_1000_24c0(cpu);
   FUN_1000_255c(cpu);
   MEM_WORD(0x5bba) = 0x0; //= 0001h
   cpu->DI = 0x5bd0;
   MEM_WORD(0x5bbc) = cpu->DI;
   cpu->SI = 0; //was a XOR
   load_cars_loop:
   cpu->DI = MEM_WORD(cpu->SI + 0x5bbc);
   cpu->AX = cpu->SI;
   INST_NEG(cpu->AX);
   INST_SHL(cpu->AX, 0x7);
   INST_ADD(cpu->AX, 0x8000);
   cpu->BX = 0x7a00;
   cpu->DX = MEM_WORD(cpu->SI + 0x5af7); //= 5B01h
   INST_PUSH(cpu->SI);
   FUN_1000_2454(cpu);
   INST_POP(cpu->SI);
   JUMP«JC» goto LAB_LOC_5;
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->DI);
   INST_PUSH(cpu->SI);
   cpu->SI = MEM_WORD(cpu->SI + 0x5bbc);
   FUN_1000_2431(cpu);
   INST_POP(cpu->SI);
   INST_POP(cpu->DI);
   INST_POP(cpu->AX);
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->DI);
   INST_PUSH(cpu->SI);
   cpu->DX = MEM_WORD(cpu->SI + 0x5b2e);
   cpu->DX = cpu->DX;
   cpu->AL = 0x0;
   cpu->AH = 0x3d;
   DOS3Call(cpu);
   cpu->BX = cpu->AX;
   JUMP«JC» goto LAB_LOC_4;
   FUN_1000_5a95(cpu);
   INST_PUSH(cpu->BX);
   INST_CMP(cpu->AX, 0x100);
   JUMP«JLE» goto LAB_LOC_2;
   cpu->AX = 0x100;
   LAB_LOC_2:
   INST_MUL(cpu->CX);
   INST_SHR(cpu->AX, 0x4);
   INST_INC(cpu->AX);
   cpu->BX = cpu->AX;
   cpu->AH = 0x48;
   DOS3Call(cpu);
   INST_POP(cpu->BX);
   JUMP«JC» goto LAB_LOC_3;
   INST_POP(cpu->SI);
   INST_PUSH(cpu->SI);
   cpu->DI = MEM_WORD(cpu->SI + 0x5bbc);
   MEM_WORD(cpu->DI + 0x1e) = cpu->AX;
   cpu->ES = cpu->AX;
   cpu->DI = 0; //was a XOR
   FUN_1000_5acf(cpu);
   LAB_LOC_3:
   cpu->AH = 0x3e;
   DOS3Call(cpu);
   LAB_LOC_4:
   INST_POP(cpu->SI);
   INST_POP(cpu->DI);
   INST_POP(cpu->AX);
   INST_INC(MEM_WORD(0x5bba)); //= 0001h
   cpu->DI = MEM_WORD(cpu->SI + 0x5bbc);
   INST_ADD(cpu->DI, cpu->AX);
   INST_INC(cpu->SI);
   INST_INC(cpu->SI);
   MEM_WORD(cpu->SI + 0x5bbc) = cpu->DI;
   goto load_cars_loop;

   LAB_LOC_5:
   FUN_1000_2b70(cpu);
   JUMP«JC» goto LAB_LOC_6;
    //CALL        FUN_1000_57e0 ;FIXME restore sound!
   MEM_WORD(0x6f) = cpu->DX;
   MEM_WORD(0x71) = cpu->AX;

   MEM_BYTE(0x6e) = 0x1;

   cpu->AX = 0;
   return;

   LAB_LOC_6:
   cpu->AX = 1;
   return;

}

void f_cam_select(cpu_ctx *cpu){
   INST_SHL(cpu->BX, 1);
    
   switch(cpu->BX){
      case 0: goto CAMERA_1;
      case 2: goto CAMERA_2;
      case 4: goto CAMERA_3;
      case 6: goto CAMERA_4;
      case 8: goto CAMERA_5;
      default: __builtin_trap();
   }


   CAMERA_1:
   F_0693(cpu); //= 0693h
   return;

   CAMERA_2:
   F_073f(cpu); //= 073Fh
   return;

   CAMERA_3:
   F_0828(cpu); //= 0828h
   return;

   CAMERA_4:
   F_0893(cpu); //= 0893h
   return;

   CAMERA_5:
   F_0948(cpu);
   return;

}

void FUN_main_render(cpu_ctx *cpu){
    //needed now that it runs on paint message
   cpu->FS = MEM_WORD(0x1a47);
   cpu->GS = MEM_WORD(0x1a45);

   INST_TEST(MEM_BYTE(0x7d), 0xff);
   JUMP«JNZ» goto LAB_LOC_5;

    //singleplayer
   MEM_WORD(0xdbc0) = 0x0;
   MEM_WORD(0xdbb8) = 0xa0; //= 00A0h
   MEM_WORD(0xdbc2) = 0x13f; //= 013Fh
   MEM_WORD(0xdbbc) = 0x0;
   MEM_WORD(0xdbba) = 0x50; //= 0064h
   MEM_WORD(0xdbbe) = 0xc7; //= 00C7h
   cpu->SI = MEM_WORD(0xa4);
   INST_SHL(cpu->SI, 0x1);
   cpu->SI = MEM_WORD(cpu->SI + 0x5bbc);
   INST_MOVZX(cpu->BX, MEM_BYTE(0x7e)); //= 03h
   cpu->DI = 0x80;
   f_cam_select(cpu);
   cpu->BX = MEM_WORD(0xc6);
   FUN_1000_2aad(cpu);
   INST_SAR(cpu->AX, 0x7);
   MEM_WORD(0x5f7) = cpu->AX;
   FUN_1000_2ad8(cpu);
   INST_SAR(cpu->AX, 0x7);
   MEM_WORD(0x5f9) = cpu->AX;
   cpu->SI = 0xc2;
   cpu->DI = 0xce;
   FUN_1000_2989(cpu);
   FUN_1000_27f1(cpu);
   cpu->EAX = 0xffffffff;
   FUN_1000_2b98(cpu);
   FUN_1000_1965(cpu);
   FUN_1000_0b25(cpu);
   cpu->SI = MEM_WORD(0xa4);
   INST_SHL(cpu->SI, 0x1);
   cpu->SI = MEM_WORD(cpu->SI + 0x5bbc);
   cpu->CX = MEM_WORD(cpu->SI + 0x8);
   cpu->EAX = MEM_DWORD(cpu->SI + 0x42);
   INST_ADD(cpu->EAX, MEM_DWORD(cpu->SI + 0x46));
   INST_SAR(cpu->EAX, 0xe);
   cpu->EBX = MEM_DWORD(cpu->SI + 0x4a);
   INST_ADD(cpu->EBX, MEM_DWORD(cpu->SI + 0x4e));
   INST_SAR(cpu->EBX, 0xe);
   INST_TEST(cpu->CX, cpu->CX);
   JUMP«JZ» goto LAB_LOC_2;
   INST_DEC(cpu->CX);
   JUMP«JZ» goto LAB_LOC_1;
   INST_ADD(cpu->EAX, cpu->EBX);
   INST_SAR(cpu->EAX, 0x1);
   LAB_LOC_1:
   cpu->EBX = cpu->EAX;
   LAB_LOC_2:
   INST_AND(cpu->BX, cpu->BX);
   JUMP«JGE» goto LAB_LOC_3;
   INST_NEG(cpu->BX);
   LAB_LOC_3:
   INST_ADD(cpu->BX, 0x1030);
   cpu->CX = MEM_WORD(cpu->SI + 0xc);
   INST_SAR(cpu->CX, 0x9);
   INST_AND(cpu->CX, cpu->CX);
   JUMP«JGE» goto LAB_LOC_4;
   INST_NEG(cpu->CX);
   LAB_LOC_4:
   INST_ADD(cpu->CX, 0x2c);
   cpu->AL = 0x0;
                              // FWD[2]:     1000:5b01(c),15cd:006f(R)
   FUN_1000_5831(cpu); //was indirect
   goto LAB_LOC_14;
   LAB_LOC_5:
    //split-screen
   MEM_WORD(0xdbc0) = 0x0;
   MEM_WORD(0xdbb8) = 0xa0; //= 00A0h
   MEM_WORD(0xdbc2) = 0x13f; //= 013Fh
   MEM_WORD(0xdbbc) = 0x0;
   MEM_WORD(0xdbba) = 0x32; //= 0064h
   MEM_WORD(0xdbbe) = 0x62; //= 00C7h
   cpu->SI = MEM_WORD(0xa4);
   INST_SHL(cpu->SI, 0x1);
   cpu->SI = MEM_WORD(cpu->SI + 0x5bbc);
   INST_MOVZX(cpu->BX, MEM_BYTE(0x7e)); //= 03h
   cpu->DI = 0x80;
   f_cam_select(cpu);
   cpu->BX = MEM_WORD(0xc6);
   FUN_1000_2aad(cpu);
   INST_SAR(cpu->AX, 0x7);
   MEM_WORD(0x5f7) = cpu->AX;
   FUN_1000_2ad8(cpu);
   INST_SAR(cpu->AX, 0x7);
   MEM_WORD(0x5f9) = cpu->AX;
   cpu->SI = 0xc2;
   cpu->DI = 0xce;
   FUN_1000_2989(cpu);
   FUN_1000_27f1(cpu);
   cpu->EAX = 0xffffffff;
   FUN_1000_2b98(cpu);
   FUN_1000_1965(cpu);
   FUN_1000_0b25(cpu);
   cpu->SI = MEM_WORD(0xa4);
   INST_SHL(cpu->SI, 0x1);
   cpu->SI = MEM_WORD(cpu->SI + 0x5bbc);
   cpu->CX = MEM_WORD(cpu->SI + 0x8);
   cpu->EAX = MEM_DWORD(cpu->SI + 0x42);
   INST_ADD(cpu->EAX, MEM_DWORD(cpu->SI + 0x46));
   INST_SAR(cpu->EAX, 0xe);
   cpu->EBX = MEM_DWORD(cpu->SI + 0x4a);
   INST_ADD(cpu->EBX, MEM_DWORD(cpu->SI + 0x4e));
   INST_SAR(cpu->EBX, 0xe);
   INST_TEST(cpu->CX, cpu->CX);
   JUMP«JZ» goto LAB_LOC_7;
   INST_DEC(cpu->CX);
   JUMP«JZ» goto LAB_LOC_6;
   INST_ADD(cpu->EAX, cpu->EBX);
   INST_SAR(cpu->EAX, 0x1);
   LAB_LOC_6:
   cpu->EBX = cpu->EAX;
   LAB_LOC_7:
   INST_AND(cpu->BX, cpu->BX);
   JUMP«JGE» goto LAB_LOC_8;
   INST_NEG(cpu->BX);
   LAB_LOC_8:
   INST_ADD(cpu->BX, 0x1030);
   cpu->CX = MEM_WORD(cpu->SI + 0xc);
   INST_SAR(cpu->CX, 0x9);
   INST_AND(cpu->CX, cpu->CX);
   JUMP«JGE» goto LAB_LOC_9;
   INST_NEG(cpu->CX);
   LAB_LOC_9:
   INST_ADD(cpu->CX, 0x2c);
   cpu->AL = 0x0;
                              // FWD[2]:     1000:5b01(c),15cd:006f(R)
   FUN_1000_5831(cpu); //was indirect
   MEM_WORD(0xdbc0) = 0x0;
   MEM_WORD(0xdbb8) = 0xa0; //= 00A0h
   MEM_WORD(0xdbc2) = 0x13f; //= 013Fh
   MEM_WORD(0xdbbc) = 0x64;
   MEM_WORD(0xdbba) = 0x96; //= 0064h
   MEM_WORD(0xdbbe) = 0xc7; //= 00C7h
   cpu->SI = MEM_WORD(0xa6);
   INST_SHL(cpu->SI, 0x1);
   cpu->SI = MEM_WORD(cpu->SI + 0x5bbc);
   INST_MOVZX(cpu->BX, MEM_BYTE(0x7f)); //= 03h
   cpu->DI = 0x92;
   f_cam_select(cpu);
   cpu->BX = MEM_WORD(0xc6);
   FUN_1000_2aad(cpu);
   INST_SAR(cpu->AX, 0x7);
   MEM_WORD(0x5f7) = cpu->AX;
   FUN_1000_2ad8(cpu);
   INST_SAR(cpu->AX, 0x7);
   MEM_WORD(0x5f9) = cpu->AX;
   cpu->SI = 0xc2;
   cpu->DI = 0xce;
   FUN_1000_2989(cpu);
   FUN_1000_27f1(cpu);
   FUN_1000_1965(cpu);
   FUN_1000_0b25(cpu);
   cpu->SI = MEM_WORD(0xa6);
   INST_SHL(cpu->SI, 0x1);
   cpu->SI = MEM_WORD(cpu->SI + 0x5bbc);
   cpu->CX = MEM_WORD(cpu->SI + 0x8);
   cpu->EAX = MEM_DWORD(cpu->SI + 0x42);
   INST_ADD(cpu->EAX, MEM_DWORD(cpu->SI + 0x46));
   INST_SAR(cpu->EAX, 0xe);
   cpu->EBX = MEM_DWORD(cpu->SI + 0x4a);
   INST_ADD(cpu->EBX, MEM_DWORD(cpu->SI + 0x4e));
   INST_SAR(cpu->EBX, 0xe);
   INST_TEST(cpu->CX, cpu->CX);
   JUMP«JZ» goto LAB_LOC_11;
   INST_DEC(cpu->CX);
   JUMP«JZ» goto LAB_LOC_10;
   INST_ADD(cpu->EAX, cpu->EBX);
   INST_SAR(cpu->EAX, 0x1);
   LAB_LOC_10:
   cpu->EBX = cpu->EAX;
   LAB_LOC_11:
   INST_AND(cpu->BX, cpu->BX);
   JUMP«JGE» goto LAB_LOC_12;
   INST_NEG(cpu->BX);
   LAB_LOC_12:
   INST_ADD(cpu->BX, 0x1030);
   cpu->CX = MEM_WORD(cpu->SI + 0xc);
   INST_SAR(cpu->CX, 0x9);
   INST_AND(cpu->CX, cpu->CX);
   JUMP«JGE» goto LAB_LOC_13;
   INST_NEG(cpu->CX);
   LAB_LOC_13:
   INST_ADD(cpu->CX, 0x2c);
   cpu->AL = 0x1;
                              // FWD[2]:     1000:5b01(c),15cd:006f(R)
   FUN_1000_5831(cpu); //was indirect
   LAB_LOC_14:
   MEM_WORD(0xdbc0) = 0x0;
   MEM_WORD(0xdbb8) = 0xa0; //= 00A0h
   MEM_WORD(0xdbc2) = 0x13f; //= 013Fh
   MEM_WORD(0xdbbc) = 0x0;
   MEM_WORD(0xdbba) = 0x50; //= 0064h
   MEM_WORD(0xdbbe) = 0xc7; //= 00C7h
   cpu->SI = 0x0;
   cpu->AX = 0xa;
   cpu->BX = 0xa;
   cpu->CL = 0xf;
   FUN_1000_5940_render_text(cpu);
   cpu->SI = 0x4b;
   cpu->AX = 0x64;
   cpu->BX = 0xbe;
   cpu->CL = 0xf;
   FUN_1000_5940_render_text(cpu);

   // unknown ->
   // unknown ->MOVSI, //string
   cpu->AX = 5; //X
   cpu->BX = 190; //Y
   cpu->CL = giracor; //color
   INST_SHR(cpu->CL, 2);
   FUN_1000_5940_render_text(cpu);
   INST_INC(giracor);

   FUN_1000_2baa(cpu);
   INST_TEST(CSD_DAT_keys_571e[78], 0x80);
   JUMP«JS» goto LAB_LOC_15;
   INST_CMP(MEM_WORD(0x11c), 0x3e8); //= 0100h
   JUMP«JG» goto LAB_LOC_15;
   INST_ADD(MEM_WORD(0x11c), 0x14); //= 0100h
   LAB_LOC_15:
   INST_TEST(CSD_DAT_keys_571e[74], 0x80);
   JUMP«JS» goto LAB_LOC_16;
   INST_CMP(MEM_WORD(0x11c), 0x32); //= 0100h
   JUMP«JL» goto LAB_LOC_16;
   INST_SUB(MEM_WORD(0x11c), 0x14); //= 0100h
   LAB_LOC_16:
   INST_TEST(CSD_DAT_keys_571e[53], 0x80);
   JUMP«JS» goto LAB_LOC_17;
   INST_CMP(MEM_WORD(0x11e), 0x1000); //= 0400h
   JUMP«JG» goto LAB_LOC_17;
   INST_ADD(MEM_WORD(0x11e), 0x28); //= 0400h
   LAB_LOC_17:
   INST_TEST(CSD_DAT_keys_571e[55], 0x80);
   JUMP«JS» goto LAB_LOC_18;
   INST_CMP(MEM_WORD(0x11e), 0x100); //= 0400h
   JUMP«JL» goto LAB_LOC_18;
   INST_SUB(MEM_WORD(0x11e), 0x28); //= 0400h
   LAB_LOC_18:
   cpu->AL = CSD_DAT_keys_571e[0];
    //Esc
   INST_CMP(cpu->AL, 0x1);
   JUMP«JZ» goto LAB_LOC_33;

    //Tab
   INST_CMP(cpu->AL, 0xf);
   JUMP«JZ» goto LAB_LOC_28;

    //Q
   INST_CMP(cpu->AL, 0x10);
   JUMP«JZ» goto LAB_LOC_30;

    //F1
   INST_CMP(cpu->AL, 0x3b);
   JUMP«JZ» goto LAB_LOC_20;

    //F2
   INST_CMP(cpu->AL, 0x3c);
   JUMP«JZ» goto LAB_LOC_21;

    //F3
   INST_CMP(cpu->AL, 0x3d);
   JUMP«JZ» goto LAB_LOC_22;

    //F4
   INST_CMP(cpu->AL, 0x3e);
   JUMP«JZ» goto LAB_LOC_23;

    //F5
   INST_CMP(cpu->AL, 0x3f);
   JUMP«JZ» goto LAB_LOC_24;

    //F6
   INST_CMP(cpu->AL, 0x40);
   JUMP«JZ» goto CYCLE_2ND_CAM;

    //[
   INST_CMP(cpu->AL, 0x1a);
   JUMP«JZ» goto LAB_LOC_26;

    //]
   INST_CMP(cpu->AL, 0x1b);
   JUMP«JZ» goto LAB_LOC_27;

    //F10
   INST_CMP(cpu->AL, 0x44);
   JUMP«JZ» goto LAB_LOC_32;

    //F9
   INST_CMP(cpu->AL, 0x43);
   JUMP«JZ» goto LAB_LOC_25;
   cpu->AX = 0;
   return;
   LAB_LOC_19:
                              //             1000:05db(j),1000:05e2(j),1000:05ea(j),1000:05f2(j),
                              //             1000:0607(j),1000:061c(j),1000:0624(j)
   CSD_DAT_keys_571e[0] = 0x0;
   cpu->AX = 0;
   return;
   LAB_LOC_20:
   MEM_BYTE(0x7e) = 0x0; //= 03h
   goto LAB_LOC_19;
   LAB_LOC_21:
   MEM_BYTE(0x7e) = 0x1; //= 03h
   goto LAB_LOC_19;
   LAB_LOC_22:
   MEM_BYTE(0x7e) = 0x2; //= 03h
   goto LAB_LOC_19;
   LAB_LOC_23:
   MEM_BYTE(0x7e) = 0x3; //= 03h
   goto LAB_LOC_19;
   LAB_LOC_24:
   MEM_BYTE(0x7e) = 0x4; //= 03h
   goto LAB_LOC_19;
   LAB_LOC_25:
   INST_XOR(MEM_BYTE(0x7d), 0x1);
   goto LAB_LOC_19;
   LAB_LOC_26:
   INST_ADD(MEM_DWORD(0x6a), 0x32); //= 00000C00h
   goto LAB_LOC_19;
   LAB_LOC_27:
   INST_SUB(MEM_DWORD(0x6a), 0x32); //= 00000C00h
   goto LAB_LOC_19;
   LAB_LOC_28:
   cpu->SI = MEM_WORD(0xa4);
   INST_INC(cpu->SI);
   INST_CMP(cpu->SI, MEM_WORD(0x5bba)); //= 0001h
   JUMP«JC» goto LAB_LOC_29;
   cpu->SI = 0; //was a XOR
   LAB_LOC_29:
   MEM_WORD(0xa4) = cpu->SI;
   goto LAB_LOC_19;
   LAB_LOC_30:
   cpu->SI = MEM_WORD(0xa6);
   INST_INC(cpu->SI);
   INST_CMP(cpu->SI, MEM_WORD(0x5bba)); //= 0001h
   JUMP«JC» goto LAB_LOC_31;
   cpu->SI = 0; //was a XOR
   LAB_LOC_31:
   MEM_WORD(0xa6) = cpu->SI;
   goto LAB_LOC_19;
   LAB_LOC_32:
   INST_XOR(MEM_WORD(0x5f5), 0x600); //= 0600h
   goto LAB_LOC_19;

   CYCLE_2ND_CAM:
   INST_INC(MEM_BYTE(0x7f));
   INST_CMP(MEM_BYTE(0x7f), 5);
   JUMP«JL» goto LAB_LOC_19;
   MEM_BYTE(0x7f) = 0;
   JUMP«JL» goto LAB_LOC_19;

 // 1000:0653 [UNDEFINED BYTES REMOVED]

   LAB_LOC_33:
   cpu->AX = 1;
   return;

 // 1000:0692 [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void F_0693(cpu_ctx *cpu){
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI + 0x20));
   cpu->EAX = MEM_DWORD(cpu->SI);
   MEM_DWORD(0xaa) = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x4);
   MEM_DWORD(0xae) = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x8);
   MEM_DWORD(0xb2) = cpu->EAX;
   INST_POP(cpu->SI);
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   INST_INC(cpu->SI);
   INST_INC(cpu->SI);
   FUN_1000_1091(cpu);
   MEM_DWORD(0xe0) = cpu->EAX;
   MEM_DWORD(0xe4) = cpu->EBX;
   MEM_DWORD(0xe8) = cpu->ECX;
   FUN_1000_10b6(cpu);
   MEM_DWORD(0xec) = cpu->EAX;
   MEM_DWORD(0xf0) = cpu->EBX;
   MEM_DWORD(0xf4) = cpu->ECX;
   INST_POP(cpu->SI);
   cpu->AX = MEM_WORD(0xed);
   cpu->BX = MEM_WORD(0xf1);
   INST_NEG(cpu->AX);
   FUN_1000_2b08(cpu);
   INST_PUSH(cpu->AX);
   INST_SUB(cpu->AX, MEM_WORD(0xc6));
   INST_ADD(MEM_WORD(0xc6), cpu->AX);
   cpu->AX = MEM_WORD(0xe1);
   cpu->BX = MEM_WORD(0xe5);
   FUN_1000_26dd(cpu);
   cpu->CX = cpu->AX;
   cpu->AX = MEM_WORD(0xe1);
   cpu->BX = MEM_WORD(0xe5);
   INST_NEG(cpu->AX);
   FUN_1000_2b08(cpu);
   INST_POP(cpu->BX);
   INST_SUB(cpu->BX, cpu->AX);
   cpu->BX = cpu->CX;
   JUMP«JNS» goto LAB_LOC_1;
   INST_NEG(cpu->BX);
   LAB_LOC_1:
   cpu->AX = MEM_WORD(0xe9);
   FUN_1000_2b08(cpu);
   INST_NEG(cpu->AX);
   INST_SUB(cpu->AX, MEM_WORD(0xc2));
   INST_ADD(MEM_WORD(0xc2), cpu->AX);
   cpu->AX = MEM_WORD(0xed);
   cpu->BX = MEM_WORD(0xf1);
   cpu->CX = MEM_WORD(0xf5);
   FUN_1000_26dd(cpu);
   cpu->BX = cpu->AX;
   cpu->AX = cpu->CX;
   FUN_1000_2b08(cpu);
   INST_NEG(cpu->AX);
   INST_SUB(cpu->AX, MEM_WORD(0xc4));
   INST_ADD(MEM_WORD(0xc4), cpu->AX);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void F_073f(cpu_ctx *cpu){
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI + 0x20));
   cpu->EAX = MEM_DWORD(cpu->SI);
   MEM_DWORD(0xaa) = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x4);
   MEM_DWORD(0xae) = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x8);
   MEM_DWORD(0xb2) = cpu->EAX;
   INST_POP(cpu->SI);
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   INST_INC(cpu->SI);
   INST_INC(cpu->SI);
   FUN_1000_1091(cpu);
   MEM_DWORD(0xe0) = cpu->EAX;
   MEM_DWORD(0xe4) = cpu->EBX;
   MEM_DWORD(0xe8) = cpu->ECX;
   FUN_1000_10b6(cpu);
   MEM_DWORD(0xec) = cpu->EAX;
   MEM_DWORD(0xf0) = cpu->EBX;
   MEM_DWORD(0xf4) = cpu->ECX;
   INST_POP(cpu->SI);
   cpu->AX = MEM_WORD(0xed);
   cpu->BX = MEM_WORD(0xf1);
   INST_NEG(cpu->EAX);
   FUN_1000_2b08(cpu);
   INST_SUB(cpu->AX, MEM_WORD(0xc6));
   INST_ADD(MEM_WORD(0xc6), cpu->AX);
   cpu->BX = MEM_WORD(0xc6);
   FUN_1000_2ad8(cpu);
   INST_NEG(cpu->AX);
   INST_SAR(cpu->AX, 0x5);
   INST_ADD(cpu->AX, MEM_WORD(0xb0));
   INST_PUSH(cpu->AX);
   FUN_1000_2aad(cpu);
   INST_SAR(cpu->AX, 0x5);
   INST_ADD(cpu->AX, MEM_WORD(0xac));
   INST_POP(cpu->BX);
   FUN_1000_25c5(cpu);
   INST_SUB(cpu->AX, MEM_WORD(0xb4));
   cpu->BX = 0x3ff;
   FUN_1000_2b08(cpu);
   INST_SUB(cpu->AX, MEM_WORD(0xc4));
   INST_SAR(cpu->AX, 0x2);
   INST_ADD(MEM_WORD(0xc4), cpu->AX);
   cpu->BX = MEM_WORD(0xc6);
   INST_ADD(cpu->BX, 0x2000);
   FUN_1000_2ad8(cpu);
   INST_NEG(cpu->AX);
   INST_SAR(cpu->AX, 0x6);
   INST_ADD(cpu->AX, MEM_WORD(0xb0));
   INST_PUSH(cpu->AX);
   FUN_1000_2aad(cpu);
   INST_SAR(cpu->AX, 0x6);
   INST_POP(cpu->BX);
   INST_ADD(cpu->AX, MEM_WORD(0xac));
   FUN_1000_25c5(cpu);
   INST_PUSH(cpu->AX);
   cpu->BX = MEM_WORD(0xc6);
   INST_SUB(cpu->BX, 0x2000);
   FUN_1000_2ad8(cpu);
   INST_NEG(cpu->AX);
   INST_SAR(cpu->AX, 0x6);
   INST_ADD(cpu->AX, MEM_WORD(0xb0));
   INST_PUSH(cpu->AX);
   FUN_1000_2aad(cpu);
   INST_SAR(cpu->AX, 0x6);
   INST_POP(cpu->BX);
   INST_ADD(cpu->AX, MEM_WORD(0xac));
   FUN_1000_25c5(cpu);
   INST_POP(cpu->BX);
   INST_SUB(cpu->AX, cpu->BX);
   cpu->BX = 0x1ff;
   FUN_1000_2b08(cpu);
   INST_SUB(cpu->AX, MEM_WORD(0xc2));
   INST_SAR(cpu->AX, 0x2);
   INST_ADD(MEM_WORD(0xc2), cpu->AX);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void F_0828(cpu_ctx *cpu){
   cpu->EAX = MEM_DWORD(cpu->DI);
   MEM_DWORD(0xaa) = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->DI + 0x4);
   MEM_DWORD(0xae) = cpu->EAX;
   cpu->AX = MEM_WORD(0xac);
   cpu->BX = MEM_WORD(0xb0);
   FUN_1000_25c5(cpu);
   INST_ADD(cpu->AX, MEM_WORD(0x11c));
   INST_SHL(cpu->EAX, 0x10);
   MEM_DWORD(0xb2) = cpu->EAX;
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI + 0x20));
   cpu->AX = MEM_WORD(cpu->SI + 0x2);
   INST_SUB(cpu->AX, MEM_WORD(0xac));
   cpu->BX = MEM_WORD(cpu->SI + 0x6);
   INST_SUB(cpu->BX, MEM_WORD(0xb0));
   INST_NEG(cpu->BX);
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   FUN_1000_2b08(cpu);
   INST_SUB(cpu->AX, MEM_WORD(0xc6));
   INST_ADD(MEM_WORD(0xc6), cpu->AX);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   FUN_1000_26dd(cpu);
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI + 0xa);
   INST_SUB(cpu->AX, MEM_WORD(0xb4));
   FUN_1000_2b08(cpu);
   INST_SUB(cpu->AX, MEM_WORD(0xc4));
   INST_ADD(MEM_WORD(0xc4), cpu->AX);
   cpu->AX = 0; //was a XOR
   INST_SUB(cpu->AX, MEM_WORD(0xc2));
   INST_ADD(MEM_WORD(0xc2), cpu->AX);
   INST_POP(cpu->SI);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void F_0893(cpu_ctx *cpu){
                              //XREF[3]:     1000:029a(c),1000:0366(c),1000:042f(c)
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI + 0x20));
   cpu->AX = MEM_WORD(cpu->SI + 0x2);
   INST_SUB(cpu->AX, MEM_WORD(cpu->DI + 0x2));
   cpu->BX = MEM_WORD(cpu->SI + 0x6);
   INST_SUB(cpu->BX, MEM_WORD(cpu->DI + 0x6));
   INST_NEG(cpu->BX);
   FUN_1000_2b08(cpu);
   MEM_WORD(cpu->DI + 0xc) = cpu->AX;
   cpu->BX = cpu->AX;
   FUN_1000_2ad8(cpu);
   cpu->CX = cpu->AX;
   FUN_1000_2aad(cpu);
   cpu->BX = cpu->CX;
   cpu->CX = MEM_WORD(0x11e);
   INST_SHL(cpu->CX, 0x1);
   INST_IMUL(cpu->CX);
   cpu->AX = cpu->DX;
   INST_XCHG(cpu->AX, cpu->BX);
   INST_IMUL(cpu->CX);
   cpu->AX = cpu->DX;
   INST_XCHG(cpu->AX, cpu->BX);
   INST_NEG(cpu->AX);
   INST_ADD(cpu->AX, MEM_WORD(cpu->SI + 0x2));
   INST_ADD(cpu->BX, MEM_WORD(cpu->SI + 0x6));
   INST_SUB(cpu->AX, MEM_WORD(cpu->DI + 0x2));
   INST_ADD(MEM_WORD(cpu->DI + 0x2), cpu->AX);
   INST_SUB(cpu->BX, MEM_WORD(cpu->DI + 0x6));
   INST_ADD(MEM_WORD(cpu->DI + 0x6), cpu->BX);
   cpu->AX = MEM_WORD(cpu->DI + 0x2);
   cpu->BX = MEM_WORD(cpu->DI + 0x6);
   FUN_1000_25c5(cpu);
   cpu->BX = cpu->AX;
   INST_ADD(cpu->BX, 0x28);
   INST_ADD(cpu->AX, MEM_WORD(0x11c));
   INST_SUB(cpu->AX, MEM_WORD(cpu->DI + 0xa));
   INST_SAR(cpu->AX, 0x3);
   INST_ADD(MEM_WORD(cpu->DI + 0xa), cpu->AX);
   INST_CMP(cpu->BX, MEM_WORD(cpu->DI + 0xa));
   JUMP«JA» goto LAB_LOC_2;
   LAB_LOC_1:
   cpu->BX = MEM_WORD(0x11e);
   cpu->AX = MEM_WORD(cpu->SI + 0xa);
   INST_SUB(cpu->AX, MEM_WORD(cpu->DI + 0xa));
   FUN_1000_2b08(cpu);
   INST_SUB(cpu->AX, MEM_WORD(cpu->DI + 0xe));
   INST_SAR(cpu->AX, 0x2);
   INST_ADD(MEM_WORD(cpu->DI + 0xe), cpu->AX);
   MEM_WORD(cpu->DI + 0x10) = 0x0;
   cpu->AX = MEM_WORD(cpu->DI + 0xc);
   MEM_WORD(0xc6) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->DI + 0xe);
   MEM_WORD(0xc4) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->DI + 0x10);
   MEM_WORD(0xc2) = cpu->AX;
   cpu->EAX = MEM_DWORD(cpu->DI);
   MEM_DWORD(0xaa) = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->DI + 0x4);
   MEM_DWORD(0xae) = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->DI + 0x8);
   MEM_DWORD(0xb2) = cpu->EAX;
   INST_POP(cpu->SI);
   return;
   LAB_LOC_2:
   MEM_WORD(cpu->DI + 0xa) = cpu->BX;
   goto LAB_LOC_1;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void F_0948(cpu_ctx *cpu){
   cpu->EAX = 0; //was a XOR
   cpu->EBX = 0; //was a XOR
   cpu->EDX = 0; //was a XOR
   cpu->CX = MEM_WORD(0x5bba);
   cpu->DI = 0; //was a XOR
   LAB_LOC_1:
   cpu->SI = MEM_WORD(cpu->DI + 0x5bbc);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI + 0x20));
   INST_MOVZX(cpu->EBP, MEM_WORD(cpu->SI + 0x2));
   INST_ADD(cpu->EAX, cpu->EBP);
   INST_MOVZX(cpu->EBP, MEM_WORD(cpu->SI + 0x6));
   INST_ADD(cpu->EBX, cpu->EBP);
   INST_MOVZX(cpu->EBP, MEM_WORD(cpu->SI + 0xa));
   INST_ADD(cpu->EDX, cpu->EBP);
   INST_ADD(cpu->DI, 0x2);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   cpu->ECX = cpu->EDX;
   INST_MOVZX(cpu->EBP, MEM_WORD(0x5bba));
   INST_CDQ();
   INST_DIV(cpu->EBP);
   MEM_WORD(0xc8) = cpu->AX;
   cpu->EAX = cpu->EBX;
   INST_CDQ();
   INST_DIV(cpu->EBP);
   MEM_WORD(0xca) = cpu->AX;
   cpu->EAX = cpu->ECX;
   INST_CDQ();
   INST_IDIV(cpu->EBP);
   MEM_WORD(0xcc) = cpu->AX;
   cpu->AX = MEM_WORD(0xc8);
   cpu->BX = MEM_WORD(0xca);
   INST_SUB(cpu->AX, MEM_WORD(0xac));
   INST_SUB(cpu->BX, MEM_WORD(0xb0));
   INST_NEG(cpu->BX);
   FUN_1000_2b08(cpu);
   MEM_WORD(0xc6) = cpu->AX;
   cpu->BX = cpu->AX;
   FUN_1000_2ad8(cpu);
   cpu->CX = cpu->AX;
   FUN_1000_2aad(cpu);
   cpu->BX = cpu->CX;
   cpu->CX = MEM_WORD(0x11e);
   INST_SHL(cpu->CX, 0x1);
   INST_IMUL(cpu->CX);
   cpu->AX = cpu->DX;
   INST_XCHG(cpu->AX, cpu->BX);
   INST_IMUL(cpu->CX);
   cpu->AX = cpu->DX;
   INST_XCHG(cpu->AX, cpu->BX);
   INST_NEG(cpu->AX);
   INST_ADD(cpu->AX, MEM_WORD(0xc8));
   INST_ADD(cpu->BX, MEM_WORD(0xca));
   INST_SUB(cpu->AX, MEM_WORD(0xac));
   INST_ADD(MEM_WORD(0xac), cpu->AX);
   INST_SUB(cpu->BX, MEM_WORD(0xb0));
   INST_ADD(MEM_WORD(0xb0), cpu->BX);
   cpu->AX = MEM_WORD(0xac);
   cpu->BX = MEM_WORD(0xb0);
   FUN_1000_25c5(cpu);
   cpu->BX = cpu->AX;
   INST_ADD(cpu->BX, 0x28);
   INST_ADD(cpu->AX, MEM_WORD(0x11c));
   INST_SUB(cpu->AX, MEM_WORD(0xb4));
   INST_SAR(cpu->AX, 0x3);
   INST_ADD(MEM_WORD(0xb4), cpu->AX);
   INST_CMP(cpu->BX, MEM_WORD(0xb4));
   JUMP«JA» goto LAB_LOC_3;
   LAB_LOC_2:
   cpu->BX = MEM_WORD(0x11e);
   cpu->AX = MEM_WORD(0xcc);
   INST_SUB(cpu->AX, MEM_WORD(0xb4));
   FUN_1000_2b08(cpu);
   INST_SUB(cpu->AX, MEM_WORD(0xc4));
   INST_SAR(cpu->AX, 0x2);
   INST_ADD(MEM_WORD(0xc4), cpu->AX);
   MEM_WORD(0xc2) = 0x0;
   return;
   LAB_LOC_3:
   MEM_WORD(0xb4) = cpu->BX;
   goto LAB_LOC_2;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_0a3b(cpu_ctx *cpu){
                              //XREF[1]:     1000:56ce(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   INST_TEST(CSD_DAT_keys_571e[2], 0xc0);
   JUMP«JNS» goto LAB_LOC_3;
   LAB_LOC_1:
   INST_TEST(CSD_DAT_keys_571e[3], 0xc0);
   JUMP«JNS» goto LAB_LOC_4;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   return;
   LAB_LOC_3:
   INST_PUSHF();
   INST_AND(CSD_DAT_keys_571e[2], 0x3f);
   cpu->SI = MEM_WORD(0xa4);
   INST_SHL(cpu->SI, 0x1);
   cpu->SI = MEM_WORD(cpu->SI + 0x5bbc);
   INST_POPF();
   FUN_1000_0a82(cpu);
   goto LAB_LOC_1;
   LAB_LOC_4:
   INST_PUSHF();
   INST_AND(CSD_DAT_keys_571e[3], 0x3f);
   cpu->SI = MEM_WORD(0xa6);
   INST_SHL(cpu->SI, 0x1);
   cpu->SI = MEM_WORD(cpu->SI + 0x5bbc);
   INST_POPF();
   FUN_1000_0a82(cpu);
   goto LAB_LOC_2;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_0a82(cpu_ctx *cpu){
                              //XREF[2]:     1000:0a66(c),1000:0a7d(c)
   INST_PUSHF();
   cpu->DI = cpu->SI;
   INST_ADD(cpu->DI, MEM_WORD(cpu->SI));
   INST_MOVZX(cpu->EAX, MEM_WORD(cpu->DI));
   cpu->CX = cpu->AX;
   INST_SHR(cpu->EAX, 0x1);
   INST_INC(cpu->EAX);
   INST_IMUL(cpu->EAX, MEM_DWORD(0x6a));
   INST_POPF();
   JUMP«JP» goto LAB_LOC_3;
   INST_INC(cpu->DI);
   INST_INC(cpu->DI);
   cpu->DX = cpu->DI;
   cpu->BX = MEM_WORD(cpu->DI + 0xa);
   INST_ADD(cpu->DI, 0x1c);
   INST_DEC(cpu->CX);
   LAB_LOC_1:
   cpu->AX = MEM_WORD(cpu->DI + 0xa);
   INST_CMP(cpu->AX, cpu->BX);
   JUMP«JL» goto LAB_LOC_4;
   LAB_LOC_2:
   INST_ADD(cpu->DI, 0x1c);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   MEM_WORD(cpu->SI + 0x22) = cpu->DX;
   LAB_LOC_3:
   cpu->DI = MEM_WORD(cpu->SI + 0x22);
   INST_ADD(MEM_DWORD(cpu->DI + 0x14), cpu->EAX);
   return;
   LAB_LOC_4:
   cpu->BX = cpu->AX;
   cpu->DX = cpu->DI;
   goto LAB_LOC_2;

 // 1000:0b24 [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
//ANALYSIS: related to smoke, debris, particle effects in general
void FUN_1000_0b25(cpu_ctx *cpu){
                              //XREF[3]:     1000:02cc(c),1000:0398(c),1000:0458(c)
   INST_PUSH(cpu->FS);
   cpu->FS = MEM_WORD(0x1a49);
   cpu->DI = 0; //was a XOR
   INST_CMP(cpu->DI, MEM_WORD(0x3e51));
   JUMP«JNC» goto LAB_LOC_4;
   LAB_LOC_1:
   cpu->AX = MEM_WORD(cpu->DI + 0x3e55);
   cpu->BX = MEM_WORD(cpu->DI + 0x3e59);
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_TEST(MEM_BYTE(0x5fb), 0x1);
   JUMP«JZ» goto LAB_LOC_2;
   INST_XCHG(cpu->AX, cpu->BX);
   LAB_LOC_2:
   INST_MOVZX(cpu->BX, cpu->BH);
   INST_MOVZX(cpu->AX, cpu->AH);
   INST_CMP(cpu->BX, MEM_WORD(0xe58c));
   JUMP«JL» goto LAB_LOC_5;
   INST_CMP(cpu->BX, MEM_WORD(0xe58e));
   JUMP«JG» goto LAB_LOC_5;
   INST_SHL(cpu->BX, 0x2);
   INST_CMP(cpu->AX, MEM_WORD(cpu->BX + 0xe590));
   JUMP«JL» goto LAB_LOC_5;
   INST_CMP(cpu->AX, MEM_WORD(cpu->BX + 0xe592));
   JUMP«JG» goto LAB_LOC_5;
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   cpu->CX = MEM_WORD(cpu->DI + 0x3e5d);
   INST_SUB(cpu->AX, MEM_WORD(0xac));
   INST_SUB(cpu->BX, MEM_WORD(0xb0));
   INST_SUB(cpu->CX, MEM_WORD(0xb4));
   cpu->DX = 0xce;
   FUN_1000_277e(cpu);
   INST_NEG(cpu->BX);
   FUN_1000_2418(cpu);
   JUMP«JC» goto LAB_LOC_3;
   INST_MOVZX(cpu->SI, MEM_BYTE(cpu->DI + 0x3e6d));
   INST_SHR(cpu->SI, 0x4);
   INST_SHL(cpu->SI, 0x1);
   cpu->SI = MEM_WORD(cpu->SI + 0x5a53);
   FUN_1000_0cd3(cpu);
   LAB_LOC_3:
   INST_ADD(cpu->DI, 0x1c);
   INST_CMP(cpu->DI, MEM_WORD(0x3e51));
   JUMP«JC» goto LAB_LOC_1;
   LAB_LOC_4:
   INST_POP(cpu->FS);
   return;
   LAB_LOC_5:
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   goto LAB_LOC_3;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_0bb5(cpu_ctx *cpu){
                              //XREF[1]:     1000:56cb(c)
   cpu->DI = 0; //was a XOR
   INST_CMP(cpu->DI, MEM_WORD(0x3e51));
   JUMP«JNC» goto LAB_LOC_4;
   LAB_LOC_1:
   INST_SUB(MEM_WORD(cpu->DI + 0x3e6b), 0x2);
   JUMP«JS» goto LAB_LOC_8;
   cpu->EAX = MEM_DWORD(cpu->DI + 0x3e5f);
   cpu->EBX = MEM_DWORD(cpu->DI + 0x3e63);
   cpu->ECX = MEM_DWORD(cpu->DI + 0x3e67);
   INST_ADD(MEM_DWORD(cpu->DI + 0x3e53), cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->DI + 0x3e57), cpu->EBX);
   INST_ADD(MEM_DWORD(cpu->DI + 0x3e5b), cpu->ECX);
   INST_CMP(MEM_WORD(cpu->DI + 0x3e6d), 0xf);
   JUMP«JNZ» goto LAB_LOC_2;
   cpu->EAX = MEM_DWORD(cpu->DI + 0x3e53);
   cpu->EBX = MEM_DWORD(cpu->DI + 0x3e57);
   cpu->ECX = MEM_DWORD(cpu->DI + 0x3e5b);
   INST_SAR(cpu->EAX, 0x10);
   INST_SAR(cpu->EBX, 0x10);
   INST_SAR(cpu->ECX, 0x10);
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->CX);
   FUN_1000_25c5(cpu);
   INST_POP(cpu->CX);
   INST_CMP(cpu->AX, cpu->CX);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   JUMP«JNS» goto LAB_LOC_6;
   cpu->EAX = MEM_DWORD(0x6a);
   INST_SAR(cpu->EAX, 0x1);
   INST_SUB(MEM_DWORD(cpu->DI + 0x3e67), cpu->EAX);
   LAB_LOC_2:
   INST_ADD(cpu->DI, 0x1c);
   LAB_LOC_3:
   INST_CMP(cpu->DI, MEM_WORD(0x3e51));
   JUMP«JC» goto LAB_LOC_1;
   LAB_LOC_4:
   return;
   LAB_LOC_5:

   return;
   LAB_LOC_6:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   cpu->BL = cpu->AH;
   cpu->AL = MEM_BYTE(cpu->FS*SEGM + cpu->BX);
   INST_TEST(cpu->AL, 0xf);
   JUMP«JZ» goto LAB_LOC_7;
   INST_DEC(cpu->AL);
   MEM_BYTE(cpu->FS*SEGM + cpu->BX) = cpu->AL;
   LAB_LOC_7:
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_ADD(cpu->BX, 0x80);
   INST_ADD(cpu->AX, 0x80);
   cpu->BL = cpu->AH;
   INST_DEC(MEM_BYTE(cpu->GS*SEGM + cpu->BX));
   MEM_WORD(cpu->DI + 0x3e6d) = 0x1;
   cpu->EAX = 0x0;
   MEM_DWORD(cpu->DI + 0x3e5f) = cpu->EAX;
   MEM_DWORD(cpu->DI + 0x3e63) = cpu->EAX;
   MEM_DWORD(cpu->DI + 0x3e67) = 0x2710;
   goto LAB_LOC_2;
   LAB_LOC_8:

   cpu->SI = MEM_WORD(0x3e51);
   INST_SUB(cpu->SI, 0x1c);
   MEM_WORD(0x3e51) = cpu->SI;
   JUMP«JZ» goto LAB_LOC_5;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x3e53);
   MEM_DWORD(cpu->DI + 0x3e53) = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x3e57);
   MEM_DWORD(cpu->DI + 0x3e57) = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x3e5b);
   MEM_DWORD(cpu->DI + 0x3e5b) = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x3e5f);
   MEM_DWORD(cpu->DI + 0x3e5f) = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x3e63);
   MEM_DWORD(cpu->DI + 0x3e63) = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x3e67);
   MEM_DWORD(cpu->DI + 0x3e67) = cpu->EAX;
   cpu->AX = MEM_WORD(cpu->SI + 0x3e6b);
   MEM_WORD(cpu->DI + 0x3e6b) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI + 0x3e6d);
   MEM_WORD(cpu->DI + 0x3e6d) = cpu->AX;
   INST_SUB(cpu->SI, 0x1c);

   goto LAB_LOC_3;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_0cd3(cpu_ctx *cpu){
                              //XREF[1]:     1000:0ba2(c)
   INST_CMP(cpu->CX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_1;
   cpu->BP = cpu->BX;
   cpu->BX = cpu->AX;
   INST_LODSW();
   INST_CWD();
   INST_IDIV(cpu->CX);
   cpu->DX = cpu->AX;
   INST_PUSH(cpu->ES);
   INST_PUSH(cpu->DI);
   cpu->AX = cpu->DS;
   cpu->ES = cpu->AX;
   cpu->DI = 0xdb16;
   cpu->AX = cpu->BX;
   INST_SUB(cpu->AX, cpu->DX);
   INST_STOSW();
   cpu->AX = cpu->BP;
   INST_SUB(cpu->AX, cpu->DX);
   INST_STOSW();
   INST_MOVSD();
   cpu->AX = cpu->BX;
   INST_ADD(cpu->AX, cpu->DX);
   INST_STOSW();
   cpu->AX = cpu->BP;
   INST_SUB(cpu->AX, cpu->DX);
   INST_STOSW();
   INST_MOVSD();
   cpu->AX = cpu->BX;
   INST_ADD(cpu->AX, cpu->DX);
   INST_STOSW();
   cpu->AX = cpu->BP;
   INST_ADD(cpu->AX, cpu->DX);
   INST_STOSW();
   INST_MOVSD();
   cpu->AX = cpu->BX;
   INST_SUB(cpu->AX, cpu->DX);
   INST_STOSW();
   cpu->AX = cpu->BP;
   INST_ADD(cpu->AX, cpu->DX);
   INST_STOSW();
   INST_MOVSD();
   MEM_WORD(0xdb14) = 0x4;
   FUN_1000_36fe(cpu);
   INST_POP(cpu->DI);
   INST_POP(cpu->ES);
   LAB_LOC_1:
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_0d2a(cpu_ctx *cpu){
                              //XREF[1]:     1000:56b4(c)
   INST_MOVZX(cpu->BX, MEM_BYTE(cpu->DI));
   cpu->AL = CSD_DAT_keys_571e[cpu->BX];
   INST_MOVZX(cpu->BX, MEM_BYTE(cpu->DI + 0x1));
   cpu->AH = CSD_DAT_keys_571e[cpu->BX];
   cpu->BX = MEM_WORD(cpu->SI + 0xc);
   cpu->CX = 0x32;
   INST_TEST(cpu->AL, 0x80);
   JUMP«JS» goto LAB_LOC_2;
   INST_CMP(cpu->BX, 0x2000);
   JUMP«JG» goto LAB_LOC_2;
   INST_TEST(cpu->BX, cpu->BX);
   JUMP«JNS» goto LAB_LOC_1;
   INST_SHL(cpu->CX, 0x2);
   LAB_LOC_1:
   INST_ADD(cpu->BX, cpu->CX);
   LAB_LOC_2:
   INST_TEST(cpu->AH, 0x80);
   JUMP«JS» goto LAB_LOC_4;
   INST_CMP(cpu->BX, 0xe000);
   JUMP«JL» goto LAB_LOC_4;
   INST_TEST(cpu->BX, cpu->BX);
   JUMP«JS» goto LAB_LOC_3;
   INST_SHL(cpu->CX, 0x2);
   LAB_LOC_3:
   INST_SUB(cpu->BX, cpu->CX);
   LAB_LOC_4:
   INST_XOR(cpu->AX, 0x8080);
   INST_TEST(cpu->AX, 0x8080);
   JUMP«JNZ» goto LAB_LOC_6;
   cpu->CX = 0x12c;
   INST_TEST(cpu->BX, cpu->BX);
   JUMP«JZ» goto LAB_LOC_6;
   JUMP«JNS» goto LAB_LOC_5;
   INST_NEG(cpu->CX);
   LAB_LOC_5:
   INST_SUB(cpu->BX, cpu->CX);
   LAB_LOC_6:
   MEM_WORD(cpu->SI + 0xc) = cpu->BX;
   INST_MOVZX(cpu->BX, MEM_BYTE(cpu->DI + 0x2));
   cpu->AL = CSD_DAT_keys_571e[cpu->BX];
   INST_MOVZX(cpu->BX, MEM_BYTE(cpu->DI + 0x3));
   cpu->AH = CSD_DAT_keys_571e[cpu->BX];
   cpu->BX = MEM_WORD(cpu->SI + 0xa);
   cpu->ECX = MEM_DWORD(cpu->SI + 0x42);
   INST_ADD(cpu->ECX, MEM_DWORD(cpu->SI + 0x46));
   INST_AND(cpu->CX, cpu->CX);
   JUMP«JGE» goto LAB_LOC_7;
   INST_NEG(cpu->CX);
   LAB_LOC_7:
   INST_SHR(cpu->ECX, 0x10);
   INST_NEG(cpu->CX);
   INST_ADD(cpu->CX, 0x40);
   INST_TEST(cpu->AL, 0x80);
   JUMP«JS» goto LAB_LOC_9;
   INST_CMP(cpu->BX, 0xe000);
   JUMP«JL» goto LAB_LOC_9;
   INST_TEST(cpu->BX, cpu->BX);
   JUMP«JS» goto LAB_LOC_8;
   INST_SHL(cpu->CX, 0x2);
   LAB_LOC_8:
   INST_SUB(cpu->BX, cpu->CX);
   LAB_LOC_9:
   INST_TEST(cpu->AH, 0x80);
   JUMP«JS» goto LAB_LOC_11;
   INST_CMP(cpu->BX, 0x2000);
   JUMP«JG» goto LAB_LOC_11;
   INST_TEST(cpu->BX, cpu->BX);
   JUMP«JNS» goto LAB_LOC_10;
   INST_SHL(cpu->CX, 0x2);
   LAB_LOC_10:
   INST_ADD(cpu->BX, cpu->CX);
   LAB_LOC_11:
   INST_XOR(cpu->AX, 0x8080);
   INST_TEST(cpu->AX, 0x8080);
   JUMP«JNZ» goto LAB_LOC_13;
   cpu->CX = 0x50;
   INST_TEST(cpu->BX, cpu->BX);
   JUMP«JZ» goto LAB_LOC_13;
   JUMP«JNS» goto LAB_LOC_12;
   INST_NEG(cpu->CX);
   LAB_LOC_12:
   INST_SUB(cpu->BX, cpu->CX);
   LAB_LOC_13:
   MEM_WORD(cpu->SI + 0xa) = cpu->BX;
   cpu->AX = 0; //was a XOR
   INST_MOVZX(cpu->BX, MEM_BYTE(cpu->DI + 0x4));
   INST_TEST(CSD_DAT_keys_571e[cpu->BX], 0x80);
   JUMP«JNZ» goto LAB_LOC_14;
   INST_OR(cpu->AX, 0x1);
   LAB_LOC_14:
   MEM_WORD(cpu->SI + 0xe) = cpu->AX;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_0e28(cpu_ctx *cpu){
                              //XREF[1]:     1000:48db(c)
   cpu->DI = cpu->SI;
   INST_ADD(cpu->DI, MEM_WORD(cpu->SI));
   INST_ADD(cpu->DI, 0x2);
   cpu->AX = MEM_WORD(cpu->DI + 0x72);
   cpu->BX = MEM_WORD(cpu->DI + 0xaa);
   INST_SHR(cpu->AX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   INST_ADD(cpu->AX, cpu->BX);
   MEM_WORD(cpu->SI + 0x10) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->DI + 0x76);
   cpu->BX = MEM_WORD(cpu->DI + 0xae);
   INST_SHR(cpu->AX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   INST_ADD(cpu->AX, cpu->BX);
   MEM_WORD(cpu->SI + 0x12) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->DI + 0x7a);
   cpu->BX = MEM_WORD(cpu->DI + 0xb2);
   INST_SHR(cpu->AX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   INST_ADD(cpu->AX, cpu->BX);
   MEM_WORD(cpu->SI + 0x14) = cpu->AX;
   CSD_WORD_1000_0e67 = 0x0;
   return;


}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_0e69(cpu_ctx *cpu){
                              //XREF[1]:     1000:4b6f(c)
   INST_CMP(cpu->AX, 0x0);
   JUMP«JZ» goto LAB_LOC_1;
   INST_CMP(cpu->AX, 0x1);
   JUMP«JZ» goto LAB_LOC_3;
   INST_CMP(cpu->AX, 0x2);
   JUMP«JZ» goto LAB_LOC_5;
   INST_CMP(cpu->AX, 0x3);
   JUMP«JZ» goto LAB_LOC_7;
   cpu->EAX = 0; //was a XOR
   cpu->EBX = 0; //was a XOR
   cpu->ECX = 0; //was a XOR
   return;
   LAB_LOC_1:
   INST_TEST(CSD_WORD_1000_0e67, 0x1);
   JUMP«JNZ» goto LAB_LOC_2;
   FUN_1000_1136(cpu);
   INST_OR(CSD_WORD_1000_0e67, 0x1);
   LAB_LOC_2:
   cpu->EAX = CSD_DWORD_1000_12a7;
   cpu->EBX = CSD_DWORD_1000_12ab;
   cpu->ECX = CSD_DWORD_1000_12af;
   cpu->EDX = MEM_DWORD(cpu->SI + 0x42);
   return;
   LAB_LOC_3:
   INST_TEST(CSD_WORD_1000_0e67, 0x1);
   JUMP«JNZ» goto LAB_LOC_4;
   FUN_1000_1136(cpu);
   INST_OR(CSD_WORD_1000_0e67, 0x1);
   LAB_LOC_4:
   cpu->EAX = CSD_DWORD_1000_12a7;
   cpu->EBX = CSD_DWORD_1000_12ab;
   cpu->ECX = CSD_DWORD_1000_12af;
   cpu->EDX = MEM_DWORD(cpu->SI + 0x46);
   return;
   LAB_LOC_5:
   INST_TEST(CSD_WORD_1000_0e67, 0x2);
   JUMP«JNZ» goto LAB_LOC_6;
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   INST_ADD(cpu->SI, 0x2);
   FUN_1000_10b6(cpu);
   CSD_DWORD_1000_12bf = cpu->EAX;
   CSD_DWORD_1000_12c3 = cpu->EBX;
   CSD_DWORD_1000_12c7 = cpu->ECX;
   INST_POP(cpu->SI);
   INST_OR(CSD_WORD_1000_0e67, 0x2);
   LAB_LOC_6:
   cpu->EAX = CSD_DWORD_1000_12bf;
   cpu->EBX = CSD_DWORD_1000_12c3;
   cpu->ECX = CSD_DWORD_1000_12c7;
   cpu->EDX = MEM_DWORD(cpu->SI + 0x4a);
   return;
   LAB_LOC_7:
   INST_TEST(CSD_WORD_1000_0e67, 0x2);
   JUMP«JNZ» goto LAB_LOC_8;
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   INST_ADD(cpu->SI, 0x2);
   FUN_1000_10b6(cpu);
   CSD_DWORD_1000_12bf = cpu->EAX;
   CSD_DWORD_1000_12c3 = cpu->EBX;
   CSD_DWORD_1000_12c7 = cpu->ECX;
   INST_POP(cpu->SI);
   INST_OR(CSD_WORD_1000_0e67, 0x2);
   LAB_LOC_8:
   cpu->EAX = CSD_DWORD_1000_12bf;
   cpu->EBX = CSD_DWORD_1000_12c3;
   cpu->ECX = CSD_DWORD_1000_12c7;
   cpu->EDX = MEM_DWORD(cpu->SI + 0x4e);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_0f67(cpu_ctx *cpu){
                              //XREF[1]:     1000:4bd5(c)
   cpu->CX = MEM_WORD(cpu->SI + 0x8);
   INST_CMP(cpu->AX, 0x0);
   JUMP«JZ» goto LAB_LOC_1;
   INST_CMP(cpu->AX, 0x1);
   JUMP«JZ» goto LAB_LOC_3;
   INST_CMP(cpu->AX, 0x2);
   JUMP«JZ» goto LAB_LOC_5;
   INST_CMP(cpu->AX, 0x3);
   JUMP«JZ» goto LAB_LOC_7;
   return;
   LAB_LOC_1:
   INST_TEST(cpu->CX, cpu->CX);
   JUMP«JZ» goto LAB_LOC_2;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x42);
   INST_SUB(cpu->EAX, cpu->EBX);
   INST_SAR(cpu->EAX, 0x2);
   INST_ADD(cpu->EAX, cpu->EBX);
   MEM_DWORD(cpu->SI + 0x42) = cpu->EAX;
   return;
   LAB_LOC_2:
   MEM_DWORD(cpu->SI + 0x42) = cpu->EBX;
   return;
   LAB_LOC_3:
   INST_TEST(cpu->CX, cpu->CX);
   JUMP«JZ» goto LAB_LOC_4;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x46);
   INST_SUB(cpu->EAX, cpu->EBX);
   INST_SAR(cpu->EAX, 0x2);
   INST_ADD(cpu->EAX, cpu->EBX);
   MEM_DWORD(cpu->SI + 0x46) = cpu->EAX;
   return;
   LAB_LOC_4:
   MEM_DWORD(cpu->SI + 0x46) = cpu->EBX;
   return;
   LAB_LOC_5:
   INST_TEST(cpu->CX, 0x1);
   JUMP«JZ» goto LAB_LOC_6;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x4a);
   INST_SUB(cpu->EAX, cpu->EBX);
   INST_SAR(cpu->EAX, 0x2);
   INST_ADD(cpu->EAX, cpu->EBX);
   MEM_DWORD(cpu->SI + 0x4a) = cpu->EAX;
   return;
   LAB_LOC_6:
   MEM_DWORD(cpu->SI + 0x4a) = cpu->EBX;
   return;
   LAB_LOC_7:
   INST_TEST(cpu->CX, 0x1);
   JUMP«JZ» goto LAB_LOC_8;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x4e);
   INST_SUB(cpu->EAX, cpu->EBX);
   INST_SAR(cpu->EAX, 0x2);
   INST_ADD(cpu->EAX, cpu->EBX);
   MEM_DWORD(cpu->SI + 0x4e) = cpu->EAX;
   return;
   LAB_LOC_8:
   MEM_DWORD(cpu->SI + 0x4e) = cpu->EBX;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_1003(cpu_ctx *cpu){
                              //XREF[1]:     1000:497a(c)
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_1004(cpu_ctx *cpu){
                              //XREF[1]:     1000:56b7(c)
   cpu->AX = MEM_WORD(cpu->SI + 0xa);
   MEM_WORD(cpu->SI + 0x16) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI + 0xc);
   MEM_WORD(cpu->SI + 0x18) = cpu->AX;
   cpu->CX = 0x10;
   cpu->BX = 0x0;
   LAB_LOC_1:
   cpu->EAX = MEM_DWORD(cpu->BX + cpu->SI + 0x42);
   INST_SAR(cpu->EAX, 0x7);
   INST_SUB(MEM_DWORD(cpu->BX + cpu->SI + 0x42), cpu->EAX);
   INST_ADD(cpu->BX, 0x4);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   INST_TEST(MEM_WORD(cpu->SI + 0xe), 0x1);
   JUMP«JZ» goto LAB_LOC_3;
   cpu->CX = 0x10;
   cpu->BX = 0x0;
   LAB_LOC_2:
   cpu->EAX = MEM_DWORD(cpu->BX + cpu->SI + 0x42);
   INST_SAR(cpu->EAX, 0x2);
   INST_SUB(MEM_DWORD(cpu->BX + cpu->SI + 0x42), cpu->EAX);
   INST_ADD(cpu->BX, 0x4);
   if (--cpu->CX != 0) goto LAB_LOC_2;
   LAB_LOC_3:
   cpu->AX = MEM_WORD(cpu->SI + 0x18);
   INST_CWD();
   cpu->CX = 0x4000;
   INST_IMUL(cpu->CX);
   INST_MOVSX(cpu->EAX, cpu->DX);
   cpu->BX = MEM_WORD(cpu->SI + 0x8);
   INST_TEST(cpu->BX, cpu->BX);
   JUMP«JZ» goto LAB_LOC_4;
   INST_DEC(cpu->BX);
   JUMP«JZ» goto LAB_LOC_5;
   INST_ROL(cpu->EAX, 0x3);
   INST_ADD(MEM_DWORD(cpu->SI + 0x42), cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->SI + 0x46), cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->SI + 0x4a), cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->SI + 0x4e), cpu->EAX);
   return;
   LAB_LOC_4:
   INST_ROL(cpu->EAX, 0x4);
   INST_ADD(MEM_DWORD(cpu->SI + 0x4a), cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->SI + 0x4e), cpu->EAX);
   return;
   LAB_LOC_5:
   INST_ROL(cpu->EAX, 0x4);
   INST_ADD(MEM_DWORD(cpu->SI + 0x42), cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->SI + 0x46), cpu->EAX);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_1091(cpu_ctx *cpu){
                              //XREF[4]:     1000:06b4(c),1000:0760(c),1000:113c(c),1000:11f6(c)
   cpu->EDX = MEM_DWORD(cpu->SI + 0xc4);
   INST_SUB(cpu->EDX, MEM_DWORD(cpu->SI + 0xa8));
   cpu->EBX = MEM_DWORD(cpu->SI + 0xc8);
   INST_SUB(cpu->EBX, MEM_DWORD(cpu->SI + 0xac));
   cpu->ECX = MEM_DWORD(cpu->SI + 0xcc);
   INST_SUB(cpu->ECX, MEM_DWORD(cpu->SI + 0xb0));
   cpu->EAX = cpu->EDX;
   FUN_1000_2726(cpu);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_10b6(cpu_ctx *cpu){
                              //XREF[6]:     1000:06c5(c),1000:0771(c),1000:0ef4(c),1000:0f36(c),
                              //             1000:1150(c),1000:120a(c)
   cpu->EDX = MEM_DWORD(cpu->SI + 0x70);
   INST_SUB(cpu->EDX, MEM_DWORD(cpu->SI + 0xa8));
   INST_ADD(cpu->EDX, MEM_DWORD(cpu->SI + 0x8c));
   INST_SUB(cpu->EDX, MEM_DWORD(cpu->SI + 0xc4));
   cpu->EBX = MEM_DWORD(cpu->SI + 0x74);
   INST_SUB(cpu->EBX, MEM_DWORD(cpu->SI + 0xac));
   INST_ADD(cpu->EBX, MEM_DWORD(cpu->SI + 0x90));
   INST_SUB(cpu->EBX, MEM_DWORD(cpu->SI + 0xc8));
   cpu->ECX = MEM_DWORD(cpu->SI + 0x78);
   INST_SUB(cpu->ECX, MEM_DWORD(cpu->SI + 0xb0));
   INST_ADD(cpu->ECX, MEM_DWORD(cpu->SI + 0x94));
   INST_SUB(cpu->ECX, MEM_DWORD(cpu->SI + 0xcc));
   cpu->EAX = cpu->EDX;
   FUN_1000_2726(cpu);
   return;

 // 1000:1135 [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
//ANALYSIS: related to steering, disabling this function disables steering
void FUN_1000_1136(cpu_ctx *cpu){
                              //XREF[2]:     1000:0e9a(c),1000:0ec4(c)
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   INST_ADD(cpu->SI, 0x2);
   FUN_1000_1091(cpu);
   CSD_DWORD_1000_12b3 = cpu->EAX;
   CSD_DWORD_1000_12b7 = cpu->EBX;
   CSD_DWORD_1000_12bb = cpu->ECX;
   FUN_1000_10b6(cpu);
   CSD_DWORD_1000_12bf = cpu->EAX;
   CSD_DWORD_1000_12c3 = cpu->EBX;
   CSD_DWORD_1000_12c7 = cpu->ECX;
   INST_POP(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x16);
   FUN_1000_2aad(cpu);
   INST_SHL(cpu->EAX, 0x10);
   CSD_DWORD_1000_129f = cpu->EAX;
   FUN_1000_2ad8(cpu);
   INST_SHL(cpu->EAX, 0x10);
   CSD_DWORD_1000_12a3 = cpu->EAX; //= 7FFF0000h
   cpu->EAX = CSD_DWORD_1000_12bf;
   INST_IMUL(CSD_DWORD_1000_12a3); //= 7FFF0000h
   cpu->EBX = cpu->EDX;
   cpu->EAX = CSD_DWORD_1000_12b3;
   INST_IMUL(CSD_DWORD_1000_129f);
   INST_SUB(cpu->EBX, cpu->EDX);
   INST_SHL(cpu->EBX, 0x1);
   CSD_DWORD_1000_12a7 = cpu->EBX;
   cpu->EAX = CSD_DWORD_1000_12c3;
   INST_IMUL(CSD_DWORD_1000_12a3); //= 7FFF0000h
   cpu->EBX = cpu->EDX;
   cpu->EAX = CSD_DWORD_1000_12b7;
   INST_IMUL(CSD_DWORD_1000_129f);
   INST_SUB(cpu->EBX, cpu->EDX);
   INST_SHL(cpu->EBX, 0x1);
   CSD_DWORD_1000_12ab = cpu->EBX;
   cpu->EAX = CSD_DWORD_1000_12c7;
   INST_IMUL(CSD_DWORD_1000_12a3); //= 7FFF0000h
   cpu->EBX = cpu->EDX;
   cpu->EAX = CSD_DWORD_1000_12bb;
   INST_IMUL(CSD_DWORD_1000_129f);
   INST_SUB(cpu->EBX, cpu->EDX);
   INST_SHL(cpu->EBX, 0x1);
   CSD_DWORD_1000_12af = cpu->EBX;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
//also relate do steering maybe, disabling it just makes the game crash
void FUN_1000_11f0(cpu_ctx *cpu){
                              //XREF[1]:     1000:138f(c)
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   INST_ADD(cpu->SI, 0x2);
   FUN_1000_1091(cpu);
   CSD_DWORD_1000_12b3 = cpu->EAX;
   CSD_DWORD_1000_12b7 = cpu->EBX;
   CSD_DWORD_1000_12bb = cpu->ECX;
   FUN_1000_10b6(cpu);
   CSD_DWORD_1000_12bf = cpu->EAX;
   CSD_DWORD_1000_12c3 = cpu->EBX;
   CSD_DWORD_1000_12c7 = cpu->ECX;
   INST_POP(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x16);
   FUN_1000_2aad(cpu);
   INST_SHL(cpu->EAX, 0x10);
   CSD_DWORD_1000_129f = cpu->EAX;
   FUN_1000_2ad8(cpu);
   INST_SHL(cpu->EAX, 0x10);
   CSD_DWORD_1000_12a3 = cpu->EAX; //= 7FFF0000h
   cpu->EAX = CSD_DWORD_1000_12bf;
   INST_IMUL(CSD_DWORD_1000_129f);
   cpu->EBX = cpu->EDX;
   cpu->EAX = CSD_DWORD_1000_12b3;
   INST_IMUL(CSD_DWORD_1000_12a3); //= 7FFF0000h
   INST_ADD(cpu->EBX, cpu->EDX);
   INST_SHL(cpu->EBX, 0x7);
   INST_PUSH(cpu->EBX);
   cpu->EAX = CSD_DWORD_1000_12c3;
   INST_IMUL(CSD_DWORD_1000_129f);
   cpu->EBX = cpu->EDX;
   cpu->EAX = CSD_DWORD_1000_12b7;
   INST_IMUL(CSD_DWORD_1000_12a3); //= 7FFF0000h
   INST_ADD(cpu->EBX, cpu->EDX);
   INST_SHL(cpu->EBX, 0x7);
   cpu->EAX = CSD_DWORD_1000_12c7;
   INST_IMUL(CSD_DWORD_1000_129f);
   cpu->ECX = cpu->EDX;
   cpu->EAX = CSD_DWORD_1000_12bb;
   INST_IMUL(CSD_DWORD_1000_12a3); //= 7FFF0000h
   INST_ADD(cpu->ECX, cpu->EDX);
   INST_SHL(cpu->ECX, 0x7);
   INST_POP(cpu->EAX);
   return;


 // 1000:1322 [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_1323(cpu_ctx *cpu){
                              //XREF[1]:     1000:195c(c)
   INST_PUSHA();
   cpu->AX = MEM_WORD(cpu->SI + 0x1e);
   INST_TEST(cpu->AX, cpu->AX);
   JUMP«JNZ» goto LAB_LOC_1;
   cpu->AX = MEM_WORD(0x1a49);
   LAB_LOC_1:
   INST_PUSH(cpu->FS);
   cpu->FS = cpu->AX;
   INST_PUSH(cpu->SI);
   FUN_1000_1347(cpu);
   cpu->AX = cpu->DS;
   cpu->ES = cpu->AX;
   INST_POP(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI + 0x4));
   FUN_1000_1408(cpu);
   INST_POP(cpu->FS);
   INST_POPA();
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_1347(cpu_ctx *cpu){
                              //XREF[1]:     1000:1335(c)
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   cpu->CX = MEM_WORD(cpu->SI);
   INST_ADD(cpu->SI, 0x2);
   cpu->DI = 0x126;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   cpu->EAX = MEM_DWORD(cpu->SI);
   cpu->EBX = MEM_DWORD(cpu->SI + 0x4);
   cpu->ECX = MEM_DWORD(cpu->SI + 0x8);
   FUN_1000_13cc(cpu);
   cpu->EAX = MEM_DWORD(cpu->SI);
   cpu->EBX = MEM_DWORD(cpu->SI + 0x4);
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   FUN_1000_25c5(cpu);
   cpu->CX = cpu->AX;
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_SHL(cpu->ECX, 0x10);
   FUN_1000_13cc(cpu);
   INST_ADD(cpu->SI, 0x1c);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   INST_POP(cpu->SI);
   FUN_1000_11f0(cpu);
   INST_PUSH(cpu->EAX);
   INST_PUSH(cpu->EBX);
   INST_PUSH(cpu->ECX);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   INST_ADD(cpu->SI, 0x2);
   INST_ADD(cpu->EAX, MEM_DWORD(cpu->SI));
   INST_ADD(cpu->EBX, MEM_DWORD(cpu->SI + 0x4));
   INST_ADD(cpu->ECX, MEM_DWORD(cpu->SI + 0x8));
   FUN_1000_13cc(cpu);
   INST_POP(cpu->ECX);
   INST_POP(cpu->EBX);
   INST_POP(cpu->EAX);
   INST_ADD(cpu->SI, 0x1c);
   INST_NEG(cpu->EAX);
   INST_NEG(cpu->EBX);
   INST_NEG(cpu->ECX);
   INST_ADD(cpu->EAX, MEM_DWORD(cpu->SI));
   INST_ADD(cpu->EBX, MEM_DWORD(cpu->SI + 0x4));
   INST_ADD(cpu->ECX, MEM_DWORD(cpu->SI + 0x8));
   FUN_1000_13cc(cpu);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_13cc(cpu_ctx *cpu){
                              //XREF[4]:     1000:135e(c),1000:1385(c),1000:13a8(c),1000:13c8(c)
   INST_SUB(cpu->EAX, MEM_DWORD(0xaa));
   INST_SUB(cpu->EBX, MEM_DWORD(0xae));
   INST_SUB(cpu->ECX, MEM_DWORD(0xb2));
   INST_SAR(cpu->EAX, 0x10);
   INST_SAR(cpu->EBX, 0x10);
   INST_SAR(cpu->ECX, 0x10);
   cpu->DX = 0xce;
   FUN_1000_277e(cpu);
   INST_NEG(cpu->BX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->CX;
   FUN_1000_2418(cpu);
   JUMP«JC» goto LAB_LOC_1;
   MEM_WORD(cpu->DI + 0x6) = cpu->AX;
   MEM_WORD(cpu->DI + 0x8) = cpu->BX;
   LAB_LOC_1:
   INST_ADD(cpu->DI, 0xa);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_1408(cpu_ctx *cpu){
                              //XREF[21]:    1000:1340(c),1000:1441(c),1000:1447(c),1000:144b(c),
                              //             1000:1452(j),1000:1456(c),1000:145d(j),1000:1461(c),
                              //             1000:147a(j),1000:1567(j),1000:1577(j),1000:15da(j),
                              //             1000:15ea(j),1000:1666(j),1000:1676(j),1000:16dc(j),
                              //             1000:16ec(j),1000:191f(c),1000:1929(c),1000:1939(c),
                              //             1000:1942(c)
   INST_NOP();
   L_1408_START:
   INST_LODSB();
   INST_MOVZX(cpu->BX, cpu->AL);
   INST_SHL(cpu->BX, 1);
    
   switch(cpu->BX){
      case 0: goto LAB_LOC_1;
      case 2: goto LAB_LOC_6;
      case 4: goto LAB_LOC_7;
      case 6: goto LAB_LOC_8;
      case 8: goto LAB_LOC_9;
      case 10: goto LAB_LOC_11;
      case 12: goto LAB_LOC_12;
      case 14: goto LAB_LOC_14;
      case 16: goto LAB_LOC_16;
      case 18: goto LAB_LOC_18;
      case 20: goto LAB_LOC_20;
      case 22: goto LAB_LOC_1;
      case 24: goto LAB_LOC_1;
      case 26: goto LAB_LOC_1;
      case 28: goto LAB_LOC_1;
      case 30: goto LAB_LOC_1;
      case 32: goto LAB_LOC_24;
      case 34: goto LAB_LOC_2;
      case 36: goto LAB_LOC_3;
      case 38: goto LAB_LOC_4;
      case 40: goto LAB_LOC_5;
      default: __builtin_trap();
   }


   LAB_LOC_1:
                              //             1000:142f(*),1000:1431(*)
   return;
   LAB_LOC_2:
   INST_LODSW();
   INST_ADD(cpu->SI, cpu->AX);
   goto L_1408_START;
   LAB_LOC_3:
   INST_LODSW();
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, cpu->AX);
   FUN_1000_1408(cpu);
   INST_POP(cpu->SI);
   goto L_1408_START;
   LAB_LOC_4:
   cpu->AL = MEM_BYTE(0x5ee);
   INST_SAHF();
   INST_LODSW();
   JUMP«JS» goto L_1408_START;
   INST_ADD(cpu->SI, cpu->AX);
   goto L_1408_START;
   LAB_LOC_5:
   cpu->AL = MEM_BYTE(0x5ee);
   INST_SAHF();
   INST_LODSW();
   JUMP«JNS» goto L_1408_START;
   INST_ADD(cpu->SI, cpu->AX);
   goto L_1408_START;
   LAB_LOC_6:
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   cpu->AX = MEM_WORD(0x120);
   INST_CMP(MEM_WORD(cpu->DI + 0x2), cpu->AX);
   INST_LODSW();
   cpu->CL = cpu->AL;
   JUMP«JL» goto L_1408_START;
   cpu->AX = MEM_WORD(cpu->DI + 0x6);
   cpu->BX = MEM_WORD(cpu->DI + 0x8);
   FUN_1000_3f98(cpu);
   goto L_1408_START;
   LAB_LOC_7:
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   cpu->BX = MEM_WORD(cpu->DI + 0x128);
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   cpu->AX = MEM_WORD(cpu->DI + 0x128);
   INST_LODSW();
   INST_CMP(cpu->BX, cpu->AX);
   INST_LAHF();
   MEM_BYTE(0x5ee) = cpu->AL;
   goto L_1408_START;
   LAB_LOC_8:
   cpu->BX = 0; //was a XOR
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_46a0(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_46d3(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_46d3(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI + -0x6);
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_47ec(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   INST_PUSH(cpu->SI);
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   INST_LAHF();
   MEM_BYTE(0x5ee) = cpu->AL;
   INST_POP(cpu->SI);
   goto L_1408_START;
   LAB_LOC_9:
   INST_LODSB();
   INST_MOVZX(cpu->CX, cpu->AL);
   cpu->BX = 0; //was a XOR
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_46a0(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   INST_DEC(cpu->CX);
   LAB_LOC_10:
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_PUSH(cpu->CX);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_46d3(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_10;
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_47ec(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   cpu->BL = cpu->AL;
   INST_LODSW();
   MEM_WORD(0xdb12) = cpu->AX;
   INST_CMP(cpu->BL, 0x3);
   JUMP«JL» goto L_1408_START;
   INST_PUSH(cpu->SI);
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   INST_LAHF();
   MEM_BYTE(0x5ee) = cpu->AL;
   INST_POP(cpu->SI);
   JUMP«JS» goto L_1408_START;
   FUN_1000_2bec(cpu);
   goto L_1408_START;
   LAB_LOC_11:
   goto L_1408_START;
   LAB_LOC_12:
   INST_LODSB();
   INST_MOVZX(cpu->CX, cpu->AL);
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_LODSW();
   cpu->BX = cpu->AX;
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_46a0(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   INST_DEC(cpu->CX);
   LAB_LOC_13:
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_LODSW();
   cpu->BX = cpu->AX;
   INST_PUSH(cpu->CX);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_46d3(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_13;
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_LODSW();
   cpu->BX = cpu->AX;
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_47ec(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   cpu->BL = cpu->AL;
   INST_CMP(cpu->BL, 0x3);
   JUMP«JL» goto L_1408_START;
   INST_PUSH(cpu->SI);
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   INST_LAHF();
   MEM_BYTE(0x5ee) = cpu->AL;
   INST_POP(cpu->SI);
   JUMP«JS» goto L_1408_START;
   FUN_1000_30ee(cpu);
   goto L_1408_START;
   LAB_LOC_14:
   INST_LODSB();
   INST_MOVZX(cpu->CX, cpu->AL);
   INST_LODSW();
   MEM_WORD(0xdb12) = cpu->AX;
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_LODSW();
   cpu->BX = cpu->AX;
   cpu->BX = MEM_WORD(cpu->BX + 0x50e);
   INST_ADD(cpu->BX, MEM_WORD(0xdb12));
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_46a0(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   INST_DEC(cpu->CX);
   LAB_LOC_15:
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_LODSW();
   cpu->BX = cpu->AX;
   cpu->BX = MEM_WORD(cpu->BX + 0x50e);
   INST_ADD(cpu->BX, MEM_WORD(0xdb12));
   INST_PUSH(cpu->CX);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_46d3(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_15;
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_LODSW();
   cpu->BX = cpu->AX;
   cpu->BX = MEM_WORD(cpu->BX + 0x50e);
   INST_ADD(cpu->BX, MEM_WORD(0xdb12));
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_47ec(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   cpu->BL = cpu->AL;
   INST_CMP(cpu->BL, 0x3);
   JUMP«JL» goto L_1408_START;
   INST_PUSH(cpu->SI);
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   INST_LAHF();
   MEM_BYTE(0x5ee) = cpu->AL;
   INST_POP(cpu->SI);
   JUMP«JS» goto L_1408_START;
   FUN_1000_30ee(cpu);
   goto L_1408_START;
   LAB_LOC_16:
   INST_LODSB();
   INST_MOVZX(cpu->CX, cpu->AL);
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_LODSD();
   cpu->EBX = cpu->EAX;
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_46a0(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   INST_DEC(cpu->CX);
   LAB_LOC_17:
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_LODSD();
   cpu->EBX = cpu->EAX;
   INST_PUSH(cpu->CX);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_46d3(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_17;
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   INST_LODSD();
   cpu->EBX = cpu->EAX;
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_47ec(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   cpu->BL = cpu->AL;
   INST_CMP(cpu->BL, 0x3);
   JUMP«JL» goto L_1408_START;
   INST_PUSH(cpu->SI);
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   INST_LAHF();
   MEM_BYTE(0x5ee) = cpu->AL;
   INST_POP(cpu->SI);
   JUMP«JS» goto L_1408_START;
   FUN_1000_36fe(cpu);
   goto L_1408_START;
   LAB_LOC_18:
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_ADD(cpu->DI, 0x126);
   cpu->CX = MEM_WORD(cpu->DI + 0x2);
   INST_CMP(cpu->CX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_19;
   cpu->BX = MEM_WORD(cpu->DI + 0x6);
   cpu->BP = MEM_WORD(cpu->DI + 0x8);
   INST_LODSW();
   INST_CWD();
   INST_IDIV(cpu->CX);
   cpu->DX = cpu->AX;
   INST_PUSH(cpu->ES);
   cpu->AX = cpu->DS;
   cpu->ES = cpu->AX;
   cpu->DI = 0xdb16;
   cpu->AX = cpu->BX;
   INST_SUB(cpu->AX, cpu->DX);
   INST_STOSW();
   cpu->AX = cpu->BP;
   INST_SUB(cpu->AX, cpu->DX);
   INST_STOSW();
   INST_MOVSD();
   cpu->AX = cpu->BX;
   INST_ADD(cpu->AX, cpu->DX);
   INST_STOSW();
   cpu->AX = cpu->BP;
   INST_SUB(cpu->AX, cpu->DX);
   INST_STOSW();
   INST_MOVSD();
   cpu->AX = cpu->BX;
   INST_ADD(cpu->AX, cpu->DX);
   INST_STOSW();
   cpu->AX = cpu->BP;
   INST_ADD(cpu->AX, cpu->DX);
   INST_STOSW();
   INST_MOVSD();
   cpu->AX = cpu->BX;
   INST_SUB(cpu->AX, cpu->DX);
   INST_STOSW();
   cpu->AX = cpu->BP;
   INST_ADD(cpu->AX, cpu->DX);
   INST_STOSW();
   INST_MOVSD();
   INST_POP(cpu->ES);
   MEM_WORD(0xdb14) = 0x4;
   FUN_1000_36fe(cpu);
   goto L_1408_START;
   LAB_LOC_19:
   INST_ADD(cpu->SI, 0x12);
   goto L_1408_START;
   LAB_LOC_20:
   INST_PUSH(cpu->SI);
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->BX = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->BX, cpu->AX);
   cpu->AX = MEM_WORD(cpu->BX + 0x128);
   INST_CMP(cpu->AX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_23;
   INST_LODSW();
   INST_SHL(cpu->AX, 0x1);
   cpu->DI = cpu->AX;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->DI, cpu->AX);
   INST_LODSW();
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->SI);
   cpu->SI = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI + 0x126);
   cpu->BX = MEM_WORD(cpu->SI + 0x128);
   cpu->CX = MEM_WORD(cpu->SI + 0x12a);
   INST_SUB(cpu->AX, MEM_WORD(cpu->DI + 0x126));
   INST_SUB(cpu->BX, MEM_WORD(cpu->DI + 0x128));
   INST_SUB(cpu->CX, MEM_WORD(cpu->DI + 0x12a));
   FUN_1000_271d(cpu);
   INST_MOVSX(cpu->EBP, cpu->AX);
   cpu->AX = MEM_WORD(cpu->SI + 0x126);
   cpu->BX = MEM_WORD(cpu->SI + 0x128);
   cpu->CX = MEM_WORD(cpu->SI + 0x12a);
   FUN_1000_271d(cpu);
   INST_IMUL(cpu->EBP);
   cpu->EBP = cpu->EAX;
   cpu->AX = MEM_WORD(cpu->DI + 0x126);
   INST_SUB(cpu->AX, MEM_WORD(cpu->SI + 0x126));
   INST_CWD();
   INST_IMUL(MEM_WORD(cpu->SI + 0x126));
   cpu->BX = cpu->AX;
   cpu->CX = cpu->DX;
   cpu->AX = MEM_WORD(cpu->DI + 0x128);
   INST_SUB(cpu->AX, MEM_WORD(cpu->SI + 0x128));
   INST_CWD();
   INST_IMUL(MEM_WORD(cpu->SI + 0x128));
   INST_ADD(cpu->BX, cpu->AX);
   INST_ADC(cpu->CX, cpu->DX);
   cpu->AX = MEM_WORD(cpu->DI + 0x12a);
   INST_SUB(cpu->AX, MEM_WORD(cpu->SI + 0x12a));
   INST_CWD();
   INST_IMUL(MEM_WORD(cpu->SI + 0x12a));
   INST_ADD(cpu->AX, cpu->BX);
   INST_ADC(cpu->DX, cpu->CX);
   INST_XCHG(cpu->AX, cpu->DX);
   INST_ROR(cpu->EAX, 0x10);
   cpu->AX = cpu->DX;
   INST_SAR(cpu->EBP, 0x9);
   INST_SHL(cpu->EAX, 0x6);
   INST_CDQ();
   INST_IDIV(cpu->EBP);
   INST_SAR(cpu->EAX, 0x1);
   cpu->CX = 0x8;
   cpu->BX = 0x5de;
   LAB_LOC_21:
   INST_CMP(cpu->AX, MEM_WORD(cpu->BX));
   JUMP«JL» goto LAB_LOC_22;
   INST_ADD(cpu->BX, 0x2);
   if (--cpu->CX != 0) goto LAB_LOC_21;
   LAB_LOC_22:
   INST_POP(cpu->SI);
   INST_POP(cpu->BX);
   INST_SHL(cpu->CX, 0x2);
   INST_ADD(cpu->SI, cpu->CX);
   INST_SHL(cpu->CX, 0x2);
   INST_ADD(cpu->SI, cpu->CX);
   cpu->CX = MEM_WORD(cpu->BX + 0x128);
   cpu->DX = MEM_WORD(cpu->BX + 0x12c);
   cpu->BP = MEM_WORD(cpu->BX + 0x12e);
   INST_PUSH(cpu->DX);
   INST_PUSH(cpu->BP);
   cpu->AX = MEM_WORD(cpu->DI + 0x12c);
   cpu->BX = MEM_WORD(cpu->DI + 0x12e);
   INST_SUB(cpu->AX, cpu->DX);
   INST_SUB(cpu->BX, cpu->BP);
   FUN_1000_2b08(cpu);
   cpu->BX = cpu->AX;
   FUN_1000_2aad(cpu);
   cpu->BP = cpu->AX;
   FUN_1000_2ad8(cpu);
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI);
   INST_IMUL(cpu->BX);
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   cpu->AX = cpu->DX;
   INST_CWD();
   INST_IDIV(cpu->CX);
   MEM_WORD(0x5d8) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI);
   INST_IMUL(cpu->BP);
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   cpu->AX = cpu->DX;
   INST_CWD();
   INST_IDIV(cpu->CX);
   MEM_WORD(0x5d6) = cpu->AX;
   INST_ADD(cpu->SI, 0x2);
   cpu->AX = MEM_WORD(cpu->SI);
   INST_IMUL(cpu->BX);
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   cpu->AX = cpu->DX;
   INST_CWD();
   INST_IDIV(cpu->CX);
   MEM_WORD(0x5dc) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI);
   INST_IMUL(cpu->BP);
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   cpu->AX = cpu->DX;
   INST_CWD();
   INST_IDIV(cpu->CX);
   MEM_WORD(0x5da) = cpu->AX;
   INST_ADD(cpu->SI, 0x2);
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_PUSH(cpu->ES);
   cpu->AX = cpu->DS;
   cpu->ES = cpu->AX;
   cpu->DI = 0xdb16;
   cpu->AX = cpu->BX;
   INST_SUB(cpu->AX, MEM_WORD(0x5d8));
   INST_SUB(cpu->AX, MEM_WORD(0x5da));
   INST_STOSW();
   cpu->AX = cpu->BP;
   INST_ADD(cpu->AX, MEM_WORD(0x5d6));
   INST_SUB(cpu->AX, MEM_WORD(0x5dc));
   INST_STOSW();
   INST_MOVSD();
   cpu->AX = cpu->BX;
   INST_SUB(cpu->AX, MEM_WORD(0x5d8));
   INST_ADD(cpu->AX, MEM_WORD(0x5da));
   INST_STOSW();
   cpu->AX = cpu->BP;
   INST_ADD(cpu->AX, MEM_WORD(0x5d6));
   INST_ADD(cpu->AX, MEM_WORD(0x5dc));
   INST_STOSW();
   INST_MOVSD();
   cpu->AX = cpu->BX;
   INST_ADD(cpu->AX, MEM_WORD(0x5d8));
   INST_ADD(cpu->AX, MEM_WORD(0x5da));
   INST_STOSW();
   cpu->AX = cpu->BP;
   INST_SUB(cpu->AX, MEM_WORD(0x5d6));
   INST_ADD(cpu->AX, MEM_WORD(0x5dc));
   INST_STOSW();
   INST_MOVSD();
   cpu->AX = cpu->BX;
   INST_ADD(cpu->AX, MEM_WORD(0x5d8));
   INST_SUB(cpu->AX, MEM_WORD(0x5da));
   INST_STOSW();
   cpu->AX = cpu->BP;
   INST_SUB(cpu->AX, MEM_WORD(0x5d6));
   INST_SUB(cpu->AX, MEM_WORD(0x5dc));
   INST_STOSW();
   INST_MOVSD();
   INST_POP(cpu->ES);
   MEM_WORD(0xdb14) = 0x4;
   FUN_1000_36fe(cpu);
   LAB_LOC_23:
   INST_POP(cpu->SI);
   INST_ADD(cpu->SI, 0xba);
   goto L_1408_START;
   LAB_LOC_24:
   cpu->AL = MEM_BYTE(0x5ee);
   INST_SAHF();
   JUMP«JS» goto LAB_LOC_25;
   INST_PUSH(cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   INST_ADD(cpu->SI, cpu->AX);
   FUN_1000_1408(cpu);
   INST_POP(cpu->SI);
   INST_PUSH(cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, cpu->AX);
   FUN_1000_1408(cpu);
   INST_POP(cpu->SI);
   INST_ADD(cpu->SI, 0x4);
   goto L_1408_START;
   LAB_LOC_25:
   INST_PUSH(cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, cpu->AX);
   FUN_1000_1408(cpu);
   INST_POP(cpu->SI);
   INST_PUSH(cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   INST_ADD(cpu->SI, cpu->AX);
   FUN_1000_1408(cpu);
   INST_POP(cpu->SI);
   INST_ADD(cpu->SI, 0x4);
   goto L_1408_START;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_194c(cpu_ctx *cpu){
                              //XREF[8]:     1000:1a50(c),1000:1b06(c),1000:1bfa(c),1000:1caa(c),
                              //             1000:2063(c),1000:2117(c),1000:220c(c),1000:22bc(c)
   cpu->DI = 0x5bbc;
   cpu->CX = MEM_WORD(0x5bba);
   LAB_LOC_1:
   cpu->SI = MEM_WORD(cpu->DI);
   INST_CMP(cpu->DX, MEM_WORD(cpu->SI + 0x1a));
   JUMP«JNZ» goto LAB_LOC_2;
   FUN_1000_1323(cpu);
   LAB_LOC_2:
   INST_ADD(cpu->DI, 0x2);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_1965(cpu_ctx *cpu){
                              //XREF[3]:     1000:02c9(c),1000:0395(c),1000:0455(c)
   MEM_WORD(0x19ff) = 0x0;
   MEM_WORD(0x1a01) = 0xa00;
   cpu->AX = MEM_WORD(0xc6);
   INST_TEST(cpu->AH, 0x60);
    //jumping to another function, some kind of tail call optimization
   JUMP«JNP» goto FUN_1965_NP;
   MEM_BYTE(0x5fb) = 0x0;
   FUN_1000_3fd0(cpu);
   cpu->AX = MEM_WORD(0xc6);
   INST_TEST(cpu->AH, 0xa0);
   JUMP«JNP» goto LAB_LOC_12;
   cpu->DI = 0x5bbc;
   cpu->CX = MEM_WORD(0x5bba);
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   cpu->SI = MEM_WORD(cpu->DI);
   FUN_1000_22f0(cpu);
   INST_ADD(cpu->DI, 0x2);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   cpu->SI = 0xe590;
   cpu->AX = MEM_WORD(0xe58c);
   cpu->BH = cpu->AL;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->SI, cpu->AX);
   LAB_LOC_2:
   INST_PUSH(cpu->BX);
   cpu->BL = MEM_BYTE(cpu->SI);
   INST_MOVZX(cpu->DX, cpu->BL);
   INST_SHL(cpu->DX, 0x1);
   cpu->DI = cpu->DX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->DX);
   INST_ADD(cpu->DI, 0x5ff);
   INST_ADD(cpu->DI, MEM_WORD(0x19ff));
   LAB_LOC_3:
   MEM_WORD(0x5fd) = cpu->BX;
   INST_PUSH(cpu->BX);
   cpu->AL = MEM_BYTE(cpu->FS*SEGM + cpu->BX + 0xfeff);
   MEM_BYTE(0x5fc) = cpu->AL;
   INST_MOVZX(cpu->CX, MEM_BYTE(cpu->GS*SEGM + cpu->BX));
   INST_SHL(cpu->CX, 0x4);
   cpu->AH = cpu->BL;
   cpu->AL = 0; //was a XOR
   cpu->BL = 0; //was a XOR
   INST_SUB(cpu->AX, MEM_WORD(0xac));
   INST_SUB(cpu->BX, MEM_WORD(0xb0));
   INST_SUB(cpu->CX, MEM_WORD(0xb4));
   cpu->DX = 0xce;
   FUN_1000_277e(cpu);
   INST_NEG(cpu->BX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->CX;
   INST_CMP(cpu->BX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_4;
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, MEM_WORD(0xdbb8));
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, MEM_WORD(0xdbba));
   MEM_WORD(cpu->DI + 0x6) = cpu->AX;
   MEM_WORD(cpu->DI + 0x8) = cpu->BX;
   LAB_LOC_4:
   cpu->DX = MEM_WORD(0x5fd);
   INST_CMP(cpu->DH, MEM_BYTE(0xe58c));
   JUMP«JZ» goto LAB_LOC_5;
   INST_CMP(cpu->DL, MEM_BYTE(cpu->SI));
   JUMP«JZ» goto LAB_LOC_5;
   INST_CMP(cpu->DL, MEM_BYTE(cpu->SI + -0x4));
   JUMP«JBE» goto LAB_LOC_5;
   INST_CMP(cpu->DL, MEM_BYTE(cpu->SI + -0x2));
   JUMP«JA» goto LAB_LOC_5;
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   INST_SUB(cpu->DI, 0xa);
   cpu->SI = cpu->DI;
   INST_SUB(cpu->DI, MEM_WORD(0x19ff));
   INST_ADD(cpu->DI, MEM_WORD(0x1a01));
   FUN_1000_1cde(cpu);
   cpu->DX = MEM_WORD(0x5fd);
   INST_SUB(cpu->DX, 0x101);
   FUN_1000_194c(cpu);
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   LAB_LOC_5:
   INST_POP(cpu->BX);
   INST_CMP(cpu->BL, MEM_BYTE(0xad));
   JUMP«JNC» goto LAB_LOC_6;
   INST_INC(cpu->BL);
   INST_ADD(cpu->DI, 0xa);
   goto LAB_LOC_3;
   LAB_LOC_6:
   cpu->BL = MEM_BYTE(cpu->SI + 0x2);
   INST_MOVZX(cpu->DX, cpu->BL);
   INST_SHL(cpu->DX, 0x1);
   cpu->DI = cpu->DX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->DX);
   INST_ADD(cpu->DI, 0x5ff);
   INST_ADD(cpu->DI, MEM_WORD(0x19ff));
   LAB_LOC_7:
   MEM_WORD(0x5fd) = cpu->BX;
   INST_PUSH(cpu->BX);
   cpu->AL = MEM_BYTE(cpu->FS*SEGM + cpu->BX + 0xff00);
   MEM_BYTE(0x5fc) = cpu->AL;
   INST_MOVZX(cpu->CX, MEM_BYTE(cpu->GS*SEGM + cpu->BX));
   INST_SHL(cpu->CX, 0x4);
   cpu->AH = cpu->BL;
   cpu->AL = 0; //was a XOR
   cpu->BL = 0; //was a XOR
   INST_SUB(cpu->AX, MEM_WORD(0xac));
   INST_SUB(cpu->BX, MEM_WORD(0xb0));
   INST_SUB(cpu->CX, MEM_WORD(0xb4));
   cpu->DX = 0xce;
   FUN_1000_277e(cpu);
   INST_NEG(cpu->BX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->CX;
   INST_CMP(cpu->BX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_8;
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, MEM_WORD(0xdbb8));
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, MEM_WORD(0xdbba));
   MEM_WORD(cpu->DI + 0x6) = cpu->AX;
   MEM_WORD(cpu->DI + 0x8) = cpu->BX;
   LAB_LOC_8:
   cpu->DX = MEM_WORD(0x5fd);
   INST_CMP(cpu->DH, MEM_BYTE(0xe58c));
   JUMP«JZ» goto LAB_LOC_9;
   INST_CMP(cpu->DL, MEM_BYTE(cpu->SI + 0x2));
   JUMP«JZ» goto LAB_LOC_9;
   INST_CMP(cpu->DL, MEM_BYTE(cpu->SI + -0x4));
   JUMP«JC» goto LAB_LOC_9;
   INST_CMP(cpu->DL, MEM_BYTE(cpu->SI + -0x2));
   JUMP«JNC» goto LAB_LOC_9;
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->SI = cpu->DI;
   INST_SUB(cpu->DI, MEM_WORD(0x19ff));
   INST_ADD(cpu->DI, MEM_WORD(0x1a01));
   FUN_1000_1cde(cpu);
   cpu->DX = MEM_WORD(0x5fd);
   INST_SUB(cpu->DX, 0x100);
   FUN_1000_194c(cpu);
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   LAB_LOC_9:
   INST_POP(cpu->BX);
   INST_CMP(cpu->BL, MEM_BYTE(0xad));
   JUMP«JBE» goto LAB_LOC_10;
   INST_DEC(cpu->BL);
   INST_SUB(cpu->DI, 0xa);
   goto LAB_LOC_7;
   LAB_LOC_10:
   INST_POP(cpu->BX);
   INST_CMP(cpu->BH, MEM_BYTE(0xe58e));
   JUMP«JNC» goto LAB_LOC_11;
   INST_INC(cpu->BH);
   INST_ADD(cpu->SI, 0x4);
   INST_XOR(MEM_WORD(0x19ff), 0xa00);
   INST_XOR(MEM_WORD(0x1a01), 0xa00);
   goto LAB_LOC_2;
   LAB_LOC_11:
   return;
   LAB_LOC_12:
   cpu->DI = 0x5bbc;
   cpu->CX = MEM_WORD(0x5bba);
   LAB_LOC_13:
   INST_PUSH(cpu->CX);
   cpu->SI = MEM_WORD(cpu->DI);
   FUN_1000_233b(cpu);
   INST_ADD(cpu->DI, 0x2);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_13;
   cpu->SI = 0xe590;
   cpu->AX = MEM_WORD(0xe58e);
   cpu->BH = cpu->AL;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->SI, cpu->AX);
   LAB_LOC_14:
   INST_PUSH(cpu->BX);
   cpu->BL = MEM_BYTE(cpu->SI);
   INST_MOVZX(cpu->DX, cpu->BL);
   INST_SHL(cpu->DX, 0x1);
   cpu->DI = cpu->DX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->DX);
   INST_ADD(cpu->DI, 0x5ff);
   INST_ADD(cpu->DI, MEM_WORD(0x19ff));
   LAB_LOC_15:
   MEM_WORD(0x5fd) = cpu->BX;
   INST_PUSH(cpu->BX);
   cpu->AL = MEM_BYTE(cpu->FS*SEGM + cpu->BX + -0x1);
   MEM_BYTE(0x5fc) = cpu->AL;
   INST_MOVZX(cpu->CX, MEM_BYTE(cpu->GS*SEGM + cpu->BX));
   INST_SHL(cpu->CX, 0x4);
   cpu->AH = cpu->BL;
   cpu->AL = 0; //was a XOR
   cpu->BL = 0; //was a XOR
   INST_SUB(cpu->AX, MEM_WORD(0xac));
   INST_SUB(cpu->BX, MEM_WORD(0xb0));
   INST_SUB(cpu->CX, MEM_WORD(0xb4));
   cpu->DX = 0xce;
   FUN_1000_277e(cpu);
   INST_NEG(cpu->BX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->CX;
   INST_CMP(cpu->BX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_16;
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, MEM_WORD(0xdbb8));
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, MEM_WORD(0xdbba));
   MEM_WORD(cpu->DI + 0x6) = cpu->AX;
   MEM_WORD(cpu->DI + 0x8) = cpu->BX;
   LAB_LOC_16:
   cpu->DX = MEM_WORD(0x5fd);
   INST_CMP(cpu->DH, MEM_BYTE(0xe58e));
   JUMP«JZ» goto LAB_LOC_17;
   INST_CMP(cpu->DL, MEM_BYTE(cpu->SI));
   JUMP«JZ» goto LAB_LOC_17;
   INST_CMP(cpu->DL, MEM_BYTE(cpu->SI + 0x4));
   JUMP«JBE» goto LAB_LOC_17;
   INST_CMP(cpu->DL, MEM_BYTE(cpu->SI + 0x6));
   JUMP«JA» goto LAB_LOC_17;
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   INST_SUB(cpu->DI, 0xa);
   cpu->SI = cpu->DI;
   INST_SUB(cpu->SI, MEM_WORD(0x19ff));
   INST_ADD(cpu->SI, MEM_WORD(0x1a01));
   FUN_1000_1cde(cpu);
   cpu->DX = MEM_WORD(0x5fd);
   INST_SUB(cpu->DL, 0x1);
   FUN_1000_194c(cpu);
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   LAB_LOC_17:
   INST_POP(cpu->BX);
   INST_CMP(cpu->BL, MEM_BYTE(0xad));
   JUMP«JNC» goto LAB_LOC_18;
   INST_INC(cpu->BL);
   INST_ADD(cpu->DI, 0xa);
   goto LAB_LOC_15;
   LAB_LOC_18:
   cpu->BL = MEM_BYTE(cpu->SI + 0x2);
   INST_MOVZX(cpu->DX, cpu->BL);
   INST_SHL(cpu->DX, 0x1);
   cpu->DI = cpu->DX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->DX);
   INST_ADD(cpu->DI, 0x5ff);
   INST_ADD(cpu->DI, MEM_WORD(0x19ff));
   LAB_LOC_19:
   MEM_WORD(0x5fd) = cpu->BX;
   INST_PUSH(cpu->BX);
   cpu->AL = MEM_BYTE(cpu->FS*SEGM + cpu->BX);
   MEM_BYTE(0x5fc) = cpu->AL;
   INST_MOVZX(cpu->CX, MEM_BYTE(cpu->GS*SEGM + cpu->BX));
   INST_SHL(cpu->CX, 0x4);
   cpu->AH = cpu->BL;
   cpu->AL = 0; //was a XOR
   cpu->BL = 0; //was a XOR
   INST_SUB(cpu->AX, MEM_WORD(0xac));
   INST_SUB(cpu->BX, MEM_WORD(0xb0));
   INST_SUB(cpu->CX, MEM_WORD(0xb4));
   cpu->DX = 0xce;
   FUN_1000_277e(cpu);
   INST_NEG(cpu->BX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->CX;
   INST_CMP(cpu->BX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_20;
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, MEM_WORD(0xdbb8));
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, MEM_WORD(0xdbba));
   MEM_WORD(cpu->DI + 0x6) = cpu->AX;
   MEM_WORD(cpu->DI + 0x8) = cpu->BX;
   LAB_LOC_20:
   cpu->DX = MEM_WORD(0x5fd);
   INST_CMP(cpu->DH, MEM_BYTE(0xe58e));
   JUMP«JZ» goto LAB_LOC_21;
   INST_CMP(cpu->DL, MEM_BYTE(cpu->SI + 0x2));
   JUMP«JZ» goto LAB_LOC_21;
   INST_CMP(cpu->DL, MEM_BYTE(cpu->SI + 0x4));
   JUMP«JC» goto LAB_LOC_21;
   INST_CMP(cpu->DL, MEM_BYTE(cpu->SI + 0x6));
   JUMP«JNC» goto LAB_LOC_21;
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->SI = cpu->DI;
   INST_SUB(cpu->SI, MEM_WORD(0x19ff));
   INST_ADD(cpu->SI, MEM_WORD(0x1a01));
   FUN_1000_1cde(cpu);
   cpu->DX = MEM_WORD(0x5fd);
   FUN_1000_194c(cpu);
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   LAB_LOC_21:
   INST_POP(cpu->BX);
   INST_CMP(cpu->BL, MEM_BYTE(0xad));
   JUMP«JBE» goto LAB_LOC_22;
   INST_DEC(cpu->BL);
   INST_SUB(cpu->DI, 0xa);
   goto LAB_LOC_19;
   LAB_LOC_22:
   INST_POP(cpu->BX);
   INST_CMP(cpu->BH, MEM_BYTE(0xe58c));
   JUMP«JBE» goto LAB_LOC_23;
   INST_DEC(cpu->BH);
   INST_SUB(cpu->SI, 0x4);
   INST_XOR(MEM_WORD(0x19ff), 0xa00);
   INST_XOR(MEM_WORD(0x1a01), 0xa00);
   goto LAB_LOC_14;
   LAB_LOC_23:
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_1cde(cpu_ctx *cpu){
                              //XREF[4]:     1000:1a45(c),1000:1afb(c),1000:1bf0(c),1000:1ca3(c)
   cpu->AL = MEM_BYTE(0x5fc);
   cpu->BX = 0x1d51;
   cpu->CX = MEM_WORD(cpu->DI + 0xc);
   INST_ADD(cpu->CX, MEM_WORD(cpu->SI + 0x2));
   INST_SAR(cpu->CX, 0x2);
   INST_CMP(cpu->CX, MEM_WORD(0x5f5));
   JUMP«JL» goto LAB_LOC_4;
   INST_ADD(cpu->BH, cpu->CH);
   INST_XLAT();
   cpu->AH = cpu->AL;
   MEM_WORD(0xdb12) = cpu->AX;
   INST_PUSH(cpu->SI);
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   cpu->EBX = 0; //was a XOR
   FUN_1000_46a0(cpu);
   cpu->SI = cpu->DI;
   FUN_1000_46d3(cpu);
   INST_POP(cpu->SI);
   FUN_1000_46d3(cpu);
   INST_PUSH(cpu->SI);
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   FUN_1000_47ec(cpu);
   INST_CMP(cpu->AL, 0x3);
   JUMP«JL» goto LAB_LOC_1;
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   JUMP«JNS» goto LAB_LOC_1;
   FUN_1000_2bec(cpu);
   LAB_LOC_1:
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   cpu->EBX = 0; //was a XOR
   FUN_1000_46a0(cpu);
   INST_POP(cpu->SI);
   FUN_1000_46d3(cpu);
   INST_ADD(cpu->SI, 0xa);
   FUN_1000_46d3(cpu);
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   FUN_1000_47ec(cpu);
   INST_CMP(cpu->AL, 0x3);
   JUMP«JL» goto LAB_LOC_3;
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   JUMP«JNS» goto LAB_LOC_3;
   cpu->AX = MEM_WORD(0xdb12);
   INST_TEST(cpu->AL, 0xf);
   JUMP«JZ» goto LAB_LOC_2;
   INST_SUB(MEM_WORD(0xdb12), 0x101);
   LAB_LOC_2:
   FUN_1000_2bec(cpu);
   LAB_LOC_3:
   return;
   LAB_LOC_4:
   INST_PUSH(cpu->FS);
   cpu->FS = MEM_WORD(0x1a4b);
   cpu->AH = MEM_BYTE(0x5fc);
   cpu->BH = cpu->AL;
   INST_AND(cpu->BH, 0xf0);
   INST_SHL(cpu->AH, 0x4);
   cpu->BL = 0x80;
   cpu->AL = 0x80;
   INST_SHL(cpu->EBX, 0x10);
   cpu->BX = cpu->AX;
   MEM_DWORD(0x1d4d) = cpu->EBX;
   INST_PUSH(cpu->SI);
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf00);
   FUN_1000_46a0(cpu);
   cpu->SI = cpu->DI;
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0x0);
   FUN_1000_46d3(cpu);
   INST_POP(cpu->SI);
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf000000);
   FUN_1000_46d3(cpu);
   INST_PUSH(cpu->SI);
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf00);
   FUN_1000_47ec(cpu);
   INST_CMP(cpu->AL, 0x3);
   JUMP«JL» goto LAB_LOC_5;
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   JUMP«JNS» goto LAB_LOC_5;
   FUN_1000_36fe(cpu);
   LAB_LOC_5:
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf00);
   FUN_1000_46a0(cpu);
   INST_POP(cpu->SI);
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf000000);
   FUN_1000_46d3(cpu);
   INST_ADD(cpu->SI, 0xa);
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf000f00);
   FUN_1000_46d3(cpu);
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf00);
   FUN_1000_47ec(cpu);
   INST_CMP(cpu->AL, 0x3);
   JUMP«JL» goto LAB_LOC_6;
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   JUMP«JNS» goto LAB_LOC_6;
   FUN_1000_36fe(cpu);
   LAB_LOC_6:
   INST_POP(cpu->FS);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_1e3a(cpu_ctx *cpu){
                              //XREF[4]:     1000:2058(c),1000:210d(c),1000:2202(c),1000:22b5(c)
   cpu->AL = MEM_BYTE(0x5fc);
   cpu->BX = 0x1d51;
   cpu->CX = MEM_WORD(cpu->DI + 0xc);
   INST_ADD(cpu->CX, MEM_WORD(cpu->SI + 0x2));
   INST_SAR(cpu->CX, 0x2);
   INST_CMP(cpu->CX, MEM_WORD(0x5f5));
   JUMP«JL» goto LAB_LOC_4;
   INST_ADD(cpu->BH, cpu->CH);
   INST_XLAT();
   cpu->AH = cpu->AL;
   MEM_WORD(0xdb12) = cpu->AX;
   INST_PUSH(cpu->SI);
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   cpu->EBX = 0; //was a XOR
   FUN_1000_46a0(cpu);
   cpu->SI = cpu->DI;
   FUN_1000_46d3(cpu);
   INST_POP(cpu->SI);
   FUN_1000_46d3(cpu);
   INST_PUSH(cpu->SI);
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   FUN_1000_47ec(cpu);
   INST_CMP(cpu->AL, 0x3);
   JUMP«JL» goto LAB_LOC_1;
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   JUMP«JS» goto LAB_LOC_1;
   FUN_1000_2bec(cpu);
   LAB_LOC_1:
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   FUN_1000_46a0(cpu);
   INST_POP(cpu->SI);
   FUN_1000_46d3(cpu);
   INST_ADD(cpu->SI, 0xa);
   FUN_1000_46d3(cpu);
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   FUN_1000_47ec(cpu);
   INST_CMP(cpu->AL, 0x3);
   JUMP«JL» goto LAB_LOC_3;
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   JUMP«JS» goto LAB_LOC_3;
   cpu->AX = MEM_WORD(0xdb12);
   INST_TEST(cpu->AL, 0xf);
   JUMP«JZ» goto LAB_LOC_2;
   INST_SUB(MEM_WORD(0xdb12), 0x101);
   LAB_LOC_2:
   FUN_1000_2bec(cpu);
   LAB_LOC_3:
   return;
   LAB_LOC_4:
   INST_PUSH(cpu->FS);
   cpu->FS = MEM_WORD(0x1a4b);
   cpu->AH = MEM_BYTE(0x5fc);
   cpu->BH = cpu->AL;
   INST_AND(cpu->BH, 0xf0);
   INST_SHL(cpu->AH, 0x4);
   cpu->BL = 0x80;
   cpu->AL = 0x80;
   INST_SHL(cpu->EBX, 0x10);
   cpu->BX = cpu->AX;
   MEM_DWORD(0x1d4d) = cpu->EBX;
   INST_PUSH(cpu->SI);
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   INST_OR(cpu->EBX, 0xf000000);
   FUN_1000_46a0(cpu);
   cpu->SI = cpu->DI;
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0x0);
   FUN_1000_46d3(cpu);
   INST_POP(cpu->SI);
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf00);
   FUN_1000_46d3(cpu);
   INST_PUSH(cpu->SI);
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf000000);
   FUN_1000_47ec(cpu);
   INST_CMP(cpu->AL, 0x3);
   JUMP«JL» goto LAB_LOC_5;
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   JUMP«JS» goto LAB_LOC_5;
   FUN_1000_36fe(cpu);
   LAB_LOC_5:
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf000000);
   FUN_1000_46a0(cpu);
   INST_POP(cpu->SI);
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf00);
   FUN_1000_46d3(cpu);
   INST_ADD(cpu->SI, 0xa);
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf000f00);
   FUN_1000_46d3(cpu);
   cpu->SI = cpu->DI + 0xa; //HARDCODED LEA!
   cpu->EBX = MEM_DWORD(0x1d4d);
   INST_OR(cpu->EBX, 0xf000000);
   FUN_1000_47ec(cpu);
   INST_CMP(cpu->AL, 0x3);
   JUMP«JL» goto LAB_LOC_6;
   cpu->SI = 0xdb16;
   FUN_1000_2662(cpu);
   JUMP«JS» goto LAB_LOC_6;
   FUN_1000_36fe(cpu);
   LAB_LOC_6:
   INST_POP(cpu->FS);
   return;

}

//seems like a alternative version of FUN_1000_1965, what it does? who knows?
void FUN_1965_NP(cpu_ctx *cpu){
   LAB_LOC_1:
   MEM_BYTE(0x5fb) = 0x1;
   FUN_1000_41b2(cpu);
   cpu->AX = MEM_WORD(0xc6);
   INST_TEST(cpu->AH, 0xc0);
   JUMP«JNS» goto LAB_LOC_13;
   cpu->DI = 0x5bbc;
   cpu->CX = MEM_WORD(0x5bba);
   LAB_LOC_2:
   INST_PUSH(cpu->CX);
   cpu->SI = MEM_WORD(cpu->DI);
   FUN_1000_2384(cpu);
   INST_ADD(cpu->DI, 0x2);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_2;
   cpu->SI = 0xe590;
   cpu->AX = MEM_WORD(0xe58c);
   cpu->BL = cpu->AL;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->SI, cpu->AX);
   LAB_LOC_3:
   INST_PUSH(cpu->BX);
   cpu->BH = MEM_BYTE(cpu->SI);
   INST_MOVZX(cpu->DX, cpu->BH);
   INST_SHL(cpu->DX, 0x1);
   cpu->DI = cpu->DX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->DX);
   INST_ADD(cpu->DI, 0x5ff);
   INST_ADD(cpu->DI, MEM_WORD(0x19ff));
   LAB_LOC_4:
   MEM_WORD(0x5fd) = cpu->BX;
   INST_PUSH(cpu->BX);
   cpu->AL = MEM_BYTE(cpu->FS*SEGM + cpu->BX + 0xfeff);
   MEM_BYTE(0x5fc) = cpu->AL;
   INST_MOVZX(cpu->CX, MEM_BYTE(cpu->GS*SEGM + cpu->BX));
   INST_SHL(cpu->CX, 0x4);
   cpu->AH = cpu->BL;
   cpu->AL = 0; //was a XOR
   cpu->BL = 0; //was a XOR
   INST_SUB(cpu->AX, MEM_WORD(0xac));
   INST_SUB(cpu->BX, MEM_WORD(0xb0));
   INST_SUB(cpu->CX, MEM_WORD(0xb4));
   cpu->DX = 0xce;
   FUN_1000_277e(cpu);
   INST_NEG(cpu->BX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->CX;
   INST_CMP(cpu->BX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_5;
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, MEM_WORD(0xdbb8));
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, MEM_WORD(0xdbba));
   MEM_WORD(cpu->DI + 0x6) = cpu->AX;
   MEM_WORD(cpu->DI + 0x8) = cpu->BX;
   LAB_LOC_5:
   cpu->DX = MEM_WORD(0x5fd);
   INST_CMP(cpu->DL, MEM_BYTE(0xe58c));
   JUMP«JZ» goto LAB_LOC_6;
   INST_CMP(cpu->DH, MEM_BYTE(cpu->SI));
   JUMP«JZ» goto LAB_LOC_6;
   INST_CMP(cpu->DH, MEM_BYTE(cpu->SI + -0x4));
   JUMP«JBE» goto LAB_LOC_6;
   INST_CMP(cpu->DH, MEM_BYTE(cpu->SI + -0x2));
   JUMP«JA» goto LAB_LOC_6;
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   INST_SUB(cpu->DI, 0xa);
   cpu->SI = cpu->DI;
   INST_SUB(cpu->DI, MEM_WORD(0x19ff));
   INST_ADD(cpu->DI, MEM_WORD(0x1a01));
   FUN_1000_1e3a(cpu);
   cpu->DX = MEM_WORD(0x5fd);
   INST_SUB(cpu->DX, 0x101);
   FUN_1000_194c(cpu);
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   LAB_LOC_6:
   INST_POP(cpu->BX);
   INST_CMP(cpu->BH, MEM_BYTE(0xb1));
   JUMP«JNC» goto LAB_LOC_7;
   INST_INC(cpu->BH);
   INST_ADD(cpu->DI, 0xa);
   goto LAB_LOC_4;
   LAB_LOC_7:
   cpu->BH = MEM_BYTE(cpu->SI + 0x2);
   INST_MOVZX(cpu->DX, cpu->BH);
   INST_SHL(cpu->DX, 0x1);
   cpu->DI = cpu->DX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->DX);
   INST_ADD(cpu->DI, 0x5ff);
   INST_ADD(cpu->DI, MEM_WORD(0x19ff));
   LAB_LOC_8:
   MEM_WORD(0x5fd) = cpu->BX;
   INST_PUSH(cpu->BX);
   cpu->AL = MEM_BYTE(cpu->FS*SEGM + cpu->BX + -0x1);
   MEM_BYTE(0x5fc) = cpu->AL;
   INST_MOVZX(cpu->CX, MEM_BYTE(cpu->GS*SEGM + cpu->BX));
   INST_SHL(cpu->CX, 0x4);
   cpu->AH = cpu->BL;
   cpu->AL = 0; //was a XOR
   cpu->BL = 0; //was a XOR
   INST_SUB(cpu->AX, MEM_WORD(0xac));
   INST_SUB(cpu->BX, MEM_WORD(0xb0));
   INST_SUB(cpu->CX, MEM_WORD(0xb4));
   cpu->DX = 0xce;
   FUN_1000_277e(cpu);
   INST_NEG(cpu->BX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->CX;
   INST_CMP(cpu->BX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_9;
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, MEM_WORD(0xdbb8));
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, MEM_WORD(0xdbba));
   MEM_WORD(cpu->DI + 0x6) = cpu->AX;
   MEM_WORD(cpu->DI + 0x8) = cpu->BX;
   LAB_LOC_9:
   cpu->DX = MEM_WORD(0x5fd);
   INST_CMP(cpu->DL, MEM_BYTE(0xe58c));
   JUMP«JZ» goto LAB_LOC_10;
   INST_CMP(cpu->DH, MEM_BYTE(cpu->SI + 0x2));
   JUMP«JZ» goto LAB_LOC_10;
   INST_CMP(cpu->DH, MEM_BYTE(cpu->SI + -0x4));
   JUMP«JC» goto LAB_LOC_10;
   INST_CMP(cpu->DH, MEM_BYTE(cpu->SI + -0x2));
   JUMP«JNC» goto LAB_LOC_10;
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->SI = cpu->DI;
   INST_SUB(cpu->DI, MEM_WORD(0x19ff));
   INST_ADD(cpu->DI, MEM_WORD(0x1a01));
   FUN_1000_1e3a(cpu);
   cpu->DX = MEM_WORD(0x5fd);
   INST_SUB(cpu->DX, 0x1);
   FUN_1000_194c(cpu);
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   LAB_LOC_10:
   INST_POP(cpu->BX);
   INST_CMP(cpu->BH, MEM_BYTE(0xb1));
   JUMP«JBE» goto LAB_LOC_11;
   INST_DEC(cpu->BH);
   INST_SUB(cpu->DI, 0xa);
   goto LAB_LOC_8;
   LAB_LOC_11:
   INST_POP(cpu->BX);
   INST_CMP(cpu->BL, MEM_BYTE(0xe58e));
   JUMP«JNC» goto LAB_LOC_12;
   INST_INC(cpu->BL);
   INST_ADD(cpu->SI, 0x4);
   INST_XOR(MEM_WORD(0x19ff), 0xa00);
   INST_XOR(MEM_WORD(0x1a01), 0xa00);
   goto LAB_LOC_3;
   LAB_LOC_12:
   return;
   LAB_LOC_13:
   cpu->DI = 0x5bbc;
   cpu->CX = MEM_WORD(0x5bba);
   LAB_LOC_14:
   INST_PUSH(cpu->CX);
   cpu->SI = MEM_WORD(cpu->DI);
   FUN_1000_23cf(cpu);
   INST_ADD(cpu->DI, 0x2);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_14;
   cpu->SI = 0xe590;
   cpu->AX = MEM_WORD(0xe58e);
   cpu->BL = cpu->AL;
   INST_SHL(cpu->AX, 0x2);
   INST_ADD(cpu->SI, cpu->AX);
   LAB_LOC_15:
   INST_PUSH(cpu->BX);
   cpu->BH = MEM_BYTE(cpu->SI);
   INST_MOVZX(cpu->DX, cpu->BH);
   INST_SHL(cpu->DX, 0x1);
   cpu->DI = cpu->DX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->DX);
   INST_ADD(cpu->DI, 0x5ff);
   INST_ADD(cpu->DI, MEM_WORD(0x19ff));
   LAB_LOC_16:
   MEM_WORD(0x5fd) = cpu->BX;
   INST_PUSH(cpu->BX);
   cpu->AL = MEM_BYTE(cpu->FS*SEGM + cpu->BX + 0xff00);
   MEM_BYTE(0x5fc) = cpu->AL;
   INST_MOVZX(cpu->CX, MEM_BYTE(cpu->GS*SEGM + cpu->BX));
   INST_SHL(cpu->CX, 0x4);
   cpu->AH = cpu->BL;
   cpu->AL = 0; //was a XOR
   cpu->BL = 0; //was a XOR
   INST_SUB(cpu->AX, MEM_WORD(0xac));
   INST_SUB(cpu->BX, MEM_WORD(0xb0));
   INST_SUB(cpu->CX, MEM_WORD(0xb4));
   cpu->DX = 0xce;
   FUN_1000_277e(cpu);
   INST_NEG(cpu->BX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->CX;
   INST_CMP(cpu->BX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_17;
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, MEM_WORD(0xdbb8));
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, MEM_WORD(0xdbba));
   MEM_WORD(cpu->DI + 0x6) = cpu->AX;
   MEM_WORD(cpu->DI + 0x8) = cpu->BX;
   LAB_LOC_17:
   cpu->DX = MEM_WORD(0x5fd);
   INST_CMP(cpu->DL, MEM_BYTE(0xe58e));
   JUMP«JZ» goto LAB_LOC_18;
   INST_CMP(cpu->DH, MEM_BYTE(cpu->SI));
   JUMP«JZ» goto LAB_LOC_18;
   INST_CMP(cpu->DH, MEM_BYTE(cpu->SI + 0x4));
   JUMP«JBE» goto LAB_LOC_18;
   INST_CMP(cpu->DH, MEM_BYTE(cpu->SI + 0x6));
   JUMP«JA» goto LAB_LOC_18;
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   INST_SUB(cpu->DI, 0xa);
   cpu->SI = cpu->DI;
   INST_SUB(cpu->SI, MEM_WORD(0x19ff));
   INST_ADD(cpu->SI, MEM_WORD(0x1a01));
   FUN_1000_1e3a(cpu);
   cpu->DX = MEM_WORD(0x5fd);
   INST_SUB(cpu->DH, 0x1);
   FUN_1000_194c(cpu);
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   LAB_LOC_18:
   INST_POP(cpu->BX);
   INST_CMP(cpu->BH, MEM_BYTE(0xb1));
   JUMP«JNC» goto LAB_LOC_19;
   INST_INC(cpu->BH);
   INST_ADD(cpu->DI, 0xa);
   goto LAB_LOC_16;
   LAB_LOC_19:
   cpu->BH = MEM_BYTE(cpu->SI + 0x2);
   INST_MOVZX(cpu->DX, cpu->BH);
   INST_SHL(cpu->DX, 0x1);
   cpu->DI = cpu->DX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->DX);
   INST_ADD(cpu->DI, 0x5ff);
   INST_ADD(cpu->DI, MEM_WORD(0x19ff));
   LAB_LOC_20:
   MEM_WORD(0x5fd) = cpu->BX;
   INST_PUSH(cpu->BX);
   cpu->AL = MEM_BYTE(cpu->FS*SEGM + cpu->BX);
   MEM_BYTE(0x5fc) = cpu->AL;
   INST_MOVZX(cpu->CX, MEM_BYTE(cpu->GS*SEGM + cpu->BX));
   INST_SHL(cpu->CX, 0x4);
   cpu->AH = cpu->BL;
   cpu->AL = 0; //was a XOR
   cpu->BL = 0; //was a XOR
   INST_SUB(cpu->AX, MEM_WORD(0xac));
   INST_SUB(cpu->BX, MEM_WORD(0xb0));
   INST_SUB(cpu->CX, MEM_WORD(0xb4));
   cpu->DX = 0xce;
   FUN_1000_277e(cpu);
   INST_NEG(cpu->BX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->CX;
   INST_CMP(cpu->BX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_21;
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, MEM_WORD(0xdbb8));
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, MEM_WORD(0xdbba));
   MEM_WORD(cpu->DI + 0x6) = cpu->AX;
   MEM_WORD(cpu->DI + 0x8) = cpu->BX;
   LAB_LOC_21:
   cpu->DX = MEM_WORD(0x5fd);
   INST_CMP(cpu->DL, MEM_BYTE(0xe58e));
   JUMP«JZ» goto LAB_LOC_22;
   INST_CMP(cpu->DH, MEM_BYTE(cpu->SI + 0x2));
   JUMP«JZ» goto LAB_LOC_22;
   INST_CMP(cpu->DH, MEM_BYTE(cpu->SI + 0x4));
   JUMP«JC» goto LAB_LOC_22;
   INST_CMP(cpu->DH, MEM_BYTE(cpu->SI + 0x6));
   JUMP«JNC» goto LAB_LOC_22;
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->SI = cpu->DI;
   INST_SUB(cpu->SI, MEM_WORD(0x19ff));
   INST_ADD(cpu->SI, MEM_WORD(0x1a01));
   FUN_1000_1e3a(cpu);
   cpu->DX = MEM_WORD(0x5fd);
   FUN_1000_194c(cpu);
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   LAB_LOC_22:
   INST_POP(cpu->BX);
   INST_CMP(cpu->BH, MEM_BYTE(0xb1));
   JUMP«JBE» goto LAB_LOC_23;
   INST_DEC(cpu->BH);
   INST_SUB(cpu->DI, 0xa);
   goto LAB_LOC_20;
   LAB_LOC_23:
   INST_POP(cpu->BX);
   INST_CMP(cpu->BL, MEM_BYTE(0xe58c));
   JUMP«JBE» goto LAB_LOC_24;
   INST_DEC(cpu->BL);
   INST_SUB(cpu->SI, 0x4);
   INST_XOR(MEM_WORD(0x19ff), 0xa00);
   INST_XOR(MEM_WORD(0x1a01), 0xa00);
   goto LAB_LOC_15;
   LAB_LOC_24:
   return;

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_22f0(cpu_ctx *cpu){
                              //XREF[1]:     1000:1998(c)
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   cpu->BP = MEM_WORD(cpu->SI);
   INST_ADD(cpu->SI, 0x2);
   cpu->BX = 0x0;
   cpu->CX = 0x7f7f;
   LAB_LOC_1:
   cpu->AH = MEM_BYTE(cpu->SI + 0x7);
   cpu->AL = MEM_BYTE(cpu->SI + 0x3);
   cpu->DX = cpu->AX;
   INST_SUB(cpu->AH, MEM_BYTE(0xb1));
   INST_SUB(cpu->AL, MEM_BYTE(0xad));
   INST_NEG(cpu->AH);
   INST_AND(cpu->AL, cpu->AL);
   JUMP«JGE» goto LAB_LOC_2;
   INST_NEG(cpu->AL);
   LAB_LOC_2:
   INST_CMP(cpu->AL, cpu->CL);
   JUMP«JL» goto LAB_LOC_5;
   LAB_LOC_3:
   INST_CMP(cpu->AH, cpu->CH);
   JUMP«JL» goto LAB_LOC_6;
   LAB_LOC_4:
   INST_ADD(cpu->SI, 0x1c);
   INST_DEC(cpu->BP);
   JUMP«JNZ» goto LAB_LOC_1;
   INST_POP(cpu->SI);
   MEM_WORD(cpu->SI + 0x1a) = cpu->BX;
   return;
   LAB_LOC_5:
   cpu->BL = cpu->DL;
   cpu->CL = cpu->AL;
   goto LAB_LOC_3;
   LAB_LOC_6:
   cpu->BH = cpu->DH;
   cpu->CH = cpu->AH;
   goto LAB_LOC_4;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_233b(cpu_ctx *cpu){
                              //XREF[1]:     1000:1b44(c)
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   cpu->BP = MEM_WORD(cpu->SI);
   INST_ADD(cpu->SI, 0x2);
   cpu->BX = 0x0;
   cpu->CX = 0x7f7f;
   LAB_LOC_1:
   cpu->AH = MEM_BYTE(cpu->SI + 0x7);
   cpu->AL = MEM_BYTE(cpu->SI + 0x3);
   cpu->DX = cpu->AX;
   INST_SUB(cpu->AH, MEM_BYTE(0xb1));
   INST_SUB(cpu->AL, MEM_BYTE(0xad));
   INST_AND(cpu->AL, cpu->AL);
   JUMP«JGE» goto LAB_LOC_2;
   INST_NEG(cpu->AL);
   LAB_LOC_2:
   INST_CMP(cpu->AL, cpu->CL);
   JUMP«JL» goto LAB_LOC_5;
   LAB_LOC_3:
   INST_CMP(cpu->AH, cpu->CH);
   JUMP«JL» goto LAB_LOC_6;
   LAB_LOC_4:
   INST_ADD(cpu->SI, 0x1c);
   INST_DEC(cpu->BP);
   JUMP«JNZ» goto LAB_LOC_1;
   INST_POP(cpu->SI);
   MEM_WORD(cpu->SI + 0x1a) = cpu->BX;
   return;
   LAB_LOC_5:
   cpu->BL = cpu->DL;
   cpu->CL = cpu->AL;
   goto LAB_LOC_3;
   LAB_LOC_6:
   cpu->BH = cpu->DH;
   cpu->CH = cpu->AH;
   goto LAB_LOC_4;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2384(cpu_ctx *cpu){
                              //XREF[1]:     1000:1fab(c)
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   cpu->BP = MEM_WORD(cpu->SI);
   INST_ADD(cpu->SI, 0x2);
   cpu->BX = 0x0;
   cpu->CX = 0x7f7f;
   LAB_LOC_1:
   cpu->AH = MEM_BYTE(cpu->SI + 0x7);
   cpu->AL = MEM_BYTE(cpu->SI + 0x3);
   cpu->DX = cpu->AX;
   INST_SUB(cpu->AH, MEM_BYTE(0xb1));
   INST_SUB(cpu->AL, MEM_BYTE(0xad));
   INST_AND(cpu->AH, cpu->AH);
   JUMP«JGE» goto LAB_LOC_2;
   INST_NEG(cpu->AH);
   LAB_LOC_2:
   INST_NEG(cpu->AL);
   INST_CMP(cpu->AL, cpu->CL);
   JUMP«JL» goto LAB_LOC_5;
   LAB_LOC_3:
   INST_CMP(cpu->AH, cpu->CH);
   JUMP«JL» goto LAB_LOC_6;
   LAB_LOC_4:
   INST_ADD(cpu->SI, 0x1c);
   INST_DEC(cpu->BP);
   JUMP«JNZ» goto LAB_LOC_1;
   INST_POP(cpu->SI);
   MEM_WORD(cpu->SI + 0x1a) = cpu->BX;
   return;
   LAB_LOC_5:
   cpu->BL = cpu->DL;
   cpu->CL = cpu->AL;
   goto LAB_LOC_3;
   LAB_LOC_6:
   cpu->BH = cpu->DH;
   cpu->CH = cpu->AH;
   goto LAB_LOC_4;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_23cf(cpu_ctx *cpu){
                              //XREF[1]:     1000:2155(c)
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   cpu->BP = MEM_WORD(cpu->SI);
   INST_ADD(cpu->SI, 0x2);
   cpu->BX = 0x0;
   cpu->CX = 0x7f7f;
   LAB_LOC_1:
   cpu->AH = MEM_BYTE(cpu->SI + 0x7);
   cpu->AL = MEM_BYTE(cpu->SI + 0x3);
   cpu->DX = cpu->AX;
   INST_SUB(cpu->AH, MEM_BYTE(0xb1));
   INST_SUB(cpu->AL, MEM_BYTE(0xad));
   INST_AND(cpu->AH, cpu->AH);
   JUMP«JGE» goto LAB_LOC_2;
   INST_NEG(cpu->AH);
   LAB_LOC_2:
   INST_CMP(cpu->AL, cpu->CL);
   JUMP«JL» goto LAB_LOC_5;
   LAB_LOC_3:
   INST_CMP(cpu->AH, cpu->CH);
   JUMP«JL» goto LAB_LOC_6;
   LAB_LOC_4:
   INST_ADD(cpu->SI, 0x1c);
   INST_DEC(cpu->BP);
   JUMP«JNZ» goto LAB_LOC_1;
   INST_POP(cpu->SI);
   MEM_WORD(cpu->SI + 0x1a) = cpu->BX;
   return;
   LAB_LOC_5:
   cpu->BL = cpu->DL;
   cpu->CL = cpu->AL;
   goto LAB_LOC_3;
   LAB_LOC_6:
   cpu->BH = cpu->DH;
   cpu->CH = cpu->AH;
   goto LAB_LOC_4;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2418(cpu_ctx *cpu){
                              //XREF[2]:     1000:0b8d(c),1000:13f7(c)
   INST_CMP(cpu->BX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_1;
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, MEM_WORD(0xdbb8));
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, MEM_WORD(0xdbba));
   INST_CLC();
   return;
   LAB_LOC_1:
   INST_STC();
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2431(cpu_ctx *cpu){
                              //XREF[1]:     1000:01b8(c)
   cpu->DI = cpu->SI;
   cpu->CX = MEM_WORD(cpu->SI);
   INST_INC(cpu->CX);
   INST_INC(cpu->CX);
   MEM_WORD(cpu->SI + 0x20) = cpu->CX;
   cpu->DI = cpu->SI;
   INST_ADD(cpu->DI, cpu->CX);
   cpu->CX = MEM_WORD(cpu->DI);
   LAB_LOC_1:
   INST_CMP(MEM_WORD(cpu->DI + 0x1a), 0xffff);
   JUMP«JZ» goto LAB_LOC_2;
   INST_ADD(cpu->DI, 0x1c);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   return;
   LAB_LOC_2:
   INST_SUB(cpu->DI, cpu->SI);
   MEM_WORD(cpu->SI + 0x20) = cpu->DI;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2454(cpu_ctx *cpu){
                              //XREF[1]:     1000:01a9(c)

   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->ES);
   INST_PUSH(cpu->DI);
   INST_PUSH(cpu->DS);
   INST_POP(cpu->ES);
   cpu->CX = 0x82;
   cpu->AL = 0; //was a XOR
   INST_CLD();
   REP«STOSB»
   INST_POP(cpu->DI);
   INST_POP(cpu->ES);
   cpu->DX = cpu->DX;
   cpu->AL = 0x0;
   cpu->AH = 0x3d;
   DOS3Call(cpu);
   cpu->BX = cpu->AX;
   JUMP«JC» goto LAB_LOC_2;
   cpu->DX = cpu->DI;
   cpu->CX = 0x2710;
   cpu->AH = 0x3f;
   DOS3Call(cpu);
   cpu->BP = cpu->AX;
   cpu->AH = 0x3e;
   DOS3Call(cpu);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   FUN_1000_25c5(cpu);
   cpu->CX = cpu->AX;
   INST_ADD(cpu->CX, 0x64);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->ECX, 0x10);
   cpu->EDX = cpu->ECX;
   cpu->SI = cpu->DI;
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   cpu->CX = MEM_WORD(cpu->SI);
   INST_ADD(cpu->SI, 0x2);
   LAB_LOC_1:
   INST_ADD(MEM_DWORD(cpu->SI), cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->SI + 0x4), cpu->EBX);
   INST_ADD(MEM_DWORD(cpu->SI + 0x8), cpu->EDX);
   INST_ADD(cpu->SI, 0x1c);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   cpu->AX = cpu->BP;

   return;
   LAB_LOC_2:
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);

   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_24c0(cpu_ctx *cpu){
                              //XREF[1]:     1000:017e(c)
   INST_PUSH(cpu->ES);
   cpu->DX = 0x1a03;
   cpu->ES = MEM_WORD(0x1a45);
   cpu->DI = 0; //was a XOR
   FUN_1000_5a60(cpu);
   JUMP«JC» goto LAB_LOC_1;
   cpu->DX = 0x1a20;
   cpu->ES = MEM_WORD(0x1a4b);
   cpu->DI = 0; //was a XOR
   FUN_1000_5a60(cpu);
   JUMP«JC» goto LAB_LOC_1;
   cpu->DX = 0x1a0b;
   cpu->AL = 0x0;
   cpu->AH = 0x3d;
   DOS3Call(cpu);
   cpu->BX = cpu->AX;
   FUN_1000_5a95(cpu);
   JUMP«JC» goto LAB_LOC_1;
   cpu->CX = 0xffff;
   cpu->DX = 0xfd00;
   cpu->AX = 0x4202;
   DOS3Call(cpu);
   JUMP«JC» goto LAB_LOC_1;
   cpu->DX = 0x1a4d;
   cpu->CX = 0x300;
   cpu->AH = 0x3f;
   DOS3Call(cpu);
   cpu->CX = 0x0;
   cpu->DX = 0x80;
   cpu->AX = 0x4200;
   DOS3Call(cpu);
   cpu->ES = MEM_WORD(0x1a47);
   cpu->DI = 0; //was a XOR
   FUN_1000_5acf(cpu);
   JUMP«JC» goto LAB_LOC_1;
   cpu->AH = 0x3e;
   DOS3Call(cpu);
   cpu->DX = 0x1a2b;
   cpu->AL = 0x0;
   cpu->AH = 0x3d;
   DOS3Call(cpu);
   cpu->BX = cpu->AX;
   cpu->DX = 0x1d51;
   cpu->CX = 0x1100;
   cpu->AH = 0x3f;
   DOS3Call(cpu);
   cpu->AH = 0x3e;
   DOS3Call(cpu);
   cpu->DX = 0x1a33;
   cpu->AL = 0x0;
   cpu->AH = 0x3d;
   DOS3Call(cpu);
   cpu->BX = cpu->AX;
   cpu->DX = 0x2e51;
   cpu->CX = 0x1000;
   cpu->AH = 0x3f;
   DOS3Call(cpu);
   cpu->AH = 0x3e;
   DOS3Call(cpu);
   LAB_LOC_1:
                              //             1000:2520(j)
   INST_POP(cpu->ES);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_255c(cpu_ctx *cpu){
                              //XREF[1]:     1000:0181(c)
   INST_PUSH(cpu->ES);
   cpu->DX = 0x1a13;
   cpu->ES = MEM_WORD(0x1a49);
   cpu->DI = 0; //was a XOR
   FUN_1000_5a60(cpu);
   INST_POP(cpu->ES);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_256b(cpu_ctx *cpu){
                              //XREF[2]:     1000:261a(c),1000:265b(c)
   cpu->AX = MEM_WORD(0x5ac1);
   INST_IMUL(MEM_WORD(0x5ac9));
   MEM_WORD(0x5ad7) = cpu->AX;
   cpu->AX = MEM_WORD(0x5ac3);
   INST_IMUL(MEM_WORD(0x5ac7));
   INST_SUB(MEM_WORD(0x5ad7), cpu->AX);
   cpu->AX = MEM_WORD(0x5acd);
   INST_IMUL(MEM_WORD(0x5ac9));
   MEM_WORD(0x5ad3) = cpu->AX;
   cpu->AX = MEM_WORD(0x5acf);
   INST_IMUL(MEM_WORD(0x5ac7));
   INST_SUB(MEM_WORD(0x5ad3), cpu->AX);
   cpu->AX = MEM_WORD(0x5acf);
   INST_IMUL(MEM_WORD(0x5ac1));
   MEM_WORD(0x5ad5) = cpu->AX;
   cpu->AX = MEM_WORD(0x5acd);
   INST_IMUL(MEM_WORD(0x5ac3));
   INST_SUB(MEM_WORD(0x5ad5), cpu->AX);
   cpu->AX = MEM_WORD(0x5ac5);
   INST_IMUL(MEM_WORD(0x5ad3));
   cpu->BX = cpu->AX;
   cpu->CX = cpu->DX;
   cpu->AX = MEM_WORD(0x5acb);
   INST_IMUL(MEM_WORD(0x5ad5));
   INST_ADD(cpu->AX, cpu->BX);
   INST_ADC(cpu->DX, cpu->CX);
   INST_IDIV(MEM_WORD(0x5ad7));
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_25c5(cpu_ctx *cpu){
                              //XREF[9]:     1000:07b4(c),1000:07ec(c),1000:0810(c),1000:083e(c),
                              //             1000:08e1(c),1000:09f6(c),1000:0c0d(c),1000:1372(c),
                              //             1000:2486(c)
   MEM_WORD(0x5ac1) = 0x80;
   MEM_WORD(0x5ac3) = 0x0;
   MEM_WORD(0x5ac7) = 0x0;
   MEM_WORD(0x5ac9) = 0x80;
   INST_SHR(cpu->AL, 0x1);
   INST_SHR(cpu->BL, 0x1);
   cpu->CL = cpu->AL;
   INST_ADD(cpu->CL, cpu->BL);
   INST_CMP(cpu->CL, 0x80);
   JUMP«JA» goto LAB_LOC_1;
   MEM_BYTE(0x5acd) = cpu->AL;
   MEM_BYTE(0x5acf) = cpu->BL;
   cpu->BL = cpu->AH;
   INST_MOVZX(cpu->AX, MEM_BYTE(cpu->GS*SEGM + cpu->BX));
   INST_SHL(cpu->AX, 0x4);
   cpu->CX = cpu->AX;
   INST_MOVZX(cpu->AX, MEM_BYTE(cpu->GS*SEGM + cpu->BX + 0x1));
   INST_SHL(cpu->AX, 0x4);
   INST_SUB(cpu->AX, cpu->CX);
   MEM_WORD(0x5ac5) = cpu->AX;
   INST_MOVZX(cpu->AX, MEM_BYTE(cpu->GS*SEGM + cpu->BX + 0x100));
   INST_SHL(cpu->AX, 0x4);
   INST_SUB(cpu->AX, cpu->CX);
   MEM_WORD(0x5acb) = cpu->AX;
   INST_PUSH(cpu->CX);
   FUN_1000_256b(cpu);
   INST_POP(cpu->CX);
   INST_ADD(cpu->AX, cpu->CX);
   goto LAB_LOC_2;
   LAB_LOC_1:
   INST_NEG(cpu->AL);
   INST_NEG(cpu->BL);
   INST_ADD(cpu->AL, 0x80);
   INST_ADD(cpu->BL, 0x80);
   MEM_BYTE(0x5acd) = cpu->AL;
   MEM_BYTE(0x5acf) = cpu->BL;
   cpu->BL = cpu->AH;
   INST_MOVZX(cpu->AX, MEM_BYTE(cpu->GS*SEGM + cpu->BX + 0x101));
   INST_SHL(cpu->AX, 0x4);
   cpu->CX = cpu->AX;
   INST_MOVZX(cpu->AX, MEM_BYTE(cpu->GS*SEGM + cpu->BX + 0x1));
   INST_SHL(cpu->AX, 0x4);
   INST_SUB(cpu->AX, cpu->CX);
   MEM_WORD(0x5acb) = cpu->AX;
   INST_MOVZX(cpu->AX, MEM_BYTE(cpu->GS*SEGM + cpu->BX + 0x100));
   INST_SHL(cpu->AX, 0x4);
   INST_SUB(cpu->AX, cpu->CX);
   MEM_WORD(0x5ac5) = cpu->AX;
   INST_PUSH(cpu->CX);
   FUN_1000_256b(cpu);
   INST_POP(cpu->CX);
   INST_ADD(cpu->AX, cpu->CX);
   LAB_LOC_2:
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2662(cpu_ctx *cpu){
                              //XREF[13]:    1000:1509(c),1000:156f(c),1000:15e2(c),1000:166e(c),
                              //             1000:16e4(c),1000:1d20(c),1000:1d4c(c),1000:1dd4(c),
                              //             1000:1e2d(c),1000:1e7c(c),1000:1ea5(c),1000:1f28(c),
                              //             1000:1f81(c)
   cpu->AX = MEM_WORD(cpu->SI);
   INST_SUB(cpu->AX, MEM_WORD(cpu->SI + 0x8));
   cpu->DX = MEM_WORD(cpu->SI + 0x12);
   INST_SUB(cpu->DX, MEM_WORD(cpu->SI + 0xa));
   INST_IMUL(cpu->DX);
   cpu->CX = cpu->AX;
   cpu->BX = cpu->DX;
   cpu->AX = MEM_WORD(cpu->SI + 0x10);
   INST_SUB(cpu->AX, MEM_WORD(cpu->SI + 0x8));
   cpu->DX = MEM_WORD(cpu->SI + 0x2);
   INST_SUB(cpu->DX, MEM_WORD(cpu->SI + 0xa));
   INST_IMUL(cpu->DX);
   INST_SUB(cpu->AX, cpu->CX);
   INST_SBB(cpu->DX, cpu->BX);
   return;

 // 1000:26dc [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_26dd(cpu_ctx *cpu){
                              //XREF[5]:     1000:06f3(c),1000:072a(c),1000:0870(c),1000:271d(c),
                              //             1000:2722(c)
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   FUN_1000_2b08(cpu);
   INST_TEST(cpu->AH, 0x60);
   JUMP«JP» goto LAB_LOC_1;
   cpu->BX = cpu->AX;
   FUN_1000_2aad(cpu);
   INST_MOVSX(cpu->EBX, cpu->AX);
   DUMMY_POP_WORD();
   INST_POP(cpu->AX);
   INST_SHL(cpu->EAX, 0x10);
   INST_SAR(cpu->EAX, 0x1);
   INST_CDQ();
   INST_IDIV(cpu->EBX);
   return;
   LAB_LOC_1:
   cpu->BX = cpu->AX;
   FUN_1000_2ad8(cpu);
   INST_MOVSX(cpu->EBX, cpu->AX);
   INST_POP(cpu->AX);
   DUMMY_POP_WORD();
   INST_SHL(cpu->EAX, 0x10);
   INST_SAR(cpu->EAX, 0x1);
   INST_CDQ();
   INST_IDIV(cpu->EBX);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_271d(cpu_ctx *cpu){
                              //XREF[4]:     1000:17a4(c),1000:17b7(c),1000:2738(c),1000:57cd(c)
   FUN_1000_26dd(cpu);
   cpu->BX = cpu->CX;
   FUN_1000_26dd(cpu);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2726(cpu_ctx *cpu){
                              //XREF[3]:     1000:10b2(c),1000:10f2(c),1000:57d4(c)
   INST_PUSH(cpu->EAX);
   INST_PUSH(cpu->EBX);
   INST_PUSH(cpu->ECX);
   INST_SAR(cpu->EAX, 0x10);
   INST_SAR(cpu->EBX, 0x10);
   INST_SAR(cpu->ECX, 0x10);
   FUN_1000_271d(cpu);
   cpu->EBX = cpu->EAX;
   INST_INC(cpu->EBX);
   INST_POP(cpu->EAX);
   INST_CDQ();
   INST_IDIV(cpu->EBX);
   cpu->ECX = cpu->EAX;
   INST_POP(cpu->EAX);
   INST_CDQ();
   INST_IDIV(cpu->EBX);
   INST_POP(cpu->EDX);
   INST_PUSH(cpu->EAX);
   cpu->EAX = cpu->EDX;
   INST_CDQ();
   INST_IDIV(cpu->EBX);
   INST_POP(cpu->EBX);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2760(cpu_ctx *cpu){
                              //XREF[13]:    1000:1a03(c),1000:1abb(c),1000:1bae(c),1000:1c63(c),
                              //             1000:2016(c),1000:20cd(c),1000:21c0(c),1000:2275(c),
                              //             1000:2420(c),1000:4739(c),1000:47a6(c),1000:4836(c),
                              //             1000:4897(c)
   cpu->DX = cpu->AX;
   cpu->AL = cpu->DH;
   INST_CBW();
   INST_XCHG(cpu->AX, cpu->DX);
   cpu->AH = cpu->AL;
   cpu->AL = 0; //was a XOR
   INST_IDIV(cpu->BX);
   INST_XCHG(cpu->AX, cpu->CX);
   cpu->DX = cpu->AX;
   cpu->AL = cpu->DH;
   INST_CBW();
   INST_XCHG(cpu->AX, cpu->DX);
   cpu->AH = cpu->AL;
   cpu->AL = 0; //was a XOR
   INST_IDIV(cpu->BX);
   INST_XCHG(cpu->CX, cpu->BX);
   INST_XCHG(cpu->AX, cpu->BX);
   return;

 // 1000:277d [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
//ANALYSIS: seems to be related to camera rotation and maybe position, if I nop it the camera stops rotating and following the car
//MODIFICATIONS: before ES and BP was used as temporary storage, this broke protected mode (the writing to ES part), modified to use globals as locals (leaf function, no problem)
void FUN_1000_277e(cpu_ctx *cpu){
                              //XREF[10]:    1000:0b88(c),1000:13ea(c),1000:19ee(c),1000:1aa6(c),
                              //             1000:1b99(c),1000:1c4e(c),1000:2001(c),1000:20b8(c),
                              //             1000:21ab(c),1000:2260(c)
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->DX;
   pseudolocal_a = cpu->AX;
   cpu->AX = cpu->BX;
   INST_IMUL(MEM_WORD(cpu->DI));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   pseudolocal_b = cpu->DX;
   cpu->AX = cpu->CX;
   INST_IMUL(MEM_WORD(cpu->DI + 0x6));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   INST_ADD(pseudolocal_b, cpu->DX);
   cpu->AX = pseudolocal_a;
   INST_IMUL(MEM_WORD(cpu->DI + 0xc));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   INST_ADD(pseudolocal_b, cpu->DX);
   INST_PUSH(pseudolocal_b);
   cpu->AX = cpu->BX;
   INST_IMUL(MEM_WORD(cpu->DI + 0x2));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   pseudolocal_b = cpu->DX;
   cpu->AX = cpu->CX;
   INST_IMUL(MEM_WORD(cpu->DI + 0x8));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   INST_ADD(pseudolocal_b, cpu->DX);
   cpu->AX = pseudolocal_a;
   INST_IMUL(MEM_WORD(cpu->DI + 0xe));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   INST_ADD(pseudolocal_b, cpu->DX);
   INST_PUSH(pseudolocal_b);
   cpu->AX = cpu->BX;
   INST_IMUL(MEM_WORD(cpu->DI + 0x4));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   pseudolocal_b = cpu->DX;
   cpu->AX = cpu->CX;
   INST_IMUL(MEM_WORD(cpu->DI + 0xa));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   INST_ADD(pseudolocal_b, cpu->DX);
   cpu->AX = pseudolocal_a;
   INST_IMUL(MEM_WORD(cpu->DI + 0x10));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   INST_ADD(pseudolocal_b, cpu->DX);
   cpu->CX = pseudolocal_b;
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->DI);

   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_27f1(cpu_ctx *cpu){
                              //XREF[3]:     1000:02bd(c),1000:0389(c),1000:0452(c)
   cpu->AX = MEM_WORD(cpu->DI + 0x2);
   INST_XCHG(MEM_WORD(cpu->DI + 0x6), cpu->AX);
   MEM_WORD(cpu->DI + 0x2) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->DI + 0x4);
   INST_XCHG(MEM_WORD(cpu->DI + 0xc), cpu->AX);
   MEM_WORD(cpu->DI + 0x4) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->DI + 0xa);
   INST_XCHG(MEM_WORD(cpu->DI + 0xe), cpu->AX);
   MEM_WORD(cpu->DI + 0xa) = cpu->AX;
   return;

 // 1000:2988 [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2989(cpu_ctx *cpu){
                              //XREF[3]:     1000:02ba(c),1000:0386(c),1000:044f(c)
   cpu->BX = MEM_WORD(cpu->SI);
   FUN_1000_2aad(cpu);
   MEM_WORD(0xd100) = cpu->AX;
   FUN_1000_2ad8(cpu);
   MEM_WORD(0xd102) = cpu->AX;
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   FUN_1000_2aad(cpu);
   MEM_WORD(0xd104) = cpu->AX;
   FUN_1000_2ad8(cpu);
   MEM_WORD(0xd106) = cpu->AX;
   cpu->BX = MEM_WORD(cpu->SI + 0x4);
   FUN_1000_2aad(cpu);
   INST_NEG(cpu->AX);
   MEM_WORD(0xd108) = cpu->AX;
   FUN_1000_2ad8(cpu);
   MEM_WORD(0xd10a) = cpu->AX;
   cpu->AX = MEM_WORD(0xd100);
   INST_IMUL(MEM_WORD(0xd104));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   cpu->AX = cpu->DX;
   cpu->BX = cpu->AX;
   INST_IMUL(MEM_WORD(0xd108));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   INST_CMP(cpu->DX, 0x8000);
   JUMP«JNZ» goto LAB_LOC_1;
   INST_INC(cpu->DX);
   LAB_LOC_1:
   INST_NEG(cpu->DX);
   cpu->CX = cpu->DX;
   cpu->AX = MEM_WORD(0xd102);
   INST_IMUL(MEM_WORD(0xd10a));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   cpu->AX = cpu->DX;
   INST_ADD(cpu->DX, cpu->CX);
   MEM_WORD(cpu->DI) = cpu->DX;
   INST_XCHG(cpu->AX, cpu->BX);
   INST_IMUL(MEM_WORD(0xd10a));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   cpu->CX = cpu->DX;
   cpu->AX = MEM_WORD(0xd108);
   INST_IMUL(MEM_WORD(0xd102));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_ADD(cpu->DX, cpu->CX);
   INST_CMP(cpu->DX, 0x8000);
   JUMP«JNZ» goto LAB_LOC_2;
   INST_INC(cpu->DX);
   LAB_LOC_2:
   INST_NEG(cpu->DX);
   MEM_WORD(cpu->DI + 0x2) = cpu->DX;
   cpu->AX = MEM_WORD(0xd100);
   INST_IMUL(MEM_WORD(0xd106));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   INST_CMP(cpu->DX, 0x8000);
   JUMP«JNZ» goto LAB_LOC_3;
   INST_INC(cpu->DX);
   LAB_LOC_3:
   INST_NEG(cpu->DX);
   MEM_WORD(cpu->DI + 0x4) = cpu->DX;
   cpu->AX = MEM_WORD(0xd108);
   INST_IMUL(MEM_WORD(0xd106));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   MEM_WORD(cpu->DI + 0x6) = cpu->DX;
   cpu->AX = MEM_WORD(0xd10a);
   INST_IMUL(MEM_WORD(0xd106));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   MEM_WORD(cpu->DI + 0x8) = cpu->DX;
   cpu->DX = MEM_WORD(0xd104);
   INST_CMP(cpu->DX, 0x8000);
   JUMP«JNZ» goto LAB_LOC_4;
   INST_INC(cpu->DX);
   LAB_LOC_4:
   INST_NEG(cpu->DX);
   MEM_WORD(cpu->DI + 0xa) = cpu->DX;
   cpu->AX = cpu->CX;
   INST_IMUL(MEM_WORD(0xd104));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   cpu->CX = cpu->DX;
   cpu->AX = MEM_WORD(0xd10a);
   INST_IMUL(MEM_WORD(0xd100));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   INST_ADD(cpu->DX, cpu->CX);
   MEM_WORD(cpu->DI + 0xc) = cpu->DX;
   cpu->AX = cpu->BX;
   INST_IMUL(MEM_WORD(0xd104));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   cpu->CX = cpu->DX;
   cpu->AX = MEM_WORD(0xd100);
   INST_IMUL(MEM_WORD(0xd108));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   INST_CMP(cpu->DX, 0x8000);
   JUMP«JNZ» goto LAB_LOC_5;
   INST_INC(cpu->DX);
   LAB_LOC_5:
   INST_NEG(cpu->DX);
   INST_ADD(cpu->DX, cpu->CX);
   MEM_WORD(cpu->DI + 0xe) = cpu->DX;
   cpu->AX = MEM_WORD(0xd102);
   INST_IMUL(MEM_WORD(0xd106));
   INST_SHL(cpu->AX, 0x1);
   INST_RCL(cpu->DX, 0x1);
   MEM_WORD(cpu->DI + 0x10) = cpu->DX;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2aad(cpu_ctx *cpu){
                              //XREF[19]:    1000:02a2(c),1000:036e(c),1000:0437(c),1000:07a9(c),
                              //             1000:07e1(c),1000:0805(c),1000:08b2(c),1000:09c0(c),
                              //             1000:1168(c),1000:1222(c),1000:1846(c),1000:26eb(c),
                              //             1000:298b(c),1000:299a(c),1000:29a9(c),1000:4a48(c),
                              //             1000:4a5f(c),1000:4b9b(c),1000:57bd(c)
   cpu->AX = cpu->BX;
   INST_AND(cpu->AH, 0x7f);
   INST_TEST(cpu->AH, 0x40);
   JUMP«JZ» goto LAB_LOC_1;
   INST_NEG(cpu->AX);
   INST_ADD(cpu->AX, 0x8000);
   LAB_LOC_1:
   INST_SHR(cpu->AX, 0x1);
   INST_SHR(cpu->AX, 0x1);
   INST_SHR(cpu->AX, 0x1);
   INST_AND(cpu->AL, 0xfe);
   INST_PUSH(cpu->BX);
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(cpu->BX + 0xd10c);
   INST_POP(cpu->BX);
   INST_TEST(cpu->BH, 0x80);
   JUMP«JZ» goto LAB_LOC_2;
   INST_NEG(cpu->AX);
   LAB_LOC_2:
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2ad8(cpu_ctx *cpu){
                              //XREF[19]:    1000:02ab(c),1000:0377(c),1000:0440(c),1000:079c(c),
                              //             1000:07d4(c),1000:07f8(c),1000:08ad(c),1000:09bb(c),
                              //             1000:1174(c),1000:122e(c),1000:184b(c),1000:2705(c),
                              //             1000:2991(c),1000:29a0(c),1000:29b1(c),1000:4a4e(c),
                              //             1000:4a65(c),1000:4b90(c),1000:57c1(c)
   cpu->AX = cpu->BX;
   INST_AND(cpu->AH, 0x7f);
   INST_TEST(cpu->AH, 0x40);
   JUMP«JZ» goto LAB_LOC_1;
   INST_SUB(cpu->AX, 0x4000);
   goto LAB_LOC_2;
   LAB_LOC_1:
   INST_NEG(cpu->AX);
   INST_ADD(cpu->AX, 0x4000);
   LAB_LOC_2:
   INST_SHR(cpu->AX, 0x1);
   INST_SHR(cpu->AX, 0x1);
   INST_SHR(cpu->AX, 0x1);
   INST_AND(cpu->AL, 0xfe);
   INST_PUSH(cpu->BX);
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(cpu->BX + 0xd10c);
   INST_POP(cpu->BX);
   INST_TEST(cpu->BH, 0xc0);
   JUMP«JP» goto LAB_LOC_3;
   INST_NEG(cpu->AX);
   LAB_LOC_3:
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2b08(cpu_ctx *cpu){
                              //XREF[19]:    1000:06e0(c),1000:0701(c),1000:0712(c),1000:0731(c),
                              //             1000:078d(c),1000:07be(c),1000:0819(c),1000:0863(c),
                              //             1000:087c(c),1000:08a5(c),1000:0907(c),1000:09b3(c),
                              //             1000:0a20(c),1000:1841(c),1000:26df(c),1000:4a43(c),
                              //             1000:4a5a(c),1000:4c64(c),1000:57c7(c)
   INST_AND(cpu->AX, cpu->AX);
   JUMP«JS» goto LAB_LOC_2;
   JUMP«JNZ» goto FUN_1000_2b1f;
   cpu->AX = 0x0;
   INST_TEST(cpu->BX, cpu->BX);
   JUMP«JNS» goto LAB_LOC_1;
   INST_ADD(cpu->AX, 0x8000);
   LAB_LOC_1:
   return;

   LAB_LOC_2:
   INST_NOT(cpu->AX);
   FUN_1000_2b1f(cpu);
   INST_NEG(cpu->AX);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2b1f(cpu_ctx *cpu){
                              //XREF[2]:     1000:2b0e(j),1000:2b63(c)
   INST_AND(cpu->BX, cpu->BX);
   JUMP«JS» goto LAB_LOC_1;
   JUMP«JNZ» goto FUN_1000_2b2d;
   cpu->AX = 0x4000;
   return;

   LAB_LOC_1:
   INST_NOT(cpu->BX);
   FUN_1000_2b2d(cpu);
   INST_NEG(cpu->AX);
   INST_ADD(cpu->AX, 0x8000);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2b2d(cpu_ctx *cpu){
                              //XREF[2]:     1000:2b25(j),1000:2b58(c)
   INST_CMP(cpu->AX, cpu->BX);
   JUMP«JG» goto LAB_LOC_1;
   JUMP«JL» goto FUN_1000_2b3b;
   cpu->AX = 0x2000;
   return;

   LAB_LOC_1:
   INST_XCHG(cpu->AX, cpu->BX);
   FUN_1000_2b3b(cpu);
   INST_NEG(cpu->AX);
   INST_ADD(cpu->AX, 0x4000);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2b3b(cpu_ctx *cpu){
                              //XREF[2]:     1000:2b33(j),1000:2b4d(c)
   cpu->DX = cpu->AX;
   cpu->AX = 0; //was a XOR
   INST_DIV(cpu->BX);
   cpu->BL = cpu->AH;
   cpu->BH = 0; //was a XOR
   INST_SHL(cpu->BX, 0x1);
   cpu->AX = MEM_WORD(cpu->BX + 0xd90e);
   return;

 // 1000:2b6f [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
//MODIFIED: now it only alocates and doesnt set vga to mode 13h
void FUN_1000_2b70(cpu_ctx *cpu){
                              //XREF[1]:     1000:021c(c)
   cpu->AH = 0x48;
   cpu->BX = 0xfa0;
   DOS3Call(cpu);
   JUMP«JC» goto LAB_LOC_1;
   MEM_WORD(0xdb10) = cpu->AX;
   LAB_LOC_1:
   return;

 // 1000:2b97 [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
//ANALYSIS: this clears the framebuffer
void FUN_1000_2b98(cpu_ctx *cpu){
                              //XREF[2]:     1000:02c6(c),1000:0392(c)
   INST_PUSH(cpu->ES);
   INST_PUSH(cpu->DI);
   cpu->ES = MEM_WORD(0xdb10);
   cpu->DI = 0; //was a XOR
   cpu->CX = 0x3e80;
   INST_CLD();
   REP«STOSD»
   INST_POP(cpu->DI);
   INST_POP(cpu->ES);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2baa(cpu_ctx *cpu){
                              //XREF[1]:     1000:04f7(c)
//REMOVED, was copy to VGA mem
   return;

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2bec(cpu_ctx *cpu){
                              //XREF[5]:     1000:157b(c),1000:1d27(c),1000:1d62(c),1000:1e83(c),
                              //             1000:1ebb(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->SI = 0xdb16;
   cpu->DI = 0xdb68;
   FUN_1000_2df2(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_2eaf(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_2f6c(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_302d(cpu);
   cpu->SI = cpu->DI;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   INST_CMP(cpu->CX, 0x3);
   JUMP«JC» goto LAB_LOC_2;
   cpu->AX = MEM_WORD(0xdbbe);
   MEM_WORD(0xdbc4) = cpu->AX;
   cpu->AX = MEM_WORD(0xdbbc);
   MEM_WORD(0xdbc6) = cpu->AX;
   INST_PUSH(cpu->SI);
   INST_DEC(cpu->CX);
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   INST_PUSH(cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->CX = MEM_WORD(cpu->SI + 0x8);
   cpu->DX = MEM_WORD(cpu->SI + 0xa);
   FUN_1000_2c4b(cpu);
   INST_POP(cpu->SI);
   INST_POP(cpu->CX);
   INST_ADD(cpu->SI, 0x8);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_POP(cpu->SI);
   cpu->CX = MEM_WORD(cpu->SI);
   cpu->DX = MEM_WORD(cpu->SI + 0x2);
   FUN_1000_2c4b(cpu);
   FUN_1000_2d61(cpu);
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2c4b(cpu_ctx *cpu){
                              //XREF[6]:     1000:2c2d(c),1000:2c42(c),1000:312f(c),1000:3144(c),
                              //             1000:373f(c),1000:3754(c)
   INST_XCHG(cpu->DX, cpu->CX);
   INST_CMP(cpu->BX, cpu->CX);
   JUMP«JLE» goto LAB_LOC_3;
   INST_XCHG(cpu->AX, cpu->DX);
   INST_XCHG(cpu->CX, cpu->BX);
   INST_CMP(cpu->BX, MEM_WORD(0xdbc4));
   JUMP«JGE» goto LAB_LOC_1;
   MEM_WORD(0xdbc4) = cpu->BX;
   LAB_LOC_1:
   INST_CMP(cpu->CX, MEM_WORD(0xdbc6));
   JUMP«JLE» goto LAB_LOC_2;
   MEM_WORD(0xdbc6) = cpu->CX;
   LAB_LOC_2:
   INST_SUB(cpu->CX, cpu->BX);
   INST_SHL(cpu->BX, 0x2);
   INST_ADD(cpu->BX, 0xdbca);
   goto LAB_LOC_6;
   LAB_LOC_3:
   INST_CMP(cpu->BX, MEM_WORD(0xdbc4));
   JUMP«JGE» goto LAB_LOC_4;
   MEM_WORD(0xdbc4) = cpu->BX;
   LAB_LOC_4:
   INST_CMP(cpu->CX, MEM_WORD(0xdbc6));
   JUMP«JLE» goto LAB_LOC_5;
   MEM_WORD(0xdbc6) = cpu->CX;
   LAB_LOC_5:
   INST_SUB(cpu->CX, cpu->BX);
   INST_SHL(cpu->BX, 0x2);
   INST_ADD(cpu->BX, 0xdbc8);
   LAB_LOC_6:
   if (cpu->CX == 0) goto LAB_LOC_8;
   INST_PUSH(cpu->AX);
   INST_SUB(cpu->DX, cpu->AX);
   cpu->AX = cpu->DX;
   INST_SHL(cpu->EAX, 0x10);
   INST_CDQ();
   INST_MOVSX(cpu->ECX, cpu->CX);
   INST_IDIV(cpu->ECX);
   cpu->EDX = cpu->EAX;
   INST_POP(cpu->AX);
   INST_SHL(cpu->EAX, 0x10);
   LAB_LOC_7:
   INST_ROR(cpu->EAX, 0x10);
   MEM_WORD(cpu->BX) = cpu->AX;
   INST_ADD(cpu->BX, 0x4);
   INST_ROL(cpu->EAX, 0x10);
   INST_ADD(cpu->EAX, cpu->EDX);
   if (--cpu->CX != 0) goto LAB_LOC_7;
   INST_ROR(cpu->EAX, 0x10);
   MEM_WORD(cpu->BX) = cpu->AX;
   LAB_LOC_8:
   return;

 // 1000:2d60 [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2d61(cpu_ctx *cpu){
                              //XREF[1]:     1000:2c45(c)
   cpu->BX = MEM_WORD(0xdbc4);
   cpu->DX = MEM_WORD(0xdbc6);
   INST_SUB(cpu->DX, cpu->BX);
   JUMP«JZ» goto LAB_LOC_4;
   INST_INC(cpu->DX);
   INST_SHL(cpu->BX, 0x2);
   INST_PUSH(cpu->ES);
   cpu->ES = MEM_WORD(0xdb10);
   cpu->SI = cpu->BX;
   INST_CMP(MEM_WORD(0xdb12), 0xf0f0);
   JUMP«JNC» goto LAB_LOC_5;
   LAB_LOC_1:
   cpu->DI = cpu->SI;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->SI);
   INST_SHL(cpu->DI, 0x4);
   cpu->AX = MEM_WORD(cpu->SI + 0xdbc8);
   cpu->CX = MEM_WORD(cpu->SI + 0xdbca);
   INST_SUB(cpu->CX, cpu->AX);
   JUMP«JNS» goto LAB_LOC_2;
   INST_ADD(cpu->AX, cpu->CX);
   INST_NEG(cpu->CX);
   LAB_LOC_2:
   INST_INC(cpu->CX);
   INST_ADD(cpu->DI, cpu->AX);
   INST_CLD();
   cpu->AX = MEM_WORD(0xdb12);
   INST_SHR(cpu->CX, 0x1);
   REP«STOSW»
   JUMP«JNC» goto LAB_LOC_3;
   INST_STOSB();
   LAB_LOC_3:
   INST_ADD(cpu->SI, 0x4);
   INST_DEC(cpu->DX);
   JUMP«JNZ» goto LAB_LOC_1;
   INST_POP(cpu->ES);
   LAB_LOC_4:
   return;
   LAB_LOC_5:
   cpu->BX = MEM_WORD(0xdb12);
   INST_SUB(cpu->BH, 0xf0);
   LAB_LOC_6:
   cpu->DI = cpu->SI;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->SI);
   INST_SHL(cpu->DI, 0x4);
   cpu->AX = MEM_WORD(cpu->SI + 0xdbc8);
   cpu->CX = MEM_WORD(cpu->SI + 0xdbca);
   INST_SUB(cpu->CX, cpu->AX);
   JUMP«JNS» goto LAB_LOC_7;
   INST_ADD(cpu->AX, cpu->CX);
   INST_NEG(cpu->CX);
   LAB_LOC_7:
   INST_INC(cpu->CX);
   INST_ADD(cpu->DI, cpu->AX);
   INST_CLD();
   LAB_LOC_8:
   cpu->BL = MEM_BYTE(cpu->ES*SEGM + cpu->DI);
   cpu->AL = MEM_BYTE(cpu->BX + 0x2e51);
   INST_STOSB();
   if (--cpu->CX != 0) goto LAB_LOC_8;
   INST_ADD(cpu->SI, 0x4);
   INST_DEC(cpu->DX);
   JUMP«JNZ» goto LAB_LOC_6;
   INST_POP(cpu->ES);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2df2(cpu_ctx *cpu){
                              //XREF[1]:     1000:2bf4(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->BP = 0; //was a XOR
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x3);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc0));
   JUMP«JL» goto LAB_LOC_6;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(cpu->BP);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc0));
   JUMP«JL» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_SUB(cpu->CX, MEM_WORD(0xdbc0));
   JUMP«JZ» goto LAB_LOC_4;
   INST_SUB(cpu->AX, MEM_WORD(0xdbc0));
   FUN_1000_3f7a(cpu);
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(0xdbc0);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(cpu->BP);
   LAB_LOC_4:
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_5:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_XCHG(cpu->DX, cpu->BX);
   INST_SUB(cpu->AX, MEM_WORD(0xdbc0));
   INST_SUB(cpu->CX, MEM_WORD(0xdbc0));
   FUN_1000_3f7a(cpu);
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(0xdbc0);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_6:
   INST_PUSH(cpu->CX);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc0));
   JUMP«JGE» goto LAB_LOC_5;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2eaf(cpu_ctx *cpu){
                              //XREF[1]:     1000:2bf9(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->BP = 0; //was a XOR
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x3);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc2));
   JUMP«JG» goto LAB_LOC_6;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(cpu->BP);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc2));
   JUMP«JG» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_XCHG(cpu->DX, cpu->BX);
   INST_SUB(cpu->CX, MEM_WORD(0xdbc2));
   JUMP«JZ» goto LAB_LOC_4;
   INST_SUB(cpu->AX, MEM_WORD(0xdbc2));
   FUN_1000_3f7a(cpu);
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(0xdbc2);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(cpu->BP);
   LAB_LOC_4:
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_5:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_SUB(cpu->AX, MEM_WORD(0xdbc2));
   INST_SUB(cpu->CX, MEM_WORD(0xdbc2));
   FUN_1000_3f7a(cpu);
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(0xdbc2);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_6:
   INST_PUSH(cpu->CX);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc2));
   JUMP«JLE» goto LAB_LOC_5;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_2f6c(cpu_ctx *cpu){
                              //XREF[1]:     1000:2bfe(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->BP = 0; //was a XOR
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x3);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbc));
   JUMP«JL» goto LAB_LOC_6;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(cpu->BP);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbc));
   JUMP«JL» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->CX, MEM_WORD(0xdbbc));
   JUMP«JZ» goto LAB_LOC_4;
   INST_SUB(cpu->AX, MEM_WORD(0xdbbc));
   FUN_1000_3f7a(cpu);
   cpu->BX = MEM_WORD(0xdbbc);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(cpu->BP);
   LAB_LOC_4:
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_5:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_XCHG(cpu->DX, cpu->BX);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->AX, MEM_WORD(0xdbbc));
   INST_SUB(cpu->CX, MEM_WORD(0xdbbc));
   FUN_1000_3f7a(cpu);
   cpu->BX = MEM_WORD(0xdbbc);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_6:
   INST_PUSH(cpu->CX);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbc));
   JUMP«JGE» goto LAB_LOC_5;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_302d(cpu_ctx *cpu){
                              //XREF[1]:     1000:2c03(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->BP = 0; //was a XOR
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x3);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbe));
   JUMP«JG» goto LAB_LOC_6;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(cpu->BP);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbe));
   JUMP«JG» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_XCHG(cpu->DX, cpu->BX);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->CX, MEM_WORD(0xdbbe));
   JUMP«JZ» goto LAB_LOC_4;
   INST_SUB(cpu->AX, MEM_WORD(0xdbbe));
   FUN_1000_3f7a(cpu);
   cpu->BX = MEM_WORD(0xdbbe);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(cpu->BP);
   LAB_LOC_4:
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_5:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->AX, MEM_WORD(0xdbbe));
   INST_SUB(cpu->CX, MEM_WORD(0xdbbe));
   FUN_1000_3f7a(cpu);
   cpu->BX = MEM_WORD(0xdbbe);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_6:
   INST_PUSH(cpu->CX);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbe));
   JUMP«JLE» goto LAB_LOC_5;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
//TODO find out when this is called
void FUN_1000_30ee(cpu_ctx *cpu){
                              //XREF[2]:     1000:15ee(c),1000:167a(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->SI = 0xdb16;
   cpu->DI = 0xdb68;
    //TODO parametrize and all that jazz
   FUN_1000_324f(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_3376(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_34a2(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_35cf(cpu);
   cpu->SI = cpu->DI;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   INST_CMP(cpu->CX, 0x3);
   JUMP«JC» goto LAB_LOC_3;
   cpu->AX = MEM_WORD(0xdbbe);
   MEM_WORD(0xdbc4) = cpu->AX;
   cpu->AX = MEM_WORD(0xdbbc);
   MEM_WORD(0xdbc6) = cpu->AX;
   INST_PUSH(cpu->SI);
   INST_DEC(cpu->CX);
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   INST_PUSH(cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->CX = MEM_WORD(cpu->SI + 0x8);
   cpu->DX = MEM_WORD(cpu->SI + 0xa);
   FUN_1000_2c4b(cpu);
   INST_POP(cpu->SI);
   INST_POP(cpu->CX);
   INST_ADD(cpu->SI, 0x8);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_POP(cpu->SI);
   cpu->CX = MEM_WORD(cpu->SI);
   cpu->DX = MEM_WORD(cpu->SI + 0x2);
   FUN_1000_2c4b(cpu);
   cpu->SI = 0xdb16;
   INST_PUSH(cpu->SI);
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   INST_DEC(cpu->CX);
   LAB_LOC_2:
   INST_PUSH(cpu->CX);
   INST_PUSH(cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI + 0x4);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->CX = MEM_WORD(cpu->SI + 0xc);
   cpu->DX = MEM_WORD(cpu->SI + 0xa);
   FUN_1000_317d(cpu);
   INST_POP(cpu->SI);
   INST_POP(cpu->CX);
   INST_ADD(cpu->SI, 0x8);
   if (--cpu->CX != 0) goto LAB_LOC_2;
   cpu->AX = MEM_WORD(cpu->SI + 0x4);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_POP(cpu->SI);
   cpu->CX = MEM_WORD(cpu->SI + 0x4);
   cpu->DX = MEM_WORD(cpu->SI + 0x2);
   FUN_1000_317d(cpu);
   FUN_1000_31d1(cpu);
   LAB_LOC_3:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_317d(cpu_ctx *cpu){
                              //XREF[2]:     1000:315d(c),1000:3174(c)
   INST_XCHG(cpu->DX, cpu->CX);
   INST_CMP(cpu->BX, cpu->CX);
   JUMP«JLE» goto LAB_LOC_1;
   INST_XCHG(cpu->AX, cpu->DX);
   INST_XCHG(cpu->CX, cpu->BX);
   INST_SUB(cpu->CX, cpu->BX);
   INST_SHL(cpu->BX, 0x2);
   INST_ADD(cpu->BX, 0xdeea);
   goto LAB_LOC_2;
   LAB_LOC_1:
   INST_SUB(cpu->CX, cpu->BX);
   INST_SHL(cpu->BX, 0x2);
   INST_ADD(cpu->BX, 0xdee8);
   LAB_LOC_2:
   if (cpu->CX == 0) goto LAB_LOC_4;
   INST_PUSH(cpu->AX);
   INST_SUB(cpu->DX, cpu->AX);
   cpu->AX = cpu->DX;
   INST_SHL(cpu->EAX, 0x10);
   INST_CDQ();
   INST_MOVSX(cpu->ECX, cpu->CX);
   INST_IDIV(cpu->ECX);
   cpu->EDX = cpu->EAX;
   INST_POP(cpu->AX);
   INST_SHL(cpu->EAX, 0x10);
   LAB_LOC_3:
   INST_ROR(cpu->EAX, 0x10);
   MEM_WORD(cpu->BX) = cpu->AX;
   INST_ADD(cpu->BX, 0x4);
   INST_ROL(cpu->EAX, 0x10);
   INST_ADD(cpu->EAX, cpu->EDX);
   if (--cpu->CX != 0) goto LAB_LOC_3;
   INST_ROR(cpu->EAX, 0x10);
   MEM_WORD(cpu->BX) = cpu->AX;
   LAB_LOC_4:
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_31d1(cpu_ctx *cpu){
                              //XREF[1]:     1000:3177(c)
   cpu->BX = MEM_WORD(0xdbc4);
   cpu->DX = MEM_WORD(0xdbc6);
   INST_SUB(cpu->DX, cpu->BX);
   JUMP«JZ» goto LAB_LOC_4;
   INST_INC(cpu->DX);
   INST_SHL(cpu->BX, 0x2);
   INST_PUSH(cpu->ES);
   cpu->ES = MEM_WORD(0xdb10);
   LAB_LOC_1:
   cpu->DI = cpu->BX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->BX);
   INST_SHL(cpu->DI, 0x4);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->DX);
   cpu->AX = MEM_WORD(cpu->BX + 0xdbc8);
   cpu->CX = MEM_WORD(cpu->BX + 0xdbca);
   cpu->BP = MEM_WORD(cpu->BX + 0xdee8);
   cpu->DX = MEM_WORD(cpu->BX + 0xdeea);
   INST_SUB(cpu->DX, cpu->BP);
   INST_SUB(cpu->CX, cpu->AX);
   JUMP«JNS» goto LAB_LOC_2;
   INST_ADD(cpu->AX, cpu->CX);
   INST_NEG(cpu->CX);
   INST_ADD(cpu->BP, cpu->DX);
   INST_NEG(cpu->DX);
   LAB_LOC_2:
   INST_PUSH(cpu->BP);
   INST_INC(cpu->CX);
   INST_ADD(cpu->DI, cpu->AX);
   INST_MOVSX(cpu->EAX, cpu->DX);
   INST_SHL(cpu->EAX, 0x8);
   INST_CDQ();
   INST_MOVZX(cpu->ECX, cpu->CX);
   INST_IDIV(cpu->ECX);
   cpu->EBX = cpu->EAX;
   INST_POP(cpu->AX);
   INST_MOVSX(cpu->EAX, cpu->AX);
   INST_SHL(cpu->EAX, 0x8);
   INST_CLD();
   LAB_LOC_3:
   INST_ROR(cpu->EAX, 0x10);
   INST_STOSB();
   INST_ROL(cpu->EAX, 0x10);
   INST_ADD(cpu->EAX, cpu->EBX);
   if (--cpu->CX != 0) goto LAB_LOC_3;
   INST_POP(cpu->DX);
   INST_POP(cpu->BX);
   INST_ADD(cpu->BX, 0x4);
   INST_DEC(cpu->DX);
   JUMP«JNZ» goto LAB_LOC_1;
   INST_POP(cpu->ES);
   LAB_LOC_4:
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_324f(cpu_ctx *cpu){
                              //XREF[1]:     1000:30f6(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   MEM_WORD(0xe528) = 0x0;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x3);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->BP;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc0));
   JUMP«JL» goto LAB_LOC_6;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->BP;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc0));
   JUMP«JL» goto LAB_LOC_4;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   cpu->AX = MEM_WORD(0xe528);
   MEM_WORD(cpu->DI + -0x2) = cpu->AX;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_SUB(cpu->AX, MEM_WORD(0xdbc0));
   INST_SUB(cpu->CX, MEM_WORD(0xdbc0));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbc0);
   MEM_WORD(cpu->DI) = cpu->CX;
   MEM_WORD(cpu->DI + 0x2) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->DX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->BX = cpu->BP;
   FUN_1000_3f7a(cpu);
   MEM_WORD(cpu->DI + 0x4) = cpu->AX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   goto LAB_LOC_2;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_SUB(cpu->CX, MEM_WORD(0xdbc0));
   JUMP«JZ» goto LAB_LOC_5;
   INST_SUB(cpu->AX, MEM_WORD(0xdbc0));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbc0);
   MEM_WORD(cpu->DI) = cpu->CX;
   MEM_WORD(cpu->DI + 0x2) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->BX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->DX = cpu->BP;
   FUN_1000_3f7a(cpu);
   MEM_WORD(cpu->DI + 0x4) = cpu->AX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   LAB_LOC_5:
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
   LAB_LOC_6:
   INST_PUSH(cpu->CX);
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc0));
   JUMP«JGE» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_3376(cpu_ctx *cpu){
                              //XREF[1]:     1000:30fb(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   MEM_WORD(0xe528) = 0x0;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x3);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->BP;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc2));
   JUMP«JG» goto LAB_LOC_6;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->BP;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc2));
   JUMP«JG» goto LAB_LOC_4;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   cpu->AX = MEM_WORD(0xe528);
   cpu->AX = MEM_WORD(0xe528);
   MEM_WORD(cpu->DI + -0x2) = cpu->AX;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_SUB(cpu->AX, MEM_WORD(0xdbc2));
   INST_SUB(cpu->CX, MEM_WORD(0xdbc2));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbc2);
   MEM_WORD(cpu->DI) = cpu->CX;
   MEM_WORD(cpu->DI + 0x2) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->BX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->DX = cpu->BP;
   FUN_1000_3f7a(cpu);
   MEM_WORD(cpu->DI + 0x4) = cpu->AX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   INST_DEC(cpu->CX);
   JUMP«JZ» goto LAB_LOC_2;
   goto LAB_LOC_1;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_SUB(cpu->CX, MEM_WORD(0xdbc2));
   JUMP«JZ» goto LAB_LOC_5;
   INST_SUB(cpu->AX, MEM_WORD(0xdbc2));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbc2);
   MEM_WORD(cpu->DI) = cpu->CX;
   MEM_WORD(cpu->DI + 0x2) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->DX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->BX = cpu->BP;
   FUN_1000_3f7a(cpu);
   MEM_WORD(cpu->DI + 0x4) = cpu->AX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   LAB_LOC_5:
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
   LAB_LOC_6:
   INST_PUSH(cpu->CX);
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc2));
   JUMP«JLE» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_34a2(cpu_ctx *cpu){
                              //XREF[1]:     1000:3100(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   MEM_WORD(0xe528) = 0x0;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x3);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->BP;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbc));
   JUMP«JL» goto LAB_LOC_6;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->BP;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbc));
   JUMP«JL» goto LAB_LOC_4;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   cpu->AX = MEM_WORD(0xe528);
   MEM_WORD(cpu->DI + -0x2) = cpu->AX;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->AX, MEM_WORD(0xdbbc));
   INST_SUB(cpu->CX, MEM_WORD(0xdbbc));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbbc);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->CX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->DX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->BX = cpu->BP;
   FUN_1000_3f7a(cpu);
   MEM_WORD(cpu->DI + 0x4) = cpu->AX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   goto LAB_LOC_2;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->CX, MEM_WORD(0xdbbc));
   JUMP«JZ» goto LAB_LOC_5;
   INST_SUB(cpu->AX, MEM_WORD(0xdbbc));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbbc);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->CX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->BX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->DX = cpu->BP;
   FUN_1000_3f7a(cpu);
   MEM_WORD(cpu->DI + 0x4) = cpu->AX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   LAB_LOC_5:
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
   LAB_LOC_6:
   INST_PUSH(cpu->CX);
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbc));
   JUMP«JGE» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_35cf(cpu_ctx *cpu){
                              //XREF[1]:     1000:3105(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   MEM_WORD(0xe528) = 0x0;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x3);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->BP;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbe));
   JUMP«JG» goto LAB_LOC_6;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->BP;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbe));
   JUMP«JG» goto LAB_LOC_4;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   cpu->AX = MEM_WORD(0xe528);
   MEM_WORD(cpu->DI + -0x2) = cpu->AX;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->AX, MEM_WORD(0xdbbe));
   INST_SUB(cpu->CX, MEM_WORD(0xdbbe));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbbe);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->CX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->BX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->DX = cpu->BP;
   FUN_1000_3f7a(cpu);
   MEM_WORD(cpu->DI + 0x4) = cpu->AX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   INST_DEC(cpu->CX);
   JUMP«JZ» goto LAB_LOC_2;
   goto LAB_LOC_1;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->CX, MEM_WORD(0xdbbe));
   JUMP«JZ» goto LAB_LOC_5;
   INST_SUB(cpu->AX, MEM_WORD(0xdbbe));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbbe);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->CX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->DX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->BX = cpu->BP;
   FUN_1000_3f7a(cpu);
   MEM_WORD(cpu->DI + 0x4) = cpu->AX;
   INST_ADD(cpu->DI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   LAB_LOC_5:
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
   LAB_LOC_6:
   INST_PUSH(cpu->CX);
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   INST_ADD(cpu->SI, 0x8);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbe));
   JUMP«JLE» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
//ANALYSIS: related to textured polygons
void FUN_1000_36fe(cpu_ctx *cpu){
                              //XREF[8]:     1000:0d24(c),1000:16f0(c),1000:175a(c),1000:1907(c),
                              //             1000:1ddb(c),1000:1e34(c),1000:1f2f(c),1000:1f88(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->SI = 0xdb16;
   cpu->DI = 0xdb68;
   FUN_1000_390a(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_3aa3(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_3c3c(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_3ddb(cpu);
   cpu->SI = cpu->DI;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   INST_CMP(cpu->CX, 0x3);
   JUMP«JC» goto LAB_LOC_3;
   cpu->AX = MEM_WORD(0xdbbe);
   MEM_WORD(0xdbc4) = cpu->AX;
   cpu->AX = MEM_WORD(0xdbbc);
   MEM_WORD(0xdbc6) = cpu->AX;
   INST_PUSH(cpu->SI);
   INST_DEC(cpu->CX);
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   INST_PUSH(cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->CX = MEM_WORD(cpu->SI + 0x8);
   cpu->DX = MEM_WORD(cpu->SI + 0xa);
   FUN_1000_2c4b(cpu);
   INST_POP(cpu->SI);
   INST_POP(cpu->CX);
   INST_ADD(cpu->SI, 0x8);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_POP(cpu->SI);
   cpu->CX = MEM_WORD(cpu->SI);
   cpu->DX = MEM_WORD(cpu->SI + 0x2);
   FUN_1000_2c4b(cpu);
   cpu->SI = 0xdb16;
   INST_PUSH(cpu->SI);
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   INST_DEC(cpu->CX);
   LAB_LOC_2:
   INST_PUSH(cpu->CX);
   INST_PUSH(cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI + 0x4);
   cpu->BX = MEM_WORD(cpu->SI + 0x6);
   cpu->CX = MEM_WORD(cpu->SI + 0xc);
   cpu->DX = MEM_WORD(cpu->SI + 0xe);
   cpu->DI = MEM_WORD(cpu->SI + 0xa);
   cpu->SI = MEM_WORD(cpu->SI + 0x2);
   FUN_1000_379b(cpu);
   INST_POP(cpu->SI);
   INST_POP(cpu->CX);
   INST_ADD(cpu->SI, 0x8);
   if (--cpu->CX != 0) goto LAB_LOC_2;
   cpu->AX = MEM_WORD(cpu->SI + 0x4);
   cpu->BX = MEM_WORD(cpu->SI + 0x6);
   cpu->BP = MEM_WORD(cpu->SI + 0x2);
   INST_POP(cpu->SI);
   cpu->CX = MEM_WORD(cpu->SI + 0x4);
   cpu->DX = MEM_WORD(cpu->SI + 0x6);
   cpu->DI = MEM_WORD(cpu->SI + 0x2);
   cpu->SI = cpu->BP;
   FUN_1000_379b(cpu);
   FUN_1000_3827(cpu);
   LAB_LOC_3:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_379b(cpu_ctx *cpu){
                              //XREF[2]:     1000:3773(c),1000:3792(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   INST_CMP(cpu->SI, cpu->DI);
   JUMP«JLE» goto LAB_LOC_1;
   INST_XCHG(cpu->DI, cpu->SI);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_XCHG(cpu->DX, cpu->BX);
   INST_SUB(cpu->DI, cpu->SI);
   INST_SHL(cpu->SI, 0x2);
   INST_ADD(cpu->SI, 0xdeea);
   goto LAB_LOC_2;
   LAB_LOC_1:
   INST_SUB(cpu->DI, cpu->SI);
   INST_SHL(cpu->SI, 0x2);
   INST_ADD(cpu->SI, 0xdee8);
   LAB_LOC_2:
   INST_TEST(cpu->DI, cpu->DI);
   JUMP«JZ» goto LAB_LOC_4;
   INST_MOVSX(cpu->EDI, cpu->DI);
   INST_SUB(cpu->CX, cpu->AX);
   INST_SUB(cpu->DX, cpu->BX);
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->DX);
   cpu->AX = cpu->CX;
   INST_SHL(cpu->EAX, 0x10);
   INST_CDQ();
   INST_IDIV(cpu->EDI);
   cpu->ECX = cpu->EAX;
   INST_POP(cpu->AX);
   INST_SHL(cpu->EAX, 0x10);
   INST_CDQ();
   INST_IDIV(cpu->EDI);
   cpu->EDX = cpu->EAX;
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_XCHG(cpu->ECX, cpu->EDI);
   LAB_LOC_3:
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   MEM_WORD(cpu->SI) = cpu->AX;
   MEM_WORD(cpu->SI + 0x320) = cpu->BX;
   INST_ADD(cpu->SI, 0x4);
   INST_ROL(cpu->EAX, 0x10);
   INST_ROL(cpu->EBX, 0x10);
   INST_ADD(cpu->EAX, cpu->EDI);
   INST_ADD(cpu->EBX, cpu->EDX);
   if (--cpu->CX != 0) goto LAB_LOC_3;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   MEM_WORD(cpu->SI) = cpu->AX;
   MEM_WORD(cpu->SI + 0x320) = cpu->BX;
   LAB_LOC_4:
   INST_POP(cpu->SI);
   INST_POP(cpu->DI);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
//ANALYSIS: seems to be related to rendering textured polygons, disabling it makes only flat polygons render, also it show a lot on the profiler
void FUN_1000_3827(cpu_ctx *cpu){
                              //XREF[1]:     1000:3795(c)
   cpu->SI = MEM_WORD(0xdbc4);
   cpu->DI = MEM_WORD(0xdbc6);
   INST_SUB(cpu->DI, cpu->SI);
   JUMP«JZ» goto LAB_LOC_5;
   INST_INC(cpu->DI);
   INST_SHL(cpu->SI, 0x2);
   INST_PUSH(cpu->ES);
   cpu->ES = MEM_WORD(0xdb10);
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
   JUMP«JNS» goto LAB_LOC_2;
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
   INST_XCHG(cpu->EAX, cpu->ESI);
   INST_MOVSX(cpu->EAX, cpu->AX);
   INST_SHL(cpu->EAX, 0x8);
   INST_CDQ();
   INST_IDIV(cpu->ECX);
   cpu->EDX = cpu->EAX;
   INST_XCHG(cpu->ESI, cpu->ECX);
   INST_MOVZX(cpu->EBX, cpu->BX);
   INST_MOVZX(cpu->EBP, cpu->BP);
   INST_SHL(cpu->EBX, 0x8);
   INST_SHL(cpu->EBP, 0x8);
   INST_CLD();
   LAB_LOC_3:
   INST_ROR(cpu->EBX, 0x10);
   INST_ROR(cpu->EBP, 0x10);
   INST_ROR(cpu->ESI, 0x10);
   cpu->SI = cpu->BP;
   INST_SHL(cpu->SI, 0x8);
   cpu->AL = MEM_BYTE(cpu->FS*SEGM + cpu->BX + cpu->SI);
   INST_CMP(cpu->AL, 0xff);
   JUMP«JZ» goto LAB_LOC_4;
   INST_CMP(cpu->AL, 0xf0);
   JUMP«JNC» goto LAB_LOC_6;
   MEM_BYTE(cpu->ES*SEGM + cpu->DI) = cpu->AL;
   LAB_LOC_4:
   INST_INC(cpu->DI);
   INST_ROL(cpu->ESI, 0x10);
   INST_ROL(cpu->EBX, 0x10);
   INST_ROL(cpu->EBP, 0x10);
   INST_ADD(cpu->EBX, cpu->ECX);
   INST_ADD(cpu->EBP, cpu->EDX);
   INST_DEC(cpu->SI);
   JUMP«JNZ» goto LAB_LOC_3;
   INST_POP(cpu->SI);
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x4);
   INST_DEC(cpu->DI);
   JUMP«JNZ» goto LAB_LOC_1;
   INST_POP(cpu->ES);
   LAB_LOC_5:
   return;
   LAB_LOC_6:
   INST_SUB(cpu->AL, 0xf0);
   cpu->AH = cpu->AL;
   cpu->AL = MEM_BYTE(cpu->ES*SEGM + cpu->DI);
   INST_XCHG(cpu->AX, cpu->BX);
   cpu->BL = MEM_BYTE(cpu->BX + 0x2e51);
   INST_XCHG(cpu->AX, cpu->BX);
   MEM_BYTE(cpu->ES*SEGM + cpu->DI) = cpu->AL;
   goto LAB_LOC_4;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
//ANALYSIS: seems to also be related to rendering textured polygons
void FUN_1000_390a(cpu_ctx *cpu){
                              //XREF[1]:     1000:3706(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   MEM_WORD(0xe528) = 0x0;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x3);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   cpu->DX = MEM_WORD(cpu->SI + 0x6);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->BP;
   MEM_WORD(cpu->DI + 0x6) = cpu->DX;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x8);
   INST_ROR(cpu->ESI, 0x10);
   cpu->SI = cpu->DI;
   cpu->DI = cpu->DX;
   INST_CMP(cpu->AX, MEM_WORD(0xdbc0));
   JUMP«JL» goto LAB_LOC_6;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->SI) = cpu->AX;
   MEM_WORD(cpu->SI + 0x2) = cpu->BX;
   MEM_WORD(cpu->SI + 0x4) = cpu->BP;
   MEM_WORD(cpu->SI + 0x6) = cpu->DI;
   INST_ADD(cpu->SI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   INST_SHL(cpu->EDI, 0x10);
   INST_ROR(cpu->ESI, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   cpu->DI = MEM_WORD(cpu->SI + 0x6);
   INST_ADD(cpu->SI, 0x8);
   INST_ROR(cpu->ESI, 0x10);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc0));
   JUMP«JL» goto LAB_LOC_4;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   cpu->AX = MEM_WORD(0xe528);
   MEM_WORD(cpu->DI + -0x2) = cpu->AX;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   INST_PUSH(cpu->DI);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_SUB(cpu->AX, MEM_WORD(0xdbc0));
   INST_SUB(cpu->CX, MEM_WORD(0xdbc0));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbc0);
   MEM_WORD(cpu->SI) = cpu->CX;
   MEM_WORD(cpu->SI + 0x2) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->DX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->BX = cpu->BP;
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x4) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->DX = cpu->DI;
   INST_ROR(cpu->EDI, 0x10);
   cpu->BX = cpu->DI;
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x6) = cpu->AX;
   INST_ADD(cpu->SI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_POP(cpu->DI);
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   INST_DEC(cpu->CX);
   JUMP«JNZ» goto LAB_LOC_1;
   goto LAB_LOC_2;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   INST_PUSH(cpu->DI);
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_SUB(cpu->CX, MEM_WORD(0xdbc0));
   JUMP«JZ» goto LAB_LOC_5;
   INST_SUB(cpu->AX, MEM_WORD(0xdbc0));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbc0);
   MEM_WORD(cpu->SI) = cpu->CX;
   MEM_WORD(cpu->SI + 0x2) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->BX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->DX = cpu->BP;
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x4) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->BX = cpu->DI;
   INST_ROR(cpu->EDI, 0x10);
   cpu->DX = cpu->DI;
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x6) = cpu->AX;
   INST_ADD(cpu->SI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   LAB_LOC_5:
   INST_POP(cpu->DI);
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
   LAB_LOC_6:
   INST_PUSH(cpu->CX);
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   INST_SHL(cpu->EDI, 0x10);
   INST_ROR(cpu->ESI, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   cpu->DI = MEM_WORD(cpu->SI + 0x6);
   INST_ADD(cpu->SI, 0x8);
   INST_ROR(cpu->ESI, 0x10);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc0));
   JUMP«JGE» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_3aa3(cpu_ctx *cpu){
                              //XREF[1]:     1000:370b(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   MEM_WORD(0xe528) = 0x0;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x3);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   cpu->DX = MEM_WORD(cpu->SI + 0x6);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->BP;
   MEM_WORD(cpu->DI + 0x6) = cpu->DX;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x8);
   INST_ROR(cpu->ESI, 0x10);
   cpu->SI = cpu->DI;
   cpu->DI = cpu->DX;
   INST_CMP(cpu->AX, MEM_WORD(0xdbc2));
   JUMP«JG» goto LAB_LOC_6;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->SI) = cpu->AX;
   MEM_WORD(cpu->SI + 0x2) = cpu->BX;
   MEM_WORD(cpu->SI + 0x4) = cpu->BP;
   MEM_WORD(cpu->SI + 0x6) = cpu->DI;
   INST_ADD(cpu->SI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   INST_SHL(cpu->EDI, 0x10);
   INST_ROR(cpu->ESI, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   cpu->DI = MEM_WORD(cpu->SI + 0x6);
   INST_ADD(cpu->SI, 0x8);
   INST_ROR(cpu->ESI, 0x10);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc2));
   JUMP«JG» goto LAB_LOC_4;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   cpu->AX = MEM_WORD(0xe528);
   MEM_WORD(cpu->DI + -0x2) = cpu->AX;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   INST_PUSH(cpu->DI);
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_SUB(cpu->AX, MEM_WORD(0xdbc2));
   INST_SUB(cpu->CX, MEM_WORD(0xdbc2));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbc2);
   MEM_WORD(cpu->SI) = cpu->CX;
   MEM_WORD(cpu->SI + 0x2) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->BX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->DX = cpu->BP;
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x4) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->BX = cpu->DI;
   INST_ROR(cpu->EDI, 0x10);
   cpu->DX = cpu->DI;
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x6) = cpu->AX;
   INST_ADD(cpu->SI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_POP(cpu->DI);
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   INST_DEC(cpu->CX);
   JUMP«JNZ» goto LAB_LOC_1;
   goto LAB_LOC_2;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   INST_PUSH(cpu->DI);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_SUB(cpu->CX, MEM_WORD(0xdbc2));
   JUMP«JZ» goto LAB_LOC_5;
   INST_SUB(cpu->AX, MEM_WORD(0xdbc2));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbc2);
   MEM_WORD(cpu->SI) = cpu->CX;
   MEM_WORD(cpu->SI + 0x2) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->DX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->BX = cpu->BP;
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x4) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->DX = cpu->DI;
   INST_ROR(cpu->EDI, 0x10);
   cpu->BX = cpu->DI;
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x6) = cpu->AX;
   INST_ADD(cpu->SI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   LAB_LOC_5:
   INST_POP(cpu->DI);
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
   LAB_LOC_6:
   INST_PUSH(cpu->CX);
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   INST_SHL(cpu->EDI, 0x10);
   INST_ROR(cpu->ESI, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   cpu->DI = MEM_WORD(cpu->SI + 0x6);
   INST_ADD(cpu->SI, 0x8);
   INST_ROR(cpu->ESI, 0x10);
   INST_CMP(cpu->AX, MEM_WORD(0xdbc2));
   JUMP«JLE» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_3c3c(cpu_ctx *cpu){
                              //XREF[1]:     1000:3710(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   MEM_WORD(0xe528) = 0x0;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x3);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   cpu->DX = MEM_WORD(cpu->SI + 0x6);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->BP;
   MEM_WORD(cpu->DI + 0x6) = cpu->DX;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x8);
   INST_ROR(cpu->ESI, 0x10);
   cpu->SI = cpu->DI;
   cpu->DI = cpu->DX;
   INST_CMP(cpu->BX, MEM_WORD(0xdbbc));
   JUMP«JL» goto LAB_LOC_6;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->SI) = cpu->AX;
   MEM_WORD(cpu->SI + 0x2) = cpu->BX;
   MEM_WORD(cpu->SI + 0x4) = cpu->BP;
   MEM_WORD(cpu->SI + 0x6) = cpu->DI;
   INST_ADD(cpu->SI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   INST_SHL(cpu->EDI, 0x10);
   INST_ROR(cpu->ESI, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   cpu->DI = MEM_WORD(cpu->SI + 0x6);
   INST_ADD(cpu->SI, 0x8);
   INST_ROR(cpu->ESI, 0x10);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbc));
   JUMP«JL» goto LAB_LOC_4;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   cpu->AX = MEM_WORD(0xe528);
   MEM_WORD(cpu->DI + -0x2) = cpu->AX;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   INST_PUSH(cpu->DI);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->AX, MEM_WORD(0xdbbc));
   INST_SUB(cpu->CX, MEM_WORD(0xdbbc));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbbc);
   MEM_WORD(cpu->SI) = cpu->AX;
   MEM_WORD(cpu->SI + 0x2) = cpu->CX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->DX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->BX = cpu->BP;
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x4) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->DX = cpu->DI;
   INST_ROR(cpu->EDI, 0x10);
   cpu->BX = cpu->DI;
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x6) = cpu->AX;
   INST_ADD(cpu->SI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_POP(cpu->DI);
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   INST_DEC(cpu->CX);
   JUMP«JNZ» goto LAB_LOC_1;
   goto LAB_LOC_2;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   INST_PUSH(cpu->DI);
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->CX, MEM_WORD(0xdbbc));
   JUMP«JZ» goto LAB_LOC_5;
   INST_SUB(cpu->AX, MEM_WORD(0xdbbc));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbbc);
   MEM_WORD(cpu->SI) = cpu->AX;
   MEM_WORD(cpu->SI + 0x2) = cpu->CX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->BX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->DX = cpu->BP;
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x4) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->BX = cpu->DI;
   INST_ROR(cpu->EDI, 0x10);
   cpu->DX = cpu->DI;
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x6) = cpu->AX;
   INST_ADD(cpu->SI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   LAB_LOC_5:
   INST_POP(cpu->DI);
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
   LAB_LOC_6:
   INST_PUSH(cpu->CX);
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   INST_SHL(cpu->EDI, 0x10);
   INST_ROR(cpu->ESI, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   cpu->DI = MEM_WORD(cpu->SI + 0x6);
   INST_ADD(cpu->SI, 0x8);
   INST_ROR(cpu->ESI, 0x10);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbc));
   JUMP«JGE» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_3ddb(cpu_ctx *cpu){
                              //XREF[1]:     1000:3715(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   MEM_WORD(0xe528) = 0x0;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x3);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   cpu->DX = MEM_WORD(cpu->SI + 0x6);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   MEM_WORD(cpu->DI + 0x4) = cpu->BP;
   MEM_WORD(cpu->DI + 0x6) = cpu->DX;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x8);
   INST_ROR(cpu->ESI, 0x10);
   cpu->SI = cpu->DI;
   cpu->DI = cpu->DX;
   INST_CMP(cpu->BX, MEM_WORD(0xdbbe));
   JUMP«JG» goto LAB_LOC_6;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->SI) = cpu->AX;
   MEM_WORD(cpu->SI + 0x2) = cpu->BX;
   MEM_WORD(cpu->SI + 0x4) = cpu->BP;
   MEM_WORD(cpu->SI + 0x6) = cpu->DI;
   INST_ADD(cpu->SI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   INST_SHL(cpu->EDI, 0x10);
   INST_ROR(cpu->ESI, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   cpu->DI = MEM_WORD(cpu->SI + 0x6);
   INST_ADD(cpu->SI, 0x8);
   INST_ROR(cpu->ESI, 0x10);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbe));
   JUMP«JG» goto LAB_LOC_4;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   cpu->AX = MEM_WORD(0xe528);
   MEM_WORD(cpu->DI + -0x2) = cpu->AX;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   INST_PUSH(cpu->DI);
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->AX, MEM_WORD(0xdbbe));
   INST_SUB(cpu->CX, MEM_WORD(0xdbbe));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbbe);
   MEM_WORD(cpu->SI) = cpu->AX;
   MEM_WORD(cpu->SI + 0x2) = cpu->CX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->BX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->DX = cpu->BP;
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x4) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->BX = cpu->DI;
   INST_ROR(cpu->EDI, 0x10);
   cpu->DX = cpu->DI;
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x6) = cpu->AX;
   INST_ADD(cpu->SI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   INST_POP(cpu->DI);
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   INST_DEC(cpu->CX);
   JUMP«JNZ» goto LAB_LOC_1;
   goto LAB_LOC_2;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_PUSH(cpu->BP);
   INST_PUSH(cpu->DI);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   INST_ROR(cpu->EAX, 0x10);
   INST_ROR(cpu->EBX, 0x10);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->CX, MEM_WORD(0xdbbe));
   JUMP«JZ» goto LAB_LOC_5;
   INST_SUB(cpu->AX, MEM_WORD(0xdbbe));
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->CX = MEM_WORD(0xdbbe);
   MEM_WORD(cpu->SI) = cpu->AX;
   MEM_WORD(cpu->SI + 0x2) = cpu->CX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->DX = cpu->BP;
   INST_ROR(cpu->EBP, 0x10);
   cpu->BX = cpu->BP;
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x4) = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->DX = cpu->DI;
   INST_ROR(cpu->EDI, 0x10);
   cpu->BX = cpu->DI;
   INST_SHR(cpu->DX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   FUN_1000_3f7a(cpu);
   INST_SHL(cpu->AX, 0x1);
   MEM_WORD(cpu->SI + 0x6) = cpu->AX;
   INST_ADD(cpu->SI, 0x8);
   INST_INC(MEM_WORD(0xe528));
   LAB_LOC_5:
   INST_POP(cpu->DI);
   INST_POP(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
   LAB_LOC_6:
   INST_PUSH(cpu->CX);
   INST_SHL(cpu->EAX, 0x10);
   INST_SHL(cpu->EBX, 0x10);
   INST_SHL(cpu->EBP, 0x10);
   INST_SHL(cpu->EDI, 0x10);
   INST_ROR(cpu->ESI, 0x10);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->BP = MEM_WORD(cpu->SI + 0x4);
   cpu->DI = MEM_WORD(cpu->SI + 0x6);
   INST_ADD(cpu->SI, 0x8);
   INST_ROR(cpu->ESI, 0x10);
   INST_CMP(cpu->BX, MEM_WORD(0xdbbe));
   JUMP«JLE» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_6;
   goto LAB_LOC_2;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_3f7a(cpu_ctx *cpu){
                              //XREF[21]:    1000:2e4e(c),1000:2e77(c),1000:2f0e(c),1000:2f34(c),
                              //             1000:2fcb(c),1000:2ff6(c),1000:308f(c),1000:30b7(c),
                              //             1000:39b0(c),1000:39cc(c),1000:39e2(c),1000:3a23(c),
                              //             1000:3a3f(c),1000:3a55(c),1000:3b51(c),1000:3b6d(c),
                              //             1000:3b83(c),1000:3bbc(c),1000:3bd8(c),1000:3bee(c),
                              //             1000:3d5b(c)
   INST_CMP(cpu->BX, cpu->DX);
   JUMP«JZ» goto LAB_LOC_1;
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   INST_NEG(cpu->AX);
   INST_IMUL(cpu->DX);
   INST_XCHG(cpu->DX, cpu->BX);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_IMUL(cpu->DX);
   INST_ADD(cpu->AX, cpu->CX);
   INST_ADC(cpu->DX, cpu->BX);
   INST_POP(cpu->CX);
   INST_POP(cpu->BX);
   INST_SUB(cpu->CX, cpu->BX);
   INST_IDIV(cpu->CX);
   return;
   LAB_LOC_1:
   INST_XCHG(cpu->AX, cpu->BX);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_3f98(cpu_ctx *cpu){
                              //XREF[2]:     1000:1482(c),1000:59ad(c)
   INST_CMP(cpu->AX, MEM_WORD(0xdbc0));
   JUMP«JL» goto LAB_LOC_1;
   INST_CMP(cpu->AX, MEM_WORD(0xdbc2));
   JUMP«JG» goto LAB_LOC_1;
   INST_CMP(cpu->BX, MEM_WORD(0xdbbc));
   JUMP«JL» goto LAB_LOC_1;
   INST_CMP(cpu->BX, MEM_WORD(0xdbbe));
   JUMP«JG» goto LAB_LOC_1;
   INST_PUSH(cpu->ES);
   cpu->BH = cpu->BL;
   cpu->BL = 0; //was a XOR
   INST_ADD(cpu->AX, cpu->BX);
   INST_SHR(cpu->BX, 0x1);
   INST_SHR(cpu->BX, 0x1);
   INST_ADD(cpu->BX, cpu->AX);
   cpu->ES = MEM_WORD(0xdb10);
   MEM_BYTE(cpu->ES*SEGM + cpu->BX) = cpu->CL;
   INST_POP(cpu->ES);
   LAB_LOC_1:
   return;

 // 1000:3fcf [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_3fd0(cpu_ctx *cpu){
                              //XREF[1]:     1000:1981(c)
   MEM_WORD(0xe530) = 0x6;
   cpu->BX = MEM_WORD(0x5f9);
   INST_SAR(cpu->BX, 0x6);
   cpu->AX = MEM_WORD(0xac);
   INST_SHR(cpu->AX, 0x8);
   INST_ADD(cpu->AX, cpu->BX);
   MEM_WORD(0xe53a) = cpu->AX;
   cpu->AX = MEM_WORD(0xb0);
   INST_SHR(cpu->AX, 0x8);
   INST_ADD(cpu->AX, cpu->BX);
   MEM_WORD(0xe538) = cpu->AX;
   cpu->AX = MEM_WORD(0xac);
   INST_SHR(cpu->AX, 0x8);
   INST_SUB(cpu->AX, cpu->BX);
   MEM_WORD(0xe532) = cpu->AX;
   cpu->BX = MEM_WORD(0x5f7);
   INST_SAR(cpu->BX, 0x6);
   cpu->AX = MEM_WORD(0xb0);
   INST_SHR(cpu->AX, 0x8);
   INST_ADD(cpu->AX, cpu->BX);
   MEM_WORD(0xe53c) = cpu->AX;
   cpu->AX = MEM_WORD(0xac);
   INST_SHR(cpu->AX, 0x8);
   INST_SUB(cpu->AX, cpu->BX);
   MEM_WORD(0xe536) = cpu->AX;
   cpu->AX = MEM_WORD(0xb0);
   INST_SHR(cpu->AX, 0x8);
   INST_SUB(cpu->AX, cpu->BX);
   MEM_WORD(0xe534) = cpu->AX;
   cpu->AX = MEM_WORD(0x5f9);
   INST_IMUL(MEM_WORD(0x5f1));
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(0x5f7);
   INST_IMUL(MEM_WORD(0x5f3));
   cpu->CX = cpu->AX;
   INST_SUB(cpu->AX, cpu->BX);
   cpu->DX = MEM_WORD(0xb0);
   INST_SHR(cpu->DX, 0x8);
   INST_SAR(cpu->AX, 0x8);
   INST_ADD(cpu->AX, cpu->DX);
   MEM_WORD(0xe540) = cpu->AX;
   cpu->AX = cpu->CX;
   INST_NEG(cpu->AX);
   INST_SUB(cpu->AX, cpu->BX);
   cpu->DX = MEM_WORD(0xb0);
   INST_SHR(cpu->DX, 0x8);
   INST_SAR(cpu->AX, 0x8);
   INST_ADD(cpu->AX, cpu->DX);
   MEM_WORD(0xe548) = cpu->AX;
   cpu->AX = MEM_WORD(0x5f9);
   INST_IMUL(MEM_WORD(0x5f3));
   cpu->CX = cpu->AX;
   cpu->AX = MEM_WORD(0x5f7);
   INST_IMUL(MEM_WORD(0x5f1));
   cpu->BX = cpu->AX;
   cpu->AX = cpu->CX;
   INST_ADD(cpu->AX, cpu->BX);
   INST_SAR(cpu->AX, 0x8);
   cpu->DX = MEM_WORD(0xac);
   INST_SHR(cpu->DX, 0x8);
   INST_ADD(cpu->AX, cpu->DX);
   MEM_WORD(0xe53e) = cpu->AX;
   cpu->AX = cpu->BX;
   INST_SUB(cpu->AX, cpu->CX);
   cpu->DX = MEM_WORD(0xac);
   INST_SHR(cpu->DX, 0x8);
   INST_SAR(cpu->AX, 0x8);
   INST_ADD(cpu->AX, cpu->DX);
   MEM_WORD(0xe546) = cpu->AX;
   cpu->AX = MEM_WORD(0x5ef);
   INST_IMUL(MEM_WORD(0x5f9));
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(0x5ef);
   INST_IMUL(MEM_WORD(0x5f7));
   cpu->CX = cpu->AX;
   cpu->AX = MEM_WORD(0xac);
   INST_SHR(cpu->AX, 0x8);
   INST_SAR(cpu->CX, 0x8);
   INST_ADD(cpu->AX, cpu->CX);
   MEM_WORD(0xe542) = cpu->AX;
   cpu->AX = MEM_WORD(0xb0);
   INST_SHR(cpu->AX, 0x8);
   INST_SAR(cpu->BX, 0x8);
   INST_SUB(cpu->AX, cpu->BX);
   MEM_WORD(0xe544) = cpu->AX;
   FUN_1000_40c8(cpu);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_40c8(cpu_ctx *cpu){
                              //XREF[1]:     1000:40c4(c)
   cpu->SI = 0xe532;
   cpu->DI = 0xe55c;
   FUN_1000_4394(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_444d(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_4506(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_45c3(cpu);
   cpu->SI = cpu->DI;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   INST_CMP(cpu->CX, 0x3);
   JUMP«JC» goto LAB_LOC_2;
   cpu->AX = MEM_WORD(0xe586);
   MEM_WORD(0xe58c) = cpu->AX;
   cpu->AX = MEM_WORD(0xe584);
   MEM_WORD(0xe58e) = cpu->AX;
   INST_PUSH(cpu->SI);
   INST_DEC(cpu->CX);
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   INST_PUSH(cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->CX = MEM_WORD(cpu->SI + 0x4);
   cpu->DX = MEM_WORD(cpu->SI + 0x6);
   FUN_1000_4120(cpu);
   INST_POP(cpu->SI);
   INST_POP(cpu->CX);
   INST_ADD(cpu->SI, 0x4);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_POP(cpu->SI);
   cpu->CX = MEM_WORD(cpu->SI);
   cpu->DX = MEM_WORD(cpu->SI + 0x2);
   FUN_1000_4120(cpu);
   LAB_LOC_2:
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_4120(cpu_ctx *cpu){
                              //XREF[2]:     1000:4107(c),1000:411c(c)
   INST_XCHG(cpu->DX, cpu->CX);
   INST_CMP(cpu->BX, cpu->CX);
   JUMP«JLE» goto LAB_LOC_3;
   INST_XCHG(cpu->AX, cpu->DX);
   INST_XCHG(cpu->CX, cpu->BX);
   INST_CMP(cpu->BX, MEM_WORD(0xe58c));
   JUMP«JGE» goto LAB_LOC_1;
   MEM_WORD(0xe58c) = cpu->BX;
   LAB_LOC_1:
   INST_CMP(cpu->CX, MEM_WORD(0xe58e));
   JUMP«JLE» goto LAB_LOC_2;
   MEM_WORD(0xe58e) = cpu->CX;
   LAB_LOC_2:
   INST_SUB(cpu->CX, cpu->BX);
   INST_SHL(cpu->BX, 0x2);
   INST_ADD(cpu->BX, 0x2);
   goto LAB_LOC_6;
   LAB_LOC_3:
   INST_CMP(cpu->BX, MEM_WORD(0xe58c));
   JUMP«JGE» goto LAB_LOC_4;
   MEM_WORD(0xe58c) = cpu->BX;
   LAB_LOC_4:
   INST_CMP(cpu->CX, MEM_WORD(0xe58e));
   JUMP«JLE» goto LAB_LOC_5;
   MEM_WORD(0xe58e) = cpu->CX;
   LAB_LOC_5:
   INST_SUB(cpu->CX, cpu->BX);
   INST_SHL(cpu->BX, 0x2);
   LAB_LOC_6:
   if (cpu->CX == 0) goto LAB_LOC_14;
   INST_PUSH(cpu->DX);
   INST_SUB(cpu->DX, cpu->AX);
   JUMP«JS» goto LAB_LOC_10;
   cpu->DI = 0; //was a XOR
   cpu->SI = cpu->CX;
   LAB_LOC_7:
   MEM_WORD(cpu->BX + 0xe590) = cpu->AX;
   INST_ADD(cpu->BX, 0x4);
   INST_SUB(cpu->DI, cpu->DX);
   JUMP«JNS» goto LAB_LOC_9;
   LAB_LOC_8:
   INST_INC(cpu->AX);
   INST_ADD(cpu->DI, cpu->SI);
   JUMP«JS» goto LAB_LOC_8;
   LAB_LOC_9:
   if (--cpu->CX != 0) goto LAB_LOC_7;
   INST_POP(cpu->AX);
   MEM_WORD(cpu->BX + 0xe590) = cpu->AX;
   return;
   LAB_LOC_10:
   INST_NEG(cpu->DX);
   cpu->DI = 0; //was a XOR
   cpu->SI = cpu->CX;
   LAB_LOC_11:
   MEM_WORD(cpu->BX + 0xe590) = cpu->AX;
   INST_ADD(cpu->BX, 0x4);
   INST_SUB(cpu->DI, cpu->DX);
   JUMP«JNS» goto LAB_LOC_13;
   LAB_LOC_12:
   INST_DEC(cpu->AX);
   INST_ADD(cpu->DI, cpu->SI);
   JUMP«JS» goto LAB_LOC_12;
   LAB_LOC_13:
   if (--cpu->CX != 0) goto LAB_LOC_11;
   INST_POP(cpu->AX);
   MEM_WORD(cpu->BX + 0xe590) = cpu->AX;
   return;
   LAB_LOC_14:
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_41b2(cpu_ctx *cpu){
                              //XREF[1]:     1000:1f94(c)
   MEM_WORD(0xe530) = 0x6;
   cpu->BX = MEM_WORD(0x5f9);
   INST_SAR(cpu->BX, 0x6);
   cpu->AX = MEM_WORD(0xac);
   INST_SHR(cpu->AX, 0x8);
   INST_ADD(cpu->AX, cpu->BX);
   MEM_WORD(0xe53c) = cpu->AX;
   cpu->AX = MEM_WORD(0xb0);
   INST_SHR(cpu->AX, 0x8);
   INST_ADD(cpu->AX, cpu->BX);
   MEM_WORD(0xe536) = cpu->AX;
   cpu->AX = MEM_WORD(0xac);
   INST_SHR(cpu->AX, 0x8);
   INST_SUB(cpu->AX, cpu->BX);
   MEM_WORD(0xe534) = cpu->AX;
   cpu->BX = MEM_WORD(0x5f7);
   INST_SAR(cpu->BX, 0x6);
   cpu->AX = MEM_WORD(0xb0);
   INST_SHR(cpu->AX, 0x8);
   INST_ADD(cpu->AX, cpu->BX);
   MEM_WORD(0xe53a) = cpu->AX;
   cpu->AX = MEM_WORD(0xac);
   INST_SHR(cpu->AX, 0x8);
   INST_SUB(cpu->AX, cpu->BX);
   MEM_WORD(0xe538) = cpu->AX;
   cpu->AX = MEM_WORD(0xb0);
   INST_SHR(cpu->AX, 0x8);
   INST_SUB(cpu->AX, cpu->BX);
   MEM_WORD(0xe532) = cpu->AX;
   cpu->AX = MEM_WORD(0x5f9);
   INST_IMUL(MEM_WORD(0x5f1));
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(0x5f7);
   INST_IMUL(MEM_WORD(0x5f3));
   cpu->CX = cpu->AX;
   INST_SUB(cpu->AX, cpu->BX);
   cpu->DX = MEM_WORD(0xb0);
   INST_SHR(cpu->DX, 0x8);
   INST_SAR(cpu->AX, 0x8);
   INST_ADD(cpu->AX, cpu->DX);
   MEM_WORD(0xe53e) = cpu->AX;
   cpu->AX = cpu->CX;
   INST_NEG(cpu->AX);
   INST_SUB(cpu->AX, cpu->BX);
   cpu->DX = MEM_WORD(0xb0);
   INST_SHR(cpu->DX, 0x8);
   INST_SAR(cpu->AX, 0x8);
   INST_ADD(cpu->AX, cpu->DX);
   MEM_WORD(0xe546) = cpu->AX;
   cpu->AX = MEM_WORD(0x5f9);
   INST_IMUL(MEM_WORD(0x5f3));
   cpu->CX = cpu->AX;
   cpu->AX = MEM_WORD(0x5f7);
   INST_IMUL(MEM_WORD(0x5f1));
   cpu->BX = cpu->AX;
   cpu->AX = cpu->CX;
   INST_ADD(cpu->AX, cpu->BX);
   INST_SAR(cpu->AX, 0x8);
   cpu->DX = MEM_WORD(0xac);
   INST_SHR(cpu->DX, 0x8);
   INST_ADD(cpu->AX, cpu->DX);
   MEM_WORD(0xe540) = cpu->AX;
   cpu->AX = cpu->BX;
   INST_SUB(cpu->AX, cpu->CX);
   cpu->DX = MEM_WORD(0xac);
   INST_SHR(cpu->DX, 0x8);
   INST_SAR(cpu->AX, 0x8);
   INST_ADD(cpu->AX, cpu->DX);
   MEM_WORD(0xe548) = cpu->AX;
   cpu->AX = MEM_WORD(0x5ef);
   INST_IMUL(MEM_WORD(0x5f9));
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(0x5ef);
   INST_IMUL(MEM_WORD(0x5f7));
   cpu->CX = cpu->AX;
   cpu->AX = MEM_WORD(0xac);
   INST_SHR(cpu->AX, 0x8);
   INST_SAR(cpu->CX, 0x8);
   INST_ADD(cpu->AX, cpu->CX);
   MEM_WORD(0xe544) = cpu->AX;
   cpu->AX = MEM_WORD(0xb0);
   INST_SHR(cpu->AX, 0x8);
   INST_SAR(cpu->BX, 0x8);
   INST_SUB(cpu->AX, cpu->BX);
   MEM_WORD(0xe542) = cpu->AX;
   FUN_1000_42aa(cpu);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_42aa(cpu_ctx *cpu){
                              //XREF[1]:     1000:42a6(c)
   cpu->SI = 0xe532;
   cpu->DI = 0xe55c;
   FUN_1000_4394(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_444d(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_4506(cpu);
   INST_XCHG(cpu->DI, cpu->SI);
   FUN_1000_45c3(cpu);
   cpu->SI = cpu->DI;
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   INST_CMP(cpu->CX, 0x3);
   JUMP«JC» goto LAB_LOC_2;
   cpu->AX = MEM_WORD(0xe586);
   MEM_WORD(0xe58c) = cpu->AX;
   cpu->AX = MEM_WORD(0xe584);
   MEM_WORD(0xe58e) = cpu->AX;
   INST_PUSH(cpu->SI);
   INST_DEC(cpu->CX);
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   INST_PUSH(cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   cpu->CX = MEM_WORD(cpu->SI + 0x4);
   cpu->DX = MEM_WORD(cpu->SI + 0x6);
   FUN_1000_4302(cpu);
   INST_POP(cpu->SI);
   INST_POP(cpu->CX);
   INST_ADD(cpu->SI, 0x4);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_POP(cpu->SI);
   cpu->CX = MEM_WORD(cpu->SI);
   cpu->DX = MEM_WORD(cpu->SI + 0x2);
   FUN_1000_4302(cpu);
   LAB_LOC_2:
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_4302(cpu_ctx *cpu){
                              //XREF[2]:     1000:42e9(c),1000:42fe(c)
   INST_XCHG(cpu->DX, cpu->CX);
   INST_CMP(cpu->BX, cpu->CX);
   JUMP«JLE» goto LAB_LOC_3;
   INST_XCHG(cpu->AX, cpu->DX);
   INST_XCHG(cpu->CX, cpu->BX);
   INST_CMP(cpu->BX, MEM_WORD(0xe58c));
   JUMP«JGE» goto LAB_LOC_1;
   MEM_WORD(0xe58c) = cpu->BX;
   LAB_LOC_1:
   INST_CMP(cpu->CX, MEM_WORD(0xe58e));
   JUMP«JLE» goto LAB_LOC_2;
   MEM_WORD(0xe58e) = cpu->CX;
   LAB_LOC_2:
   INST_SUB(cpu->CX, cpu->BX);
   INST_SHL(cpu->BX, 0x2);
   goto LAB_LOC_6;
   LAB_LOC_3:
   INST_CMP(cpu->BX, MEM_WORD(0xe58c));
   JUMP«JGE» goto LAB_LOC_4;
   MEM_WORD(0xe58c) = cpu->BX;
   LAB_LOC_4:
   INST_CMP(cpu->CX, MEM_WORD(0xe58e));
   JUMP«JLE» goto LAB_LOC_5;
   MEM_WORD(0xe58e) = cpu->CX;
   LAB_LOC_5:
   INST_SUB(cpu->CX, cpu->BX);
   INST_SHL(cpu->BX, 0x2);
   INST_ADD(cpu->BX, 0x2);
   LAB_LOC_6:
   if (cpu->CX == 0) goto LAB_LOC_14;
   INST_PUSH(cpu->DX);
   INST_SUB(cpu->DX, cpu->AX);
   JUMP«JS» goto LAB_LOC_10;
   cpu->DI = 0; //was a XOR
   cpu->SI = cpu->CX;
   LAB_LOC_7:
   MEM_WORD(cpu->BX + 0xe590) = cpu->AX;
   INST_ADD(cpu->BX, 0x4);
   INST_SUB(cpu->DI, cpu->DX);
   JUMP«JNS» goto LAB_LOC_9;
   LAB_LOC_8:
   INST_INC(cpu->AX);
   INST_ADD(cpu->DI, cpu->SI);
   JUMP«JS» goto LAB_LOC_8;
   LAB_LOC_9:
   if (--cpu->CX != 0) goto LAB_LOC_7;
   INST_POP(cpu->AX);
   MEM_WORD(cpu->BX + 0xe590) = cpu->AX;
   return;
   LAB_LOC_10:
   INST_NEG(cpu->DX);
   cpu->DI = 0; //was a XOR
   cpu->SI = cpu->CX;
   LAB_LOC_11:
   MEM_WORD(cpu->BX + 0xe590) = cpu->AX;
   INST_ADD(cpu->BX, 0x4);
   INST_SUB(cpu->DI, cpu->DX);
   JUMP«JNS» goto LAB_LOC_13;
   LAB_LOC_12:
   INST_DEC(cpu->AX);
   INST_ADD(cpu->DI, cpu->SI);
   JUMP«JS» goto LAB_LOC_12;
   LAB_LOC_13:
   if (--cpu->CX != 0) goto LAB_LOC_11;
   INST_POP(cpu->AX);
   MEM_WORD(cpu->BX + 0xe590) = cpu->AX;
   return;
   LAB_LOC_14:
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_4394(cpu_ctx *cpu){
                              //XREF[2]:     1000:40ce(c),1000:42b0(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->BP = 0; //was a XOR
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x4);
   INST_CMP(cpu->AX, MEM_WORD(0xe588));
   JUMP«JL» goto LAB_LOC_5;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x4);
   INST_INC(cpu->BP);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x4);
   INST_CMP(cpu->AX, MEM_WORD(0xe588));
   JUMP«JL» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_SUB(cpu->AX, MEM_WORD(0xe588));
   INST_SUB(cpu->CX, MEM_WORD(0xe588));
   FUN_1000_4680(cpu);
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(0xe588);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x4);
   INST_INC(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_5;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_XCHG(cpu->DX, cpu->BX);
   INST_SUB(cpu->AX, MEM_WORD(0xe588));
   INST_SUB(cpu->CX, MEM_WORD(0xe588));
   FUN_1000_4680(cpu);
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(0xe588);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x4);
   INST_INC(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_5:
   INST_PUSH(cpu->CX);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x4);
   INST_CMP(cpu->AX, MEM_WORD(0xe588));
   JUMP«JGE» goto LAB_LOC_4;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_5;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_444d(cpu_ctx *cpu){
                              //XREF[2]:     1000:40d3(c),1000:42b5(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->BP = 0; //was a XOR
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x4);
   INST_CMP(cpu->AX, MEM_WORD(0xe58a));
   JUMP«JG» goto LAB_LOC_5;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x4);
   INST_INC(cpu->BP);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x4);
   INST_CMP(cpu->AX, MEM_WORD(0xe58a));
   JUMP«JG» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_XCHG(cpu->DX, cpu->BX);
   INST_SUB(cpu->AX, MEM_WORD(0xe58a));
   INST_SUB(cpu->CX, MEM_WORD(0xe58a));
   FUN_1000_4680(cpu);
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(0xe58a);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x4);
   INST_INC(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_5;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_SUB(cpu->AX, MEM_WORD(0xe58a));
   INST_SUB(cpu->CX, MEM_WORD(0xe58a));
   FUN_1000_4680(cpu);
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(0xe58a);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x4);
   INST_INC(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_5:
   INST_PUSH(cpu->CX);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x4);
   INST_CMP(cpu->AX, MEM_WORD(0xe58a));
   JUMP«JLE» goto LAB_LOC_4;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_5;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_4506(cpu_ctx *cpu){
                              //XREF[2]:     1000:40d8(c),1000:42ba(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->BP = 0; //was a XOR
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x4);
   INST_CMP(cpu->BX, MEM_WORD(0xe584));
   JUMP«JL» goto LAB_LOC_5;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x4);
   INST_INC(cpu->BP);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x4);
   INST_CMP(cpu->BX, MEM_WORD(0xe584));
   JUMP«JL» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->AX, MEM_WORD(0xe584));
   INST_SUB(cpu->CX, MEM_WORD(0xe584));
   FUN_1000_4680(cpu);
   cpu->BX = MEM_WORD(0xe584);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x4);
   INST_INC(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_5;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_XCHG(cpu->DX, cpu->BX);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->AX, MEM_WORD(0xe584));
   INST_SUB(cpu->CX, MEM_WORD(0xe584));
   FUN_1000_4680(cpu);
   cpu->BX = MEM_WORD(0xe584);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x4);
   INST_INC(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_5:
   INST_PUSH(cpu->CX);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x4);
   INST_CMP(cpu->BX, MEM_WORD(0xe584));
   JUMP«JGE» goto LAB_LOC_4;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_5;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_45c3(cpu_ctx *cpu){
                              //XREF[2]:     1000:40dd(c),1000:42bf(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   cpu->BP = 0; //was a XOR
   cpu->CX = MEM_WORD(cpu->SI + -0x2);
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = cpu->CX;
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->SI);
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_POP(cpu->DI);
   INST_ADD(cpu->SI, 0x4);
   INST_CMP(cpu->BX, MEM_WORD(0xe586));
   JUMP«JG» goto LAB_LOC_5;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x4);
   INST_INC(cpu->BP);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x4);
   INST_CMP(cpu->BX, MEM_WORD(0xe586));
   JUMP«JG» goto LAB_LOC_3;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   LAB_LOC_2:
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_3:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_XCHG(cpu->DX, cpu->BX);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->AX, MEM_WORD(0xe586));
   INST_SUB(cpu->CX, MEM_WORD(0xe586));
   FUN_1000_4680(cpu);
   cpu->BX = MEM_WORD(0xe586);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x4);
   INST_INC(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_5;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   INST_XCHG(cpu->AX, cpu->BX);
   INST_XCHG(cpu->DX, cpu->CX);
   INST_SUB(cpu->AX, MEM_WORD(0xe586));
   INST_SUB(cpu->CX, MEM_WORD(0xe586));
   FUN_1000_4680(cpu);
   cpu->BX = MEM_WORD(0xe586);
   MEM_WORD(cpu->DI) = cpu->AX;
   MEM_WORD(cpu->DI + 0x2) = cpu->BX;
   INST_ADD(cpu->DI, 0x4);
   INST_INC(cpu->BP);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
   LAB_LOC_5:
   INST_PUSH(cpu->CX);
   cpu->CX = cpu->AX;
   cpu->DX = cpu->BX;
   cpu->AX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(cpu->SI + 0x2);
   INST_ADD(cpu->SI, 0x4);
   INST_CMP(cpu->BX, MEM_WORD(0xe586));
   JUMP«JLE» goto LAB_LOC_4;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_5;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   MEM_WORD(cpu->DI + -0x2) = cpu->BP;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_4680(cpu_ctx *cpu){
                              //XREF[8]:     1000:43ec(c),1000:4415(c),1000:44a8(c),1000:44ce(c),
                              //             1000:4561(c),1000:458c(c),1000:4621(c),1000:4649(c)
   INST_CMP(cpu->BX, cpu->DX);
   JUMP«JZ» goto LAB_LOC_1;
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   INST_NEG(cpu->AX);
   INST_IMUL(cpu->DX);
   INST_XCHG(cpu->DX, cpu->BX);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_IMUL(cpu->DX);
   INST_ADD(cpu->AX, cpu->CX);
   INST_ADC(cpu->DX, cpu->BX);
   INST_POP(cpu->CX);
   INST_POP(cpu->BX);
   INST_SUB(cpu->CX, cpu->BX);
   INST_IDIV(cpu->CX);
   return;
   LAB_LOC_1:
   INST_XCHG(cpu->AX, cpu->BX);
   return;

 // 1000:469f [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_46a0(cpu_ctx *cpu){
                              //XREF[13]:    1000:14bf(c),1000:152a(c),1000:159b(c),1000:1617(c),
                              //             1000:1699(c),1000:1d04(c),1000:1d30(c),1000:1d97(c),
                              //             1000:1ded(c),1000:1e60(c),1000:1e89(c),1000:1eeb(c),
                              //             1000:1f41(c)
   INST_PUSH(cpu->DI);
   cpu->DI = 0; //was a XOR
   cpu->AX = MEM_WORD(cpu->SI + 0x2);
   INST_SUB(cpu->AX, MEM_WORD(0x120));
   MEM_WORD(0xe992) = cpu->AX;
   JUMP«JL» goto LAB_LOC_1;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x6);
   MEM_DWORD(cpu->DI + 0xdb16) = cpu->EAX;
   MEM_DWORD(cpu->DI + 0xdb1a) = cpu->EBX;
   INST_ADD(cpu->DI, 0x8);
   LAB_LOC_1:
   MEM_WORD(0xe996) = cpu->DI;
   INST_POP(cpu->DI);
   cpu->AX = MEM_WORD(cpu->SI);
   MEM_WORD(0xe990) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI + 0x4);
   MEM_WORD(0xe994) = cpu->AX;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_46d3(cpu_ctx *cpu){
                              //XREF[21]:    1000:14d4(c),1000:14e9(c),1000:1541(c),1000:15b5(c),
                              //             1000:1639(c),1000:1d09(c),1000:1d0d(c),1000:1d34(c),
                              //             1000:1d3a(c),1000:1da5(c),1000:1db5(c),1000:1dfd(c),
                              //             1000:1e0f(c),1000:1e65(c),1000:1e69(c),1000:1e8d(c),
                              //             1000:1e93(c),1000:1ef9(c),1000:1f09(c),1000:1f51(c),
                              //             1000:1f63(c)
   cpu->EBP = cpu->EBX;
   cpu->CX = MEM_WORD(0xe992);
   INST_TEST(cpu->CX, cpu->CX);
   JUMP«JL» goto LAB_LOC_3;
   INST_PUSH(cpu->DI);
   cpu->DI = MEM_WORD(0xe996);
   cpu->AX = MEM_WORD(cpu->SI + 0x2);
   INST_SUB(cpu->AX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_1;
   MEM_WORD(0xe992) = cpu->AX;
   cpu->EAX = MEM_DWORD(cpu->SI + 0x6);
   MEM_DWORD(cpu->DI + 0xdb16) = cpu->EAX;
   MEM_DWORD(cpu->DI + 0xdb1a) = cpu->EBP;
   INST_ADD(cpu->DI, 0x8);
   MEM_WORD(0xe996) = cpu->DI;
   INST_POP(cpu->DI);
   cpu->AX = MEM_WORD(cpu->SI);
   MEM_WORD(0xe990) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI + 0x4);
   MEM_WORD(0xe994) = cpu->AX;
   return;
   LAB_LOC_1:
   INST_PUSH(cpu->AX);
   if (cpu->CX == 0) goto LAB_LOC_2;
   cpu->BX = MEM_WORD(cpu->SI);
   cpu->DX = MEM_WORD(0xe990);
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->BX = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   INST_PUSH(cpu->BX);
   cpu->BX = MEM_WORD(cpu->SI + 0x4);
   cpu->DX = MEM_WORD(0xe994);
   FUN_1000_3f7a(cpu);
   cpu->CX = cpu->AX;
   INST_POP(cpu->AX);
   cpu->BX = MEM_WORD(0x120);
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, 0xa0);
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, 0x64);
   MEM_WORD(cpu->DI + 0xdb16) = cpu->AX;
   MEM_WORD(cpu->DI + 0xdb18) = cpu->BX;
   MEM_DWORD(cpu->DI + 0xdb1a) = cpu->EBP;
   INST_ADD(cpu->DI, 0x8);
   LAB_LOC_2:
   INST_POP(MEM_WORD(0xe992));
   MEM_WORD(0xe996) = cpu->DI;
   INST_POP(cpu->DI);
   cpu->AX = MEM_WORD(cpu->SI);
   MEM_WORD(0xe990) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI + 0x4);
   MEM_WORD(0xe994) = cpu->AX;
   return;
   LAB_LOC_3:
   cpu->AX = MEM_WORD(cpu->SI + 0x2);
   INST_SUB(cpu->AX, MEM_WORD(0x120));
   JUMP«JGE» goto LAB_LOC_4;
   MEM_WORD(0xe992) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI);
   MEM_WORD(0xe990) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI + 0x4);
   MEM_WORD(0xe994) = cpu->AX;
   return;
   LAB_LOC_4:
   INST_PUSH(cpu->AX);
   cpu->DX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(0xe990);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->BX = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   INST_PUSH(cpu->BX);
   cpu->DX = MEM_WORD(cpu->SI + 0x4);
   cpu->BX = MEM_WORD(0xe994);
   FUN_1000_3f7a(cpu);
   cpu->CX = cpu->AX;
   INST_POP(cpu->AX);
   cpu->BX = MEM_WORD(0x120);
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, 0xa0);
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, 0x64);
   INST_PUSH(cpu->DI);
   cpu->DI = MEM_WORD(0xe996);
   MEM_WORD(cpu->DI + 0xdb16) = cpu->AX;
   MEM_WORD(cpu->DI + 0xdb18) = cpu->BX;
   MEM_DWORD(cpu->DI + 0xdb1a) = cpu->EBP;
   INST_ADD(cpu->DI, 0x8);
   cpu->EAX = MEM_DWORD(cpu->SI + 0x6);
   MEM_DWORD(cpu->DI + 0xdb16) = cpu->EAX;
   MEM_DWORD(cpu->DI + 0xdb1a) = cpu->EBP;
   INST_ADD(cpu->DI, 0x8);
   MEM_WORD(0xe996) = cpu->DI;
   INST_POP(cpu->DI);
   INST_POP(MEM_WORD(0xe992));
   cpu->AX = MEM_WORD(cpu->SI);
   MEM_WORD(0xe990) = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI + 0x4);
   MEM_WORD(0xe994) = cpu->AX;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_47ec(cpu_ctx *cpu){
                              //XREF[13]:    1000:1500(c),1000:1559(c),1000:15d0(c),1000:165c(c),
                              //             1000:16d2(c),1000:1d14(c),1000:1d40(c),1000:1dc8(c),
                              //             1000:1e21(c),1000:1e70(c),1000:1e99(c),1000:1f1c(c),
                              //             1000:1f75(c)
   cpu->EBP = cpu->EBX;
   cpu->CX = MEM_WORD(0xe992);
   INST_TEST(cpu->CX, cpu->CX);
   JUMP«JL» goto LAB_LOC_3;
   cpu->AX = MEM_WORD(cpu->SI + 0x2);
   INST_SUB(cpu->AX, MEM_WORD(0x120));
   JUMP«JL» goto LAB_LOC_1;
   cpu->AX = MEM_WORD(0xe996);
   INST_SHR(cpu->AX, 0x3);
   MEM_WORD(0xdb14) = cpu->AX;
   return;
   LAB_LOC_1:
   if (cpu->CX == 0) goto LAB_LOC_2;
   INST_PUSH(cpu->DI);
   cpu->DI = MEM_WORD(0xe996);
   cpu->BX = MEM_WORD(cpu->SI);
   cpu->DX = MEM_WORD(0xe990);
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->BX = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   INST_PUSH(cpu->BX);
   cpu->BX = MEM_WORD(cpu->SI + 0x4);
   cpu->DX = MEM_WORD(0xe994);
   FUN_1000_3f7a(cpu);
   cpu->CX = cpu->AX;
   INST_POP(cpu->AX);
   cpu->BX = MEM_WORD(0x120);
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, 0xa0);
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, 0x64);
   MEM_WORD(cpu->DI + 0xdb16) = cpu->AX;
   MEM_WORD(cpu->DI + 0xdb18) = cpu->BX;
   MEM_DWORD(cpu->DI + 0xdb1a) = cpu->EBP;
   INST_ADD(cpu->DI, 0x8);
   MEM_WORD(0xe996) = cpu->DI;
   INST_POP(cpu->DI);
   LAB_LOC_2:
   cpu->AX = MEM_WORD(0xe996);
   INST_SHR(cpu->AX, 0x3);
   MEM_WORD(0xdb14) = cpu->AX;
   return;
   LAB_LOC_3:
   cpu->AX = MEM_WORD(cpu->SI + 0x2);
   INST_SUB(cpu->AX, MEM_WORD(0x120));
   JUMP«JGE» goto LAB_LOC_4;
   cpu->AX = MEM_WORD(0xe996);
   INST_SHR(cpu->AX, 0x3);
   MEM_WORD(0xdb14) = cpu->AX;
   return;
   LAB_LOC_4:
   cpu->DX = MEM_WORD(cpu->SI);
   cpu->BX = MEM_WORD(0xe990);
   INST_XCHG(cpu->AX, cpu->CX);
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   FUN_1000_3f7a(cpu);
   cpu->BX = cpu->AX;
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   INST_PUSH(cpu->BX);
   cpu->DX = MEM_WORD(cpu->SI + 0x4);
   cpu->BX = MEM_WORD(0xe994);
   FUN_1000_3f7a(cpu);
   cpu->CX = cpu->AX;
   INST_POP(cpu->AX);
   cpu->BX = MEM_WORD(0x120);
   FUN_1000_2760(cpu);
   INST_ADD(cpu->AX, 0xa0);
   INST_NEG(cpu->BX);
   INST_ADD(cpu->BX, 0x64);
   INST_PUSH(cpu->DI);
   cpu->DI = MEM_WORD(0xe996);
   MEM_WORD(cpu->DI + 0xdb16) = cpu->AX;
   MEM_WORD(cpu->DI + 0xdb18) = cpu->BX;
   MEM_DWORD(cpu->DI + 0xdb1a) = cpu->EBP;
   INST_ADD(cpu->DI, 0x8);
   MEM_WORD(0xe996) = cpu->DI;
   cpu->AX = cpu->DI;
   INST_POP(cpu->DI);
   INST_SHR(cpu->AX, 0x3);
   MEM_WORD(0xdb14) = cpu->AX;
   return;

 // 1000:48cf [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_48d0(cpu_ctx *cpu){
                              //XREF[1]:     1000:56ba(c)
   INST_PUSH(cpu->SI);
   FUN_1000_4e0a(cpu);
   INST_POP(cpu->SI);
   INST_PUSH(cpu->SI);
   FUN_1000_48db(cpu);
   INST_POP(cpu->SI);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_48db(cpu_ctx *cpu){
                              //XREF[1]:     1000:48d6(c)
   FUN_1000_0e28(cpu);
   cpu->DI = cpu->SI;
   INST_ADD(cpu->DI, MEM_WORD(cpu->SI));
   cpu->AX = MEM_WORD(cpu->DI);
   MEM_WORD(0xe9d4) = cpu->AX;
   MEM_WORD(0xe9d6) = 0x0;
   INST_ADD(cpu->DI, 0x2);
   LAB_LOC_1:
   cpu->EAX = MEM_DWORD(0x6a);
   INST_SUB(MEM_DWORD(cpu->DI + 0x14), cpu->EAX);
   cpu->EAX = MEM_DWORD(cpu->DI);
   cpu->EBX = MEM_DWORD(cpu->DI + 0x4);
   cpu->ECX = MEM_DWORD(cpu->DI + 0x8);
   INST_SHR(cpu->EAX, 0x10);
   INST_SHR(cpu->EBX, 0x10);
   INST_SHR(cpu->ECX, 0x10);
   INST_PUSH(cpu->CX);
   FUN_1000_532e(cpu);
   INST_POP(cpu->CX);
   INST_ADD(cpu->AX, MEM_WORD(cpu->DI + 0x18));
   MEM_WORD(0xe9c6) = cpu->AX;
   INST_CMP(cpu->AX, cpu->CX);
   JUMP«JNS» goto LAB_LOC_11;
   LAB_LOC_2:
   cpu->AX = MEM_WORD(cpu->DI + 0x2);
   INST_SUB(cpu->AX, MEM_WORD(cpu->DI + 0x18));
   INST_CMP(cpu->AX, 0x80);
   JUMP«JC» goto LAB_LOC_7;
   LAB_LOC_3:
   cpu->AX = MEM_WORD(cpu->DI + 0x6);
   INST_SUB(cpu->AX, MEM_WORD(cpu->DI + 0x18));
   INST_CMP(cpu->AX, 0x80);
   JUMP«JC» goto LAB_LOC_8;
   LAB_LOC_4:
   cpu->AX = MEM_WORD(cpu->DI + 0x2);
   INST_ADD(cpu->AX, MEM_WORD(cpu->DI + 0x18));
   INST_CMP(cpu->AX, 0xfe80);
   JUMP«JA» goto LAB_LOC_9;
   LAB_LOC_5:
   cpu->AX = MEM_WORD(cpu->DI + 0x6);
   INST_ADD(cpu->AX, MEM_WORD(cpu->DI + 0x18));
   INST_CMP(cpu->AX, 0xfe80);
   JUMP«JA» goto LAB_LOC_10;
   LAB_LOC_6:
   cpu->EAX = MEM_DWORD(cpu->DI + 0xc);
   cpu->EBX = MEM_DWORD(cpu->DI + 0x10);
   cpu->ECX = MEM_DWORD(cpu->DI + 0x14);
   INST_ADD(MEM_DWORD(cpu->DI), cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->DI + 0x4), cpu->EBX);
   INST_ADD(MEM_DWORD(cpu->DI + 0x8), cpu->ECX);
   INST_ADD(cpu->DI, 0x1c);
   INST_INC(MEM_WORD(0xe9d6));
   INST_DEC(MEM_WORD(0xe9d4));
   JUMP«JNZ» goto LAB_LOC_1;
   FUN_1000_1003(cpu);
   return;
   LAB_LOC_7:
   MEM_WORD(0xe9a2) = 0x8000;
   MEM_WORD(0xe9a6) = 0x0;
   MEM_WORD(0xe9aa) = 0x0;
   MEM_WORD(0xe9ae) = 0x7f00;
   MEM_BYTE(0xea28) = 0x0;
   FUN_1000_4a71(cpu);
   goto LAB_LOC_3;
   LAB_LOC_8:
   MEM_WORD(0xe9a2) = 0x0;
   MEM_WORD(0xe9a6) = 0x7fff;
   MEM_WORD(0xe9aa) = 0x8000;
   MEM_WORD(0xe9ae) = 0x0;
   MEM_BYTE(0xea28) = 0x0;
   FUN_1000_4a71(cpu);
   goto LAB_LOC_4;
   LAB_LOC_9:
   MEM_WORD(0xe9a2) = 0x7fff;
   MEM_WORD(0xe9a6) = 0x0;
   MEM_WORD(0xe9aa) = 0x0;
   MEM_WORD(0xe9ae) = 0x7fff;
   MEM_BYTE(0xea28) = 0x0;
   FUN_1000_4a71(cpu);
   goto LAB_LOC_5;
   LAB_LOC_10:
   MEM_WORD(0xe9a2) = 0x0;
   MEM_WORD(0xe9a6) = 0x7fff;
   MEM_WORD(0xe9aa) = 0x7fff;
   MEM_WORD(0xe9ae) = 0x0;
   MEM_BYTE(0xea28) = 0x0;
   FUN_1000_4a71(cpu);
   goto LAB_LOC_6;
   LAB_LOC_11:
   INST_MOVZX(cpu->BX, MEM_BYTE(0xea28));
   INST_SHR(cpu->BX, 0x4);
   INST_MOVZX(cpu->CX, MEM_BYTE(cpu->BX + 0xea49));
   if (cpu->CX == 0) goto LAB_LOC_12;
   cpu->EAX = MEM_DWORD(cpu->DI + 0xc);
   INST_SAR(cpu->EAX, cpu->CL);
   INST_SUB(MEM_DWORD(cpu->DI + 0xc), cpu->EAX);
   cpu->EAX = MEM_DWORD(cpu->DI + 0x10);
   INST_SAR(cpu->EAX, cpu->CL);
   INST_SUB(MEM_DWORD(cpu->DI + 0x10), cpu->EAX);
   cpu->EAX = MEM_DWORD(cpu->DI + 0x14);
   INST_SAR(cpu->EAX, cpu->CL);
   INST_SUB(MEM_DWORD(cpu->DI + 0x14), cpu->EAX);
   LAB_LOC_12:
   cpu->AX = MEM_WORD(0xea24);
   cpu->BX = 0x100;
   FUN_1000_2b08(cpu);
   cpu->BX = cpu->AX;
   FUN_1000_2aad(cpu);
   MEM_WORD(0xe9a2) = cpu->AX;
   FUN_1000_2ad8(cpu);
   MEM_WORD(0xe9a6) = cpu->AX;
   cpu->AX = MEM_WORD(0xea26);
   cpu->BX = 0x100;
   FUN_1000_2b08(cpu);
   cpu->BX = cpu->AX;
   FUN_1000_2aad(cpu);
   MEM_WORD(0xe9aa) = cpu->AX;
   FUN_1000_2ad8(cpu);
   MEM_WORD(0xe9ae) = cpu->AX;
   FUN_1000_4a71(cpu);
   goto LAB_LOC_2;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_4a71(cpu_ctx *cpu){
                              //XREF[5]:     1000:499c(c),1000:49bf(c),1000:49e3(c),1000:4a07(c),
                              //             1000:4a6b(c)
   cpu->EAX = MEM_DWORD(cpu->DI + 0x14);
   INST_IMUL(MEM_DWORD(0xe9a4));
   INST_SHL(cpu->EDX, 0x1);
   cpu->EAX = cpu->EDX;
   INST_IMUL(MEM_DWORD(0xe9ac));
   INST_SHL(cpu->EDX, 0x1);
   cpu->EBX = cpu->EDX;
   cpu->EAX = MEM_DWORD(cpu->DI + 0xc);
   INST_IMUL(MEM_DWORD(0xe9a0));
   INST_SHL(cpu->EDX, 0x1);
   INST_SUB(cpu->EBX, cpu->EDX);
   cpu->EAX = MEM_DWORD(cpu->DI + 0x10);
   INST_IMUL(MEM_DWORD(0xe9a8));
   INST_SHL(cpu->EDX, 0x1);
   INST_SUB(cpu->EBX, cpu->EDX);
   JUMP«JNS» goto LAB_LOC_3;
   MEM_DWORD(0xe9c8) = cpu->EBX;
   INST_CMP(cpu->EBX, 0xfffa0000);
   JUMP«JG» goto LAB_LOC_1;
   cpu->AX = 0; //was a XOR
   FUN_1000_5864(cpu);
   LAB_LOC_1:
   cpu->ECX = MEM_DWORD(0xe9c8);
   cpu->EAX = cpu->ECX;
   INST_SAR(cpu->EAX, 0x2);
   INST_ADD(cpu->ECX, cpu->EAX);
   cpu->EAX = MEM_DWORD(0xe9a0);
   INST_IMUL(cpu->ECX);
   INST_ADD(MEM_DWORD(cpu->DI + 0xc), cpu->EDX);
   INST_SHL(cpu->EDX, 0x1);
   INST_ADD(MEM_DWORD(cpu->DI), cpu->EDX);
   cpu->EAX = MEM_DWORD(0xe9a8);
   INST_IMUL(cpu->ECX);
   INST_ADD(MEM_DWORD(cpu->DI + 0x10), cpu->EDX);
   INST_SHL(cpu->EDX, 0x1);
   INST_ADD(MEM_DWORD(cpu->DI + 0x4), cpu->EDX);
   cpu->EAX = cpu->ECX;
   INST_IMUL(MEM_DWORD(0xe9a4));
   INST_SHL(cpu->EDX, 0x1);
   cpu->EAX = cpu->EDX;
   INST_IMUL(MEM_DWORD(0xe9ac));
   INST_SUB(MEM_DWORD(cpu->DI + 0x14), cpu->EDX);
   INST_SHL(cpu->EDX, 0x1);
   INST_SUB(MEM_DWORD(cpu->DI + 0x8), cpu->EDX);
   cpu->AX = MEM_WORD(cpu->DI + 0x1a);
   INST_CMP(cpu->AX, 0x0);
   JUMP«JZ» goto LAB_LOC_5;
   INST_CMP(cpu->AX, 0xffff);
   JUMP«JZ» goto LAB_LOC_4;
   goto LAB_LOC_2;

 // 1000:4b25 [UNDEFINED BYTES REMOVED]

   LAB_LOC_2:
   cpu->EAX = MEM_DWORD(cpu->DI + 0xc);
   INST_IMUL(MEM_DWORD(0xe9a4));
   INST_SHL(cpu->EDX, 0x1);
   cpu->EBX = cpu->EDX;
   cpu->EAX = MEM_DWORD(cpu->DI + 0x14);
   INST_IMUL(MEM_DWORD(0xe9a0));
   INST_SHL(cpu->EDX, 0x1);
   INST_ADD(cpu->EBX, cpu->EDX);
   MEM_DWORD(0xe9cc) = cpu->EBX;
   cpu->EAX = MEM_DWORD(cpu->DI + 0x10);
   INST_IMUL(MEM_DWORD(0xe9ac));
   INST_SHL(cpu->EDX, 0x1);
   cpu->EBX = cpu->EDX;
   cpu->EAX = MEM_DWORD(cpu->DI + 0x14);
   INST_IMUL(MEM_DWORD(0xe9a8));
   INST_SHL(cpu->EDX, 0x1);
   INST_ADD(cpu->EBX, cpu->EDX);
   MEM_DWORD(0xe9d0) = cpu->EBX;
   cpu->AX = MEM_WORD(0xe9d6);
   FUN_1000_0e69(cpu);
   MEM_DWORD(0xe9b0) = cpu->EAX;
   MEM_DWORD(0xe9b4) = cpu->EBX;
   MEM_DWORD(0xe9b8) = cpu->ECX;
   INST_NEG(cpu->EDX);
   MEM_DWORD(0xe9da) = cpu->EDX;
   FUN_1000_4c26(cpu);
   MEM_WORD(0xe9bc) = cpu->AX;
   cpu->BX = cpu->AX;
   FUN_1000_2ad8(cpu);
   INST_SHL(cpu->EAX, 0x10);
   MEM_DWORD(0xe9c2) = cpu->EAX;
   FUN_1000_2aad(cpu);
   INST_SHL(cpu->EAX, 0x10);
   MEM_DWORD(0xe9be) = cpu->EAX;
   cpu->EAX = MEM_DWORD(0xe9da);
   INST_SHL(cpu->EAX, 0x1);
   cpu->EBX = cpu->EAX;
   INST_IMUL(MEM_DWORD(0xe9be));
   INST_ADD(MEM_DWORD(0xe9cc), cpu->EDX);
   cpu->EAX = cpu->EBX;
   INST_IMUL(MEM_DWORD(0xe9c2));
   INST_SUB(MEM_DWORD(0xe9d0), cpu->EDX);
   FUN_1000_4d0e(cpu);
   cpu->EBX = MEM_DWORD(0xe9da);
   INST_NEG(cpu->EBX);
   cpu->AX = MEM_WORD(0xe9d6);
   FUN_1000_0f67(cpu);
   LAB_LOC_3:
   return;
   LAB_LOC_4:
   goto LAB_LOC_5;

 // 1000:4bdb [UNDEFINED BYTES REMOVED]

   LAB_LOC_5:
   cpu->EAX = MEM_DWORD(cpu->DI + 0xc);
   INST_IMUL(MEM_DWORD(0xe9a4));
   INST_SHL(cpu->EDX, 0x1);
   cpu->EBX = cpu->EDX;
   cpu->EAX = MEM_DWORD(cpu->DI + 0x14);
   INST_IMUL(MEM_DWORD(0xe9a0));
   INST_SHL(cpu->EDX, 0x1);
   INST_ADD(cpu->EBX, cpu->EDX);
   MEM_DWORD(0xe9cc) = cpu->EBX;
   cpu->EAX = MEM_DWORD(cpu->DI + 0x10);
   INST_IMUL(MEM_DWORD(0xe9ac));
   INST_SHL(cpu->EDX, 0x1);
   cpu->EBX = cpu->EDX;
   cpu->EAX = MEM_DWORD(cpu->DI + 0x14);
   INST_IMUL(MEM_DWORD(0xe9a8));
   INST_SHL(cpu->EDX, 0x1);
   INST_ADD(cpu->EBX, cpu->EDX);
   MEM_DWORD(0xe9d0) = cpu->EBX;
   FUN_1000_4cc3(cpu);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_4c26(cpu_ctx *cpu){
                              //XREF[1]:     1000:4b88(c)
   INST_PUSH(cpu->ECX);
   INST_PUSH(cpu->EBX);
   INST_PUSH(cpu->ECX);
   INST_SAR(cpu->EAX, 0x4);
   INST_IMUL(MEM_DWORD(0xe9a4));
   cpu->BX = cpu->DX;
   INST_NEG(cpu->BX);
   INST_POP(cpu->EAX);
   INST_SAR(cpu->EAX, 0x4);
   INST_IMUL(MEM_DWORD(0xe9a0));
   INST_SUB(cpu->BX, cpu->DX);
   cpu->CX = cpu->BX;
   INST_POP(cpu->EAX);
   INST_SAR(cpu->EAX, 0x4);
   INST_IMUL(MEM_DWORD(0xe9ac));
   cpu->BX = cpu->DX;
   INST_POP(cpu->EAX);
   INST_SAR(cpu->EAX, 0x4);
   INST_IMUL(MEM_DWORD(0xe9a8));
   INST_ADD(cpu->BX, cpu->DX);
   cpu->AX = cpu->CX;
   FUN_1000_2b08(cpu);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_4c68(cpu_ctx *cpu){
                              //XREF[2]:     1000:4cc3(c),1000:4d0e(c)
   cpu->EAX = MEM_DWORD(0xe9cc);
   cpu->EBX = MEM_DWORD(0xe9d0);
   INST_AND(cpu->EAX, cpu->EAX);
   JUMP«JGE» goto LAB_LOC_1;
   INST_NEG(cpu->EAX);
   LAB_LOC_1:
   INST_AND(cpu->EBX, cpu->EBX);
   JUMP«JGE» goto LAB_LOC_2;
   INST_NEG(cpu->EBX);
   LAB_LOC_2:
   INST_ADD(cpu->EAX, cpu->EBX);
   INST_MOVZX(cpu->BX, MEM_BYTE(0xea28));
   INST_SHR(cpu->BX, 0x4);
   INST_SHL(cpu->BX, 0x1);
   INST_MOVZX(cpu->ECX, MEM_WORD(cpu->BX + 0xea29));
   INST_SHL(cpu->BX, 0x1);
   cpu->EDX = MEM_DWORD(cpu->BX + 0xea59);
   cpu->EBX = cpu->EAX;
   cpu->EAX = MEM_DWORD(0xe9c8);
   INST_NEG(cpu->EAX);
   INST_CMP(cpu->EAX, cpu->EDX);
   JUMP«JL» goto LAB_LOC_3;
   cpu->EAX = cpu->EDX;
   LAB_LOC_3:
   INST_CDQ();
   INST_IDIV(cpu->ECX);
   INST_SAR(cpu->EBX, 0x6);
   INST_SAR(cpu->ECX, 0x1);
   INST_CMP(cpu->EAX, cpu->EBX);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_4cc3(cpu_ctx *cpu){
                              //XREF[1]:     1000:4c22(c)
   FUN_1000_4c68(cpu);
   JUMP«JG» goto LAB_LOC_1;
   INST_PUSH(cpu->ECX);
   FUN_1000_4d96(cpu);
   INST_POP(cpu->ECX);
   cpu->EAX = MEM_DWORD(0xe9d0);
   INST_CDQ();
   INST_IDIV(cpu->ECX);
   cpu->EBX = cpu->EAX;
   cpu->EAX = MEM_DWORD(0xe9cc);
   INST_CDQ();
   INST_IDIV(cpu->ECX);
   goto LAB_LOC_2;
   LAB_LOC_1:
   cpu->EAX = MEM_DWORD(0xe9cc);
   cpu->EBX = MEM_DWORD(0xe9d0);
   LAB_LOC_2:
   INST_IMUL(MEM_DWORD(0xe9a4));
   INST_SUB(MEM_DWORD(cpu->DI + 0xc), cpu->EDX);
   INST_SUB(MEM_DWORD(cpu->DI), cpu->EDX);
   cpu->EAX = cpu->EBX;
   INST_IMUL(MEM_DWORD(0xe9ac));
   INST_SUB(MEM_DWORD(cpu->DI + 0x10), cpu->EDX);
   INST_SUB(MEM_DWORD(cpu->DI + 0x4), cpu->EDX);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_4d0e(cpu_ctx *cpu){
                              //XREF[1]:     1000:4bc7(c)
   FUN_1000_4c68(cpu);
   JUMP«JG» goto LAB_LOC_1;
   INST_PUSH(cpu->ECX);
   FUN_1000_4d96(cpu);
   INST_POP(cpu->ECX);
   cpu->EAX = MEM_DWORD(0xe9d0);
   INST_CDQ();
   INST_IDIV(cpu->ECX);
   cpu->EBX = cpu->EAX;
   cpu->EAX = MEM_DWORD(0xe9cc);
   INST_CDQ();
   INST_IDIV(cpu->ECX);
   MEM_DWORD(0xe9cc) = cpu->EAX;
   MEM_DWORD(0xe9d0) = cpu->EBX;
   LAB_LOC_1:
   cpu->EAX = MEM_DWORD(0xe9cc);
   INST_IMUL(MEM_DWORD(0xe9be));
   cpu->ECX = cpu->EDX;
   cpu->EAX = MEM_DWORD(0xe9d0);
   INST_IMUL(MEM_DWORD(0xe9c2));
   INST_SUB(cpu->ECX, cpu->EDX);
   INST_SUB(MEM_DWORD(0xe9da), cpu->ECX);
   cpu->EAX = cpu->ECX;
   cpu->EBX = cpu->EAX;
   INST_IMUL(MEM_DWORD(0xe9be));
   INST_ADD(MEM_DWORD(0xe9cc), cpu->EDX);
   cpu->EAX = cpu->EBX;
   INST_IMUL(MEM_DWORD(0xe9c2));
   INST_SUB(MEM_DWORD(0xe9d0), cpu->EDX);
   cpu->EAX = MEM_DWORD(0xe9cc);
   INST_IMUL(MEM_DWORD(0xe9a4));
   INST_SUB(MEM_DWORD(cpu->DI + 0xc), cpu->EDX);
   INST_SUB(MEM_DWORD(cpu->DI), cpu->EDX);
   cpu->EAX = MEM_DWORD(0xe9d0);
   INST_IMUL(MEM_DWORD(0xe9ac));
   INST_SUB(MEM_DWORD(cpu->DI + 0x10), cpu->EDX);
   INST_SUB(MEM_DWORD(cpu->DI + 0x4), cpu->EDX);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_4d96(cpu_ctx *cpu){
                              //XREF[3]:     1000:4ccc(c),1000:4d17(c),1000:52b7(c)
   INST_PUSH(cpu->SI);
   cpu->SI = MEM_WORD(0x3e51);
   INST_CMP(cpu->SI, 0x15e0);
   JUMP«JNC» goto LAB_LOC_1;
   cpu->EAX = MEM_DWORD(cpu->DI);
   cpu->EBX = MEM_DWORD(cpu->DI + 0x4);
   cpu->ECX = MEM_DWORD(cpu->DI + 0x8);
   MEM_DWORD(cpu->SI + 0x3e53) = cpu->EAX;
   MEM_DWORD(cpu->SI + 0x3e57) = cpu->EBX;
   INST_MOVZX(cpu->EAX, MEM_WORD(cpu->DI + 0x18));
   INST_SHL(cpu->EAX, 0x10);
   INST_SUB(cpu->ECX, cpu->EAX);
   MEM_DWORD(cpu->SI + 0x3e5b) = cpu->ECX;
   cpu->EAX = MEM_DWORD(0xe9cc);
   INST_IMUL(MEM_DWORD(0xe9a4));
   INST_SHL(cpu->EDX, 0x1);
   MEM_DWORD(cpu->SI + 0x3e5f) = cpu->EDX;
   cpu->EAX = MEM_DWORD(0xe9d0);
   INST_IMUL(MEM_DWORD(0xe9ac));
   INST_SHL(cpu->EDX, 0x1);
   MEM_DWORD(cpu->SI + 0x3e63) = cpu->EDX;
   cpu->ECX = MEM_DWORD(cpu->DI + 0x14);
   MEM_DWORD(cpu->SI + 0x3e67) = cpu->ECX;
   INST_MOVZX(cpu->AX, MEM_BYTE(0xea28));
   MEM_WORD(cpu->SI + 0x3e6d) = cpu->AX;
   MEM_WORD(cpu->SI + 0x3e6b) = 0x64;
   INST_ADD(MEM_WORD(0x3e51), 0x1c);
   LAB_LOC_1:
   INST_POP(cpu->SI);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_4e0a(cpu_ctx *cpu){
                              //XREF[1]:     1000:48d1(c)
   cpu->AX = cpu->SI;
   INST_ADD(cpu->AX, MEM_WORD(cpu->SI));
   INST_ADD(cpu->AX, 0x2);
   MEM_WORD(0xe9d8) = cpu->AX;
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI + 0x2));
   cpu->AX = MEM_WORD(cpu->SI);
   MEM_WORD(0xe9e6) = cpu->AX;
   INST_ADD(cpu->SI, 0x2);
   LAB_LOC_1:
   cpu->BP = cpu->SI;
   cpu->DI = MEM_WORD(cpu->SI + 0x2);
   cpu->AX = cpu->DI;
   INST_SHL(cpu->DI, 0x3);
   INST_SUB(cpu->DI, cpu->AX);
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, MEM_WORD(0xe9d8));
   cpu->SI = MEM_WORD(cpu->SI);
   cpu->AX = cpu->SI;
   INST_SHL(cpu->SI, 0x3);
   INST_SUB(cpu->SI, cpu->AX);
   INST_SHL(cpu->SI, 0x2);
   INST_ADD(cpu->SI, MEM_WORD(0xe9d8));
   cpu->EAX = MEM_DWORD(cpu->SI);
   INST_SUB(cpu->EAX, MEM_DWORD(cpu->DI));
   cpu->ECX = MEM_DWORD(cpu->SI + 0xc);
   INST_SUB(cpu->ECX, MEM_DWORD(cpu->DI + 0xc));
   MEM_DWORD(0xe9f8) = cpu->EAX;
   INST_ADD(cpu->EAX, cpu->ECX);
   float tmp_ec = SIGNED(cpu->EAX);
   cpu->EAX = MEM_DWORD(cpu->SI + 0x4);
   INST_SUB(cpu->EAX, MEM_DWORD(cpu->DI + 0x4));
   cpu->ECX = MEM_DWORD(cpu->SI + 0x10);
   INST_SUB(cpu->ECX, MEM_DWORD(cpu->DI + 0x10));
   MEM_DWORD(0xe9fc) = cpu->EAX;
   INST_ADD(cpu->EAX, cpu->ECX);
   float tmp_f0 = SIGNED(cpu->EAX);
   cpu->EAX = MEM_DWORD(cpu->SI + 0x8);
   INST_SUB(cpu->EAX, MEM_DWORD(cpu->DI + 0x8));
   cpu->ECX = MEM_DWORD(cpu->SI + 0x14);
   INST_SUB(cpu->ECX, MEM_DWORD(cpu->DI + 0x14));
   MEM_DWORD(0xea00) = cpu->EAX;
   INST_ADD(cpu->EAX, cpu->ECX);
   float tmp_f4 = SIGNED(cpu->EAX);
   
   tmp_ec *= tmp_ec;
   tmp_f0 *= tmp_f0;
   tmp_f4 *= tmp_f4;


   float ressq = __builtin_sqrtf(tmp_ec + tmp_f0 + tmp_f4);
   cpu->EAX = (int32_t)ressq;
    
   
   INST_SAR(cpu->EAX, 0xa);
   INST_MOVSX(cpu->EBX, MEM_WORD(cpu->DS*SEGM + cpu->BP + 0x4));
   INST_TEST(cpu->BX, cpu->BX);
   JUMP«JS» goto LAB_LOC_10;
   INST_MOVZX(cpu->ECX, MEM_WORD(cpu->DS*SEGM + cpu->BP + 0x8));
   MEM_WORD(0xea04) = cpu->CX;
   INST_AND(cpu->CX, 0xff);
   JUMP«JZ» goto LAB_LOC_5;
   JUMP«JS» goto LAB_LOC_3;
   INST_CMP(cpu->CX, 0x1);
   JUMP«JG» goto LAB_LOC_6;
   cpu->ECX = cpu->EBX;
   INST_SUB(cpu->ECX, cpu->EAX);
   JUMP«JZ» goto LAB_LOC_3;
   INST_CMP(cpu->CX, MEM_WORD(0xe9e2));
   JUMP«JG» goto LAB_LOC_8;
   INST_CMP(cpu->CX, MEM_WORD(0xe9e4));
   JUMP«JL» goto LAB_LOC_9;
   cpu->EBX = cpu->EAX;
   LAB_LOC_2:
   INST_SHL(cpu->ECX, 0x6);
   INST_SHL(cpu->EBX, 0x6);
   INST_PUSH(cpu->EBP);
   cpu->EBP = cpu->ECX;
   cpu->CL = MEM_BYTE(0xea05);
   INST_INC(cpu->CL);
   cpu->EAX = MEM_DWORD(0xe9f8);
   INST_IMUL(cpu->EBP);
   INST_IDIV(cpu->EBX);
   cpu->EDX = cpu->EAX;
   INST_SAR(cpu->EAX, cpu->CL);
   INST_SUB(cpu->EDX, cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->SI + 0xc), cpu->EAX);
   INST_SUB(MEM_DWORD(cpu->DI + 0xc), cpu->EDX);
   cpu->EAX = MEM_DWORD(0xe9fc);
   INST_IMUL(cpu->EBP);
   INST_IDIV(cpu->EBX);
   cpu->EDX = cpu->EAX;
   INST_SAR(cpu->EAX, cpu->CL);
   INST_SUB(cpu->EDX, cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->SI + 0x10), cpu->EAX);
   INST_SUB(MEM_DWORD(cpu->DI + 0x10), cpu->EDX);
   cpu->EAX = MEM_DWORD(0xea00);
   INST_IMUL(cpu->EBP);
   INST_IDIV(cpu->EBX);
   cpu->EDX = cpu->EAX;
   INST_SAR(cpu->EAX, cpu->CL);
   INST_SUB(cpu->EDX, cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->SI + 0x14), cpu->EAX);
   INST_SUB(MEM_DWORD(cpu->DI + 0x14), cpu->EDX);
   INST_POP(cpu->EBP);
   LAB_LOC_3:
                              //             1000:4ffd(j)
   cpu->SI = cpu->BP;
   LAB_LOC_4:
   INST_ADD(cpu->SI, 0xe);
   INST_DEC(MEM_WORD(0xe9e6));
   JUMP«JNZ» goto LAB_LOC_1;
   return;
   LAB_LOC_5:
   INST_MOVZX(cpu->EDX, MEM_WORD(cpu->DS*SEGM + cpu->BP + 0xc));
   INST_CMP(cpu->EAX, cpu->EDX);
   JUMP«JG» goto LAB_LOC_7;
   INST_MOVZX(cpu->EDX, MEM_WORD(cpu->DS*SEGM + cpu->BP + 0xa));
   INST_CMP(cpu->EAX, cpu->EDX);
   JUMP«JL» goto LAB_LOC_7;
   goto LAB_LOC_3;
   LAB_LOC_6:
   INST_MOVZX(cpu->EDX, MEM_WORD(cpu->DS*SEGM + cpu->BP + 0xc));
   INST_CMP(cpu->EAX, cpu->EDX);
   JUMP«JG» goto LAB_LOC_7;
   INST_MOVZX(cpu->EDX, MEM_WORD(cpu->DS*SEGM + cpu->BP + 0xa));
   INST_CMP(cpu->EAX, cpu->EDX);
   JUMP«JL» goto LAB_LOC_7;
   INST_XCHG(cpu->EAX, cpu->EBX);
   INST_SUB(cpu->EAX, cpu->EBX);
   INST_CDQ();
   INST_SHR(cpu->ECX, 0x1);
   INST_IDIV(cpu->ECX);
   cpu->ECX = cpu->EAX;
   INST_MOVZX(cpu->EAX, MEM_WORD(cpu->DS*SEGM + cpu->BP + 0x6));
   INST_SUB(cpu->EAX, cpu->EBX);
   INST_SAR(cpu->EAX, 0x1);
   INST_ADD(cpu->ECX, cpu->EAX);
   MEM_WORD(cpu->DS*SEGM + cpu->BP + 0x6) = cpu->BX;
   goto LAB_LOC_2;
   LAB_LOC_7:
   cpu->ECX = cpu->EDX;
   INST_SUB(cpu->ECX, cpu->EAX);
   INST_SAR(cpu->ECX, 0x1);
   JUMP«JZ» goto LAB_LOC_3;
   cpu->EBX = cpu->EAX;
   MEM_WORD(cpu->DS*SEGM + cpu->BP + 0x6) = cpu->BX;
   goto LAB_LOC_2;
   LAB_LOC_8:
   INST_SAR(cpu->ECX, 0x4);
   INST_XCHG(cpu->EAX, cpu->EBX);
   INST_SUB(cpu->EAX, cpu->ECX);
   MEM_WORD(cpu->DS*SEGM + cpu->BP + 0x4) = cpu->AX;
   MEM_WORD(cpu->DS*SEGM + cpu->BP + 0x6) = cpu->AX;
   goto LAB_LOC_2;
   LAB_LOC_9:
   INST_OR(MEM_WORD(cpu->DS*SEGM + cpu->BP + 0x8), 0x80);
   goto LAB_LOC_3;
   LAB_LOC_10:
   cpu->SI = cpu->BP;
   MEM_WORD(cpu->SI + 0x4) = cpu->AX;
   MEM_WORD(cpu->SI + 0x6) = cpu->AX;
   goto LAB_LOC_4;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_500b(cpu_ctx *cpu){
                              //XREF[1]:     1000:56c8(c)
   MEM_BYTE(0xea28) = 0x0;
   cpu->DI = 0x5bbc;
   cpu->CX = MEM_WORD(0x5bba);
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   INST_PUSH(cpu->DI);
   cpu->SI = MEM_WORD(cpu->DI);
   FUN_1000_5091(cpu);
   cpu->DI = 0x5bbc;
   cpu->CX = MEM_WORD(0x5bba);
   LAB_LOC_2:
   INST_PUSH(cpu->CX);
   INST_PUSH(cpu->DI);
   cpu->DI = MEM_WORD(cpu->DI);
   INST_CMP(cpu->DI, cpu->SI);
   JUMP«JZ» goto LAB_LOC_4;
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DI);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   INST_ADD(cpu->SI, 0x2);
   INST_ADD(cpu->DI, MEM_WORD(cpu->DI));
   INST_ADD(cpu->DI, 0x2);
   cpu->AX = MEM_WORD(cpu->SI + 0x2);
   INST_SUB(cpu->AX, MEM_WORD(cpu->DI + 0x2));
   INST_CMP(cpu->AX, 0x200);
   JUMP«JG» goto LAB_LOC_3;
   INST_CMP(cpu->AX, 0xfe00);
   JUMP«JL» goto LAB_LOC_3;
   cpu->AX = MEM_WORD(cpu->SI + 0x6);
   INST_SUB(cpu->AX, MEM_WORD(cpu->DI + 0x6));
   INST_CMP(cpu->AX, 0x200);
   JUMP«JG» goto LAB_LOC_3;
   INST_CMP(cpu->AX, 0xfe00);
   JUMP«JL» goto LAB_LOC_3;
   cpu->AX = MEM_WORD(cpu->SI + 0xa);
   INST_SUB(cpu->AX, MEM_WORD(cpu->DI + 0xa));
   INST_CMP(cpu->AX, 0x200);
   JUMP«JG» goto LAB_LOC_3;
   INST_CMP(cpu->AX, 0xfe00);
   JUMP«JL» goto LAB_LOC_3;
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   FUN_1000_51bd(cpu);
   goto LAB_LOC_4;

 // 1000:507f [UNDEFINED BYTES REMOVED]

   LAB_LOC_3:
                              //             1000:506d(j),1000:5074(j)
   INST_POP(cpu->DI);
   INST_POP(cpu->SI);
   LAB_LOC_4:
   INST_POP(cpu->DI);
   INST_POP(cpu->CX);
   INST_ADD(cpu->DI, 0x2);
   if (--cpu->CX != 0) goto LAB_LOC_2;
   INST_POP(cpu->DI);
   INST_POP(cpu->CX);
   INST_ADD(cpu->DI, 0x2);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
//ANALYSIS: related to colision, nop-ing it makes the cars just phase thru one another
void FUN_1000_5091(cpu_ctx *cpu){
                              //XREF[1]:     1000:501c(c)
   INST_PUSH(cpu->SI);
   cpu->DX = cpu->SI;
   INST_ADD(cpu->DX, MEM_WORD(cpu->SI));
   INST_ADD(cpu->DX, 0x2);
   cpu->SI = 0xec1b;
   INST_LODSW();
   cpu->CX = cpu->AX;
   MEM_WORD(0xea99) = 0x0;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   INST_LODSW();
   cpu->BX = cpu->AX;
   INST_SHL(cpu->BX, 0x3);
   INST_SUB(cpu->BX, cpu->AX);
   INST_SHL(cpu->BX, 0x2);
   INST_ADD(cpu->BX, cpu->DX);
   INST_LODSW();
   cpu->BP = cpu->AX;
   INST_SHL(cpu->BP, 0x3);
   INST_SUB(cpu->BP, cpu->AX);
   INST_SHL(cpu->BP, 0x2);
   INST_ADD(cpu->BP, cpu->DX);
   INST_LODSW();
   cpu->DI = cpu->AX;
   INST_SHL(cpu->DI, 0x3);
   INST_SUB(cpu->DI, cpu->AX);
   INST_SHL(cpu->DI, 0x2);
   INST_ADD(cpu->DI, cpu->DX);
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DX);
   cpu->SI = cpu->BP;
   cpu->BP = MEM_WORD(0xea99);
   cpu->EAX = MEM_DWORD(cpu->BX + 0x4);
   MEM_DWORD(cpu->DS*SEGM + cpu->BP + 0xeb5f) = cpu->EAX;
   INST_SUB(cpu->EAX, MEM_DWORD(cpu->SI + 0x4));
   cpu->ECX = MEM_DWORD(cpu->BX + 0x8);
   INST_SUB(cpu->ECX, MEM_DWORD(cpu->DI + 0x8));
   INST_SAR(cpu->EAX, 0xe);
   INST_SAR(cpu->ECX, 0xe);
   INST_IMUL(cpu->EAX, cpu->ECX);
   cpu->EDX = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->BX + 0x4);
   INST_SUB(cpu->EAX, MEM_DWORD(cpu->DI + 0x4));
   cpu->ECX = MEM_DWORD(cpu->BX + 0x8);
   INST_SUB(cpu->ECX, MEM_DWORD(cpu->SI + 0x8));
   INST_SAR(cpu->EAX, 0xe);
   INST_SAR(cpu->ECX, 0xe);
   INST_IMUL(cpu->EAX, cpu->ECX);
   INST_SUB(cpu->EDX, cpu->EAX);
   MEM_DWORD(cpu->DS*SEGM + cpu->BP + 0xea9b) = cpu->EDX;
   cpu->EAX = MEM_DWORD(cpu->BX + 0x8);
   MEM_DWORD(cpu->DS*SEGM + cpu->BP + 0xeb63) = cpu->EAX;
   INST_SUB(cpu->EAX, MEM_DWORD(cpu->DI + 0x8));
   cpu->ECX = MEM_DWORD(cpu->BX);
   INST_SUB(cpu->ECX, MEM_DWORD(cpu->SI));
   INST_SAR(cpu->EAX, 0xe);
   INST_SAR(cpu->ECX, 0xe);
   INST_IMUL(cpu->EAX, cpu->ECX);
   cpu->EDX = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->BX + 0x8);
   INST_SUB(cpu->EAX, MEM_DWORD(cpu->SI + 0x8));
   cpu->ECX = MEM_DWORD(cpu->BX);
   INST_SUB(cpu->ECX, MEM_DWORD(cpu->DI));
   INST_SAR(cpu->EAX, 0xe);
   INST_SAR(cpu->ECX, 0xe);
   INST_IMUL(cpu->EAX, cpu->ECX);
   INST_SUB(cpu->EDX, cpu->EAX);
   INST_NEG(cpu->EDX);
   MEM_DWORD(cpu->DS*SEGM + cpu->BP + 0xea9f) = cpu->EDX;
   cpu->EAX = MEM_DWORD(cpu->BX);
   MEM_DWORD(cpu->DS*SEGM + cpu->BP + 0xeb5b) = cpu->EAX;
   INST_SUB(cpu->EAX, MEM_DWORD(cpu->DI));
   cpu->ECX = MEM_DWORD(cpu->BX + 0x4);
   INST_SUB(cpu->ECX, MEM_DWORD(cpu->SI + 0x4));
   INST_SAR(cpu->EAX, 0xe);
   INST_SAR(cpu->ECX, 0xe);
   INST_IMUL(cpu->EAX, cpu->ECX);
   cpu->EDX = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->BX);
   INST_SUB(cpu->EAX, MEM_DWORD(cpu->SI));
   cpu->ECX = MEM_DWORD(cpu->BX + 0x4);
   INST_SUB(cpu->ECX, MEM_DWORD(cpu->DI + 0x4));
   INST_SAR(cpu->EAX, 0xe);
   INST_SAR(cpu->ECX, 0xe);
   INST_IMUL(cpu->EAX, cpu->ECX);
   INST_SUB(cpu->EDX, cpu->EAX);
   MEM_DWORD(cpu->DS*SEGM + cpu->BP + 0xeaa3) = cpu->EDX;
   INST_POP(cpu->DX);
   INST_POP(cpu->SI);
   INST_ADD(MEM_WORD(0xea99), 0xc);
   INST_POP(cpu->CX);
   INST_DEC(cpu->CX);
   JUMP«JNZ» goto LAB_LOC_1;
   INST_POP(cpu->SI);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_51bd(cpu_ctx *cpu){
                              //XREF[1]:     1000:507a(c)
   INST_PUSH(cpu->DI);
   INST_PUSH(cpu->SI);
   INST_ADD(cpu->DI, MEM_WORD(cpu->DI));
   cpu->CX = MEM_WORD(cpu->DI);
   INST_ADD(cpu->DI, 0x2);
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   cpu->SI = 0; //was a XOR
   cpu->BX = cpu->SI;
   cpu->ECX = 0x80000000;
   LAB_LOC_2:
   cpu->EAX = MEM_DWORD(cpu->DI);
   INST_SUB(cpu->EAX, MEM_DWORD(cpu->SI + 0xeb5b));
   INST_SAR(cpu->EAX, 0x10);
   INST_IMUL(cpu->EAX, MEM_DWORD(cpu->SI + 0xea9b));
   cpu->EDX = cpu->EAX;
   cpu->EAX = MEM_DWORD(cpu->DI + 0x4);
   INST_SUB(cpu->EAX, MEM_DWORD(cpu->SI + 0xeb5f));
   INST_SAR(cpu->EAX, 0x10);
   INST_IMUL(cpu->EAX, MEM_DWORD(cpu->SI + 0xea9f));
   INST_ADD(cpu->EDX, cpu->EAX);
   cpu->EAX = MEM_DWORD(cpu->DI + 0x8);
   INST_SUB(cpu->EAX, MEM_DWORD(cpu->SI + 0xeb63));
   INST_SAR(cpu->EAX, 0x10);
   INST_IMUL(cpu->EAX, MEM_DWORD(cpu->SI + 0xeaa3));
   INST_ADD(cpu->EDX, cpu->EAX);
   JUMP«JNS» goto LAB_LOC_9;
   INST_CMP(cpu->EDX, cpu->ECX);
   JUMP«JG» goto LAB_LOC_10;
   LAB_LOC_3:
   INST_ADD(cpu->SI, 0xc);
   INST_CMP(cpu->SI, MEM_WORD(0xea99));
   JUMP«JC» goto LAB_LOC_2;
   cpu->EAX = MEM_DWORD(cpu->BX + 0xea9b);
   INST_ADD(MEM_DWORD(cpu->DI + 0xc), cpu->EAX);
   cpu->EAX = MEM_DWORD(cpu->BX + 0xea9f);
   INST_ADD(MEM_DWORD(cpu->DI + 0x10), cpu->EAX);
   cpu->EAX = MEM_DWORD(cpu->BX + 0xeaa3);
   INST_ADD(MEM_DWORD(cpu->DI + 0x14), cpu->EAX);
   INST_POP(cpu->CX);
   INST_POP(cpu->SI);
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->CX);
   INST_PUSH(cpu->BX);
   INST_ADD(cpu->SI, MEM_WORD(cpu->SI));
   cpu->CX = MEM_WORD(cpu->SI);
   INST_ADD(cpu->SI, 0x2);
   cpu->DX = 0x7fff;
   cpu->BP = cpu->SI;
   LAB_LOC_4:
   cpu->AX = MEM_WORD(cpu->SI + 0x2);
   INST_AND(cpu->AX, cpu->AX);
   JUMP«JGE» goto LAB_LOC_5;
   INST_NEG(cpu->AX);
   LAB_LOC_5:
   cpu->BX = cpu->AX;
   cpu->AX = MEM_WORD(cpu->SI + 0x6);
   INST_AND(cpu->AX, cpu->AX);
   JUMP«JGE» goto LAB_LOC_6;
   INST_NEG(cpu->AX);
   LAB_LOC_6:
   INST_ADD(cpu->BX, cpu->AX);
   cpu->AX = MEM_WORD(cpu->SI + 0xa);
   INST_AND(cpu->AX, cpu->AX);
   JUMP«JGE» goto LAB_LOC_7;
   INST_NEG(cpu->AX);
   LAB_LOC_7:
   INST_ADD(cpu->BX, cpu->AX);
   INST_CMP(cpu->BX, cpu->DX);
   JUMP«JL» goto LAB_LOC_11;
   LAB_LOC_8:
   INST_ADD(cpu->SI, 0x1c);
   if (--cpu->CX != 0) goto LAB_LOC_4;
   cpu->SI = cpu->BP;
   INST_POP(cpu->BX);
   cpu->EAX = MEM_DWORD(cpu->BX + 0xea9b);
   INST_SAR(cpu->EAX, 0x1);
   INST_SUB(MEM_DWORD(cpu->SI + 0xc), cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->DI + 0xc), cpu->EAX);
   cpu->EAX = MEM_DWORD(cpu->BX + 0xea9f);
   INST_SAR(cpu->EAX, 0x1);
   INST_SUB(MEM_DWORD(cpu->SI + 0x10), cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->DI + 0x10), cpu->EAX);
   cpu->EAX = MEM_DWORD(cpu->BX + 0xeaa3);
   INST_SAR(cpu->EAX, 0x1);
   INST_SUB(MEM_DWORD(cpu->SI + 0x14), cpu->EAX);
   INST_ADD(MEM_DWORD(cpu->DI + 0x14), cpu->EAX);
   FUN_1000_4d96(cpu);
   LAB_LOC_9:
   INST_ADD(cpu->DI, 0x1c);
   INST_POP(cpu->CX);
   INST_DEC(cpu->CX);
   JUMP«JNZ» goto LAB_LOC_1;
   INST_POP(cpu->SI);
   INST_POP(cpu->DI);
   return;
   LAB_LOC_10:
   cpu->ECX = cpu->EDX;
   cpu->BX = cpu->SI;
   goto LAB_LOC_3;
   LAB_LOC_11:
   cpu->DX = cpu->BX;
   cpu->BP = cpu->SI;
   goto LAB_LOC_8;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_52d4(cpu_ctx *cpu){
                              //XREF[2]:     1000:5393(c),1000:53e4(c)
   cpu->AX = MEM_WORD(0xea0c);
   INST_IMUL(MEM_WORD(0xea14));
   MEM_WORD(0xea22) = cpu->AX;
   cpu->AX = MEM_WORD(0xea0e);
   INST_IMUL(MEM_WORD(0xea12));
   INST_SUB(MEM_WORD(0xea22), cpu->AX);
   cpu->AX = MEM_WORD(0xea18);
   INST_IMUL(MEM_WORD(0xea14));
   MEM_WORD(0xea1e) = cpu->AX;
   cpu->AX = MEM_WORD(0xea1a);
   INST_IMUL(MEM_WORD(0xea12));
   INST_SUB(MEM_WORD(0xea1e), cpu->AX);
   cpu->AX = MEM_WORD(0xea1a);
   INST_IMUL(MEM_WORD(0xea0c));
   MEM_WORD(0xea20) = cpu->AX;
   cpu->AX = MEM_WORD(0xea18);
   INST_IMUL(MEM_WORD(0xea0e));
   INST_SUB(MEM_WORD(0xea20), cpu->AX);
   cpu->AX = MEM_WORD(0xea10);
   INST_IMUL(MEM_WORD(0xea1e));
   cpu->BX = cpu->AX;
   cpu->CX = cpu->DX;
   cpu->AX = MEM_WORD(0xea16);
   INST_IMUL(MEM_WORD(0xea20));
   INST_ADD(cpu->AX, cpu->BX);
   INST_ADC(cpu->DX, cpu->CX);
   INST_IDIV(MEM_WORD(0xea22));
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_532e(cpu_ctx *cpu){
                              //XREF[1]:     1000:4910(c)
   MEM_WORD(0xea1c) = cpu->CX;
   MEM_WORD(0xea0c) = 0x80;
   MEM_WORD(0xea0e) = 0x0;
   MEM_WORD(0xea12) = 0x0;
   MEM_WORD(0xea14) = 0x80;
   INST_SHR(cpu->AL, 0x1);
   INST_SHR(cpu->BL, 0x1);
   cpu->CL = cpu->AL;
   INST_ADD(cpu->CL, cpu->BL);
   INST_CMP(cpu->CL, 0x80);
   JUMP«JA» goto LAB_LOC_1;
   MEM_BYTE(0xea18) = cpu->AL;
   MEM_BYTE(0xea1a) = cpu->BL;
   cpu->BL = cpu->AH;
   cpu->AL = MEM_BYTE(cpu->FS*SEGM + cpu->BX);
   MEM_BYTE(0xea28) = cpu->AL;
   INST_MOVZX(cpu->AX, MEM_BYTE(cpu->GS*SEGM + cpu->BX));
   INST_SHL(cpu->AX, 0x4);
   cpu->CX = cpu->AX;
   INST_MOVZX(cpu->AX, MEM_BYTE(cpu->GS*SEGM + cpu->BX + 0x1));
   INST_SHL(cpu->AX, 0x4);
   INST_SUB(cpu->AX, cpu->CX);
   MEM_WORD(0xea10) = cpu->AX;
   MEM_WORD(0xea24) = cpu->AX;
   INST_MOVZX(cpu->AX, MEM_BYTE(cpu->GS*SEGM + cpu->BX + 0x100));
   INST_SHL(cpu->AX, 0x4);
   INST_SUB(cpu->AX, cpu->CX);
   MEM_WORD(0xea16) = cpu->AX;
   MEM_WORD(0xea26) = cpu->AX;
   INST_PUSH(cpu->CX);
   FUN_1000_52d4(cpu);
   INST_POP(cpu->CX);
   INST_ADD(cpu->AX, cpu->CX);
   goto LAB_LOC_2;
   LAB_LOC_1:
   INST_NEG(cpu->AL);
   INST_NEG(cpu->BL);
   INST_ADD(cpu->AL, 0x80);
   INST_ADD(cpu->BL, 0x80);
   MEM_BYTE(0xea18) = cpu->AL;
   MEM_BYTE(0xea1a) = cpu->BL;
   cpu->BL = cpu->AH;
   cpu->AL = MEM_BYTE(cpu->FS*SEGM + cpu->BX);
   MEM_BYTE(0xea28) = cpu->AL;
   INST_MOVZX(cpu->AX, MEM_BYTE(cpu->GS*SEGM + cpu->BX + 0x101));
   INST_SHL(cpu->AX, 0x4);
   cpu->CX = cpu->AX;
   INST_MOVZX(cpu->AX, MEM_BYTE(cpu->GS*SEGM + cpu->BX + 0x1));
   INST_SHL(cpu->AX, 0x4);
   INST_SUB(cpu->AX, cpu->CX);
   MEM_WORD(0xea16) = cpu->AX;
   INST_NEG(cpu->AX);
   MEM_WORD(0xea26) = cpu->AX;
   INST_MOVZX(cpu->AX, MEM_BYTE(cpu->GS*SEGM + cpu->BX + 0x100));
   INST_SHL(cpu->AX, 0x4);
   INST_SUB(cpu->AX, cpu->CX);
   MEM_WORD(0xea10) = cpu->AX;
   INST_NEG(cpu->AX);
   MEM_WORD(0xea24) = cpu->AX;
   INST_PUSH(cpu->CX);
   FUN_1000_52d4(cpu);
   INST_POP(cpu->CX);
   INST_ADD(cpu->AX, cpu->CX);
   LAB_LOC_2:
   return;


}

void dummy_ifunc(cpu_ctx *cpu){
   INST_IRET();


}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_timer_5680(cpu_ctx *cpu){
   INST_PUSHAD();
   INST_PUSH(cpu->DS);
   INST_PUSH(cpu->ES);
   INST_PUSH(cpu->FS);
   INST_PUSH(cpu->GS);
   cpu->AX = def_datareg;
   cpu->DS = cpu->AX;
   cpu->ES = cpu->AX;
   INST_CMP(MEM_BYTE(0x6e), 0x1);
   JUMP«JNZ» goto LAB_LOC_2;
   cpu->FS = MEM_WORD(0x1a47);
   cpu->GS = MEM_WORD(0x1a45);
   cpu->DI = 0x5bbc;
   cpu->CX = MEM_WORD(0x5bba); //= 0001h
   cpu->BP = 0x5ad9;
   LAB_LOC_1:
                              // FWD[2]:     15cd:5bbc(R),15cd:5bbe(R)
   cpu->SI = MEM_WORD(cpu->DI); // =>0x5bbc
   INST_PUSH(cpu->CX);
   INST_PUSH(cpu->DI);
   INST_PUSH(cpu->BP);
   cpu->DI = cpu->BP;
   FUN_1000_0d2a(cpu);
   FUN_1000_1004(cpu);
   FUN_1000_48d0(cpu);
   INST_POP(cpu->BP);
   INST_POP(cpu->DI);
   INST_POP(cpu->CX);
   INST_ADD(cpu->DI, 0x2);
   INST_ADD(cpu->BP, 0x6);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   FUN_1000_500b(cpu);
   FUN_1000_0bb5(cpu);
   FUN_1000_0a3b(cpu);
   LAB_LOC_2:
   INST_POP(cpu->GS);
   INST_POP(cpu->FS);
   INST_POP(cpu->ES);
   INST_POP(cpu->DS);
   INST_POPAD();
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_keyboard_56df(cpu_ctx *cpu){

   cpu->BX = def_datareg;
   cpu->DS = cpu->BX;

   cpu->BL = cpu->AL;
   INST_AND(cpu->BX, 0x7f);
   INST_AND(cpu->AL, 0x80);
   JUMP«JNS» goto LAB_LOC_1;
   CSD_DAT_keys_571e[cpu->BX] = 0xff;
   CSD_DAT_keys_571e[0] = 0x0;
   return;

   LAB_LOC_1:
   INST_AND(CSD_DAT_keys_571e[cpu->BX], 0x7f);
   CSD_DAT_keys_571e[0] = cpu->BL;
   return;

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_int_f1_579e(cpu_ctx *cpu){
   INST_CMP(cpu->AL, 0x0);
   JUMP«JZ» goto LAB_LOC_1;
   INST_CMP(cpu->AL, 0x1);
   JUMP«JZ» goto LAB_LOC_2;
   INST_CMP(cpu->AL, 0x2);
   JUMP«JZ» goto LAB_LOC_3;
   INST_CMP(cpu->AL, 0x10);
   JUMP«JZ» goto LAB_LOC_4;
   INST_CMP(cpu->AL, 0x11);
   JUMP«JZ» goto LAB_LOC_5;
   INST_IRET();
   LAB_LOC_1:
   FUN_1000_2aad(cpu);
   INST_IRET();
   LAB_LOC_2:
   FUN_1000_2ad8(cpu);
   INST_IRET();
   LAB_LOC_3:
   cpu->AX = cpu->CX;
   FUN_1000_2b08(cpu);
   INST_IRET();
   LAB_LOC_4:
   cpu->AX = cpu->DX;
   FUN_1000_271d(cpu);
   INST_IRET();
   LAB_LOC_5:
   cpu->EAX = cpu->EDX;
   FUN_1000_2726(cpu);
   INST_IRET();

 // 1000:57df [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_57e0(cpu_ctx *cpu){
                              //XREF[1]:     1000:022c(c)
   cpu->AX = 0x120;
   FUN_1000_58fc(cpu);
   cpu->AX = 0x800;
   FUN_1000_58fc(cpu);
   cpu->AX = 0xbdc0;
   FUN_1000_58fc(cpu);
   cpu->AX = 0xb000;
   LAB_LOC_1:
   INST_PUSH(cpu->AX);
   FUN_1000_58fc(cpu);
   INST_POP(cpu->AX);
   INST_INC(cpu->AH);
   INST_CMP(cpu->AH, 0xb8);
   JUMP«JBE» goto LAB_LOC_1;
   cpu->AL = 0x0;
   cpu->SI = 0xecb8;
   FUN_1000_589b(cpu);
   cpu->AL = 0x1;
   cpu->SI = 0xecb8;
   FUN_1000_589b(cpu);
   cpu->AX = 0x443f;
   FUN_1000_58fc(cpu);
   cpu->CX = 0xf00;
   cpu->AL = cpu->CL;
   cpu->AH = 0xa1;
   FUN_1000_58fc(cpu);
   cpu->AL = cpu->CH;
   INST_OR(cpu->AL, 0x20);
   cpu->AH = 0xb1;
   FUN_1000_58fc(cpu);
   // unknown ->
   // unknown ->MOVAX,
   return;

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_5831(cpu_ctx *cpu){
   cpu->CH = cpu->AL;
   cpu->DX = 0x388;
   cpu->AL = cpu->BL;
   cpu->AH = 0xa0;
   INST_ADD(cpu->AH, cpu->CH);
   FUN_1000_58fc(cpu);
   cpu->AL = cpu->BH;
   INST_OR(cpu->AL, 0x20);
   cpu->AH = 0xb0;
   INST_ADD(cpu->AH, cpu->CH);
   FUN_1000_58fc(cpu);
   cpu->AL = 0x3f;
   INST_SUB(cpu->AL, cpu->CL);
   INST_CMP(cpu->AL, 0x3f);
   JUMP«JBE» goto LAB_LOC_1;
   cpu->AL = 0x3f;
   LAB_LOC_1:
   cpu->AH = 0x43;
   INST_MOVZX(cpu->BX, cpu->CH);
   INST_ADD(cpu->AH, CSD_DAT_unk_592c[cpu->BX]);
   FUN_1000_58fc(cpu);
   return;

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_5864(cpu_ctx *cpu){
                              //XREF[1]:     1000:4abf(c)
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->DX);
   cpu->DX = 0x388;
   INST_SHL(cpu->AX, 0x4);
   cpu->SI = 0xecd9;
   INST_ADD(cpu->SI, cpu->AX);
   cpu->AX = 0xb800;
   FUN_1000_58fc(cpu);
   cpu->AL = 0x8;
   FUN_1000_589b(cpu);
   INST_LODSB();
   cpu->AH = 0xa8;
   FUN_1000_58fc(cpu);
   INST_LODSB();
   cpu->AH = 0xb8;
   FUN_1000_58fc(cpu);
   INST_POP(cpu->DX);
   INST_POP(cpu->SI);
   return;

}

void FUN_dummy_1000_588b(cpu_ctx *cpu){
   INST_UD2();
   return;


}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_589b(cpu_ctx *cpu){
                              //XREF[3]:     1000:5806(c),1000:580e(c),1000:5879(c)
   INST_MOVZX(cpu->BX, cpu->AL);
   cpu->BL = CSD_DAT_unk_592c[cpu->BX];
   cpu->AH = 0x20;
   INST_ADD(cpu->AH, cpu->BL);
   INST_LODSB();
   FUN_1000_58fc(cpu);
   cpu->AH = 0x40;
   INST_ADD(cpu->AH, cpu->BL);
   INST_LODSB();
   FUN_1000_58fc(cpu);
   cpu->AH = 0x60;
   INST_ADD(cpu->AH, cpu->BL);
   INST_LODSB();
   FUN_1000_58fc(cpu);
   cpu->AH = 0x80;
   INST_ADD(cpu->AH, cpu->BL);
   INST_LODSB();
   FUN_1000_58fc(cpu);
   cpu->AH = 0xe0;
   INST_ADD(cpu->AH, cpu->BL);
   INST_LODSB();
   FUN_1000_58fc(cpu);
   cpu->AH = 0x23;
   INST_ADD(cpu->AH, cpu->BL);
   INST_LODSB();
   FUN_1000_58fc(cpu);
   cpu->AH = 0x43;
   INST_ADD(cpu->AH, cpu->BL);
   INST_LODSB();
   FUN_1000_58fc(cpu);
   cpu->AH = 0x63;
   INST_ADD(cpu->AH, cpu->BL);
   INST_LODSB();
   FUN_1000_58fc(cpu);
   cpu->AH = 0x83;
   INST_ADD(cpu->AH, cpu->BL);
   INST_LODSB();
   FUN_1000_58fc(cpu);
   cpu->AH = 0xe3;
   INST_ADD(cpu->AH, cpu->BL);
   INST_LODSB();
   FUN_1000_58fc(cpu);
   cpu->AH = 0xc0;
   INST_ADD(cpu->AH, cpu->BL);
   INST_LODSB();
   FUN_1000_58fc(cpu);
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_58fc(cpu_ctx *cpu){
                              //XREF[21]:    1000:57e3(c),1000:57e9(c),1000:57ef(c),1000:57f6(c),
                              //             1000:5814(c),1000:581e(c),1000:5827(c),1000:5874(c),
                              //             1000:587f(c),1000:5885(c),1000:58a8(c),1000:58b0(c),
                              //             1000:58b8(c),1000:58c0(c),1000:58c8(c),1000:58d0(c),
                              //             1000:58d8(c),1000:58e0(c),1000:58e8(c),1000:58f0(c),
                              //             1000:58f8(c)
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);

    //TODO actually do something with AX

   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   return;

 // 1000:592b [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_5940_render_text(cpu_ctx *cpu){
                              //XREF[2]:     1000:04e6(c),1000:04f4(c)
   CSD_BYTE_1000_59c1 = cpu->CL; //= Fh
   cpu->CX = cpu->AX;
   INST_CLD();
   LAB_LOC_1:
   INST_LODSB();
   INST_CMP(cpu->AL, 0x0);
   JUMP«JNZ» goto LAB_LOC_2;
   return;
   LAB_LOC_2:
   INST_CMP(cpu->AL, 0x9);
   JUMP«JNZ» goto LAB_LOC_3;
   INST_ADD(cpu->CX, 0x14);
   goto LAB_LOC_1;
   LAB_LOC_3:
   INST_CMP(cpu->AL, 0xd);
   JUMP«JNZ» goto LAB_LOC_4;
   return;
   LAB_LOC_4:
   INST_CMP(cpu->AL, 0x1b);
   JUMP«JNZ» goto LAB_LOC_5;
   INST_LODSB();
   CSD_BYTE_1000_59c1 = cpu->AL; //= Fh
   goto LAB_LOC_1;
   LAB_LOC_5:
   INST_CMP(cpu->AL, 0x20);
   JUMP«JNZ» goto LAB_LOC_6;
   INST_ADD(cpu->CX, 0x5);
   goto LAB_LOC_1;
   LAB_LOC_6:
   INST_PUSH(cpu->SI);
   INST_PUSH(cpu->BX);
   cpu->SI = 0xed17;
   INST_SUB(cpu->AH, cpu->AH);
   INST_ADD(cpu->AX, cpu->AX);
   cpu->BX = cpu->AX;
   INST_ADD(cpu->SI, MEM_WORD(cpu->BX + 0xed17));
   INST_ADD(cpu->SI, 0x100);
   INST_POP(cpu->BX);
   cpu->AX = cpu->CX;
   LAB_LOC_7:
   INST_PUSH(cpu->BX);
   cpu->DL = MEM_BYTE(cpu->SI);
   INST_TEST(cpu->DL, cpu->DL);
   JUMP«JZ» goto LAB_LOC_11;
   LAB_LOC_8:
   INST_SHR(cpu->DL, 0x1);
   JUMP«JC» goto LAB_LOC_9;
   JUMP«JZ» goto LAB_LOC_10;
   INST_INC(cpu->BX);
   goto LAB_LOC_8;
   LAB_LOC_9:
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->BX);
   cpu->CL = CSD_BYTE_1000_59c1; //= Fh
   FUN_1000_3f98(cpu);
   INST_POP(cpu->BX);
   INST_POP(cpu->AX);
   INST_INC(cpu->BX);
   goto LAB_LOC_8;
   LAB_LOC_10:
   INST_POP(cpu->BX);
   INST_INC(cpu->AX);
   INST_INC(cpu->SI);
   goto LAB_LOC_7;
   LAB_LOC_11:
   INST_POP(cpu->BX);
   INST_POP(cpu->SI);
   cpu->CX = cpu->AX;
   INST_INC(cpu->CX);
   goto LAB_LOC_1;

 // 1000:5a5f [UNDEFINED BYTES REMOVED]

}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_5a60(cpu_ctx *cpu){
                              //XREF[3]:     1000:24ca(c),1000:24da(c),1000:2566(c)
   cpu->DX = cpu->DX;
   cpu->AL = 0x0;
   cpu->AH = 0x3d;
   DOS3Call(cpu);
   cpu->BX = cpu->AX;
   JUMP«JC» goto LAB_LOC_1;
   FUN_1000_5a95(cpu);
   JUMP«JC» goto LAB_LOC_1;
   cpu->CX = 0x0;
   cpu->DX = 0x80;
   cpu->AX = 0x4200;
   DOS3Call(cpu);
   JUMP«JC» goto LAB_LOC_1;
   FUN_1000_5acf(cpu);
   JUMP«JC» goto LAB_LOC_1;
   cpu->AH = 0x3e;
   DOS3Call(cpu);
   JUMP«JC» goto LAB_LOC_1;
   return;
   LAB_LOC_1:
                              //             1000:5a8f(j)
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_5a95(cpu_ctx *cpu){
                              //XREF[3]:     1000:01d3(c),1000:24ec(c),1000:5a6e(c)
   cpu->DX = 0xef88;
   cpu->CX = 0x80;
   cpu->AH = 0x3f;
   DOS3Call(cpu);
   JUMP«JC» goto LAB_LOC_1;
   cpu->AX = MEM_WORD(0xef90);
   INST_SUB(cpu->AX, MEM_WORD(0xef8c));
   INST_INC(cpu->AX);
   MEM_WORD(0xef80) = cpu->AX;
   cpu->CX = MEM_WORD(0xef92);
   INST_SUB(cpu->CX, MEM_WORD(0xef8e));
   INST_INC(cpu->CX);
   MEM_WORD(0xef82) = cpu->CX;
   INST_CMP(MEM_BYTE(0xef8b), 0x8);
   JUMP«JNZ» goto LAB_LOC_1;
   INST_CMP(MEM_BYTE(0xefc9), 0x1);
   JUMP«JNZ» goto LAB_LOC_1;
   return;
   LAB_LOC_1:
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_5acf(cpu_ctx *cpu){
                              //XREF[3]:     1000:01ff(c),1000:251d(c),1000:5a84(c)
   INST_CLD();
   cpu->DX = 0xf008;
   cpu->SI = 0xf308;
   cpu->AX = 0x0;
   cpu->CX = MEM_WORD(0xef82);
   INST_CMP(cpu->CX, 0x100);
   JUMP«JLE» goto LAB_LOC_1;
   cpu->CX = 0x100;
   LAB_LOC_1:
   INST_PUSH(cpu->CX);
   cpu->CX = 0; //was a XOR
   LAB_LOC_2:
   INST_AND(cpu->AH, cpu->AH);
   JUMP«JZ» goto LAB_LOC_3;
   INST_DEC(cpu->AH);
   goto LAB_LOC_4;

 // 1000:5af5 [UNDEFINED BYTES REMOVED]

   LAB_LOC_3:
   FUN_1000_5b26(cpu);
   cpu->AH = cpu->AL;
   INST_AND(cpu->AH, 0xc0);
   INST_CMP(cpu->AH, 0xc0);
//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
   WHY_1000_5b01: // this is never called as a function, but it was labeled as one
                              //XREF[3]:     1000:0327(c),1000:03f3(c),1000:04b3(c)
   cpu->AH = 0x0;
   JUMP«JNZ» goto LAB_LOC_4;
   cpu->AH = cpu->AL;
   INST_AND(cpu->AH, 0x3f);
   FUN_1000_5b26(cpu);
   INST_DEC(cpu->AH);
   LAB_LOC_4:
   INST_CMP(cpu->CX, 0x100);
   JUMP«JNC» goto LAB_LOC_5;
   INST_STOSB();
   LAB_LOC_5:
   INST_INC(cpu->CX);
   INST_CMP(cpu->CX, MEM_WORD(0xef80));
   JUMP«JC» goto LAB_LOC_2;
   INST_POP(cpu->CX);
   if (--cpu->CX != 0) goto LAB_LOC_1;
   INST_CLC();
   return;
}

//************************************************************************************************
//*                                           FUNCTION                                           *
//************************************************************************************************
void FUN_1000_5b26(cpu_ctx *cpu){
                              //XREF[2]:     1000:5af6(c),1000:5b0c(c)
   INST_CMP(cpu->SI, 0xf308);
   JUMP«JNZ» goto LAB_LOC_1;
   INST_PUSH(cpu->AX);
   INST_PUSH(cpu->CX);
   cpu->CX = 0x300;
   cpu->DX = 0xf008;
   cpu->CX = cpu->CX;
   cpu->AH = 0x3f;
   DOS3Call(cpu);
   INST_POP(cpu->CX);
   INST_POP(cpu->AX);
   cpu->SI = 0xf008;
   LAB_LOC_1:
   INST_LODSB();
   return;

 // 1000:5cce [UNDEFINED BYTES REMOVED]

//FIM:

}