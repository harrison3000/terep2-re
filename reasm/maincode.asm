;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
entry:
                              ;XREF[1]:     Entry Point(*)
    CLI
    IN          AL,0x21
    PUSH        AX  ; =>0xf70e                ;= 6B63h
    MOV         AL,0xff
    OUT         0x21,AL
    MOV         CX,SS
    MOV         DX,SP
    MOV         AX,CS
    MOV         SS,AX
    MOV         SP,0x1e
    MOV         SS,CX
    MOV         SP,DX
    POP         AX  ; =>0xf70e                ;= 6B63h
    OUT         0x21,AL
    STI
    JMP         LAB_1000_0046

 ; 1000:001d [UNDEFINED BYTES REMOVED]

LAB_1000_001e:                ;XREF[6]:     1000:0149(j),1000:0159(j),1000:0169(j),1000:0177(j),
                              ;             1000:021f(j),1000:0654(j)
    MOV         AX,0x4c00
    INT         0x21
    UD2

 ; 1000:0045 [UNDEFINED BYTES REMOVED]

LAB_1000_0046:                ;XREF[1]:     1000:001b(j)
    MOV         BX,0x3000
    NOP
    MOV         AX,DS
    SUB         BX,AX
    MOV         AH,0x4a
    INT         0x21
    MOV         AX,0x15cd
    MOV         DS,AX
    MOV         word [0x0073],F_0693  ;= 0693h
    MOV         word [0x0075],F_073f  ;= 073Fh
    MOV         word [0x0077],F_0828  ;= 0828h
    MOV         word [0x0079],F_0893  ;= 0893h
    MOV         word [0x007b],F_0948  ;= 0948h
    JMP         LAB_1000_00dc

 ; 1000:00db [UNDEFINED BYTES REMOVED]

LAB_1000_00dc:                ;XREF[1]:     1000:0075(j)
    MOV         word [0xec50],0x78    ;= 00C8h
    MOV         dword [0x006a],0x1800 ;= 00000C00h
    MOV         word [0xe9e2],0x800   ;= 0320h
    MOV         word [0xe9e4],0xf000  ;= F000h
    MOV         word [0xdbc0],0x0
    MOV         word [0xdbb8],0xa0    ;= 00A0h
    MOV         word [0xdbc2],0x13f   ;= 013Fh
    MOV         word [0xdbbc],0x0
    MOV         word [0xdbba],0x50    ;= 0064h
    MOV         word [0xdbbe],0xc7    ;= 00C7h
    MOV         DX,0x1a3d
    MOV         AL,0x0
    MOV         AH,0x3d
    INT         0x21
    MOV         BX,AX
    JC          LAB_1000_0142
    NOP
    NOP
    MOV         DX,0xe9e2
    MOV         CX,0x2
    MOV         AH,0x3f
    INT         0x21
    MOV         DX,0xe9e4
    MOV         CX,0x2
    MOV         AH,0x3f
    INT         0x21
    MOV         AH,0x3e
    INT         0x21
LAB_1000_0142:                ;XREF[1]:     1000:0126(j)
    MOV         AH,0x48
    MOV         BX,0x1000
    INT         0x21
    JC          LAB_1000_001e
    MOV         [0x1a45],AX
    MOV         GS,AX
    MOV         AH,0x48
    MOV         BX,0x1000
    INT         0x21
    JC          LAB_1000_001e
    MOV         [0x1a47],AX
    MOV         FS,AX
    MOV         AH,0x48
    MOV         BX,0x1000
    INT         0x21
    JC          LAB_1000_001e
    MOV         [0x1a49],AX
    MOV         AH,0x48
    MOV         BX,0x1000
    INT         0x21
    JC          LAB_1000_001e
    MOV         [0x1a4b],AX
    CALL        FUN_1000_24c0
    CALL        FUN_1000_255c
    MOV         word [0x5bba],0x0     ;= 0001h
    MOV         DI,0x5bd0
    MOV         word [0x5bbc],DI
    XOR         SI,SI
LAB_1000_0193:                ;XREF[1]:     1000:0219(j)
    MOV         DI,word [SI + 0x5bbc]
    MOV         AX,SI
    NEG         AX
    SHL         AX,0x7
    ADD         AX,0x8000
    MOV         BX,0x7a00
    MOV         DX,word [SI + 0x5af7] ;= 5B01h
    PUSH        SI
    CALL        FUN_1000_2454
    POP         SI
    JC          LAB_1000_021c
    NOP
    NOP
    PUSH        AX
    PUSH        DI
    PUSH        SI
    MOV         SI,word [SI + 0x5bbc]
    CALL        FUN_1000_2431
    POP         SI
    POP         DI
    POP         AX
    PUSH        AX
    PUSH        DI
    PUSH        SI
    MOV         DX,word [SI + 0x5b2e]
    MOV         DX,DX
    MOV         AL,0x0
    MOV         AH,0x3d
    INT         0x21
    MOV         BX,AX
    JC          LAB_1000_0206
    NOP
    NOP
    CALL        FUN_1000_5a95
    PUSH        BX
    CMP         AX,0x100
    JLE         LAB_1000_01e1
    NOP
    NOP
    MOV         AX,0x100
LAB_1000_01e1:                ;XREF[1]:     1000:01da(j)
    MUL         CX
    SHR         AX,0x4
    INC         AX
    MOV         BX,AX
    MOV         AH,0x48
    INT         0x21
    POP         BX
    JC          LAB_1000_0202
    NOP
    NOP
    POP         SI
    PUSH        SI
    MOV         DI,word [SI + 0x5bbc]
    MOV         word [DI + 0x1e],AX
    MOV         ES,AX
    XOR         DI,DI
    CALL        FUN_1000_5acf
LAB_1000_0202:                ;XREF[1]:     1000:01ee(j)
    MOV         AH,0x3e
    INT         0x21
LAB_1000_0206:                ;XREF[1]:     1000:01cf(j)
    POP         SI
    POP         DI
    POP         AX
    INC         word [0x5bba]         ;= 0001h
    MOV         DI,word [SI + 0x5bbc]
    ADD         DI,AX
    INC         SI
    INC         SI
    MOV         word [SI + 0x5bbc],DI
    JMP         LAB_1000_0193
LAB_1000_021c:                ;XREF[1]:     1000:01ad(j)
    CALL        FUN_1000_2b70
    JC          LAB_1000_001e
    MOV         SI,0x1a4d
    CALL        FUN_1000_2bc1
    CALL        fun_setup_interrupts
    CALL        FUN_1000_57e0
    MOV         word [0x006f],DX
    MOV         [0x0071],AX
    JMP         LAB_1000_0252

 ; 1000:0251 [UNDEFINED BYTES REMOVED]

LAB_1000_0252:                ;XREF[1]:     1000:0236(j)
    MOV         byte [0x006e],0x1
    NOP
LAB_1000_0258:                ;XREF[2]:     1000:05a9(j),1000:05b2(j)
    TEST        byte [0x007d],0xff
    NOP
    JNZ         LAB_1000_032e
    MOV         word [0xdbc0],0x0
    MOV         word [0xdbb8],0xa0    ;= 00A0h
    MOV         word [0xdbc2],0x13f   ;= 013Fh
    MOV         word [0xdbbc],0x0
    MOV         word [0xdbba],0x50    ;= 0064h
    MOV         word [0xdbbe],0xc7    ;= 00C7h
    MOV         SI,word [0x00a4]
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5bbc]
    MOVZX       BX,byte [0x007e]      ;= 03h
    SHL         BX,0x1
    MOV         DI,0x80
                              ; FWD[2]:     1000:0893(c),15cd:0079(R)
    CALL        word [BX + 0x73]  ; =>CODE_1:DAT_15cd...;undefined F_0893()
                                                        ;= 0893h
    MOV         BX,word [0x00c6]
    CALL        FUN_1000_2aad
    SAR         AX,0x7
    MOV         [0x05f7],AX
    CALL        FUN_1000_2ad8
    SAR         AX,0x7
    MOV         [0x05f9],AX
    MOV         SI,0xc2
    MOV         DI,0xce
    CALL        FUN_1000_2989
    CALL        FUN_1000_27f1
    MOV         EAX,0xffffffff
    CALL        FUN_1000_2b98
    CALL        FUN_1000_1965
    CALL        FUN_1000_0b25
    MOV         SI,word [0x00a4]
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5bbc]
    MOV         CX,word [SI + 0x8]
    MOV         EAX,dword [SI + 0x42]
    ADD         EAX,dword [SI + 0x46]
    SAR         EAX,0xe
    MOV         EBX,dword [SI + 0x4a]
    ADD         EBX,dword [SI + 0x4e]
    SAR         EBX,0xe
    TEST        CX,CX
    JZ          LAB_1000_0308
    NOP
    NOP
    DEC         CX
    JZ          LAB_1000_0305
    NOP
    NOP
    ADD         EAX,EBX
    SAR         EAX,0x1
LAB_1000_0305:                ;XREF[1]:     1000:02fb(j)
    MOV         EBX,EAX
LAB_1000_0308:                ;XREF[1]:     1000:02f6(j)
    AND         BX,BX
    JGE         LAB_1000_0310
    NOP
    NOP
    NEG         BX
LAB_1000_0310:                ;XREF[1]:     1000:030a(j)
    ADD         BX,0x1030
    MOV         CX,word [SI + 0xc]
    SAR         CX,0x9
    AND         CX,CX
    JGE         LAB_1000_0322
    NOP
    NOP
    NEG         CX
LAB_1000_0322:                ;XREF[1]:     1000:031c(j)
    ADD         CX,0x2c
    MOV         AL,0x0
                              ; FWD[2]:     1000:5b01(c),15cd:006f(R)
    CALL        word [0x006f]
    JMP         LAB_1000_04b7
LAB_1000_032e:                ;XREF[1]:     1000:025e(j)
    MOV         word [0xdbc0],0x0
    MOV         word [0xdbb8],0xa0    ;= 00A0h
    MOV         word [0xdbc2],0x13f   ;= 013Fh
    MOV         word [0xdbbc],0x0
    MOV         word [0xdbba],0x32    ;= 0064h
    MOV         word [0xdbbe],0x62    ;= 00C7h
    MOV         SI,word [0x00a4]
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5bbc]
    MOVZX       BX,byte [0x007e]      ;= 03h
    SHL         BX,0x1
    MOV         DI,0x80
                              ; FWD[2]:     1000:0893(c),15cd:0079(R)
    CALL        word [BX + 0x73]  ; =>CODE_1:DAT_15cd...;undefined F_0893()
                                                        ;= 0893h
    MOV         BX,word [0x00c6]
    CALL        FUN_1000_2aad
    SAR         AX,0x7
    MOV         [0x05f7],AX
    CALL        FUN_1000_2ad8
    SAR         AX,0x7
    MOV         [0x05f9],AX
    MOV         SI,0xc2
    MOV         DI,0xce
    CALL        FUN_1000_2989
    CALL        FUN_1000_27f1
    MOV         EAX,0xffffffff
    CALL        FUN_1000_2b98
    CALL        FUN_1000_1965
    CALL        FUN_1000_0b25
    MOV         SI,word [0x00a4]
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5bbc]
    MOV         CX,word [SI + 0x8]
    MOV         EAX,dword [SI + 0x42]
    ADD         EAX,dword [SI + 0x46]
    SAR         EAX,0xe
    MOV         EBX,dword [SI + 0x4a]
    ADD         EBX,dword [SI + 0x4e]
    SAR         EBX,0xe
    TEST        CX,CX
    JZ          LAB_1000_03d4
    NOP
    NOP
    DEC         CX
    JZ          LAB_1000_03d1
    NOP
    NOP
    ADD         EAX,EBX
    SAR         EAX,0x1
LAB_1000_03d1:                ;XREF[1]:     1000:03c7(j)
    MOV         EBX,EAX
LAB_1000_03d4:                ;XREF[1]:     1000:03c2(j)
    AND         BX,BX
    JGE         LAB_1000_03dc
    NOP
    NOP
    NEG         BX
LAB_1000_03dc:                ;XREF[1]:     1000:03d6(j)
    ADD         BX,0x1030
    MOV         CX,word [SI + 0xc]
    SAR         CX,0x9
    AND         CX,CX
    JGE         LAB_1000_03ee
    NOP
    NOP
    NEG         CX
LAB_1000_03ee:                ;XREF[1]:     1000:03e8(j)
    ADD         CX,0x2c
    MOV         AL,0x0
                              ; FWD[2]:     1000:5b01(c),15cd:006f(R)
    CALL        word [0x006f]
    MOV         word [0xdbc0],0x0
    MOV         word [0xdbb8],0xa0    ;= 00A0h
    MOV         word [0xdbc2],0x13f   ;= 013Fh
    MOV         word [0xdbbc],0x64
    MOV         word [0xdbba],0x96    ;= 0064h
    MOV         word [0xdbbe],0xc7    ;= 00C7h
    MOV         SI,word [0x00a6]
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5bbc]
    MOVZX       BX,byte [0x007f]      ;= 03h
    SHL         BX,0x1
    MOV         DI,0x92
                              ; FWD[2]:     1000:0893(c),15cd:0079(R)
    CALL        word [BX + 0x73]  ; =>CODE_1:DAT_15cd...;undefined F_0893()
                                                        ;= 0893h
    MOV         BX,word [0x00c6]
    CALL        FUN_1000_2aad
    SAR         AX,0x7
    MOV         [0x05f7],AX
    CALL        FUN_1000_2ad8
    SAR         AX,0x7
    MOV         [0x05f9],AX
    MOV         SI,0xc2
    MOV         DI,0xce
    CALL        FUN_1000_2989
    CALL        FUN_1000_27f1
    CALL        FUN_1000_1965
    CALL        FUN_1000_0b25
    MOV         SI,word [0x00a6]
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5bbc]
    MOV         CX,word [SI + 0x8]
    MOV         EAX,dword [SI + 0x42]
    ADD         EAX,dword [SI + 0x46]
    SAR         EAX,0xe
    MOV         EBX,dword [SI + 0x4a]
    ADD         EBX,dword [SI + 0x4e]
    SAR         EBX,0xe
    TEST        CX,CX
    JZ          LAB_1000_0494
    NOP
    NOP
    DEC         CX
    JZ          LAB_1000_0491
    NOP
    NOP
    ADD         EAX,EBX
    SAR         EAX,0x1
LAB_1000_0491:                ;XREF[1]:     1000:0487(j)
    MOV         EBX,EAX
LAB_1000_0494:                ;XREF[1]:     1000:0482(j)
    AND         BX,BX
    JGE         LAB_1000_049c
    NOP
    NOP
    NEG         BX
LAB_1000_049c:                ;XREF[1]:     1000:0496(j)
    ADD         BX,0x1030
    MOV         CX,word [SI + 0xc]
    SAR         CX,0x9
    AND         CX,CX
    JGE         LAB_1000_04ae
    NOP
    NOP
    NEG         CX
LAB_1000_04ae:                ;XREF[1]:     1000:04a8(j)
    ADD         CX,0x2c
    MOV         AL,0x1
                              ; FWD[2]:     1000:5b01(c),15cd:006f(R)
    CALL        word [0x006f]
LAB_1000_04b7:                ;XREF[1]:     1000:032b(j)
    MOV         word [0xdbc0],0x0
    MOV         word [0xdbb8],0xa0    ;= 00A0h
    MOV         word [0xdbc2],0x13f   ;= 013Fh
    MOV         word [0xdbbc],0x0
    MOV         word [0xdbba],0x50    ;= 0064h
    MOV         word [0xdbbe],0xc7    ;= 00C7h
    MOV         SI,0x0
    MOV         AX,0xa
    MOV         BX,0xa
    MOV         CL,0xf
    CALL        FUN_1000_5940
    MOV         SI,0x4b
    MOV         AX,0x64
    MOV         BX,0xbe
    MOV         CL,0xf
    CALL        FUN_1000_5940
    CALL        FUN_1000_2baa
    TEST        byte CS:[DAT_keys_571e + 78],0x80
    JS          LAB_1000_0513
    NOP
    NOP
    CMP         word [0x011c],0x3e8   ;= 0100h
    JG          LAB_1000_0513
    NOP
    NOP
    ADD         word [0x011c],0x14    ;= 0100h
LAB_1000_0513:                ;XREF[2]:     1000:0500(j),1000:050a(j)
    TEST        byte CS:[DAT_keys_571e + 74],0x80
    JS          LAB_1000_052b
    NOP
    NOP
    CMP         word [0x011c],0x32    ;= 0100h
    JL          LAB_1000_052b
    NOP
    NOP
    SUB         word [0x011c],0x14    ;= 0100h
LAB_1000_052b:                ;XREF[2]:     1000:0519(j),1000:0522(j)
    TEST        byte CS:[DAT_keys_571e + 53],0x80
    JS          LAB_1000_0544
    NOP
    NOP
    CMP         word [0x011e],0x1000  ;= 0400h
    JG          LAB_1000_0544
    NOP
    NOP
    ADD         word [0x011e],0x28    ;= 0400h
LAB_1000_0544:                ;XREF[2]:     1000:0531(j),1000:053b(j)
    TEST        byte CS:[DAT_keys_571e + 55],0x80
    JS          LAB_1000_055d
    NOP
    NOP
    CMP         word [0x011e],0x100   ;= 0400h
    JL          LAB_1000_055d
    NOP
    NOP
    SUB         word [0x011e],0x28    ;= 0400h
LAB_1000_055d:                ;XREF[2]:     1000:054a(j),1000:0554(j)
    MOV         AL,CS:[DAT_keys_571e]
    CMP         AL,0x1
    JZ          LAB_1000_0654
    CMP         AL,0xf
    JZ          LAB_1000_05f4
    CMP         AL,0x10
    JZ          LAB_1000_0609
    CMP         AL,0x3b
    JZ          LAB_1000_05b5
    NOP
    NOP
    CMP         AL,0x3c
    JZ          LAB_1000_05bd
    NOP
    NOP
    CMP         AL,0x3d
    JZ          LAB_1000_05c5
    NOP
    NOP
    CMP         AL,0x3e
    JZ          LAB_1000_05cd
    NOP
    NOP
    CMP         AL,0x3f
    JZ          LAB_1000_05d5
    NOP
    NOP
    CMP         AL,0x1a
    JZ          LAB_1000_05e4
    NOP
    NOP
    CMP         AL,0x1b
    JZ          LAB_1000_05ec
    NOP
    NOP
    CMP         AL,0x44
    JZ          LAB_1000_061e
    NOP
    NOP
    CMP         AL,0x43
    JZ          LAB_1000_05dd
    NOP
    NOP
    JMP         LAB_1000_0258
LAB_1000_05ac:                ;XREF[11]:    1000:05bb(j),1000:05c3(j),1000:05cb(j),1000:05d3(j),
                              ;             1000:05db(j),1000:05e2(j),1000:05ea(j),1000:05f2(j),
                              ;             1000:0607(j),1000:061c(j),1000:0624(j)
    MOV         byte CS:[DAT_keys_571e],0x0
    JMP         LAB_1000_0258
LAB_1000_05b5:                ;XREF[1]:     1000:0575(j)
    MOV         byte [0x007e],0x0     ;= 03h
    NOP
    JMP         LAB_1000_05ac
LAB_1000_05bd:                ;XREF[1]:     1000:057b(j)
    MOV         byte [0x007e],0x1     ;= 03h
    NOP
    JMP         LAB_1000_05ac
LAB_1000_05c5:                ;XREF[1]:     1000:0581(j)
    MOV         byte [0x007e],0x2     ;= 03h
    NOP
    JMP         LAB_1000_05ac
LAB_1000_05cd:                ;XREF[1]:     1000:0587(j)
    MOV         byte [0x007e],0x3     ;= 03h
    NOP
    JMP         LAB_1000_05ac
LAB_1000_05d5:                ;XREF[1]:     1000:058d(j)
    MOV         byte [0x007e],0x4     ;= 03h
    NOP
    JMP         LAB_1000_05ac
LAB_1000_05dd:                ;XREF[1]:     1000:05a5(j)
    XOR         byte [0x007d],0x1
    JMP         LAB_1000_05ac
LAB_1000_05e4:                ;XREF[1]:     1000:0593(j)
    ADD         dword [0x006a],0x32   ;= 00000C00h
    JMP         LAB_1000_05ac
LAB_1000_05ec:                ;XREF[1]:     1000:0599(j)
    SUB         dword [0x006a],0x32   ;= 00000C00h
    JMP         LAB_1000_05ac
LAB_1000_05f4:                ;XREF[1]:     1000:0569(j)
    MOV         SI,word [0x00a4]
    INC         SI
    CMP         SI,word [0x5bba]      ;= 0001h
    JC          LAB_1000_0603
    NOP
    NOP
    XOR         SI,SI
LAB_1000_0603:                ;XREF[1]:     1000:05fd(j)
    MOV         word [0x00a4],SI
    JMP         LAB_1000_05ac
LAB_1000_0609:                ;XREF[1]:     1000:056f(j)
    MOV         SI,word [0x00a6]
    INC         SI
    CMP         SI,word [0x5bba]      ;= 0001h
    JC          LAB_1000_0618
    NOP
    NOP
    XOR         SI,SI
LAB_1000_0618:                ;XREF[1]:     1000:0612(j)
    MOV         word [0x00a6],SI
    JMP         LAB_1000_05ac
LAB_1000_061e:                ;XREF[1]:     1000:059f(j)
    XOR         word [0x05f5],0x600   ;= 0600h
    JMP         LAB_1000_05ac

 ; 1000:0653 [UNDEFINED BYTES REMOVED]

LAB_1000_0654:                ;XREF[1]:     1000:0563(j)
    JMP         LAB_1000_001e

 ; 1000:0692 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
F_0693:
    PUSH        SI
    ADD         SI,word [SI + 0x20]
    MOV         EAX,dword [SI]
    MOV         [0xaa],EAX
    MOV         EAX,dword [SI + 0x4]
    MOV         [0xae],EAX
    MOV         EAX,dword [SI + 0x8]
    MOV         [0xb2],EAX
    POP         SI
    PUSH        SI
    ADD         SI,word [SI]
    INC         SI
    INC         SI
    CALL        FUN_1000_1091
    MOV         [0xe0],EAX
    MOV         dword [0xe4],EBX
    MOV         dword [0xe8],ECX
    CALL        FUN_1000_10b6
    MOV         [0xec],EAX
    MOV         dword [0xf0],EBX
    MOV         dword [0xf4],ECX
    POP         SI
    MOV         AX,[0xed]
    MOV         BX,word [0xf1]
    NEG         AX
    CALL        FUN_1000_2b08
    PUSH        AX
    SUB         AX,word [0xc6]
    ADD         word [0xc6],AX
    MOV         AX,[0xe1]
    MOV         BX,word [0xe5]
    CALL        FUN_1000_26dd
    MOV         CX,AX
    MOV         AX,[0xe1]
    MOV         BX,word [0xe5]
    NEG         AX
    CALL        FUN_1000_2b08
    POP         BX
    SUB         BX,AX
    MOV         BX,CX
    JNS         LAB_1000_070f
    NOP
    NOP
    NEG         BX
LAB_1000_070f:                ;XREF[1]:     1000:0709(j)
    MOV         AX,[0xe9]
    CALL        FUN_1000_2b08
    NEG         AX
    SUB         AX,word [0xc2]
    ADD         word [0xc2],AX
    MOV         AX,[0xed]
    MOV         BX,word [0xf1]
    MOV         CX,word [0xf5]
    CALL        FUN_1000_26dd
    MOV         BX,AX
    MOV         AX,CX
    CALL        FUN_1000_2b08
    NEG         AX
    SUB         AX,word [0xc4]
    ADD         word [0xc4],AX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
F_073f:
    PUSH        SI
    ADD         SI,word [SI + 0x20]
    MOV         EAX,dword [SI]
    MOV         [0xaa],EAX
    MOV         EAX,dword [SI + 0x4]
    MOV         [0xae],EAX
    MOV         EAX,dword [SI + 0x8]
    MOV         [0xb2],EAX
    POP         SI
    PUSH        SI
    ADD         SI,word [SI]
    INC         SI
    INC         SI
    CALL        FUN_1000_1091
    MOV         [0xe0],EAX
    MOV         dword [0xe4],EBX
    MOV         dword [0xe8],ECX
    CALL        FUN_1000_10b6
    MOV         [0xec],EAX
    MOV         dword [0xf0],EBX
    MOV         dword [0xf4],ECX
    POP         SI
    MOV         AX,[0xed]
    MOV         BX,word [0xf1]
    NEG         EAX
    CALL        FUN_1000_2b08
    SUB         AX,word [0xc6]
    ADD         word [0xc6],AX
    MOV         BX,word [0xc6]
    CALL        FUN_1000_2ad8
    NEG         AX
    SAR         AX,0x5
    ADD         AX,word [0xb0]
    PUSH        AX
    CALL        FUN_1000_2aad
    SAR         AX,0x5
    ADD         AX,word [0xac]
    POP         BX
    CALL        FUN_1000_25c5
    SUB         AX,word [0xb4]
    MOV         BX,0x3ff
    CALL        FUN_1000_2b08
    SUB         AX,word [0xc4]
    SAR         AX,0x2
    ADD         word [0xc4],AX
    MOV         BX,word [0xc6]
    ADD         BX,0x2000
    CALL        FUN_1000_2ad8
    NEG         AX
    SAR         AX,0x6
    ADD         AX,word [0xb0]
    PUSH        AX
    CALL        FUN_1000_2aad
    SAR         AX,0x6
    POP         BX
    ADD         AX,word [0xac]
    CALL        FUN_1000_25c5
    PUSH        AX
    MOV         BX,word [0xc6]
    SUB         BX,0x2000
    CALL        FUN_1000_2ad8
    NEG         AX
    SAR         AX,0x6
    ADD         AX,word [0xb0]
    PUSH        AX
    CALL        FUN_1000_2aad
    SAR         AX,0x6
    POP         BX
    ADD         AX,word [0xac]
    CALL        FUN_1000_25c5
    POP         BX
    SUB         AX,BX
    MOV         BX,0x1ff
    CALL        FUN_1000_2b08
    SUB         AX,word [0xc2]
    SAR         AX,0x2
    ADD         word [0xc2],AX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
F_0828:
    MOV         EAX,dword [DI]
    MOV         [0xaa],EAX
    MOV         EAX,dword [DI + 0x4]
    MOV         [0xae],EAX
    MOV         AX,[0xac]
    MOV         BX,word [0xb0]
    CALL        FUN_1000_25c5
    ADD         AX,word [0x11c]
    SHL         EAX,0x10
    MOV         [0xb2],EAX
    PUSH        SI
    ADD         SI,word [SI + 0x20]
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [0xac]
    MOV         BX,word [SI + 0x6]
    SUB         BX,word [0xb0]
    NEG         BX
    PUSH        AX
    PUSH        BX
    CALL        FUN_1000_2b08
    SUB         AX,word [0xc6]
    ADD         word [0xc6],AX
    POP         BX
    POP         AX
    CALL        FUN_1000_26dd
    MOV         BX,AX
    MOV         AX,word [SI + 0xa]
    SUB         AX,word [0xb4]
    CALL        FUN_1000_2b08
    SUB         AX,word [0xc4]
    ADD         word [0xc4],AX
    XOR         AX,AX
    SUB         AX,word [0xc2]
    ADD         word [0xc2],AX
    POP         SI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
F_0893:
                              ;XREF[3]:     1000:029a(c),1000:0366(c),1000:042f(c)
    PUSH        SI
    ADD         SI,word [SI + 0x20]
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [DI + 0x2]
    MOV         BX,word [SI + 0x6]
    SUB         BX,word [DI + 0x6]
    NEG         BX
    CALL        FUN_1000_2b08
    MOV         word [DI + 0xc],AX
    MOV         BX,AX
    CALL        FUN_1000_2ad8
    MOV         CX,AX
    CALL        FUN_1000_2aad
    MOV         BX,CX
    MOV         CX,word [0x11e]
    SHL         CX,0x1
    IMUL        CX
    MOV         AX,DX
    XCHG        AX,BX
    IMUL        CX
    MOV         AX,DX
    XCHG        AX,BX
    NEG         AX
    ADD         AX,word [SI + 0x2]
    ADD         BX,word [SI + 0x6]
    SUB         AX,word [DI + 0x2]
    ADD         word [DI + 0x2],AX
    SUB         BX,word [DI + 0x6]
    ADD         word [DI + 0x6],BX
    MOV         AX,word [DI + 0x2]
    MOV         BX,word [DI + 0x6]
    CALL        FUN_1000_25c5
    MOV         BX,AX
    ADD         BX,0x28
    ADD         AX,word [0x11c]
    SUB         AX,word [DI + 0xa]
    SAR         AX,0x3
    ADD         word [DI + 0xa],AX
    CMP         BX,word [DI + 0xa]
    JA          LAB_1000_0943
    NOP
    NOP
LAB_1000_08fd:                ;XREF[1]:     1000:0946(j)
    MOV         BX,word [0x11e]
    MOV         AX,word [SI + 0xa]
    SUB         AX,word [DI + 0xa]
    CALL        FUN_1000_2b08
    SUB         AX,word [DI + 0xe]
    SAR         AX,0x2
    ADD         word [DI + 0xe],AX
    MOV         word [DI + 0x10],0x0
    MOV         AX,word [DI + 0xc]
    MOV         [0xc6],AX
    MOV         AX,word [DI + 0xe]
    MOV         [0xc4],AX
    MOV         AX,word [DI + 0x10]
    MOV         [0xc2],AX
    MOV         EAX,dword [DI]
    MOV         [0xaa],EAX
    MOV         EAX,dword [DI + 0x4]
    MOV         [0xae],EAX
    MOV         EAX,dword [DI + 0x8]
    MOV         [0xb2],EAX
    POP         SI
    RET
LAB_1000_0943:                ;XREF[1]:     1000:08f9(j)
    MOV         word [DI + 0xa],BX
    JMP         LAB_1000_08fd
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
F_0948:
    XOR         EAX,EAX
    XOR         EBX,EBX
    XOR         EDX,EDX
    MOV         CX,word [0x5bba]
    XOR         DI,DI
LAB_1000_0957:                ;XREF[1]:     1000:0979(j)
    MOV         SI,word [DI + 0x5bbc]
    ADD         SI,word [SI + 0x20]
    MOVZX       EBP,word [SI + 0x2]
    ADD         EAX,EBP
    MOVZX       EBP,word [SI + 0x6]
    ADD         EBX,EBP
    MOVZX       EBP,word [SI + 0xa]
    ADD         EDX,EBP
    ADD         DI,0x2
    LOOP        LAB_1000_0957
    MOV         ECX,EDX
    MOVZX       EBP,word [0x5bba]
    CDQ
    DIV         EBP
    MOV         [0xc8],AX
    MOV         EAX,EBX
    CDQ
    DIV         EBP
    MOV         [0xca],AX
    MOV         EAX,ECX
    CDQ
    IDIV        EBP
    MOV         [0xcc],AX
    MOV         AX,[0xc8]
    MOV         BX,word [0xca]
    SUB         AX,word [0xac]
    SUB         BX,word [0xb0]
    NEG         BX
    CALL        FUN_1000_2b08
    MOV         [0xc6],AX
    MOV         BX,AX
    CALL        FUN_1000_2ad8
    MOV         CX,AX
    CALL        FUN_1000_2aad
    MOV         BX,CX
    MOV         CX,word [0x11e]
    SHL         CX,0x1
    IMUL        CX
    MOV         AX,DX
    XCHG        AX,BX
    IMUL        CX
    MOV         AX,DX
    XCHG        AX,BX
    NEG         AX
    ADD         AX,word [0xc8]
    ADD         BX,word [0xca]
    SUB         AX,word [0xac]
    ADD         word [0xac],AX
    SUB         BX,word [0xb0]
    ADD         word [0xb0],BX
    MOV         AX,[0xac]
    MOV         BX,word [0xb0]
    CALL        FUN_1000_25c5
    MOV         BX,AX
    ADD         BX,0x28
    ADD         AX,word [0x11c]
    SUB         AX,word [0xb4]
    SAR         AX,0x3
    ADD         word [0xb4],AX
    CMP         BX,word [0xb4]
    JA          LAB_1000_0a35
    NOP
    NOP
LAB_1000_0a15:                ;XREF[1]:     1000:0a39(j)
    MOV         BX,word [0x11e]
    MOV         AX,[0xcc]
    SUB         AX,word [0xb4]
    CALL        FUN_1000_2b08
    SUB         AX,word [0xc4]
    SAR         AX,0x2
    ADD         word [0xc4],AX
    MOV         word [0xc2],0x0
    RET
LAB_1000_0a35:                ;XREF[1]:     1000:0a11(j)
    MOV         word [0xb4],BX
    JMP         LAB_1000_0a15
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0a3b:
                              ;XREF[1]:     1000:56ce(c)
    PUSH        SI
    PUSH        DI
    TEST        byte CS:[DAT_keys_571e + 2],0xc0
    JNS         LAB_1000_0a54
    NOP
    NOP
LAB_1000_0a47:                ;XREF[1]:     1000:0a69(j)
    TEST        byte CS:[DAT_keys_571e + 3],0xc0
    JNS         LAB_1000_0a6b
    NOP
    NOP
LAB_1000_0a51:                ;XREF[1]:     1000:0a80(j)
    POP         DI
    POP         SI
    RET
LAB_1000_0a54:                ;XREF[1]:     1000:0a43(j)
    PUSHF
    AND         byte CS:[DAT_keys_571e + 2],0x3f
    MOV         SI,word [0xa4]
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5bbc]
    POPF
    CALL        FUN_1000_0a82
    JMP         LAB_1000_0a47
LAB_1000_0a6b:                ;XREF[1]:     1000:0a4d(j)
    PUSHF
    AND         byte CS:[DAT_keys_571e + 3],0x3f
    MOV         SI,word [0xa6]
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5bbc]
    POPF
    CALL        FUN_1000_0a82
    JMP         LAB_1000_0a51
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0a82:
                              ;XREF[2]:     1000:0a66(c),1000:0a7d(c)
    PUSHF
    MOV         DI,SI
    ADD         DI,word [SI]
    MOVZX       EAX,word [DI]
    MOV         CX,AX
    SHR         EAX,0x1
    INC         EAX
    IMUL        EAX,dword [0x6a]
    POPF
    JP          LAB_1000_0ab9
    NOP
    NOP
    INC         DI
    INC         DI
    MOV         DX,DI
    MOV         BX,word [DI + 0xa]
    ADD         DI,0x1c
    DEC         CX
LAB_1000_0aa8:                ;XREF[1]:     1000:0ab4(j)
    MOV         AX,word [DI + 0xa]
    CMP         AX,BX
    JL          LAB_1000_0ac1
    NOP
    NOP
LAB_1000_0ab1:                ;XREF[1]:     1000:0ac5(j)
    ADD         DI,0x1c
    LOOP        LAB_1000_0aa8
    MOV         word [SI + 0x22],DX
LAB_1000_0ab9:                ;XREF[1]:     1000:0a99(j)
    MOV         DI,word [SI + 0x22]
    ADD         dword [DI + 0x14],EAX
    RET
LAB_1000_0ac1:                ;XREF[1]:     1000:0aad(j)
    MOV         BX,AX
    MOV         DX,DI
    JMP         LAB_1000_0ab1

 ; 1000:0b24 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0b25:
                              ;XREF[3]:     1000:02cc(c),1000:0398(c),1000:0458(c)
    PUSH        FS
    MOV         FS,word [0x1a49]
    XOR         DI,DI
    CMP         DI,word [0x3e51]
    JNC         LAB_1000_0bae
    NOP
    NOP
LAB_1000_0b35:                ;XREF[1]:     1000:0bac(j)
    MOV         AX,word [DI + 0x3e55]
    MOV         BX,word [DI + 0x3e59]
    PUSH        AX
    PUSH        BX
    TEST        byte [0x5fb],0x1
    NOP
    JZ          LAB_1000_0b4a
    NOP
    NOP
    XCHG        AX,BX
LAB_1000_0b4a:                ;XREF[1]:     1000:0b45(j)
    MOVZX       BX,BH
    MOVZX       AX,AH
    CMP         BX,word [0xe58c]
    JL          LAB_1000_0bb1
    NOP
    NOP
    CMP         BX,word [0xe58e]
    JG          LAB_1000_0bb1
    NOP
    NOP
    SHL         BX,0x2
    CMP         AX,word [BX + 0xe590]
    JL          LAB_1000_0bb1
    NOP
    NOP
    CMP         AX,word [BX + 0xe592]
    JG          LAB_1000_0bb1
    NOP
    NOP
    POP         BX
    POP         AX
    MOV         CX,word [DI + 0x3e5d]
    SUB         AX,word [0xac]
    SUB         BX,word [0xb0]
    SUB         CX,word [0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    CALL        FUN_1000_2418
    JC          LAB_1000_0ba5
    NOP
    NOP
    MOVZX       SI,byte [DI + 0x3e6d]
    SHR         SI,0x4
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5a53]
    CALL        FUN_1000_0cd3
LAB_1000_0ba5:                ;XREF[2]:     1000:0b90(j),1000:0bb3(j)
    ADD         DI,0x1c
    CMP         DI,word [0x3e51]
    JC          LAB_1000_0b35
LAB_1000_0bae:                ;XREF[1]:     1000:0b31(j)
    POP         FS
    RET
LAB_1000_0bb1:                ;XREF[4]:     1000:0b54(j),1000:0b5c(j),1000:0b67(j),1000:0b6f(j)
    POP         BX
    POP         AX
    JMP         LAB_1000_0ba5
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0bb5:
                              ;XREF[1]:     1000:56cb(c)
    XOR         DI,DI
    CMP         DI,word [0x3e51]
    JNC         LAB_1000_0c2e
    NOP
    NOP
LAB_1000_0bbf:                ;XREF[1]:     1000:0c2c(j)
    SUB         word [DI + 0x3e6b],0x2
    JS          LAB_1000_0c72
    MOV         EAX,dword [DI + 0x3e5f]
    MOV         EBX,dword [DI + 0x3e63]
    MOV         ECX,dword [DI + 0x3e67]
    ADD         dword [DI + 0x3e53],EAX
    ADD         dword [DI + 0x3e57],EBX
    ADD         dword [DI + 0x3e5b],ECX
    CMP         word [DI + 0x3e6d],0xf
    JNZ         LAB_1000_0c25
    NOP
    NOP
    MOV         EAX,dword [DI + 0x3e53]
    MOV         EBX,dword [DI + 0x3e57]
    MOV         ECX,dword [DI + 0x3e5b]
    SAR         EAX,0x10
    SAR         EBX,0x10
    SAR         ECX,0x10
    PUSH        AX
    PUSH        BX
    PUSH        CX
    CALL        FUN_1000_25c5
    POP         CX
    CMP         AX,CX
    POP         BX
    POP         AX
    JNS         LAB_1000_0c31
    NOP
    NOP
    MOV         EAX,[0x6a]
    SAR         EAX,0x1
    SUB         dword [DI + 0x3e67],EAX
LAB_1000_0c25:                ;XREF[2]:     1000:0beb(j),1000:0c70(j)
    ADD         DI,0x1c
LAB_1000_0c28:                ;XREF[1]:     1000:0cd0(j)
    CMP         DI,word [0x3e51]
    JC          LAB_1000_0bbf
LAB_1000_0c2e:                ;XREF[1]:     1000:0bbb(j)
    RET
LAB_1000_0c2f:                ;XREF[1]:     1000:0c7e(j)
    STI
    RET
LAB_1000_0c31:                ;XREF[1]:     1000:0c15(j)
    PUSH        AX
    PUSH        BX
    MOV         BL,AH
    MOV         AL,byte FS:[BX]
    TEST        AL,0xf
    JZ          LAB_1000_0c43
    NOP
    NOP
    DEC         AL
    MOV         byte FS:[BX],AL
LAB_1000_0c43:                ;XREF[1]:     1000:0c3a(j)
    POP         BX
    POP         AX
    ADD         BX,0x80
    ADD         AX,0x80
    MOV         BL,AH
    DEC         byte GS:[BX]
    MOV         word [DI + 0x3e6d],0x1
    MOV         EAX,0x0
    MOV         dword [DI + 0x3e5f],EAX
    MOV         dword [DI + 0x3e63],EAX
    MOV         dword [DI + 0x3e67],0x2710
    JMP         LAB_1000_0c25
LAB_1000_0c72:                ;XREF[1]:     1000:0bc4(j)
    CLI
    MOV         SI,word [0x3e51]
    SUB         SI,0x1c
    MOV         word [0x3e51],SI
    JZ          LAB_1000_0c2f
    MOV         EAX,dword [SI + 0x3e53]
    MOV         dword [DI + 0x3e53],EAX
    MOV         EAX,dword [SI + 0x3e57]
    MOV         dword [DI + 0x3e57],EAX
    MOV         EAX,dword [SI + 0x3e5b]
    MOV         dword [DI + 0x3e5b],EAX
    MOV         EAX,dword [SI + 0x3e5f]
    MOV         dword [DI + 0x3e5f],EAX
    MOV         EAX,dword [SI + 0x3e63]
    MOV         dword [DI + 0x3e63],EAX
    MOV         EAX,dword [SI + 0x3e67]
    MOV         dword [DI + 0x3e67],EAX
    MOV         AX,word [SI + 0x3e6b]
    MOV         word [DI + 0x3e6b],AX
    MOV         AX,word [SI + 0x3e6d]
    MOV         word [DI + 0x3e6d],AX
    SUB         SI,0x1c
    STI
    JMP         LAB_1000_0c28
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0cd3:
                              ;XREF[1]:     1000:0ba2(c)
    CMP         CX,word [0x120]
    JL          LAB_1000_0d29
    NOP
    NOP
    MOV         BP,BX
    MOV         BX,AX
    LODSW ;       SI
    CWD
    IDIV        CX
    MOV         DX,AX
    PUSH        ES
    PUSH        DI
    MOV         AX,DS
    MOV         ES,AX
    MOV         DI,0xdb16
    MOV         AX,BX
    SUB         AX,DX
    STOSW ;       ES:DI
    MOV         AX,BP
    SUB         AX,DX
    STOSW ;       ES:DI
    MOVSD ;       ES:DI,SI
    MOV         AX,BX
    ADD         AX,DX
    STOSW ;       ES:DI
    MOV         AX,BP
    SUB         AX,DX
    STOSW ;       ES:DI
    MOVSD ;       ES:DI,SI
    MOV         AX,BX
    ADD         AX,DX
    STOSW ;       ES:DI
    MOV         AX,BP
    ADD         AX,DX
    STOSW ;       ES:DI
    MOVSD ;       ES:DI,SI
    MOV         AX,BX
    SUB         AX,DX
    STOSW ;       ES:DI
    MOV         AX,BP
    ADD         AX,DX
    STOSW ;       ES:DI
    MOVSD ;       ES:DI,SI
    MOV         word [0xdb14],0x4
    CALL        FUN_1000_36fe
    POP         DI
    POP         ES
LAB_1000_0d29:                ;XREF[1]:     1000:0cd7(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0d2a:
                              ;XREF[1]:     1000:56b4(c)
    MOVZX       BX,byte [DI]
    MOV         AL,byte CS:[BX + DAT_keys_571e]
    MOVZX       BX,byte [DI + 0x1]
    MOV         AH,byte CS:[BX + DAT_keys_571e]
    MOV         BX,word [SI + 0xc]
    MOV         CX,0x32
    TEST        AL,0x80
    JS          LAB_1000_0d5a
    NOP
    NOP
    CMP         BX,0x2000
    JG          LAB_1000_0d5a
    NOP
    NOP
    TEST        BX,BX
    JNS         LAB_1000_0d58
    NOP
    NOP
    SHL         CX,0x2
LAB_1000_0d58:                ;XREF[1]:     1000:0d51(j)
    ADD         BX,CX
LAB_1000_0d5a:                ;XREF[2]:     1000:0d43(j),1000:0d4b(j)
    TEST        AH,0x80
    JS          LAB_1000_0d74
    NOP
    NOP
    CMP         BX,0xe000
    JL          LAB_1000_0d74
    NOP
    NOP
    TEST        BX,BX
    JS          LAB_1000_0d72
    NOP
    NOP
    SHL         CX,0x2
LAB_1000_0d72:                ;XREF[1]:     1000:0d6b(j)
    SUB         BX,CX
LAB_1000_0d74:                ;XREF[2]:     1000:0d5d(j),1000:0d65(j)
    XOR         AX,0x8080
    TEST        AX,0x8080
    JNZ         LAB_1000_0d8f
    NOP
    NOP
    MOV         CX,0x12c
    TEST        BX,BX
    JZ          LAB_1000_0d8f
    NOP
    NOP
    JNS         LAB_1000_0d8d
    NOP
    NOP
    NEG         CX
LAB_1000_0d8d:                ;XREF[1]:     1000:0d87(j)
    SUB         BX,CX
LAB_1000_0d8f:                ;XREF[2]:     1000:0d7a(j),1000:0d83(j)
    MOV         word [SI + 0xc],BX
    MOVZX       BX,byte [DI + 0x2]
    MOV         AL,byte CS:[BX + DAT_keys_571e]
    MOVZX       BX,byte [DI + 0x3]
    MOV         AH,byte CS:[BX + DAT_keys_571e]
    MOV         BX,word [SI + 0xa]
    MOV         ECX,dword [SI + 0x42]
    ADD         ECX,dword [SI + 0x46]
    AND         CX,CX
    JGE         LAB_1000_0db7
    NOP
    NOP
    NEG         CX
LAB_1000_0db7:                ;XREF[1]:     1000:0db1(j)
    SHR         ECX,0x10
    NEG         CX
    ADD         CX,0x40
    TEST        AL,0x80
    JS          LAB_1000_0dd9
    NOP
    NOP
    CMP         BX,0xe000
    JL          LAB_1000_0dd9
    NOP
    NOP
    TEST        BX,BX
    JS          LAB_1000_0dd7
    NOP
    NOP
    SHL         CX,0x2
LAB_1000_0dd7:                ;XREF[1]:     1000:0dd0(j)
    SUB         BX,CX
LAB_1000_0dd9:                ;XREF[2]:     1000:0dc2(j),1000:0dca(j)
    TEST        AH,0x80
    JS          LAB_1000_0df3
    NOP
    NOP
    CMP         BX,0x2000
    JG          LAB_1000_0df3
    NOP
    NOP
    TEST        BX,BX
    JNS         LAB_1000_0df1
    NOP
    NOP
    SHL         CX,0x2
LAB_1000_0df1:                ;XREF[1]:     1000:0dea(j)
    ADD         BX,CX
LAB_1000_0df3:                ;XREF[2]:     1000:0ddc(j),1000:0de4(j)
    XOR         AX,0x8080
    TEST        AX,0x8080
    JNZ         LAB_1000_0e0e
    NOP
    NOP
    MOV         CX,0x50
    TEST        BX,BX
    JZ          LAB_1000_0e0e
    NOP
    NOP
    JNS         LAB_1000_0e0c
    NOP
    NOP
    NEG         CX
LAB_1000_0e0c:                ;XREF[1]:     1000:0e06(j)
    SUB         BX,CX
LAB_1000_0e0e:                ;XREF[2]:     1000:0df9(j),1000:0e02(j)
    MOV         word [SI + 0xa],BX
    XOR         AX,AX
    MOVZX       BX,byte [DI + 0x4]
    TEST        byte CS:[BX + DAT_keys_571e],0x80
    JNZ         LAB_1000_0e24
    NOP
    NOP
    OR          AX,0x1
LAB_1000_0e24:                ;XREF[1]:     1000:0e1d(j)
    MOV         word [SI + 0xe],AX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0e28:
                              ;XREF[1]:     1000:48db(c)
    MOV         DI,SI
    ADD         DI,word [SI]
    ADD         DI,0x2
    MOV         AX,word [DI + 0x72]
    MOV         BX,word [DI + 0xaa]
    SHR         AX,0x1
    SHR         BX,0x1
    ADD         AX,BX
    MOV         word [SI + 0x10],AX
    MOV         AX,word [DI + 0x76]
    MOV         BX,word [DI + 0xae]
    SHR         AX,0x1
    SHR         BX,0x1
    ADD         AX,BX
    MOV         word [SI + 0x12],AX
    MOV         AX,word [DI + 0x7a]
    MOV         BX,word [DI + 0xb2]
    SHR         AX,0x1
    SHR         BX,0x1
    ADD         AX,BX
    MOV         word [SI + 0x14],AX
    MOV         word CS:[WORD_1000_0e67],0x0
    RET
WORD_1000_0e67:               ;XREF[9]:     1000:0e5f(W),1000:0e8f(R),1000:0e9d(RW),1000:0eb9(R),
                              ;             1000:0ec7(RW),1000:0ee3(R),1000:0f09(RW),1000:0f25(R),
                              ;             1000:0f4b(RW)
    dw          0h
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0e69:
                              ;XREF[1]:     1000:4b6f(c)
    CMP         AX,0x0
    JZ          LAB_1000_0e8f
    NOP
    NOP
    CMP         AX,0x1
    JZ          LAB_1000_0eb9
    NOP
    NOP
    CMP         AX,0x2
    JZ          LAB_1000_0ee3
    NOP
    NOP
    CMP         AX,0x3
    JZ          LAB_1000_0f25
    XOR         EAX,EAX
    XOR         EBX,EBX
    XOR         ECX,ECX
    RET
LAB_1000_0e8f:                ;XREF[1]:     1000:0e6c(j)
    TEST        word CS:[WORD_1000_0e67],0x1
    JNZ         LAB_1000_0ea3
    NOP
    NOP
    CALL        FUN_1000_1136
    OR          word CS:[WORD_1000_0e67],0x1
LAB_1000_0ea3:                ;XREF[1]:     1000:0e96(j)
    MOV         EAX,CS:[DWORD_1000_12a7]
    MOV         EBX,dword CS:[DWORD_1000_12ab]
    MOV         ECX,dword CS:[DWORD_1000_12af]
    MOV         EDX,dword [SI + 0x42]
    RET
LAB_1000_0eb9:                ;XREF[1]:     1000:0e73(j)
    TEST        word CS:[WORD_1000_0e67],0x1
    JNZ         LAB_1000_0ecd
    NOP
    NOP
    CALL        FUN_1000_1136
    OR          word CS:[WORD_1000_0e67],0x1
LAB_1000_0ecd:                ;XREF[1]:     1000:0ec0(j)
    MOV         EAX,CS:[DWORD_1000_12a7]
    MOV         EBX,dword CS:[DWORD_1000_12ab]
    MOV         ECX,dword CS:[DWORD_1000_12af]
    MOV         EDX,dword [SI + 0x46]
    RET
LAB_1000_0ee3:                ;XREF[1]:     1000:0e7a(j)
    TEST        word CS:[WORD_1000_0e67],0x2
    JNZ         LAB_1000_0f0f
    NOP
    NOP
    PUSH        SI
    ADD         SI,word [SI]
    ADD         SI,0x2
    CALL        FUN_1000_10b6
    MOV         CS:[DWORD_1000_12bf],EAX
    MOV         dword CS:[DWORD_1000_12c3],EBX
    MOV         dword CS:[DWORD_1000_12c7],ECX
    POP         SI
    OR          word CS:[WORD_1000_0e67],0x2
LAB_1000_0f0f:                ;XREF[1]:     1000:0eea(j)
    MOV         EAX,CS:[DWORD_1000_12bf]
    MOV         EBX,dword CS:[DWORD_1000_12c3]
    MOV         ECX,dword CS:[DWORD_1000_12c7]
    MOV         EDX,dword [SI + 0x4a]
    RET
LAB_1000_0f25:                ;XREF[1]:     1000:0e81(j)
    TEST        word CS:[WORD_1000_0e67],0x2
    JNZ         LAB_1000_0f51
    NOP
    NOP
    PUSH        SI
    ADD         SI,word [SI]
    ADD         SI,0x2
    CALL        FUN_1000_10b6
    MOV         CS:[DWORD_1000_12bf],EAX
    MOV         dword CS:[DWORD_1000_12c3],EBX
    MOV         dword CS:[DWORD_1000_12c7],ECX
    POP         SI
    OR          word CS:[WORD_1000_0e67],0x2
LAB_1000_0f51:                ;XREF[1]:     1000:0f2c(j)
    MOV         EAX,CS:[DWORD_1000_12bf]
    MOV         EBX,dword CS:[DWORD_1000_12c3]
    MOV         ECX,dword CS:[DWORD_1000_12c7]
    MOV         EDX,dword [SI + 0x4e]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0f67:
                              ;XREF[1]:     1000:4bd5(c)
    MOV         CX,word [SI + 0x8]
    CMP         AX,0x0
    JZ          LAB_1000_0f87
    NOP
    NOP
    CMP         AX,0x1
    JZ          LAB_1000_0fa5
    NOP
    NOP
    CMP         AX,0x2
    JZ          LAB_1000_0fc3
    NOP
    NOP
    CMP         AX,0x3
    JZ          LAB_1000_0fe3
    NOP
    NOP
    RET
LAB_1000_0f87:                ;XREF[1]:     1000:0f6d(j)
    TEST        CX,CX
    JZ          LAB_1000_0fa0
    NOP
    NOP
    MOV         EAX,dword [SI + 0x42]
    SUB         EAX,EBX
    SAR         EAX,0x2
    ADD         EAX,EBX
    MOV         dword [SI + 0x42],EAX
    RET
LAB_1000_0fa0:                ;XREF[1]:     1000:0f89(j)
    MOV         dword [SI + 0x42],EBX
    RET
LAB_1000_0fa5:                ;XREF[1]:     1000:0f74(j)
    TEST        CX,CX
    JZ          LAB_1000_0fbe
    NOP
    NOP
    MOV         EAX,dword [SI + 0x46]
    SUB         EAX,EBX
    SAR         EAX,0x2
    ADD         EAX,EBX
    MOV         dword [SI + 0x46],EAX
    RET
LAB_1000_0fbe:                ;XREF[1]:     1000:0fa7(j)
    MOV         dword [SI + 0x46],EBX
    RET
LAB_1000_0fc3:                ;XREF[1]:     1000:0f7b(j)
    TEST        CX,0x1
    JZ          LAB_1000_0fde
    NOP
    NOP
    MOV         EAX,dword [SI + 0x4a]
    SUB         EAX,EBX
    SAR         EAX,0x2
    ADD         EAX,EBX
    MOV         dword [SI + 0x4a],EAX
    RET
LAB_1000_0fde:                ;XREF[1]:     1000:0fc7(j)
    MOV         dword [SI + 0x4a],EBX
    RET
LAB_1000_0fe3:                ;XREF[1]:     1000:0f82(j)
    TEST        CX,0x1
    JZ          LAB_1000_0ffe
    NOP
    NOP
    MOV         EAX,dword [SI + 0x4e]
    SUB         EAX,EBX
    SAR         EAX,0x2
    ADD         EAX,EBX
    MOV         dword [SI + 0x4e],EAX
    RET
LAB_1000_0ffe:                ;XREF[1]:     1000:0fe7(j)
    MOV         dword [SI + 0x4e],EBX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1003:
                              ;XREF[1]:     1000:497a(c)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1004:
                              ;XREF[1]:     1000:56b7(c)
    MOV         AX,word [SI + 0xa]
    MOV         word [SI + 0x16],AX
    MOV         AX,word [SI + 0xc]
    MOV         word [SI + 0x18],AX
    MOV         CX,0x10
    MOV         BX,0x0
LAB_1000_1016:                ;XREF[1]:     1000:1025(j)
    MOV         EAX,dword [BX + SI + 0x42]
    SAR         EAX,0x7
    SUB         dword [BX + SI + 0x42],EAX
    ADD         BX,0x4
    LOOP        LAB_1000_1016
    TEST        word [SI + 0xe],0x1
    JZ          LAB_1000_1047
    NOP
    NOP
    MOV         CX,0x10
    MOV         BX,0x0
LAB_1000_1036:                ;XREF[1]:     1000:1045(j)
    MOV         EAX,dword [BX + SI + 0x42]
    SAR         EAX,0x2
    SUB         dword [BX + SI + 0x42],EAX
    ADD         BX,0x4
    LOOP        LAB_1000_1036
LAB_1000_1047:                ;XREF[1]:     1000:102c(j)
    MOV         AX,word [SI + 0x18]
    CWD
    MOV         CX,0x4000
    IMUL        CX
    MOVSX       EAX,DX
    MOV         BX,word [SI + 0x8]
    TEST        BX,BX
    JZ          LAB_1000_1077
    NOP
    NOP
    DEC         BX
    JZ          LAB_1000_1084
    NOP
    NOP
    ROL         EAX,0x3
    ADD         dword [SI + 0x42],EAX
    ADD         dword [SI + 0x46],EAX
    ADD         dword [SI + 0x4a],EAX
    ADD         dword [SI + 0x4e],EAX
    RET
LAB_1000_1077:                ;XREF[1]:     1000:1059(j)
    ROL         EAX,0x4
    ADD         dword [SI + 0x4a],EAX
    ADD         dword [SI + 0x4e],EAX
    RET
LAB_1000_1084:                ;XREF[1]:     1000:105e(j)
    ROL         EAX,0x4
    ADD         dword [SI + 0x42],EAX
    ADD         dword [SI + 0x46],EAX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1091:
                              ;XREF[4]:     1000:06b4(c),1000:0760(c),1000:113c(c),1000:11f6(c)
    MOV         EDX,dword [SI + 0xc4]
    SUB         EDX,dword [SI + 0xa8]
    MOV         EBX,dword [SI + 0xc8]
    SUB         EBX,dword [SI + 0xac]
    MOV         ECX,dword [SI + 0xcc]
    SUB         ECX,dword [SI + 0xb0]
    MOV         EAX,EDX
    CALL        FUN_1000_2726
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_10b6:
                              ;XREF[6]:     1000:06c5(c),1000:0771(c),1000:0ef4(c),1000:0f36(c),
                              ;             1000:1150(c),1000:120a(c)
    MOV         EDX,dword [SI + 0x70]
    SUB         EDX,dword [SI + 0xa8]
    ADD         EDX,dword [SI + 0x8c]
    SUB         EDX,dword [SI + 0xc4]
    MOV         EBX,dword [SI + 0x74]
    SUB         EBX,dword [SI + 0xac]
    ADD         EBX,dword [SI + 0x90]
    SUB         EBX,dword [SI + 0xc8]
    MOV         ECX,dword [SI + 0x78]
    SUB         ECX,dword [SI + 0xb0]
    ADD         ECX,dword [SI + 0x94]
    SUB         ECX,dword [SI + 0xcc]
    MOV         EAX,EDX
    CALL        FUN_1000_2726
    RET

 ; 1000:1135 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1136:
                              ;XREF[2]:     1000:0e9a(c),1000:0ec4(c)
    PUSH        SI
    ADD         SI,word [SI]
    ADD         SI,0x2
    CALL        FUN_1000_1091
    MOV         CS:[DWORD_1000_12b3],EAX
    MOV         dword CS:[DWORD_1000_12b7],EBX
    MOV         dword CS:[DWORD_1000_12bb],ECX
    CALL        FUN_1000_10b6
    MOV         CS:[DWORD_1000_12bf],EAX
    MOV         dword CS:[DWORD_1000_12c3],EBX
    MOV         dword CS:[DWORD_1000_12c7],ECX
    POP         SI
    MOV         BX,word [SI + 0x16]
    CALL        FUN_1000_2aad
    SHL         EAX,0x10
    MOV         CS:[DWORD_1000_129f],EAX
    CALL        FUN_1000_2ad8
    SHL         EAX,0x10
    MOV         CS:[DWORD_1000_12a3],EAX                ;= 7FFF0000h
    MOV         EAX,CS:[DWORD_1000_12bf]
    IMUL        dword CS:[DWORD_1000_12a3]          ;= 7FFF0000h
    MOV         EBX,EDX
    MOV         EAX,CS:[DWORD_1000_12b3]
    IMUL        dword CS:[DWORD_1000_129f]
    SUB         EBX,EDX
    SHL         EBX,0x1
    MOV         dword CS:[DWORD_1000_12a7],EBX
    MOV         EAX,CS:[DWORD_1000_12c3]
    IMUL        dword CS:[DWORD_1000_12a3]          ;= 7FFF0000h
    MOV         EBX,EDX
    MOV         EAX,CS:[DWORD_1000_12b7]
    IMUL        dword CS:[DWORD_1000_129f]
    SUB         EBX,EDX
    SHL         EBX,0x1
    MOV         dword CS:[DWORD_1000_12ab],EBX
    MOV         EAX,CS:[DWORD_1000_12c7]
    IMUL        dword CS:[DWORD_1000_12a3]          ;= 7FFF0000h
    MOV         EBX,EDX
    MOV         EAX,CS:[DWORD_1000_12bb]
    IMUL        dword CS:[DWORD_1000_129f]
    SUB         EBX,EDX
    SHL         EBX,0x1
    MOV         dword CS:[DWORD_1000_12af],EBX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_11f0:
                              ;XREF[1]:     1000:138f(c)
    PUSH        SI
    ADD         SI,word [SI]
    ADD         SI,0x2
    CALL        FUN_1000_1091
    MOV         CS:[DWORD_1000_12b3],EAX
    MOV         dword CS:[DWORD_1000_12b7],EBX
    MOV         dword CS:[DWORD_1000_12bb],ECX
    CALL        FUN_1000_10b6
    MOV         CS:[DWORD_1000_12bf],EAX
    MOV         dword CS:[DWORD_1000_12c3],EBX
    MOV         dword CS:[DWORD_1000_12c7],ECX
    POP         SI
    MOV         BX,word [SI + 0x16]
    CALL        FUN_1000_2aad
    SHL         EAX,0x10
    MOV         CS:[DWORD_1000_129f],EAX
    CALL        FUN_1000_2ad8
    SHL         EAX,0x10
    MOV         CS:[DWORD_1000_12a3],EAX                ;= 7FFF0000h
    MOV         EAX,CS:[DWORD_1000_12bf]
    IMUL        dword CS:[DWORD_1000_129f]
    MOV         EBX,EDX
    MOV         EAX,CS:[DWORD_1000_12b3]
    IMUL        dword CS:[DWORD_1000_12a3]          ;= 7FFF0000h
    ADD         EBX,EDX
    SHL         EBX,0x7
    PUSH        EBX
    MOV         EAX,CS:[DWORD_1000_12c3]
    IMUL        dword CS:[DWORD_1000_129f]
    MOV         EBX,EDX
    MOV         EAX,CS:[DWORD_1000_12b7]
    IMUL        dword CS:[DWORD_1000_12a3]          ;= 7FFF0000h
    ADD         EBX,EDX
    SHL         EBX,0x7
    MOV         EAX,CS:[DWORD_1000_12c7]
    IMUL        dword CS:[DWORD_1000_129f]
    MOV         ECX,EDX
    MOV         EAX,CS:[DWORD_1000_12bb]
    IMUL        dword CS:[DWORD_1000_12a3]          ;= 7FFF0000h
    ADD         ECX,EDX
    SHL         ECX,0x7
    POP         EAX
    RET
DWORD_1000_129f:              ;XREF[8]:     1000:116f(W),1000:1193(R),1000:11b8(R),1000:11dd(R),
                              ;             1000:1229(W),1000:123f(R),1000:1261(R),1000:1281(R)
    dd         0h
DWORD_1000_12a3:              ;XREF[8]:     1000:117b(W),1000:1185(R),1000:11aa(R),1000:11cf(R),
                              ;             1000:1235(W),1000:124d(R),1000:126f(R),1000:128f(R)
    dd         7FFF0000h
DWORD_1000_12a7:              ;XREF[3]:     1000:0ea3(R),1000:0ecd(R),1000:119f(W)
    dd         0h
DWORD_1000_12ab:              ;XREF[3]:     1000:0ea8(R),1000:0ed2(R),1000:11c4(W)
    dd         0h
DWORD_1000_12af:              ;XREF[3]:     1000:0eae(R),1000:0ed8(R),1000:11e9(W)
    dd         0h
DWORD_1000_12b3:              ;XREF[4]:     1000:113f(W),1000:118e(R),1000:11f9(W),1000:1248(R)
    dd         0h
DWORD_1000_12b7:              ;XREF[4]:     1000:1144(W),1000:11b3(R),1000:11fe(W),1000:126a(R)
    dd         0h
DWORD_1000_12bb:              ;XREF[4]:     1000:114a(W),1000:11d8(R),1000:1204(W),1000:128a(R)
    dd         0h
DWORD_1000_12bf:              ;XREF[8]:     1000:0ef7(W),1000:0f0f(R),1000:0f39(W),1000:0f51(R),
                              ;             1000:1153(W),1000:1180(R),1000:120d(W),1000:123a(R)
    dd         0h
DWORD_1000_12c3:              ;XREF[8]:     1000:0efc(W),1000:0f14(R),1000:0f3e(W),1000:0f56(R),
                              ;             1000:1158(W),1000:11a5(R),1000:1212(W),1000:125c(R)
    dd         0h
DWORD_1000_12c7:              ;XREF[8]:     1000:0f02(W),1000:0f1a(R),1000:0f44(W),1000:0f5c(R),
                              ;             1000:115e(W),1000:11ca(R),1000:1218(W),1000:127c(R)
    dd         0h

 ; 1000:1322 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1323:
                              ;XREF[1]:     1000:195c(c)
    PUSHA
    MOV         AX,word [SI + 0x1e]
    TEST        AX,AX
    JNZ         LAB_1000_1330
    NOP
    NOP
    MOV         AX,[0x1a49]
LAB_1000_1330:                ;XREF[1]:     1000:1329(j)
    PUSH        FS
    MOV         FS,AX
    PUSH        SI
    CALL        FUN_1000_1347
    MOV         AX,DS
    MOV         ES,AX
    POP         SI
    ADD         SI,word [SI + 0x4]
    CALL        FUN_1000_1408
    POP         FS
    POPA
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1347:
                              ;XREF[1]:     1000:1335(c)
    PUSH        SI
    ADD         SI,word [SI]
    MOV         CX,word [SI]
    ADD         SI,0x2
    MOV         DI,0x126
LAB_1000_1352:                ;XREF[1]:     1000:138c(j)
    PUSH        CX
    MOV         EAX,dword [SI]
    MOV         EBX,dword [SI + 0x4]
    MOV         ECX,dword [SI + 0x8]
    CALL        FUN_1000_13cc
    MOV         EAX,dword [SI]
    MOV         EBX,dword [SI + 0x4]
    ROR         EAX,0x10
    ROR         EBX,0x10
    PUSH        AX
    PUSH        BX
    CALL        FUN_1000_25c5
    MOV         CX,AX
    POP         BX
    POP         AX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SHL         ECX,0x10
    CALL        FUN_1000_13cc
    ADD         SI,0x1c
    POP         CX
    LOOP        LAB_1000_1352
    POP         SI
    CALL        FUN_1000_11f0
    PUSH        EAX
    PUSH        EBX
    PUSH        ECX
    ADD         SI,word [SI]
    ADD         SI,0x2
    ADD         EAX,dword [SI]
    ADD         EBX,dword [SI + 0x4]
    ADD         ECX,dword [SI + 0x8]
    CALL        FUN_1000_13cc
    POP         ECX
    POP         EBX
    POP         EAX
    ADD         SI,0x1c
    NEG         EAX
    NEG         EBX
    NEG         ECX
    ADD         EAX,dword [SI]
    ADD         EBX,dword [SI + 0x4]
    ADD         ECX,dword [SI + 0x8]
    CALL        FUN_1000_13cc
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_13cc:
                              ;XREF[4]:     1000:135e(c),1000:1385(c),1000:13a8(c),1000:13c8(c)
    SUB         EAX,dword [0xaa]
    SUB         EBX,dword [0xae]
    SUB         ECX,dword [0xb2]
    SAR         EAX,0x10
    SAR         EBX,0x10
    SAR         ECX,0x10
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],CX
    CALL        FUN_1000_2418
    JC          LAB_1000_1404
    NOP
    NOP
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
LAB_1000_1404:                ;XREF[1]:     1000:13fa(j)
    ADD         DI,0xa
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1408:
                              ;XREF[21]:    1000:1340(c),1000:1441(c),1000:1447(c),1000:144b(c),
                              ;             1000:1452(j),1000:1456(c),1000:145d(j),1000:1461(c),
                              ;             1000:147a(j),1000:1567(j),1000:1577(j),1000:15da(j),
                              ;             1000:15ea(j),1000:1666(j),1000:1676(j),1000:16dc(j),
                              ;             1000:16ec(j),1000:191f(c),1000:1929(c),1000:1939(c),
                              ;             1000:1942(c)
    LODSB ;       SI
    MOVZX       BX,AL
    ADD         BX,BX
    JMP         [CS:BX + JMP_TABLE_1413]
JMP_TABLE_1413:
    ;addr[21]
         dw  LAB_1000_143d
         dw  LAB_1000_1463
         dw  LAB_1000_1487
         dw  LAB_1000_14ad
         dw  LAB_1000_1514
         dw  LAB_1000_1581
         dw  LAB_1000_1584
         dw  LAB_1000_15f4
         dw  LAB_1000_1680
         dw  LAB_1000_16f6
         dw  LAB_1000_1766
         dw  LAB_1000_143d
         dw  LAB_1000_143d
         dw  LAB_1000_143d
         dw  LAB_1000_143d
         dw  LAB_1000_143d
         dw  LAB_1000_1912
         dw  LAB_1000_143e
         dw  LAB_1000_1443
         dw  LAB_1000_144d
         dw  LAB_1000_1458
LAB_1000_143d:                ;XREF[6]:     1000:1413(*),1000:1429(*),1000:142b(*),1000:142d(*),
                              ;             1000:142f(*),1000:1431(*)
    RET
LAB_1000_143e:                ;XREF[1]:     1000:1435(*)
    LODSW ;       SI
    ADD         SI,AX
    JMP         FUN_1000_1408
LAB_1000_1443:                ;XREF[1]:     1000:1437(*)
    LODSW ;       SI
    PUSH        SI
    ADD         SI,AX
    CALL        FUN_1000_1408
    POP         SI
    JMP         FUN_1000_1408
LAB_1000_144d:                ;XREF[1]:     1000:1439(*)
    MOV         AL,[0x5ee]
    SAHF
    LODSW ;       SI
    JS          FUN_1000_1408
    ADD         SI,AX
    JMP         FUN_1000_1408
LAB_1000_1458:                ;XREF[1]:     1000:143b(*)
    MOV         AL,[0x5ee]
    SAHF
    LODSW ;       SI
    JNS         FUN_1000_1408
    ADD         SI,AX
    JMP         FUN_1000_1408
LAB_1000_1463:                ;XREF[1]:     1000:1415(*)
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    MOV         AX,[0x120]
    CMP         word [DI + 0x2],AX
    LODSW ;       SI
    MOV         CL,AL
    JL          FUN_1000_1408
    MOV         AX,word [DI + 0x6]
    MOV         BX,word [DI + 0x8]
    CALL        FUN_1000_3f98
    JMP         FUN_1000_1408
LAB_1000_1487:                ;XREF[1]:     1000:1417(*)
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    MOV         BX,word [DI + 0x128]
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    MOV         AX,word [DI + 0x128]
    LODSW ;       SI
    CMP         BX,AX
    LAHF
    MOV         [0x5ee],AL
    JMP         FUN_1000_1408
LAB_1000_14ad:                ;XREF[1]:     1000:1419(*)
    XOR         BX,BX
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    MOV         AX,word [SI + -0x6]
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_47ec
    XCHG        DI,SI
    PUSH        SI
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    LAHF
    MOV         [0x5ee],AL
    POP         SI
    JMP         FUN_1000_1408
LAB_1000_1514:                ;XREF[1]:     1000:141b(*)
    LODSB ;       SI
    MOVZX       CX,AL
    XOR         BX,BX
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    DEC         CX
LAB_1000_1530:                ;XREF[1]:     1000:1547(j)
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    PUSH        CX
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    POP         CX
    LOOP        LAB_1000_1530
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_47ec
    XCHG        DI,SI
    MOV         BL,AL
    LODSW ;       SI
    MOV         [0xdb12],AX
    CMP         BL,0x3
    JL          FUN_1000_1408
    PUSH        SI
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    LAHF
    MOV         [0x5ee],AL
    POP         SI
    JS          FUN_1000_1408
    CALL        FUN_1000_2bec
    JMP         FUN_1000_1408
LAB_1000_1581:                ;XREF[1]:     1000:141d(*)
    JMP         FUN_1000_1408
LAB_1000_1584:                ;XREF[1]:     1000:141f(*)
    LODSB ;       SI
    MOVZX       CX,AL
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSW ;       SI
    MOV         BX,AX
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    DEC         CX
LAB_1000_15a1:                ;XREF[1]:     1000:15bb(j)
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSW ;       SI
    MOV         BX,AX
    PUSH        CX
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    POP         CX
    LOOP        LAB_1000_15a1
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSW ;       SI
    MOV         BX,AX
    XCHG        DI,SI
    CALL        FUN_1000_47ec
    XCHG        DI,SI
    MOV         BL,AL
    CMP         BL,0x3
    JL          FUN_1000_1408
    PUSH        SI
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    LAHF
    MOV         [0x5ee],AL
    POP         SI
    JS          FUN_1000_1408
    CALL        FUN_1000_30ee
    JMP         FUN_1000_1408
LAB_1000_15f4:                ;XREF[1]:     1000:1421(*)
    LODSB ;       SI
    MOVZX       CX,AL
    LODSW ;       SI
    MOV         [0xdb12],AX
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSW ;       SI
    MOV         BX,AX
    MOV         BX,word [BX + 0x50e]
    ADD         BX,word [0xdb12]
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    DEC         CX
LAB_1000_161d:                ;XREF[1]:     1000:163f(j)
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSW ;       SI
    MOV         BX,AX
    MOV         BX,word [BX + 0x50e]
    ADD         BX,word [0xdb12]
    PUSH        CX
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    POP         CX
    LOOP        LAB_1000_161d
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSW ;       SI
    MOV         BX,AX
    MOV         BX,word [BX + 0x50e]
    ADD         BX,word [0xdb12]
    XCHG        DI,SI
    CALL        FUN_1000_47ec
    XCHG        DI,SI
    MOV         BL,AL
    CMP         BL,0x3
    JL          FUN_1000_1408
    PUSH        SI
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    LAHF
    MOV         [0x5ee],AL
    POP         SI
    JS          FUN_1000_1408
    CALL        FUN_1000_30ee
    JMP         FUN_1000_1408
LAB_1000_1680:                ;XREF[1]:     1000:1423(*)
    LODSB ;       SI
    MOVZX       CX,AL
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSD ;       SI
    MOV         EBX,EAX
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    DEC         CX
LAB_1000_169f:                ;XREF[1]:     1000:16bb(j)
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSD ;       SI
    MOV         EBX,EAX
    PUSH        CX
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    POP         CX
    LOOP        LAB_1000_169f
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSD ;       SI
    MOV         EBX,EAX
    XCHG        DI,SI
    CALL        FUN_1000_47ec
    XCHG        DI,SI
    MOV         BL,AL
    CMP         BL,0x3
    JL          FUN_1000_1408
    PUSH        SI
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    LAHF
    MOV         [0x5ee],AL
    POP         SI
    JS          FUN_1000_1408
    CALL        FUN_1000_36fe
    JMP         FUN_1000_1408
LAB_1000_16f6:                ;XREF[1]:     1000:1425(*)
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    MOV         CX,word [DI + 0x2]
    CMP         CX,word [0x120]
    JL          LAB_1000_1760
    NOP
    NOP
    MOV         BX,word [DI + 0x6]
    MOV         BP,word [DI + 0x8]
    LODSW ;       SI
    CWD
    IDIV        CX
    MOV         DX,AX
    PUSH        ES
    MOV         AX,DS
    MOV         ES,AX
    MOV         DI,0xdb16
    MOV         AX,BX
    SUB         AX,DX
    STOSW ;       ES:DI
    MOV         AX,BP
    SUB         AX,DX
    STOSW ;       ES:DI
    MOVSD ;       ES:DI,SI
    MOV         AX,BX
    ADD         AX,DX
    STOSW ;       ES:DI
    MOV         AX,BP
    SUB         AX,DX
    STOSW ;       ES:DI
    MOVSD ;       ES:DI,SI
    MOV         AX,BX
    ADD         AX,DX
    STOSW ;       ES:DI
    MOV         AX,BP
    ADD         AX,DX
    STOSW ;       ES:DI
    MOVSD ;       ES:DI,SI
    MOV         AX,BX
    SUB         AX,DX
    STOSW ;       ES:DI
    MOV         AX,BP
    ADD         AX,DX
    STOSW ;       ES:DI
    MOVSD ;       ES:DI,SI
    POP         ES
    MOV         word [0xdb14],0x4
    CALL        FUN_1000_36fe
    JMP         FUN_1000_1408
LAB_1000_1760:                ;XREF[1]:     1000:170b(j)
    ADD         SI,0x12
    JMP         FUN_1000_1408
LAB_1000_1766:                ;XREF[1]:     1000:1427(*)
    PUSH        SI
    LODSW ;       SI
    SHL         AX,0x1
    MOV         BX,AX
    SHL         AX,0x2
    ADD         BX,AX
    MOV         AX,word [BX + 0x128]
    CMP         AX,word [0x120]
    JL          LAB_1000_190a
    LODSW ;       SI
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    LODSW ;       SI
    PUSH        BX
    PUSH        SI
    MOV         SI,BX
    MOV         AX,word [SI + 0x126]
    MOV         BX,word [SI + 0x128]
    MOV         CX,word [SI + 0x12a]
    SUB         AX,word [DI + 0x126]
    SUB         BX,word [DI + 0x128]
    SUB         CX,word [DI + 0x12a]
    CALL        FUN_1000_271d
    MOVSX       EBP,AX
    MOV         AX,word [SI + 0x126]
    MOV         BX,word [SI + 0x128]
    MOV         CX,word [SI + 0x12a]
    CALL        FUN_1000_271d
    IMUL        EBP
    MOV         EBP,EAX
    MOV         AX,word [DI + 0x126]
    SUB         AX,word [SI + 0x126]
    CWD
    IMUL        word [SI + 0x126]
    MOV         BX,AX
    MOV         CX,DX
    MOV         AX,word [DI + 0x128]
    SUB         AX,word [SI + 0x128]
    CWD
    IMUL        word [SI + 0x128]
    ADD         BX,AX
    ADC         CX,DX
    MOV         AX,word [DI + 0x12a]
    SUB         AX,word [SI + 0x12a]
    CWD
    IMUL        word [SI + 0x12a]
    ADD         AX,BX
    ADC         DX,CX
    XCHG        AX,DX
    ROR         EAX,0x10
    MOV         AX,DX
    SAR         EBP,0x9
    SHL         EAX,0x6
    CDQ
    IDIV        EBP
    SAR         EAX,0x1
    MOV         CX,0x8
    MOV         BX,0x5de
LAB_1000_1810:                ;XREF[1]:     1000:1819(j)
    CMP         AX,word [BX]
    JL          LAB_1000_181b
    NOP
    NOP
    ADD         BX,0x2
    LOOP        LAB_1000_1810
LAB_1000_181b:                ;XREF[1]:     1000:1812(j)
    POP         SI
    POP         BX
    SHL         CX,0x2
    ADD         SI,CX
    SHL         CX,0x2
    ADD         SI,CX
    MOV         CX,word [BX + 0x128]
    MOV         DX,word [BX + 0x12c]
    MOV         BP,word [BX + 0x12e]
    PUSH        DX
    PUSH        BP
    MOV         AX,word [DI + 0x12c]
    MOV         BX,word [DI + 0x12e]
    SUB         AX,DX
    SUB         BX,BP
    CALL        FUN_1000_2b08
    MOV         BX,AX
    CALL        FUN_1000_2aad
    MOV         BP,AX
    CALL        FUN_1000_2ad8
    MOV         BX,AX
    MOV         AX,word [SI]
    IMUL        BX
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         AX,DX
    CWD
    IDIV        CX
    MOV         [0x5d8],AX
    MOV         AX,word [SI]
    IMUL        BP
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         AX,DX
    CWD
    IDIV        CX
    MOV         [0x5d6],AX
    ADD         SI,0x2
    MOV         AX,word [SI]
    IMUL        BX
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         AX,DX
    CWD
    IDIV        CX
    MOV         [0x5dc],AX
    MOV         AX,word [SI]
    IMUL        BP
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         AX,DX
    CWD
    IDIV        CX
    MOV         [0x5da],AX
    ADD         SI,0x2
    POP         BP
    POP         BX
    PUSH        ES
    MOV         AX,DS
    MOV         ES,AX
    MOV         DI,0xdb16
    MOV         AX,BX
    SUB         AX,word [0x5d8]
    SUB         AX,word [0x5da]
    STOSW ;       ES:DI
    MOV         AX,BP
    ADD         AX,word [0x5d6]
    SUB         AX,word [0x5dc]
    STOSW ;       ES:DI
    MOVSD ;       ES:DI,SI
    MOV         AX,BX
    SUB         AX,word [0x5d8]
    ADD         AX,word [0x5da]
    STOSW ;       ES:DI
    MOV         AX,BP
    ADD         AX,word [0x5d6]
    ADD         AX,word [0x5dc]
    STOSW ;       ES:DI
    MOVSD ;       ES:DI,SI
    MOV         AX,BX
    ADD         AX,word [0x5d8]
    ADD         AX,word [0x5da]
    STOSW ;       ES:DI
    MOV         AX,BP
    SUB         AX,word [0x5d6]
    ADD         AX,word [0x5dc]
    STOSW ;       ES:DI
    MOVSD ;       ES:DI,SI
    MOV         AX,BX
    ADD         AX,word [0x5d8]
    SUB         AX,word [0x5da]
    STOSW ;       ES:DI
    MOV         AX,BP
    SUB         AX,word [0x5d6]
    SUB         AX,word [0x5dc]
    STOSW ;       ES:DI
    MOVSD ;       ES:DI,SI
    POP         ES
    MOV         word [0xdb14],0x4
    CALL        FUN_1000_36fe
LAB_1000_190a:                ;XREF[1]:     1000:1779(j)
    POP         SI
    ADD         SI,0xba
    JMP         FUN_1000_1408
LAB_1000_1912:                ;XREF[1]:     1000:1433(*)
    MOV         AL,[0x5ee]
    SAHF
    JS          LAB_1000_1933
    NOP
    NOP
    PUSH        SI
    MOV         AX,word [SI]
    ADD         SI,AX
    CALL        FUN_1000_1408
    POP         SI
    PUSH        SI
    MOV         AX,word [SI + 0x2]
    ADD         SI,AX
    CALL        FUN_1000_1408
    POP         SI
    ADD         SI,0x4
    JMP         FUN_1000_1408
LAB_1000_1933:                ;XREF[1]:     1000:1916(j)
    PUSH        SI
    MOV         AX,word [SI + 0x2]
    ADD         SI,AX
    CALL        FUN_1000_1408
    POP         SI
    PUSH        SI
    MOV         AX,word [SI]
    ADD         SI,AX
    CALL        FUN_1000_1408
    POP         SI
    ADD         SI,0x4
    JMP         FUN_1000_1408
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_194c:
                              ;XREF[8]:     1000:1a50(c),1000:1b06(c),1000:1bfa(c),1000:1caa(c),
                              ;             1000:2063(c),1000:2117(c),1000:220c(c),1000:22bc(c)
    MOV         DI,0x5bbc
    MOV         CX,word [0x5bba]
LAB_1000_1953:                ;XREF[1]:     1000:1962(j)
    MOV         SI,word [DI]
    CMP         DX,word [SI + 0x1a]
    JNZ         LAB_1000_195f
    NOP
    NOP
    CALL        FUN_1000_1323
LAB_1000_195f:                ;XREF[1]:     1000:1958(j)
    ADD         DI,0x2
    LOOP        LAB_1000_1953
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1965:
                              ;XREF[3]:     1000:02c9(c),1000:0395(c),1000:0455(c)
    MOV         word [0x19ff],0x0
    MOV         word [0x1a01],0xa00
    MOV         AX,[0xc6]
    TEST        AH,0x60
    JNP         LAB_1000_1f8e
    MOV         byte [0x5fb],0x0
    NOP
    CALL        FUN_1000_3fd0
    MOV         AX,[0xc6]
    TEST        AH,0xa0
    JNP         LAB_1000_1b3a
    MOV         DI,0x5bbc
    MOV         CX,word [0x5bba]
LAB_1000_1995:                ;XREF[1]:     1000:199f(j)
    PUSH        CX
    MOV         SI,word [DI]
    CALL        FUN_1000_22f0
    ADD         DI,0x2
    POP         CX
    LOOP        LAB_1000_1995
    MOV         SI,0xe590
    MOV         AX,[0xe58c]
    MOV         BH,AL
    SHL         AX,0x2
    ADD         SI,AX
LAB_1000_19ae:                ;XREF[1]:     1000:1b36(j)
    PUSH        BX
    MOV         BL,byte [SI]
    MOVZX       DX,BL
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
LAB_1000_19c5:                ;XREF[1]:     1000:1a63(j)
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX + 0xfeff]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [0xac]
    SUB         BX,word [0xb0]
    SUB         CX,word [0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],CX
    CMP         BX,word [0x120]
    JL          LAB_1000_1a16
    NOP
    NOP
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
LAB_1000_1a16:                ;XREF[1]:     1000:19ff(j)
    MOV         DX,word [0x5fd]
    CMP         DH,byte [0xe58c]
    JZ          LAB_1000_1a55
    NOP
    NOP
    CMP         DL,byte [SI]
    JZ          LAB_1000_1a55
    NOP
    NOP
    CMP         DL,byte [SI + -0x4]
    JBE         LAB_1000_1a55
    NOP
    NOP
    CMP         DL,byte [SI + -0x2]
    JA          LAB_1000_1a55
    NOP
    NOP
    PUSH        SI
    PUSH        DI
    SUB         DI,0xa
    MOV         SI,DI
    SUB         DI,word [0x19ff]
    ADD         DI,word [0x1a01]
    CALL        FUN_1000_1cde
    MOV         DX,word [0x5fd]
    SUB         DX,0x101
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
LAB_1000_1a55:                ;XREF[4]:     1000:1a1e(j),1000:1a24(j),1000:1a2b(j),1000:1a32(j)
    POP         BX
    CMP         BL,byte [0xad]
    JNC         LAB_1000_1a66
    NOP
    NOP
    INC         BL
    ADD         DI,0xa
    JMP         LAB_1000_19c5
LAB_1000_1a66:                ;XREF[1]:     1000:1a5a(j)
    MOV         BL,byte [SI + 0x2]
    MOVZX       DX,BL
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
LAB_1000_1a7d:                ;XREF[1]:     1000:1b19(j)
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX + 0xff00]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [0xac]
    SUB         BX,word [0xb0]
    SUB         CX,word [0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],CX
    CMP         BX,word [0x120]
    JL          LAB_1000_1ace
    NOP
    NOP
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
LAB_1000_1ace:                ;XREF[1]:     1000:1ab7(j)
    MOV         DX,word [0x5fd]
    CMP         DH,byte [0xe58c]
    JZ          LAB_1000_1b0b
    NOP
    NOP
    CMP         DL,byte [SI + 0x2]
    JZ          LAB_1000_1b0b
    NOP
    NOP
    CMP         DL,byte [SI + -0x4]
    JC          LAB_1000_1b0b
    NOP
    NOP
    CMP         DL,byte [SI + -0x2]
    JNC         LAB_1000_1b0b
    NOP
    NOP
    PUSH        SI
    PUSH        DI
    MOV         SI,DI
    SUB         DI,word [0x19ff]
    ADD         DI,word [0x1a01]
    CALL        FUN_1000_1cde
    MOV         DX,word [0x5fd]
    SUB         DX,0x100
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
LAB_1000_1b0b:                ;XREF[4]:     1000:1ad6(j),1000:1add(j),1000:1ae4(j),1000:1aeb(j)
    POP         BX
    CMP         BL,byte [0xad]
    JBE         LAB_1000_1b1c
    NOP
    NOP
    DEC         BL
    SUB         DI,0xa
    JMP         LAB_1000_1a7d
LAB_1000_1b1c:                ;XREF[1]:     1000:1b10(j)
    POP         BX
    CMP         BH,byte [0xe58e]
    JNC         LAB_1000_1b39
    NOP
    NOP
    INC         BH
    ADD         SI,0x4
    XOR         word [0x19ff],0xa00
    XOR         word [0x1a01],0xa00
    JMP         LAB_1000_19ae
LAB_1000_1b39:                ;XREF[1]:     1000:1b21(j)
    RET
LAB_1000_1b3a:                ;XREF[1]:     1000:198a(j)
    MOV         DI,0x5bbc
    MOV         CX,word [0x5bba]
LAB_1000_1b41:                ;XREF[1]:     1000:1b4b(j)
    PUSH        CX
    MOV         SI,word [DI]
    CALL        FUN_1000_233b
    ADD         DI,0x2
    POP         CX
    LOOP        LAB_1000_1b41
    MOV         SI,0xe590
    MOV         AX,[0xe58e]
    MOV         BH,AL
    SHL         AX,0x2
    ADD         SI,AX
LAB_1000_1b5a:                ;XREF[1]:     1000:1cda(j)
    PUSH        BX
    MOV         BL,byte [SI]
    MOVZX       DX,BL
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
LAB_1000_1b71:                ;XREF[1]:     1000:1c0d(j)
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX + -0x1]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [0xac]
    SUB         BX,word [0xb0]
    SUB         CX,word [0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],CX
    CMP         BX,word [0x120]
    JL          LAB_1000_1bc1
    NOP
    NOP
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
LAB_1000_1bc1:                ;XREF[1]:     1000:1baa(j)
    MOV         DX,word [0x5fd]
    CMP         DH,byte [0xe58e]
    JZ          LAB_1000_1bff
    NOP
    NOP
    CMP         DL,byte [SI]
    JZ          LAB_1000_1bff
    NOP
    NOP
    CMP         DL,byte [SI + 0x4]
    JBE         LAB_1000_1bff
    NOP
    NOP
    CMP         DL,byte [SI + 0x6]
    JA          LAB_1000_1bff
    NOP
    NOP
    PUSH        SI
    PUSH        DI
    SUB         DI,0xa
    MOV         SI,DI
    SUB         SI,word [0x19ff]
    ADD         SI,word [0x1a01]
    CALL        FUN_1000_1cde
    MOV         DX,word [0x5fd]
    SUB         DL,0x1
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
LAB_1000_1bff:                ;XREF[4]:     1000:1bc9(j),1000:1bcf(j),1000:1bd6(j),1000:1bdd(j)
    POP         BX
    CMP         BL,byte [0xad]
    JNC         LAB_1000_1c10
    NOP
    NOP
    INC         BL
    ADD         DI,0xa
    JMP         LAB_1000_1b71
LAB_1000_1c10:                ;XREF[1]:     1000:1c04(j)
    MOV         BL,byte [SI + 0x2]
    MOVZX       DX,BL
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
LAB_1000_1c27:                ;XREF[1]:     1000:1cbd(j)
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [0xac]
    SUB         BX,word [0xb0]
    SUB         CX,word [0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],CX
    CMP         BX,word [0x120]
    JL          LAB_1000_1c76
    NOP
    NOP
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
LAB_1000_1c76:                ;XREF[1]:     1000:1c5f(j)
    MOV         DX,word [0x5fd]
    CMP         DH,byte [0xe58e]
    JZ          LAB_1000_1caf
    NOP
    NOP
    CMP         DL,byte [SI + 0x2]
    JZ          LAB_1000_1caf
    NOP
    NOP
    CMP         DL,byte [SI + 0x4]
    JC          LAB_1000_1caf
    NOP
    NOP
    CMP         DL,byte [SI + 0x6]
    JNC         LAB_1000_1caf
    NOP
    NOP
    PUSH        SI
    PUSH        DI
    MOV         SI,DI
    SUB         SI,word [0x19ff]
    ADD         SI,word [0x1a01]
    CALL        FUN_1000_1cde
    MOV         DX,word [0x5fd]
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
LAB_1000_1caf:                ;XREF[4]:     1000:1c7e(j),1000:1c85(j),1000:1c8c(j),1000:1c93(j)
    POP         BX
    CMP         BL,byte [0xad]
    JBE         LAB_1000_1cc0
    NOP
    NOP
    DEC         BL
    SUB         DI,0xa
    JMP         LAB_1000_1c27
LAB_1000_1cc0:                ;XREF[1]:     1000:1cb4(j)
    POP         BX
    CMP         BH,byte [0xe58c]
    JBE         LAB_1000_1cdd
    NOP
    NOP
    DEC         BH
    SUB         SI,0x4
    XOR         word [0x19ff],0xa00
    XOR         word [0x1a01],0xa00
    JMP         LAB_1000_1b5a
LAB_1000_1cdd:                ;XREF[1]:     1000:1cc5(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1cde:
                              ;XREF[4]:     1000:1a45(c),1000:1afb(c),1000:1bf0(c),1000:1ca3(c)
    MOV         AL,[0x5fc]
    MOV         BX,0x1d51
    MOV         CX,word [DI + 0xc]
    ADD         CX,word [SI + 0x2]
    SAR         CX,0x2
    CMP         CX,word [0x5f5]
    JL          LAB_1000_1d66
    NOP
    NOP
    ADD         BH,CH
    XLAT      ;  BX
    MOV         AH,AL
    MOV         [0xdb12],AX
    PUSH        SI
    LEA         SI,[DI + 0xa]
    XOR         EBX,EBX
    CALL        FUN_1000_46a0
    MOV         SI,DI
    CALL        FUN_1000_46d3
    POP         SI
    CALL        FUN_1000_46d3
    PUSH        SI
    LEA         SI,[DI + 0xa]
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          LAB_1000_1d2a
    NOP
    NOP
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JNS         LAB_1000_1d2a
    NOP
    NOP
    CALL        FUN_1000_2bec
LAB_1000_1d2a:                ;XREF[2]:     1000:1d19(j),1000:1d23(j)
    LEA         SI,[DI + 0xa]
    XOR         EBX,EBX
    CALL        FUN_1000_46a0
    POP         SI
    CALL        FUN_1000_46d3
    ADD         SI,0xa
    CALL        FUN_1000_46d3
    LEA         SI,[DI + 0xa]
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          LAB_1000_1d65
    NOP
    NOP
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JNS         LAB_1000_1d65
    NOP
    NOP
    MOV         AX,[0xdb12]
    TEST        AL,0xf
    JZ          LAB_1000_1d62
    NOP
    NOP
    SUB         word [0xdb12],0x101
LAB_1000_1d62:                ;XREF[1]:     1000:1d58(j)
    CALL        FUN_1000_2bec
LAB_1000_1d65:                ;XREF[2]:     1000:1d45(j),1000:1d4f(j)
    RET
LAB_1000_1d66:                ;XREF[1]:     1000:1cf1(j)
    PUSH        FS
    MOV         FS,word [0x1a4b]
    MOV         AH,byte [0x5fc]
    MOV         BH,AL
    AND         BH,0xf0
    SHL         AH,0x4
    MOV         BL,0x80
    MOV         AL,0x80
    SHL         EBX,0x10
    MOV         BX,AX
    MOV         dword [0x1d4d],EBX
    PUSH        SI
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf00
    CALL        FUN_1000_46a0
    MOV         SI,DI
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0x0
    CALL        FUN_1000_46d3
    POP         SI
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf000000
    CALL        FUN_1000_46d3
    PUSH        SI
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf00
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          LAB_1000_1dde
    NOP
    NOP
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JNS         LAB_1000_1dde
    NOP
    NOP
    CALL        FUN_1000_36fe
LAB_1000_1dde:                ;XREF[2]:     1000:1dcd(j),1000:1dd7(j)
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf00
    CALL        FUN_1000_46a0
    POP         SI
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf000000
    CALL        FUN_1000_46d3
    ADD         SI,0xa
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf000f00
    CALL        FUN_1000_46d3
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf00
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          LAB_1000_1e37
    NOP
    NOP
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JNS         LAB_1000_1e37
    NOP
    NOP
    CALL        FUN_1000_36fe
LAB_1000_1e37:                ;XREF[2]:     1000:1e26(j),1000:1e30(j)
    POP         FS
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1e3a:
                              ;XREF[4]:     1000:2058(c),1000:210d(c),1000:2202(c),1000:22b5(c)
    MOV         AL,[0x5fc]
    MOV         BX,0x1d51
    MOV         CX,word [DI + 0xc]
    ADD         CX,word [SI + 0x2]
    SAR         CX,0x2
    CMP         CX,word [0x5f5]
    JL          LAB_1000_1ebf
    NOP
    NOP
    ADD         BH,CH
    XLAT     ;   BX
    MOV         AH,AL
    MOV         [0xdb12],AX
    PUSH        SI
    LEA         SI,[DI + 0xa]
    XOR         EBX,EBX
    CALL        FUN_1000_46a0
    MOV         SI,DI
    CALL        FUN_1000_46d3
    POP         SI
    CALL        FUN_1000_46d3
    PUSH        SI
    LEA         SI,[DI + 0xa]
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          LAB_1000_1e86
    NOP
    NOP
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JS          LAB_1000_1e86
    NOP
    NOP
    CALL        FUN_1000_2bec
LAB_1000_1e86:                ;XREF[2]:     1000:1e75(j),1000:1e7f(j)
    LEA         SI,[DI + 0xa]
    CALL        FUN_1000_46a0
    POP         SI
    CALL        FUN_1000_46d3
    ADD         SI,0xa
    CALL        FUN_1000_46d3
    LEA         SI,[DI + 0xa]
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          LAB_1000_1ebe
    NOP
    NOP
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JS          LAB_1000_1ebe
    NOP
    NOP
    MOV         AX,[0xdb12]
    TEST        AL,0xf
    JZ          LAB_1000_1ebb
    NOP
    NOP
    SUB         word [0xdb12],0x101
LAB_1000_1ebb:                ;XREF[1]:     1000:1eb1(j)
    CALL        FUN_1000_2bec
LAB_1000_1ebe:                ;XREF[2]:     1000:1e9e(j),1000:1ea8(j)
    RET
LAB_1000_1ebf:                ;XREF[1]:     1000:1e4d(j)
    PUSH        FS
    MOV         FS,word [0x1a4b]
    MOV         AH,byte [0x5fc]
    MOV         BH,AL
    AND         BH,0xf0
    SHL         AH,0x4
    MOV         BL,0x80
    MOV         AL,0x80
    SHL         EBX,0x10
    MOV         BX,AX
    MOV         dword [0x1d4d],EBX
    PUSH        SI
    LEA         SI,[DI + 0xa]
    OR          EBX,0xf000000
    CALL        FUN_1000_46a0
    MOV         SI,DI
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0x0
    CALL        FUN_1000_46d3
    POP         SI
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf00
    CALL        FUN_1000_46d3
    PUSH        SI
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf000000
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          LAB_1000_1f32
    NOP
    NOP
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JS          LAB_1000_1f32
    NOP
    NOP
    CALL        FUN_1000_36fe
LAB_1000_1f32:                ;XREF[2]:     1000:1f21(j),1000:1f2b(j)
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf000000
    CALL        FUN_1000_46a0
    POP         SI
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf00
    CALL        FUN_1000_46d3
    ADD         SI,0xa
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf000f00
    CALL        FUN_1000_46d3
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [0x1d4d]
    OR          EBX,0xf000000
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          LAB_1000_1f8b
    NOP
    NOP
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JS          LAB_1000_1f8b
    NOP
    NOP
    CALL        FUN_1000_36fe
LAB_1000_1f8b:                ;XREF[2]:     1000:1f7a(j),1000:1f84(j)
    POP         FS
    RET
LAB_1000_1f8e:                ;XREF[1]:     1000:1977(j)
    MOV         byte [0x5fb],0x1
    NOP
    CALL        FUN_1000_41b2
    MOV         AX,[0xc6]
    TEST        AH,0xc0
    JNS         LAB_1000_214b
    MOV         DI,0x5bbc
    MOV         CX,word [0x5bba]
LAB_1000_1fa8:                ;XREF[1]:     1000:1fb2(j)
    PUSH        CX
    MOV         SI,word [DI]
    CALL        FUN_1000_2384
    ADD         DI,0x2
    POP         CX
    LOOP        LAB_1000_1fa8
    MOV         SI,0xe590
    MOV         AX,[0xe58c]
    MOV         BL,AL
    SHL         AX,0x2
    ADD         SI,AX
LAB_1000_1fc1:                ;XREF[1]:     1000:2147(j)
    PUSH        BX
    MOV         BH,byte [SI]
    MOVZX       DX,BH
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
LAB_1000_1fd8:                ;XREF[1]:     1000:2076(j)
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX + 0xfeff]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [0xac]
    SUB         BX,word [0xb0]
    SUB         CX,word [0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],CX
    CMP         BX,word [0x120]
    JL          LAB_1000_2029
    NOP
    NOP
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
LAB_1000_2029:                ;XREF[1]:     1000:2012(j)
    MOV         DX,word [0x5fd]
    CMP         DL,byte [0xe58c]
    JZ          LAB_1000_2068
    NOP
    NOP
    CMP         DH,byte [SI]
    JZ          LAB_1000_2068
    NOP
    NOP
    CMP         DH,byte [SI + -0x4]
    JBE         LAB_1000_2068
    NOP
    NOP
    CMP         DH,byte [SI + -0x2]
    JA          LAB_1000_2068
    NOP
    NOP
    PUSH        SI
    PUSH        DI
    SUB         DI,0xa
    MOV         SI,DI
    SUB         DI,word [0x19ff]
    ADD         DI,word [0x1a01]
    CALL        FUN_1000_1e3a
    MOV         DX,word [0x5fd]
    SUB         DX,0x101
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
LAB_1000_2068:                ;XREF[4]:     1000:2031(j),1000:2037(j),1000:203e(j),1000:2045(j)
    POP         BX
    CMP         BH,byte [0xb1]
    JNC         LAB_1000_2079
    NOP
    NOP
    INC         BH
    ADD         DI,0xa
    JMP         LAB_1000_1fd8
LAB_1000_2079:                ;XREF[1]:     1000:206d(j)
    MOV         BH,byte [SI + 0x2]
    MOVZX       DX,BH
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
LAB_1000_2090:                ;XREF[1]:     1000:212a(j)
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX + -0x1]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [0xac]
    SUB         BX,word [0xb0]
    SUB         CX,word [0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],CX
    CMP         BX,word [0x120]
    JL          LAB_1000_20e0
    NOP
    NOP
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
LAB_1000_20e0:                ;XREF[1]:     1000:20c9(j)
    MOV         DX,word [0x5fd]
    CMP         DL,byte [0xe58c]
    JZ          LAB_1000_211c
    NOP
    NOP
    CMP         DH,byte [SI + 0x2]
    JZ          LAB_1000_211c
    NOP
    NOP
    CMP         DH,byte [SI + -0x4]
    JC          LAB_1000_211c
    NOP
    NOP
    CMP         DH,byte [SI + -0x2]
    JNC         LAB_1000_211c
    NOP
    NOP
    PUSH        SI
    PUSH        DI
    MOV         SI,DI
    SUB         DI,word [0x19ff]
    ADD         DI,word [0x1a01]
    CALL        FUN_1000_1e3a
    MOV         DX,word [0x5fd]
    SUB         DX,0x1
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
LAB_1000_211c:                ;XREF[4]:     1000:20e8(j),1000:20ef(j),1000:20f6(j),1000:20fd(j)
    POP         BX
    CMP         BH,byte [0xb1]
    JBE         LAB_1000_212d
    NOP
    NOP
    DEC         BH
    SUB         DI,0xa
    JMP         LAB_1000_2090
LAB_1000_212d:                ;XREF[1]:     1000:2121(j)
    POP         BX
    CMP         BL,byte [0xe58e]
    JNC         LAB_1000_214a
    NOP
    NOP
    INC         BL
    ADD         SI,0x4
    XOR         word [0x19ff],0xa00
    XOR         word [0x1a01],0xa00
    JMP         LAB_1000_1fc1
LAB_1000_214a:                ;XREF[1]:     1000:2132(j)
    RET
LAB_1000_214b:                ;XREF[1]:     1000:1f9d(j)
    MOV         DI,0x5bbc
    MOV         CX,word [0x5bba]
LAB_1000_2152:                ;XREF[1]:     1000:215c(j)
    PUSH        CX
    MOV         SI,word [DI]
    CALL        FUN_1000_23cf
    ADD         DI,0x2
    POP         CX
    LOOP        LAB_1000_2152
    MOV         SI,0xe590
    MOV         AX,[0xe58e]
    MOV         BL,AL
    SHL         AX,0x2
    ADD         SI,AX
LAB_1000_216b:                ;XREF[1]:     1000:22ec(j)
    PUSH        BX
    MOV         BH,byte [SI]
    MOVZX       DX,BH
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
LAB_1000_2182:                ;XREF[1]:     1000:221f(j)
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX + 0xff00]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [0xac]
    SUB         BX,word [0xb0]
    SUB         CX,word [0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],CX
    CMP         BX,word [0x120]
    JL          LAB_1000_21d3
    NOP
    NOP
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
LAB_1000_21d3:                ;XREF[1]:     1000:21bc(j)
    MOV         DX,word [0x5fd]
    CMP         DL,byte [0xe58e]
    JZ          LAB_1000_2211
    NOP
    NOP
    CMP         DH,byte [SI]
    JZ          LAB_1000_2211
    NOP
    NOP
    CMP         DH,byte [SI + 0x4]
    JBE         LAB_1000_2211
    NOP
    NOP
    CMP         DH,byte [SI + 0x6]
    JA          LAB_1000_2211
    NOP
    NOP
    PUSH        SI
    PUSH        DI
    SUB         DI,0xa
    MOV         SI,DI
    SUB         SI,word [0x19ff]
    ADD         SI,word [0x1a01]
    CALL        FUN_1000_1e3a
    MOV         DX,word [0x5fd]
    SUB         DH,0x1
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
LAB_1000_2211:                ;XREF[4]:     1000:21db(j),1000:21e1(j),1000:21e8(j),1000:21ef(j)
    POP         BX
    CMP         BH,byte [0xb1]
    JNC         LAB_1000_2222
    NOP
    NOP
    INC         BH
    ADD         DI,0xa
    JMP         LAB_1000_2182
LAB_1000_2222:                ;XREF[1]:     1000:2216(j)
    MOV         BH,byte [SI + 0x2]
    MOVZX       DX,BH
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
LAB_1000_2239:                ;XREF[1]:     1000:22cf(j)
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [0xac]
    SUB         BX,word [0xb0]
    SUB         CX,word [0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],CX
    CMP         BX,word [0x120]
    JL          LAB_1000_2288
    NOP
    NOP
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
LAB_1000_2288:                ;XREF[1]:     1000:2271(j)
    MOV         DX,word [0x5fd]
    CMP         DL,byte [0xe58e]
    JZ          LAB_1000_22c1
    NOP
    NOP
    CMP         DH,byte [SI + 0x2]
    JZ          LAB_1000_22c1
    NOP
    NOP
    CMP         DH,byte [SI + 0x4]
    JC          LAB_1000_22c1
    NOP
    NOP
    CMP         DH,byte [SI + 0x6]
    JNC         LAB_1000_22c1
    NOP
    NOP
    PUSH        SI
    PUSH        DI
    MOV         SI,DI
    SUB         SI,word [0x19ff]
    ADD         SI,word [0x1a01]
    CALL        FUN_1000_1e3a
    MOV         DX,word [0x5fd]
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
LAB_1000_22c1:                ;XREF[4]:     1000:2290(j),1000:2297(j),1000:229e(j),1000:22a5(j)
    POP         BX
    CMP         BH,byte [0xb1]
    JBE         LAB_1000_22d2
    NOP
    NOP
    DEC         BH
    SUB         DI,0xa
    JMP         LAB_1000_2239
LAB_1000_22d2:                ;XREF[1]:     1000:22c6(j)
    POP         BX
    CMP         BL,byte [0xe58c]
    JBE         LAB_1000_22ef
    NOP
    NOP
    DEC         BL
    SUB         SI,0x4
    XOR         word [0x19ff],0xa00
    XOR         word [0x1a01],0xa00
    JMP         LAB_1000_216b
LAB_1000_22ef:                ;XREF[1]:     1000:22d7(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_22f0:
                              ;XREF[1]:     1000:1998(c)
    PUSH        SI
    ADD         SI,word [SI]
    MOV         BP,word [SI]
    ADD         SI,0x2
    MOV         BX,0x0
    MOV         CX,0x7f7f
LAB_1000_22fe:                ;XREF[1]:     1000:2328(j)
    MOV         AH,byte [SI + 0x7]
    MOV         AL,byte [SI + 0x3]
    MOV         DX,AX
    SUB         AH,byte [0xb1]
    SUB         AL,byte [0xad]
    NEG         AH
    AND         AL,AL
    JGE         LAB_1000_2318
    NOP
    NOP
    NEG         AL
LAB_1000_2318:                ;XREF[1]:     1000:2312(j)
    CMP         AL,CL
    JL          LAB_1000_232f
    NOP
    NOP
LAB_1000_231e:                ;XREF[1]:     1000:2333(j)
    CMP         AH,CH
    JL          LAB_1000_2335
    NOP
    NOP
LAB_1000_2324:                ;XREF[1]:     1000:2339(j)
    ADD         SI,0x1c
    DEC         BP
    JNZ         LAB_1000_22fe
    POP         SI
    MOV         word [SI + 0x1a],BX
    RET
LAB_1000_232f:                ;XREF[1]:     1000:231a(j)
    MOV         BL,DL
    MOV         CL,AL
    JMP         LAB_1000_231e
LAB_1000_2335:                ;XREF[1]:     1000:2320(j)
    MOV         BH,DH
    MOV         CH,AH
    JMP         LAB_1000_2324
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_233b:
                              ;XREF[1]:     1000:1b44(c)
    PUSH        SI
    ADD         SI,word [SI]
    MOV         BP,word [SI]
    ADD         SI,0x2
    MOV         BX,0x0
    MOV         CX,0x7f7f
LAB_1000_2349:                ;XREF[1]:     1000:2371(j)
    MOV         AH,byte [SI + 0x7]
    MOV         AL,byte [SI + 0x3]
    MOV         DX,AX
    SUB         AH,byte [0xb1]
    SUB         AL,byte [0xad]
    AND         AL,AL
    JGE         LAB_1000_2361
    NOP
    NOP
    NEG         AL
LAB_1000_2361:                ;XREF[1]:     1000:235b(j)
    CMP         AL,CL
    JL          LAB_1000_2378
    NOP
    NOP
LAB_1000_2367:                ;XREF[1]:     1000:237c(j)
    CMP         AH,CH
    JL          LAB_1000_237e
    NOP
    NOP
LAB_1000_236d:                ;XREF[1]:     1000:2382(j)
    ADD         SI,0x1c
    DEC         BP
    JNZ         LAB_1000_2349
    POP         SI
    MOV         word [SI + 0x1a],BX
    RET
LAB_1000_2378:                ;XREF[1]:     1000:2363(j)
    MOV         BL,DL
    MOV         CL,AL
    JMP         LAB_1000_2367
LAB_1000_237e:                ;XREF[1]:     1000:2369(j)
    MOV         BH,DH
    MOV         CH,AH
    JMP         LAB_1000_236d
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2384:
                              ;XREF[1]:     1000:1fab(c)
    PUSH        SI
    ADD         SI,word [SI]
    MOV         BP,word [SI]
    ADD         SI,0x2
    MOV         BX,0x0
    MOV         CX,0x7f7f
LAB_1000_2392:                ;XREF[1]:     1000:23bc(j)
    MOV         AH,byte [SI + 0x7]
    MOV         AL,byte [SI + 0x3]
    MOV         DX,AX
    SUB         AH,byte [0xb1]
    SUB         AL,byte [0xad]
    AND         AH,AH
    JGE         LAB_1000_23aa
    NOP
    NOP
    NEG         AH
LAB_1000_23aa:                ;XREF[1]:     1000:23a4(j)
    NEG         AL
    CMP         AL,CL
    JL          LAB_1000_23c3
    NOP
    NOP
LAB_1000_23b2:                ;XREF[1]:     1000:23c7(j)
    CMP         AH,CH
    JL          LAB_1000_23c9
    NOP
    NOP
LAB_1000_23b8:                ;XREF[1]:     1000:23cd(j)
    ADD         SI,0x1c
    DEC         BP
    JNZ         LAB_1000_2392
    POP         SI
    MOV         word [SI + 0x1a],BX
    RET
LAB_1000_23c3:                ;XREF[1]:     1000:23ae(j)
    MOV         BL,DL
    MOV         CL,AL
    JMP         LAB_1000_23b2
LAB_1000_23c9:                ;XREF[1]:     1000:23b4(j)
    MOV         BH,DH
    MOV         CH,AH
    JMP         LAB_1000_23b8
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_23cf:
                              ;XREF[1]:     1000:2155(c)
    PUSH        SI
    ADD         SI,word [SI]
    MOV         BP,word [SI]
    ADD         SI,0x2
    MOV         BX,0x0
    MOV         CX,0x7f7f
LAB_1000_23dd:                ;XREF[1]:     1000:2405(j)
    MOV         AH,byte [SI + 0x7]
    MOV         AL,byte [SI + 0x3]
    MOV         DX,AX
    SUB         AH,byte [0xb1]
    SUB         AL,byte [0xad]
    AND         AH,AH
    JGE         LAB_1000_23f5
    NOP
    NOP
    NEG         AH
LAB_1000_23f5:                ;XREF[1]:     1000:23ef(j)
    CMP         AL,CL
    JL          LAB_1000_240c
    NOP
    NOP
LAB_1000_23fb:                ;XREF[1]:     1000:2410(j)
    CMP         AH,CH
    JL          LAB_1000_2412
    NOP
    NOP
LAB_1000_2401:                ;XREF[1]:     1000:2416(j)
    ADD         SI,0x1c
    DEC         BP
    JNZ         LAB_1000_23dd
    POP         SI
    MOV         word [SI + 0x1a],BX
    RET
LAB_1000_240c:                ;XREF[1]:     1000:23f7(j)
    MOV         BL,DL
    MOV         CL,AL
    JMP         LAB_1000_23fb
LAB_1000_2412:                ;XREF[1]:     1000:23fd(j)
    MOV         BH,DH
    MOV         CH,AH
    JMP         LAB_1000_2401
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2418:
                              ;XREF[2]:     1000:0b8d(c),1000:13f7(c)
    CMP         BX,word [0x120]
    JL          LAB_1000_242f
    NOP
    NOP
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    CLC
    RET
LAB_1000_242f:                ;XREF[1]:     1000:241c(j)
    STC
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2431:
                              ;XREF[1]:     1000:01b8(c)
    MOV         DI,SI
    MOV         CX,word [SI]
    INC         CX
    INC         CX
    MOV         word [SI + 0x20],CX
    MOV         DI,SI
    ADD         DI,CX
    MOV         CX,word [DI]
LAB_1000_2440:                ;XREF[1]:     1000:244b(j)
    CMP         word [DI + 0x1a],-0x1
    JZ          LAB_1000_244e
    NOP
    NOP
    ADD         DI,0x1c
    LOOP        LAB_1000_2440
    RET
LAB_1000_244e:                ;XREF[1]:     1000:2444(j)
    SUB         DI,SI
    MOV         word [SI + 0x20],DI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2454:
                              ;XREF[1]:     1000:01a9(c)
    CLI
    PUSH        AX
    PUSH        BX
    PUSH        ES
    PUSH        DI
    PUSH        DS
    POP         ES
    MOV         CX,0x82
    XOR         AL,AL
    CLD
    REP STOSB ;   ES:DI
    POP         DI
    POP         ES
    MOV         DX,DX
    MOV         AL,0x0
    MOV         AH,0x3d
    INT         0x21
    MOV         BX,AX
    JC          LAB_1000_24bc
    NOP
    NOP
    MOV         DX,DI
    MOV         CX,0x2710
    MOV         AH,0x3f
    INT         0x21
    MOV         BP,AX
    MOV         AH,0x3e
    INT         0x21
    POP         BX
    POP         AX
    PUSH        AX
    PUSH        BX
    CALL        FUN_1000_25c5
    MOV         CX,AX
    ADD         CX,0x64
    POP         BX
    POP         AX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         ECX,0x10
    MOV         EDX,ECX
    MOV         SI,DI
    ADD         SI,word [SI]
    MOV         CX,word [SI]
    ADD         SI,0x2
LAB_1000_24a8:                ;XREF[1]:     1000:24b6(j)
    ADD         dword [SI],EAX
    ADD         dword [SI + 0x4],EBX
    ADD         dword [SI + 0x8],EDX
    ADD         SI,0x1c
    LOOP        LAB_1000_24a8
    MOV         AX,BP
    STI
    RET
LAB_1000_24bc:                ;XREF[1]:     1000:246f(j)
    POP         BX
    POP         AX
    STI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_24c0:
                              ;XREF[1]:     1000:017e(c)
    PUSH        ES
    MOV         DX,0x1a03
    MOV         ES,word [0x1a45]
    XOR         DI,DI
    CALL        FUN_1000_5a60
    JC          LAB_1000_255a
    MOV         DX,0x1a20
    MOV         ES,word [0x1a4b]
    XOR         DI,DI
    CALL        FUN_1000_5a60
    JC          LAB_1000_255a
    NOP
    NOP
    MOV         DX,0x1a0b
    MOV         AL,0x0
    MOV         AH,0x3d
    INT         0x21
    MOV         BX,AX
    CALL        FUN_1000_5a95
    JC          LAB_1000_255a
    NOP
    NOP
    MOV         CX,0xffff
    MOV         DX,0xfd00
    MOV         AX,0x4202
    INT         0x21
    JC          LAB_1000_255a
    NOP
    NOP
    MOV         DX,0x1a4d
    MOV         CX,0x300
    MOV         AH,0x3f
    INT         0x21
    MOV         CX,0x0
    MOV         DX,0x80
    MOV         AX,0x4200
    INT         0x21
    MOV         ES,word [0x1a47]
    XOR         DI,DI
    CALL        FUN_1000_5acf
    JC          LAB_1000_255a
    NOP
    NOP
    MOV         AH,0x3e
    INT         0x21
    MOV         DX,0x1a2b
    MOV         AL,0x0
    MOV         AH,0x3d
    INT         0x21
    MOV         BX,AX
    MOV         DX,0x1d51
    MOV         CX,0x1100
    MOV         AH,0x3f
    INT         0x21
    MOV         AH,0x3e
    INT         0x21
    MOV         DX,0x1a33
    MOV         AL,0x0
    MOV         AH,0x3d
    INT         0x21
    MOV         BX,AX
    MOV         DX,0x2e51
    MOV         CX,0x1000
    MOV         AH,0x3f
    INT         0x21
    MOV         AH,0x3e
    INT         0x21
LAB_1000_255a:                ;XREF[5]:     1000:24cd(j),1000:24dd(j),1000:24ef(j),1000:24fe(j),
                              ;             1000:2520(j)
    POP         ES
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_255c:
                              ;XREF[1]:     1000:0181(c)
    PUSH        ES
    MOV         DX,0x1a13
    MOV         ES,word [0x1a49]
    XOR         DI,DI
    CALL        FUN_1000_5a60
    POP         ES
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_256b:
                              ;XREF[2]:     1000:261a(c),1000:265b(c)
    MOV         AX,[0x5ac1]
    IMUL        word [0x5ac9]
    MOV         [0x5ad7],AX
    MOV         AX,[0x5ac3]
    IMUL        word [0x5ac7]
    SUB         word [0x5ad7],AX
    MOV         AX,[0x5acd]
    IMUL        word [0x5ac9]
    MOV         [0x5ad3],AX
    MOV         AX,[0x5acf]
    IMUL        word [0x5ac7]
    SUB         word [0x5ad3],AX
    MOV         AX,[0x5acf]
    IMUL        word [0x5ac1]
    MOV         [0x5ad5],AX
    MOV         AX,[0x5acd]
    IMUL        word [0x5ac3]
    SUB         word [0x5ad5],AX
    MOV         AX,[0x5ac5]
    IMUL        word [0x5ad3]
    MOV         BX,AX
    MOV         CX,DX
    MOV         AX,[0x5acb]
    IMUL        word [0x5ad5]
    ADD         AX,BX
    ADC         DX,CX
    IDIV        word [0x5ad7]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_25c5:
                              ;XREF[9]:     1000:07b4(c),1000:07ec(c),1000:0810(c),1000:083e(c),
                              ;             1000:08e1(c),1000:09f6(c),1000:0c0d(c),1000:1372(c),
                              ;             1000:2486(c)
    MOV         word [0x5ac1],0x80
    MOV         word [0x5ac3],0x0
    MOV         word [0x5ac7],0x0
    MOV         word [0x5ac9],0x80
    SHR         AL,0x1
    SHR         BL,0x1
    MOV         CL,AL
    ADD         CL,BL
    CMP         CL,0x80
    JA          LAB_1000_2622
    NOP
    NOP
    MOV         [0x5acd],AL
    MOV         byte [0x5acf],BL
    MOV         BL,AH
    MOVZX       AX,byte GS:[BX]
    SHL         AX,0x4
    MOV         CX,AX
    MOVZX       AX,byte GS:[BX + 0x1]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         [0x5ac5],AX
    MOVZX       AX,byte GS:[BX + 0x100]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         [0x5acb],AX
    PUSH        CX
    CALL        FUN_1000_256b
    POP         CX
    ADD         AX,CX
    JMP         LAB_1000_2661
LAB_1000_2622:                ;XREF[1]:     1000:25e8(j)
    NEG         AL
    NEG         BL
    ADD         AL,0x80
    ADD         BL,0x80
    MOV         [0x5acd],AL
    MOV         byte [0x5acf],BL
    MOV         BL,AH
    MOVZX       AX,byte GS:[BX + 0x101]
    SHL         AX,0x4
    MOV         CX,AX
    MOVZX       AX,byte GS:[BX + 0x1]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         [0x5acb],AX
    MOVZX       AX,byte GS:[BX + 0x100]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         [0x5ac5],AX
    PUSH        CX
    CALL        FUN_1000_256b
    POP         CX
    ADD         AX,CX
LAB_1000_2661:                ;XREF[1]:     1000:2620(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2662:
                              ;XREF[13]:    1000:1509(c),1000:156f(c),1000:15e2(c),1000:166e(c),
                              ;             1000:16e4(c),1000:1d20(c),1000:1d4c(c),1000:1dd4(c),
                              ;             1000:1e2d(c),1000:1e7c(c),1000:1ea5(c),1000:1f28(c),
                              ;             1000:1f81(c)
    MOV         AX,word [SI]
    SUB         AX,word [SI + 0x8]
    MOV         DX,word [SI + 0x12]
    SUB         DX,word [SI + 0xa]
    IMUL        DX
    MOV         CX,AX
    MOV         BX,DX
    MOV         AX,word [SI + 0x10]
    SUB         AX,word [SI + 0x8]
    MOV         DX,word [SI + 0x2]
    SUB         DX,word [SI + 0xa]
    IMUL        DX
    SUB         AX,CX
    SBB         DX,BX
    RET

 ; 1000:26dc [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_26dd:
                              ;XREF[5]:     1000:06f3(c),1000:072a(c),1000:0870(c),1000:271d(c),
                              ;             1000:2722(c)
    PUSH        AX
    PUSH        BX
    CALL        FUN_1000_2b08
    TEST        AH,0x60
    JP          LAB_1000_2703
    NOP
    NOP
    MOV         BX,AX
    CALL        FUN_1000_2aad
    MOVSX       EBX,AX
    ADD         SP,0x2
    POP         AX
    SHL         EAX,0x10
    SAR         EAX,0x1
    CDQ
    IDIV        EBX
    RET
LAB_1000_2703:                ;XREF[1]:     1000:26e5(j)
    MOV         BX,AX
    CALL        FUN_1000_2ad8
    MOVSX       EBX,AX
    POP         AX
    ADD         SP,0x2
    SHL         EAX,0x10
    SAR         EAX,0x1
    CDQ
    IDIV        EBX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_271d:
                              ;XREF[4]:     1000:17a4(c),1000:17b7(c),1000:2738(c),1000:57cd(c)
    CALL        FUN_1000_26dd
    MOV         BX,CX
    CALL        FUN_1000_26dd
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2726:
                              ;XREF[3]:     1000:10b2(c),1000:10f2(c),1000:57d4(c)
    PUSH        EAX
    PUSH        EBX
    PUSH        ECX
    SAR         EAX,0x10
    SAR         EBX,0x10
    SAR         ECX,0x10
    CALL        FUN_1000_271d
    MOV         EBX,EAX
    INC         EBX
    POP         EAX
    CDQ
    IDIV        EBX
    MOV         ECX,EAX
    POP         EAX
    CDQ
    IDIV        EBX
    POP         EDX
    PUSH        EAX
    MOV         EAX,EDX
    CDQ
    IDIV        EBX
    POP         EBX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2760:
                              ;XREF[13]:    1000:1a03(c),1000:1abb(c),1000:1bae(c),1000:1c63(c),
                              ;             1000:2016(c),1000:20cd(c),1000:21c0(c),1000:2275(c),
                              ;             1000:2420(c),1000:4739(c),1000:47a6(c),1000:4836(c),
                              ;             1000:4897(c)
    MOV         DX,AX
    MOV         AL,DH
    CBW
    XCHG        AX,DX
    MOV         AH,AL
    XOR         AL,AL
    IDIV        BX
    XCHG        AX,CX
    MOV         DX,AX
    MOV         AL,DH
    CBW
    XCHG        AX,DX
    MOV         AH,AL
    XOR         AL,AL
    IDIV        BX
    XCHG        CX,BX
    XCHG        AX,BX
    RET

 ; 1000:277d [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_277e:
                              ;XREF[10]:    1000:0b88(c),1000:13ea(c),1000:19ee(c),1000:1aa6(c),
                              ;             1000:1b99(c),1000:1c4e(c),1000:2001(c),1000:20b8(c),
                              ;             1000:21ab(c),1000:2260(c)
    XCHG        AX,BX
    XCHG        AX,CX
    PUSH        DI
    MOV         DI,DX
    PUSH        ES
    MOV         ES,AX
    MOV         AX,BX
    IMUL        word [DI]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         BP,DX
    MOV         AX,CX
    IMUL        word [DI + 0x6]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         BP,DX
    MOV         AX,ES
    IMUL        word [DI + 0xc]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         BP,DX
    PUSH        BP
    MOV         AX,BX
    IMUL        word [DI + 0x2]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         BP,DX
    MOV         AX,CX
    IMUL        word [DI + 0x8]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         BP,DX
    MOV         AX,ES
    IMUL        word [DI + 0xe]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         BP,DX
    PUSH        BP
    MOV         AX,BX
    IMUL        word [DI + 0x4]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         BP,DX
    MOV         AX,CX
    IMUL        word [DI + 0xa]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         BP,DX
    MOV         AX,ES
    IMUL        word [DI + 0x10]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         BP,DX
    MOV         CX,BP
    POP         BX
    POP         AX
    POP         ES
    POP         DI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_27f1:
                              ;XREF[3]:     1000:02bd(c),1000:0389(c),1000:0452(c)
    MOV         AX,word [DI + 0x2]
    XCHG        word [DI + 0x6],AX
    MOV         word [DI + 0x2],AX
    MOV         AX,word [DI + 0x4]
    XCHG        word [DI + 0xc],AX
    MOV         word [DI + 0x4],AX
    MOV         AX,word [DI + 0xa]
    XCHG        word [DI + 0xe],AX
    MOV         word [DI + 0xa],AX
    RET

 ; 1000:2988 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2989:
                              ;XREF[3]:     1000:02ba(c),1000:0386(c),1000:044f(c)
    MOV         BX,word [SI]
    CALL        FUN_1000_2aad
    MOV         [0xd100],AX
    CALL        FUN_1000_2ad8
    MOV         [0xd102],AX
    MOV         BX,word [SI + 0x2]
    CALL        FUN_1000_2aad
    MOV         [0xd104],AX
    CALL        FUN_1000_2ad8
    MOV         [0xd106],AX
    MOV         BX,word [SI + 0x4]
    CALL        FUN_1000_2aad
    NEG         AX
    MOV         [0xd108],AX
    CALL        FUN_1000_2ad8
    MOV         [0xd10a],AX
    MOV         AX,[0xd100]
    IMUL        word [0xd104]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         AX,DX
    MOV         BX,AX
    IMUL        word [0xd108]
    SHL         AX,0x1
    RCL         DX,0x1
    CMP         DX,0x8000
    JNZ         LAB_1000_29d7
    NOP
    NOP
    INC         DX
LAB_1000_29d7:                ;XREF[1]:     1000:29d2(j)
    NEG         DX
    MOV         CX,DX
    MOV         AX,[0xd102]
    IMUL        word [0xd10a]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         AX,DX
    ADD         DX,CX
    MOV         word [DI],DX
    XCHG        AX,BX
    IMUL        word [0xd10a]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         CX,DX
    MOV         AX,[0xd108]
    IMUL        word [0xd102]
    SHL         AX,0x1
    RCL         DX,0x1
    XCHG        DX,CX
    ADD         DX,CX
    CMP         DX,0x8000
    JNZ         LAB_1000_2a0f
    NOP
    NOP
    INC         DX
LAB_1000_2a0f:                ;XREF[1]:     1000:2a0a(j)
    NEG         DX
    MOV         word [DI + 0x2],DX
    MOV         AX,[0xd100]
    IMUL        word [0xd106]
    SHL         AX,0x1
    RCL         DX,0x1
    CMP         DX,0x8000
    JNZ         LAB_1000_2a28
    NOP
    NOP
    INC         DX
LAB_1000_2a28:                ;XREF[1]:     1000:2a23(j)
    NEG         DX
    MOV         word [DI + 0x4],DX
    MOV         AX,[0xd108]
    IMUL        word [0xd106]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         word [DI + 0x6],DX
    MOV         AX,[0xd10a]
    IMUL        word [0xd106]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         word [DI + 0x8],DX
    MOV         DX,word [0xd104]
    CMP         DX,0x8000
    JNZ         LAB_1000_2a56
    NOP
    NOP
    INC         DX
LAB_1000_2a56:                ;XREF[1]:     1000:2a51(j)
    NEG         DX
    MOV         word [DI + 0xa],DX
    MOV         AX,CX
    IMUL        word [0xd104]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         CX,DX
    MOV         AX,[0xd10a]
    IMUL        word [0xd100]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         DX,CX
    MOV         word [DI + 0xc],DX
    MOV         AX,BX
    IMUL        word [0xd104]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         CX,DX
    MOV         AX,[0xd100]
    IMUL        word [0xd108]
    SHL         AX,0x1
    RCL         DX,0x1
    CMP         DX,0x8000
    JNZ         LAB_1000_2a97
    NOP
    NOP
    INC         DX
LAB_1000_2a97:                ;XREF[1]:     1000:2a92(j)
    NEG         DX
    ADD         DX,CX
    MOV         word [DI + 0xe],DX
    MOV         AX,[0xd102]
    IMUL        word [0xd106]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         word [DI + 0x10],DX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2aad:
                              ;XREF[19]:    1000:02a2(c),1000:036e(c),1000:0437(c),1000:07a9(c),
                              ;             1000:07e1(c),1000:0805(c),1000:08b2(c),1000:09c0(c),
                              ;             1000:1168(c),1000:1222(c),1000:1846(c),1000:26eb(c),
                              ;             1000:298b(c),1000:299a(c),1000:29a9(c),1000:4a48(c),
                              ;             1000:4a5f(c),1000:4b9b(c),1000:57bd(c)
    MOV         AX,BX
    AND         AH,0x7f
    TEST        AH,0x40
    JZ          LAB_1000_2abe
    NOP
    NOP
    NEG         AX
    ADD         AX,0x8000
LAB_1000_2abe:                ;XREF[1]:     1000:2ab5(j)
    SHR         AX,0x1
    SHR         AX,0x1
    SHR         AX,0x1
    AND         AL,0xfe
    PUSH        BX
    MOV         BX,AX
    MOV         AX,word [BX + 0xd10c]
    POP         BX
    TEST        BH,0x80
    JZ          LAB_1000_2ad7
    NOP
    NOP
    NEG         AX
LAB_1000_2ad7:                ;XREF[1]:     1000:2ad1(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2ad8:
                              ;XREF[19]:    1000:02ab(c),1000:0377(c),1000:0440(c),1000:079c(c),
                              ;             1000:07d4(c),1000:07f8(c),1000:08ad(c),1000:09bb(c),
                              ;             1000:1174(c),1000:122e(c),1000:184b(c),1000:2705(c),
                              ;             1000:2991(c),1000:29a0(c),1000:29b1(c),1000:4a4e(c),
                              ;             1000:4a65(c),1000:4b90(c),1000:57c1(c)
    MOV         AX,BX
    AND         AH,0x7f
    TEST        AH,0x40
    JZ          LAB_1000_2ae9
    NOP
    NOP
    SUB         AX,0x4000
    JMP         LAB_1000_2aee
LAB_1000_2ae9:                ;XREF[1]:     1000:2ae0(j)
    NEG         AX
    ADD         AX,0x4000
LAB_1000_2aee:                ;XREF[1]:     1000:2ae7(j)
    SHR         AX,0x1
    SHR         AX,0x1
    SHR         AX,0x1
    AND         AL,0xfe
    PUSH        BX
    MOV         BX,AX
    MOV         AX,word [BX + 0xd10c]
    POP         BX
    TEST        BH,0xc0
    JP          LAB_1000_2b07
    NOP
    NOP
    NEG         AX
LAB_1000_2b07:                ;XREF[1]:     1000:2b01(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2b08:
                              ;XREF[19]:    1000:06e0(c),1000:0701(c),1000:0712(c),1000:0731(c),
                              ;             1000:078d(c),1000:07be(c),1000:0819(c),1000:0863(c),
                              ;             1000:087c(c),1000:08a5(c),1000:0907(c),1000:09b3(c),
                              ;             1000:0a20(c),1000:1841(c),1000:26df(c),1000:4a43(c),
                              ;             1000:4a5a(c),1000:4c64(c),1000:57c7(c)
    AND         AX,AX
    JS          LAB_1000_2b61
    NOP
    NOP
    JNZ         FUN_1000_2b1f
    NOP
    NOP
    MOV         AX,0x0
    TEST        BX,BX
    JNS         LAB_1000_2b1e
    NOP
    NOP
    ADD         AX,0x8000
LAB_1000_2b1e:                ;XREF[1]:     1000:2b17(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2b1f:
                              ;XREF[2]:     1000:2b0e(j),1000:2b63(c)
    AND         BX,BX
    JS          LAB_1000_2b56
    NOP
    NOP
    JNZ         FUN_1000_2b2d
    NOP
    NOP
    MOV         AX,0x4000
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2b2d:
                              ;XREF[2]:     1000:2b25(j),1000:2b58(c)
    CMP         AX,BX
    JG          LAB_1000_2b4c
    NOP
    NOP
    JL          FUN_1000_2b3b
    NOP
    NOP
    MOV         AX,0x2000
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2b3b:
                              ;XREF[2]:     1000:2b33(j),1000:2b4d(c)
    MOV         DX,AX
    XOR         AX,AX
    DIV         BX
    MOV         BL,AH
    XOR         BH,BH
    SHL         BX,0x1
    MOV         AX,word [BX + 0xd90e]
    RET
LAB_1000_2b4c:                ;XREF[1]:     1000:2b2f(j)
    XCHG        AX,BX
    CALL        FUN_1000_2b3b
    NEG         AX
    ADD         AX,0x4000
    RET
LAB_1000_2b56:                ;XREF[1]:     1000:2b21(j)
    NOT         BX
    CALL        FUN_1000_2b2d
    NEG         AX
    ADD         AX,0x8000
    RET
LAB_1000_2b61:                ;XREF[1]:     1000:2b0a(j)
    NOT         AX
    CALL        FUN_1000_2b1f
    NEG         AX
    RET

 ; 1000:2b6f [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2b70:
                              ;XREF[1]:     1000:021c(c)
    MOV         AH,0x48
    MOV         BX,0xfa0
    INT         0x21
    JC          LAB_1000_2b89
    NOP
    NOP
    MOV         [0xdb10],AX
    MOV         AX,0x13
    INT         0x10
    MOV         DX,0x3c2
    MOV         AL,0xe3
    OUT         DX,AL
LAB_1000_2b89:                ;XREF[1]:     1000:2b77(j)
    RET

 ; 1000:2b97 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2b98:
                              ;XREF[2]:     1000:02c6(c),1000:0392(c)
    PUSH        ES
    PUSH        DI
    MOV         ES,word [0xdb10]
    XOR         DI,DI
    MOV         CX,0x3e80
    CLD
    REP STOSD ;   ES:DI
    POP         DI
    POP         ES
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2baa:
                              ;XREF[1]:     1000:04f7(c)
    PUSH        DS
    MOV         DS,word [0xdb10]
    XOR         SI,SI
    MOV         AX,0xa000
    MOV         ES,AX
    XOR         DI,DI
    MOV         CX,0x3e80
    CLD
    REP MOVSD ;   ES:DI,SI
    POP         DS
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2bc1:
                              ;XREF[1]:     1000:0226(c)
    MOV         CX,0x100
    MOV         DX,0x3c8
    MOV         AH,0x0
LAB_1000_2bc9:                ;XREF[1]:     1000:2be9(j)
    MOV         AL,AH
    CLI
    OUT         DX,AL
    JMP         LAB_1000_2bcf
LAB_1000_2bcf:                ;XREF[1]:     1000:2bcd(j)
    INC         DX
    LODSB ;       SI
    SHR         AL,0x2
    OUT         DX,AL
    JMP         LAB_1000_2bd7
LAB_1000_2bd7:                ;XREF[1]:     1000:2bd5(j)
    LODSB ;       SI
    SHR         AL,0x2
    OUT         DX,AL
    JMP         LAB_1000_2bde
LAB_1000_2bde:                ;XREF[1]:     1000:2bdc(j)
    LODSB ;       SI
    SHR         AL,0x2
    OUT         DX,AL
    JMP         LAB_1000_2be5
LAB_1000_2be5:                ;XREF[1]:     1000:2be3(j)
    DEC         DX
    STI
    INC         AH
    LOOP        LAB_1000_2bc9
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2bec:
                              ;XREF[5]:     1000:157b(c),1000:1d27(c),1000:1d62(c),1000:1e83(c),
                              ;             1000:1ebb(c)
    PUSH        SI
    PUSH        DI
    MOV         SI,0xdb16
    MOV         DI,0xdb68
    CALL        FUN_1000_2df2
    XCHG        DI,SI
    CALL        FUN_1000_2eaf
    XCHG        DI,SI
    CALL        FUN_1000_2f6c
    XCHG        DI,SI
    CALL        FUN_1000_302d
    MOV         SI,DI
    MOV         CX,word [SI + -0x2]
    CMP         CX,0x3
    JC          LAB_1000_2c48
    NOP
    NOP
    MOV         AX,[0xdbbe]
    MOV         [0xdbc4],AX
    MOV         AX,[0xdbbc]
    MOV         [0xdbc6],AX
    PUSH        SI
    DEC         CX
LAB_1000_2c20:                ;XREF[1]:     1000:2c35(j)
    PUSH        CX
    PUSH        SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         CX,word [SI + 0x8]
    MOV         DX,word [SI + 0xa]
    CALL        FUN_1000_2c4b
    POP         SI
    POP         CX
    ADD         SI,0x8
    LOOP        LAB_1000_2c20
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    POP         SI
    MOV         CX,word [SI]
    MOV         DX,word [SI + 0x2]
    CALL        FUN_1000_2c4b
    CALL        FUN_1000_2d61
LAB_1000_2c48:                ;XREF[1]:     1000:2c0e(j)
    POP         DI
    POP         SI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2c4b:
                              ;XREF[6]:     1000:2c2d(c),1000:2c42(c),1000:312f(c),1000:3144(c),
                              ;             1000:373f(c),1000:3754(c)
    XCHG        DX,CX
    CMP         BX,CX
    JLE         LAB_1000_2c79
    NOP
    NOP
    XCHG        AX,DX
    XCHG        CX,BX
    CMP         BX,word [0xdbc4]
    JGE         LAB_1000_2c62
    NOP
    NOP
    MOV         word [0xdbc4],BX
LAB_1000_2c62:                ;XREF[1]:     1000:2c5a(j)
    CMP         CX,word [0xdbc6]
    JLE         LAB_1000_2c6e
    NOP
    NOP
    MOV         word [0xdbc6],CX
LAB_1000_2c6e:                ;XREF[1]:     1000:2c66(j)
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0xdbca
    JMP         LAB_1000_2c9a
LAB_1000_2c79:                ;XREF[1]:     1000:2c4f(j)
    CMP         BX,word [0xdbc4]
    JGE         LAB_1000_2c85
    NOP
    NOP
    MOV         word [0xdbc4],BX
LAB_1000_2c85:                ;XREF[1]:     1000:2c7d(j)
    CMP         CX,word [0xdbc6]
    JLE         LAB_1000_2c91
    NOP
    NOP
    MOV         word [0xdbc6],CX
LAB_1000_2c91:                ;XREF[1]:     1000:2c89(j)
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0xdbc8
LAB_1000_2c9a:                ;XREF[1]:     1000:2c77(j)
    JCXZ        LAB_1000_2cce
    PUSH        AX
    SUB         DX,AX
    MOV         AX,DX
    SHL         EAX,0x10
    CDQ
    MOVSX       ECX,CX
    IDIV        ECX
    MOV         EDX,EAX
    POP         AX
    SHL         EAX,0x10
LAB_1000_2cb6:                ;XREF[1]:     1000:2cc6(j)
    ROR         EAX,0x10
    MOV         word [BX],AX
    ADD         BX,0x4
    ROL         EAX,0x10
    ADD         EAX,EDX
    LOOP        LAB_1000_2cb6
    ROR         EAX,0x10
    MOV         word [BX],AX
LAB_1000_2cce:                ;XREF[1]:     1000:2c9a(j)
    RET

 ; 1000:2d60 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2d61:
                              ;XREF[1]:     1000:2c45(c)
    MOV         BX,word [0xdbc4]
    MOV         DX,word [0xdbc6]
    SUB         DX,BX
    JZ          LAB_1000_2db8
    NOP
    NOP
    INC         DX
    SHL         BX,0x2
    PUSH        ES
    MOV         AX,[0xdb10]
    MOV         ES,AX
    MOV         SI,BX
    CMP         word [0xdb12],0xf0f0
    JNC         LAB_1000_2db9
    NOP
    NOP
LAB_1000_2d85:                ;XREF[1]:     1000:2db5(j)
    MOV         DI,SI
    SHL         DI,0x2
    ADD         DI,SI
    SHL         DI,0x4
    MOV         AX,word [SI + 0xdbc8]
    MOV         CX,word [SI + 0xdbca]
    SUB         CX,AX
    JNS         LAB_1000_2da1
    NOP
    NOP
    ADD         AX,CX
    NEG         CX
LAB_1000_2da1:                ;XREF[1]:     1000:2d99(j)
    INC         CX
    ADD         DI,AX
    CLD
    MOV         AX,[0xdb12]
    SHR         CX,0x1
    REP STOSW ;   ES:DI
    JNC         LAB_1000_2db1
    NOP
    NOP
    STOSB ;       ES:DI
LAB_1000_2db1:                ;XREF[1]:     1000:2dac(j)
    ADD         SI,0x4
    DEC         DX
    JNZ         LAB_1000_2d85
    POP         ES
LAB_1000_2db8:                ;XREF[1]:     1000:2d6b(j)
    RET
LAB_1000_2db9:                ;XREF[1]:     1000:2d81(j)
    MOV         BX,word [0xdb12]
    SUB         BH,0xf0
LAB_1000_2dc0:                ;XREF[1]:     1000:2dee(j)
    MOV         DI,SI
    SHL         DI,0x2
    ADD         DI,SI
    SHL         DI,0x4
    MOV         AX,word [SI + 0xdbc8]
    MOV         CX,word [SI + 0xdbca]
    SUB         CX,AX
    JNS         LAB_1000_2ddc
    NOP
    NOP
    ADD         AX,CX
    NEG         CX
LAB_1000_2ddc:                ;XREF[1]:     1000:2dd4(j)
    INC         CX
    ADD         DI,AX
    CLD
LAB_1000_2de0:                ;XREF[1]:     1000:2de8(j)
    MOV         BL,byte ES:[DI]
    MOV         AL,byte [BX + 0x2e51]
    STOSB ;       ES:DI
    LOOP        LAB_1000_2de0
    ADD         SI,0x4
    DEC         DX
    JNZ         LAB_1000_2dc0
    POP         ES
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2df2:
                              ;XREF[1]:     1000:2bf4(c)
    PUSH        SI
    PUSH        DI
    XOR         BP,BP
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_2e3a
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    POP         DI
    ADD         SI,0x8
    CMP         AX,word [0xdbc0]
    JL          LAB_1000_2e93
    NOP
    NOP
LAB_1000_2e19:                ;XREF[2]:     1000:2e38(j),1000:2e8b(j)
    PUSH        CX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x8
    CMP         AX,word [0xdbc0]
    JL          LAB_1000_2e40
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_2e19
LAB_1000_2e3a:                ;XREF[1]:     1000:2df9(j)
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_2e40:                ;XREF[1]:     1000:2e33(j)
    PUSH        AX
    PUSH        BX
    SUB         CX,word [0xdbc0]
    JZ          LAB_1000_2e5f
    NOP
    NOP
    SUB         AX,word [0xdbc0]
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    MOV         AX,[0xdbc0]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
LAB_1000_2e5f:                ;XREF[1]:     1000:2e46(j)
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_2e93
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_2e6a:                ;XREF[1]:     1000:2ea4(j)
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    SUB         AX,word [0xdbc0]
    SUB         CX,word [0xdbc0]
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    MOV         AX,[0xdbc0]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_2e19
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_2e93:                ;XREF[3]:     1000:2e15(j),1000:2e62(j),1000:2ea7(j)
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x8
    CMP         AX,word [0xdbc0]
    JGE         LAB_1000_2e6a
    POP         CX
    LOOP        LAB_1000_2e93
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2eaf:
                              ;XREF[1]:     1000:2bf9(c)
    PUSH        SI
    PUSH        DI
    XOR         BP,BP
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_2ef7
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    POP         DI
    ADD         SI,0x8
    CMP         AX,word [0xdbc2]
    JG          LAB_1000_2f50
    NOP
    NOP
LAB_1000_2ed6:                ;XREF[2]:     1000:2ef5(j),1000:2f48(j)
    PUSH        CX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x8
    CMP         AX,word [0xdbc2]
    JG          LAB_1000_2efd
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_2ed6
LAB_1000_2ef7:                ;XREF[1]:     1000:2eb6(j)
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_2efd:                ;XREF[1]:     1000:2ef0(j)
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    SUB         CX,word [0xdbc2]
    JZ          LAB_1000_2f1f
    NOP
    NOP
    SUB         AX,word [0xdbc2]
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    MOV         AX,[0xdbc2]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
LAB_1000_2f1f:                ;XREF[1]:     1000:2f06(j)
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_2f50
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_2f2a:                ;XREF[1]:     1000:2f61(j)
    PUSH        AX
    PUSH        BX
    SUB         AX,word [0xdbc2]
    SUB         CX,word [0xdbc2]
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    MOV         AX,[0xdbc2]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_2ed6
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_2f50:                ;XREF[3]:     1000:2ed2(j),1000:2f22(j),1000:2f64(j)
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x8
    CMP         AX,word [0xdbc2]
    JLE         LAB_1000_2f2a
    POP         CX
    LOOP        LAB_1000_2f50
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2f6c:
                              ;XREF[1]:     1000:2bfe(c)
    PUSH        SI
    PUSH        DI
    XOR         BP,BP
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_2fb4
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    POP         DI
    ADD         SI,0x8
    CMP         BX,word [0xdbbc]
    JL          LAB_1000_3011
LAB_1000_2f93:                ;XREF[2]:     1000:2fb2(j),1000:3009(j)
    PUSH        CX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x8
    CMP         BX,word [0xdbbc]
    JL          LAB_1000_2fba
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_2f93
LAB_1000_2fb4:                ;XREF[1]:     1000:2f73(j)
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_2fba:                ;XREF[1]:     1000:2fad(j)
    PUSH        AX
    PUSH        BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [0xdbbc]
    JZ          LAB_1000_2fdb
    NOP
    NOP
    SUB         AX,word [0xdbbc]
    CALL        FUN_1000_3f7a
    MOV         BX,word [0xdbbc]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
LAB_1000_2fdb:                ;XREF[1]:     1000:2fc3(j)
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_3011
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_2fe6:                ;XREF[1]:     1000:3022(j)
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [0xdbbc]
    SUB         CX,word [0xdbbc]
    CALL        FUN_1000_3f7a
    MOV         BX,word [0xdbbc]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_2f93
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_3011:                ;XREF[3]:     1000:2f8f(j),1000:2fde(j),1000:3025(j)
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x8
    CMP         BX,word [0xdbbc]
    JGE         LAB_1000_2fe6
    POP         CX
    LOOP        LAB_1000_3011
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_302d:
                              ;XREF[1]:     1000:2c03(c)
    PUSH        SI
    PUSH        DI
    XOR         BP,BP
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_3075
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    POP         DI
    ADD         SI,0x8
    CMP         BX,word [0xdbbe]
    JG          LAB_1000_30d2
LAB_1000_3054:                ;XREF[2]:     1000:3073(j),1000:30ca(j)
    PUSH        CX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x8
    CMP         BX,word [0xdbbe]
    JG          LAB_1000_307b
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_3054
LAB_1000_3075:                ;XREF[1]:     1000:3034(j)
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_307b:                ;XREF[1]:     1000:306e(j)
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [0xdbbe]
    JZ          LAB_1000_309f
    NOP
    NOP
    SUB         AX,word [0xdbbe]
    CALL        FUN_1000_3f7a
    MOV         BX,word [0xdbbe]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
LAB_1000_309f:                ;XREF[1]:     1000:3087(j)
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_30d2
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_30aa:                ;XREF[1]:     1000:30e3(j)
    PUSH        AX
    PUSH        BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [0xdbbe]
    SUB         CX,word [0xdbbe]
    CALL        FUN_1000_3f7a
    MOV         BX,word [0xdbbe]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_3054
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_30d2:                ;XREF[3]:     1000:3050(j),1000:30a2(j),1000:30e6(j)
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x8
    CMP         BX,word [0xdbbe]
    JLE         LAB_1000_30aa
    POP         CX
    LOOP        LAB_1000_30d2
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_30ee:
                              ;XREF[2]:     1000:15ee(c),1000:167a(c)
    PUSH        SI
    PUSH        DI
    MOV         SI,0xdb16
    MOV         DI,0xdb68
    CALL        FUN_1000_324f
    XCHG        DI,SI
    CALL        FUN_1000_3376
    XCHG        DI,SI
    CALL        FUN_1000_34a2
    XCHG        DI,SI
    CALL        FUN_1000_35cf
    MOV         SI,DI
    MOV         CX,word [SI + -0x2]
    CMP         CX,0x3
    JC          LAB_1000_317a
    NOP
    NOP
    MOV         AX,[0xdbbe]
    MOV         [0xdbc4],AX
    MOV         AX,[0xdbbc]
    MOV         [0xdbc6],AX
    PUSH        SI
    DEC         CX
LAB_1000_3122:                ;XREF[1]:     1000:3137(j)
    PUSH        CX
    PUSH        SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         CX,word [SI + 0x8]
    MOV         DX,word [SI + 0xa]
    CALL        FUN_1000_2c4b
    POP         SI
    POP         CX
    ADD         SI,0x8
    LOOP        LAB_1000_3122
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    POP         SI
    MOV         CX,word [SI]
    MOV         DX,word [SI + 0x2]
    CALL        FUN_1000_2c4b
    MOV         SI,0xdb16
    PUSH        SI
    MOV         CX,word [SI + -0x2]
    DEC         CX
LAB_1000_314f:                ;XREF[1]:     1000:3165(j)
    PUSH        CX
    PUSH        SI
    MOV         AX,word [SI + 0x4]
    MOV         BX,word [SI + 0x2]
    MOV         CX,word [SI + 0xc]
    MOV         DX,word [SI + 0xa]
    CALL        FUN_1000_317d
    POP         SI
    POP         CX
    ADD         SI,0x8
    LOOP        LAB_1000_314f
    MOV         AX,word [SI + 0x4]
    MOV         BX,word [SI + 0x2]
    POP         SI
    MOV         CX,word [SI + 0x4]
    MOV         DX,word [SI + 0x2]
    CALL        FUN_1000_317d
    CALL        FUN_1000_31d1
LAB_1000_317a:                ;XREF[1]:     1000:3110(j)
    POP         DI
    POP         SI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_317d:
                              ;XREF[2]:     1000:315d(c),1000:3174(c)
    XCHG        DX,CX
    CMP         BX,CX
    JLE         LAB_1000_3193
    NOP
    NOP
    XCHG        AX,DX
    XCHG        CX,BX
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0xdeea
    JMP         LAB_1000_319c
LAB_1000_3193:                ;XREF[1]:     1000:3181(j)
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0xdee8
LAB_1000_319c:                ;XREF[1]:     1000:3191(j)
    JCXZ        LAB_1000_31d0
    PUSH        AX
    SUB         DX,AX
    MOV         AX,DX
    SHL         EAX,0x10
    CDQ
    MOVSX       ECX,CX
    IDIV        ECX
    MOV         EDX,EAX
    POP         AX
    SHL         EAX,0x10
LAB_1000_31b8:                ;XREF[1]:     1000:31c8(j)
    ROR         EAX,0x10
    MOV         word [BX],AX
    ADD         BX,0x4
    ROL         EAX,0x10
    ADD         EAX,EDX
    LOOP        LAB_1000_31b8
    ROR         EAX,0x10
    MOV         word [BX],AX
LAB_1000_31d0:                ;XREF[1]:     1000:319c(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_31d1:
                              ;XREF[1]:     1000:3177(c)
    MOV         BX,word [0xdbc4]
    MOV         DX,word [0xdbc6]
    SUB         DX,BX
    JZ          LAB_1000_324e
    NOP
    NOP
    INC         DX
    SHL         BX,0x2
    PUSH        ES
    MOV         AX,[0xdb10]
    MOV         ES,AX
LAB_1000_31e9:                ;XREF[1]:     1000:324b(j)
    MOV         DI,BX
    SHL         DI,0x2
    ADD         DI,BX
    SHL         DI,0x4
    PUSH        BX
    PUSH        DX
    MOV         AX,word [BX + 0xdbc8]
    MOV         CX,word [BX + 0xdbca]
    MOV         BP,word [BX + 0xdee8]
    MOV         DX,word [BX + 0xdeea]
    SUB         DX,BP
    SUB         CX,AX
    JNS         LAB_1000_3215
    NOP
    NOP
    ADD         AX,CX
    NEG         CX
    ADD         BP,DX
    NEG         DX
LAB_1000_3215:                ;XREF[1]:     1000:3209(j)
    PUSH        BP
    INC         CX
    ADD         DI,AX
    MOVSX       EAX,DX
    SHL         EAX,0x8
    CDQ
    MOVZX       ECX,CX
    IDIV        ECX
    MOV         EBX,EAX
    POP         AX
    MOVSX       EAX,AX
    SHL         EAX,0x8
    CLD
LAB_1000_3237:                ;XREF[1]:     1000:3243(j)
    ROR         EAX,0x10
    STOSB ;       ES:DI
    ROL         EAX,0x10
    ADD         EAX,EBX
    LOOP        LAB_1000_3237
    POP         DX
    POP         BX
    ADD         BX,0x4
    DEC         DX
    JNZ         LAB_1000_31e9
    POP         ES
LAB_1000_324e:                ;XREF[1]:     1000:31db(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_324f:
                              ;XREF[1]:     1000:30f6(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_32b2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],BP
    POP         DI
    ADD         SI,0x8
    CMP         AX,word [0xdbc0]
    JL          LAB_1000_3350
LAB_1000_3280:                ;XREF[2]:     1000:32b0(j),1000:32fb(j)
    PUSH        CX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],BP
    ADD         DI,0x8
    INC         word [0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    ADD         SI,0x8
    CMP         AX,word [0xdbc0]
    JL          LAB_1000_32ff
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_3280
LAB_1000_32b2:                ;XREF[4]:     1000:325a(j),1000:32fd(j),1000:334d(j),1000:3373(j)
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
LAB_1000_32bb:                ;XREF[1]:     1000:336c(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         AX,word [0xdbc0]
    SUB         CX,word [0xdbc0]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbc0]
    MOV         word [DI],CX
    MOV         word [DI + 0x2],AX
    POP         CX
    POP         AX
    MOV         DX,BP
    ROR         EBP,0x10
    MOV         BX,BP
    CALL        FUN_1000_3f7a
    MOV         word [DI + 0x4],AX
    ADD         DI,0x8
    INC         word [0xe528]
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_3280
    JMP         LAB_1000_32b2
LAB_1000_32ff:                ;XREF[1]:     1000:32ab(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         CX,word [0xdbc0]
    JZ          LAB_1000_3347
    NOP
    NOP
    SUB         AX,word [0xdbc0]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbc0]
    MOV         word [DI],CX
    MOV         word [DI + 0x2],AX
    POP         CX
    POP         AX
    MOV         BX,BP
    ROR         EBP,0x10
    MOV         DX,BP
    CALL        FUN_1000_3f7a
    MOV         word [DI + 0x4],AX
    ADD         DI,0x8
    INC         word [0xe528]
LAB_1000_3347:                ;XREF[1]:     1000:331a(j)
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_3350
    JMP         LAB_1000_32b2
LAB_1000_3350:                ;XREF[3]:     1000:327c(j),1000:334b(j),1000:3371(j)
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    ADD         SI,0x8
    CMP         AX,word [0xdbc0]
    JGE         LAB_1000_32bb
    POP         CX
    LOOP        LAB_1000_3350
    JMP         LAB_1000_32b2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3376:
                              ;XREF[1]:     1000:30fb(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_33d9
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],BP
    POP         DI
    ADD         SI,0x8
    CMP         AX,word [0xdbc2]
    JG          LAB_1000_347c
LAB_1000_33a7:                ;XREF[2]:     1000:33d7(j),1000:3430(j)
    PUSH        CX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],BP
    ADD         DI,0x8
    INC         word [0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    ADD         SI,0x8
    CMP         AX,word [0xdbc2]
    JG          LAB_1000_3433
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_33a7
LAB_1000_33d9:                ;XREF[4]:     1000:3381(j),1000:342e(j),1000:3479(j),1000:349f(j)
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
LAB_1000_33e5:                ;XREF[1]:     1000:3498(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         AX,word [0xdbc2]
    SUB         CX,word [0xdbc2]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbc2]
    MOV         word [DI],CX
    MOV         word [DI + 0x2],AX
    POP         CX
    POP         AX
    MOV         BX,BP
    ROR         EBP,0x10
    MOV         DX,BP
    CALL        FUN_1000_3f7a
    MOV         word [DI + 0x4],AX
    ADD         DI,0x8
    INC         word [0xe528]
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    DEC         CX
    JZ          LAB_1000_33d9
    JMP         LAB_1000_33a7
LAB_1000_3433:                ;XREF[1]:     1000:33d2(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         CX,word [0xdbc2]
    JZ          LAB_1000_3473
    NOP
    NOP
    SUB         AX,word [0xdbc2]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbc2]
    MOV         word [DI],CX
    MOV         word [DI + 0x2],AX
    POP         CX
    POP         AX
    MOV         DX,BP
    ROR         EBP,0x10
    MOV         BX,BP
    CALL        FUN_1000_3f7a
    MOV         word [DI + 0x4],AX
    ADD         DI,0x8
    INC         word [0xe528]
LAB_1000_3473:                ;XREF[1]:     1000:3446(j)
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_347c
    JMP         LAB_1000_33d9
LAB_1000_347c:                ;XREF[3]:     1000:33a3(j),1000:3477(j),1000:349d(j)
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    ADD         SI,0x8
    CMP         AX,word [0xdbc2]
    JLE         LAB_1000_33e5
    POP         CX
    LOOP        LAB_1000_347c
    JMP         LAB_1000_33d9
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_34a2:
                              ;XREF[1]:     1000:3100(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_3505
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],BP
    POP         DI
    ADD         SI,0x8
    CMP         BX,word [0xdbbc]
    JL          LAB_1000_35a9
LAB_1000_34d3:                ;XREF[2]:     1000:3503(j),1000:3551(j)
    PUSH        CX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],BP
    ADD         DI,0x8
    INC         word [0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    ADD         SI,0x8
    CMP         BX,word [0xdbbc]
    JL          LAB_1000_3555
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_34d3
LAB_1000_3505:                ;XREF[4]:     1000:34ad(j),1000:3553(j),1000:35a6(j),1000:35cc(j)
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
LAB_1000_350e:                ;XREF[1]:     1000:35c5(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [0xdbbc]
    SUB         CX,word [0xdbbc]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbbc]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],CX
    POP         CX
    POP         AX
    MOV         DX,BP
    ROR         EBP,0x10
    MOV         BX,BP
    CALL        FUN_1000_3f7a
    MOV         word [DI + 0x4],AX
    ADD         DI,0x8
    INC         word [0xe528]
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_34d3
    JMP         LAB_1000_3505
LAB_1000_3555:                ;XREF[1]:     1000:34fe(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [0xdbbc]
    JZ          LAB_1000_35a0
    NOP
    NOP
    SUB         AX,word [0xdbbc]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbbc]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],CX
    POP         CX
    POP         AX
    MOV         BX,BP
    ROR         EBP,0x10
    MOV         DX,BP
    CALL        FUN_1000_3f7a
    MOV         word [DI + 0x4],AX
    ADD         DI,0x8
    INC         word [0xe528]
LAB_1000_35a0:                ;XREF[1]:     1000:3573(j)
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_35a9
    JMP         LAB_1000_3505
LAB_1000_35a9:                ;XREF[3]:     1000:34cf(j),1000:35a4(j),1000:35ca(j)
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    ADD         SI,0x8
    CMP         BX,word [0xdbbc]
    JGE         LAB_1000_350e
    POP         CX
    LOOP        LAB_1000_35a9
    JMP         LAB_1000_3505
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_35cf:
                              ;XREF[1]:     1000:3105(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_3632
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],BP
    POP         DI
    ADD         SI,0x8
    CMP         BX,word [0xdbbe]
    JG          LAB_1000_36d8
LAB_1000_3600:                ;XREF[2]:     1000:3630(j),1000:3689(j)
    PUSH        CX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],BP
    ADD         DI,0x8
    INC         word [0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    ADD         SI,0x8
    CMP         BX,word [0xdbbe]
    JG          LAB_1000_368c
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_3600
LAB_1000_3632:                ;XREF[4]:     1000:35da(j),1000:3687(j),1000:36d5(j),1000:36fb(j)
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
LAB_1000_363b:                ;XREF[1]:     1000:36f4(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [0xdbbe]
    SUB         CX,word [0xdbbe]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbbe]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],CX
    POP         CX
    POP         AX
    MOV         BX,BP
    ROR         EBP,0x10
    MOV         DX,BP
    CALL        FUN_1000_3f7a
    MOV         word [DI + 0x4],AX
    ADD         DI,0x8
    INC         word [0xe528]
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    DEC         CX
    JZ          LAB_1000_3632
    JMP         LAB_1000_3600
LAB_1000_368c:                ;XREF[1]:     1000:362b(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [0xdbbe]
    JZ          LAB_1000_36cf
    NOP
    NOP
    SUB         AX,word [0xdbbe]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbbe]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],CX
    POP         CX
    POP         AX
    MOV         DX,BP
    ROR         EBP,0x10
    MOV         BX,BP
    CALL        FUN_1000_3f7a
    MOV         word [DI + 0x4],AX
    ADD         DI,0x8
    INC         word [0xe528]
LAB_1000_36cf:                ;XREF[1]:     1000:36a2(j)
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_36d8
    JMP         LAB_1000_3632
LAB_1000_36d8:                ;XREF[3]:     1000:35fc(j),1000:36d3(j),1000:36f9(j)
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    ADD         SI,0x8
    CMP         BX,word [0xdbbe]
    JLE         LAB_1000_363b
    POP         CX
    LOOP        LAB_1000_36d8
    JMP         LAB_1000_3632
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_36fe:
                              ;XREF[8]:     1000:0d24(c),1000:16f0(c),1000:175a(c),1000:1907(c),
                              ;             1000:1ddb(c),1000:1e34(c),1000:1f2f(c),1000:1f88(c)
    PUSH        SI
    PUSH        DI
    MOV         SI,0xdb16
    MOV         DI,0xdb68
    CALL        FUN_1000_390a
    XCHG        DI,SI
    CALL        FUN_1000_3aa3
    XCHG        DI,SI
    CALL        FUN_1000_3c3c
    XCHG        DI,SI
    CALL        FUN_1000_3ddb
    MOV         SI,DI
    MOV         CX,word [SI + -0x2]
    CMP         CX,0x3
    JC          LAB_1000_3798
    NOP
    NOP
    MOV         AX,[0xdbbe]
    MOV         [0xdbc4],AX
    MOV         AX,[0xdbbc]
    MOV         [0xdbc6],AX
    PUSH        SI
    DEC         CX
LAB_1000_3732:                ;XREF[1]:     1000:3747(j)
    PUSH        CX
    PUSH        SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         CX,word [SI + 0x8]
    MOV         DX,word [SI + 0xa]
    CALL        FUN_1000_2c4b
    POP         SI
    POP         CX
    ADD         SI,0x8
    LOOP        LAB_1000_3732
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    POP         SI
    MOV         CX,word [SI]
    MOV         DX,word [SI + 0x2]
    CALL        FUN_1000_2c4b
    MOV         SI,0xdb16
    PUSH        SI
    MOV         CX,word [SI + -0x2]
    DEC         CX
LAB_1000_375f:                ;XREF[1]:     1000:377b(j)
    PUSH        CX
    PUSH        SI
    MOV         AX,word [SI + 0x4]
    MOV         BX,word [SI + 0x6]
    MOV         CX,word [SI + 0xc]
    MOV         DX,word [SI + 0xe]
    MOV         DI,word [SI + 0xa]
    MOV         SI,word [SI + 0x2]
    CALL        FUN_1000_379b
    POP         SI
    POP         CX
    ADD         SI,0x8
    LOOP        LAB_1000_375f
    MOV         AX,word [SI + 0x4]
    MOV         BX,word [SI + 0x6]
    MOV         BP,word [SI + 0x2]
    POP         SI
    MOV         CX,word [SI + 0x4]
    MOV         DX,word [SI + 0x6]
    MOV         DI,word [SI + 0x2]
    MOV         SI,BP
    CALL        FUN_1000_379b
    CALL        FUN_1000_3827
LAB_1000_3798:                ;XREF[1]:     1000:3720(j)
    POP         DI
    POP         SI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_379b:
                              ;XREF[2]:     1000:3773(c),1000:3792(c)
    PUSH        SI
    PUSH        DI
    CMP         SI,DI
    JLE         LAB_1000_37b3
    NOP
    NOP
    XCHG        DI,SI
    XCHG        AX,CX
    XCHG        DX,BX
    SUB         DI,SI
    SHL         SI,0x2
    ADD         SI,0xdeea
    JMP         LAB_1000_37bc
LAB_1000_37b3:                ;XREF[1]:     1000:379f(j)
    SUB         DI,SI
    SHL         SI,0x2
    ADD         SI,0xdee8
LAB_1000_37bc:                ;XREF[1]:     1000:37b1(j)
    TEST        DI,DI
    JZ          LAB_1000_3824
    NOP
    NOP
    MOVSX       EDI,DI
    SUB         CX,AX
    SUB         DX,BX
    PUSH        AX
    PUSH        BX
    PUSH        DX
    MOV         AX,CX
    SHL         EAX,0x10
    CDQ
    IDIV        EDI
    MOV         ECX,EAX
    POP         AX
    SHL         EAX,0x10
    CDQ
    IDIV        EDI
    MOV         EDX,EAX
    POP         BX
    POP         AX
    SHL         EAX,0x10
    SHL         EBX,0x10
    XCHG        ECX,EDI
LAB_1000_37f5:                ;XREF[1]:     1000:3814(j)
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         word [SI],AX
    MOV         word [SI + 0x320],BX
    ADD         SI,0x4
    ROL         EAX,0x10
    ROL         EBX,0x10
    ADD         EAX,EDI
    ADD         EBX,EDX
    LOOP        LAB_1000_37f5
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         word [SI],AX
    MOV         word [SI + 0x320],BX
LAB_1000_3824:                ;XREF[1]:     1000:37be(j)
    POP         SI
    POP         DI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3827:
                              ;XREF[1]:     1000:3795(c)
    MOV         SI,word [0xdbc4]
    MOV         DI,word [0xdbc6]
    SUB         DI,SI
    JZ          LAB_1000_38f7
    INC         DI
    SHL         SI,0x2
    PUSH        ES
    MOV         AX,[0xdb10]
    MOV         ES,AX
LAB_1000_383f:                ;XREF[1]:     1000:38f2(j)
    PUSH        DI
    MOV         DI,SI
    SHL         DI,0x2
    ADD         DI,SI
    SHL         DI,0x4
    PUSH        SI
    MOV         AX,word [SI + 0xdbc8]
    MOV         CX,word [SI + 0xdbca]
    MOV         BX,word [SI + 0xdee8]
    MOV         DX,word [SI + 0xdeea]
    MOV         BP,word [SI + 0xe208]
    MOV         SI,word [SI + 0xe20a]
    SUB         SI,BP
    SUB         DX,BX
    SUB         CX,AX
    JNS         LAB_1000_3879
    NOP
    NOP
    ADD         AX,CX
    NEG         CX
    ADD         BX,DX
    NEG         DX
    ADD         BP,SI
    NEG         SI
LAB_1000_3879:                ;XREF[1]:     1000:3869(j)
    ADD         DI,AX
    INC         CX
    MOVZX       ECX,CX
    MOVSX       EAX,DX
    SHL         EAX,0x8
    CDQ
    IDIV        ECX
    XCHG        EAX,ESI
    MOVSX       EAX,AX
    SHL         EAX,0x8
    CDQ
    IDIV        ECX
    MOV         EDX,EAX
    XCHG        ESI,ECX
    MOVZX       EBX,BX
    MOVZX       EBP,BP
    SHL         EBX,0x8
    SHL         EBP,0x8
    CLD
LAB_1000_38b3:                ;XREF[1]:     1000:38ea(j)
    ROR         EBX,0x10
    ROR         EBP,0x10
    ROR         ESI,0x10
    MOV         SI,BP
    SHL         SI,0x8
    MOV         AL,byte FS:[BX + SI]
    CMP         AL,0xff
    JZ          LAB_1000_38d6
    NOP
    NOP
    CMP         AL,0xf0
    JNC         LAB_1000_38f8
    NOP
    NOP
    MOV         byte ES:[DI],AL
LAB_1000_38d6:                ;XREF[2]:     1000:38c9(j),1000:3908(j)
    INC         DI
    ROL         ESI,0x10
    ROL         EBX,0x10
    ROL         EBP,0x10
    ADD         EBX,ECX
    ADD         EBP,EDX
    DEC         SI
    JNZ         LAB_1000_38b3
    POP         SI
    POP         DI
    ADD         SI,0x4
    DEC         DI
    JNZ         LAB_1000_383f
    POP         ES
LAB_1000_38f7:                ;XREF[1]:     1000:3831(j)
    RET
LAB_1000_38f8:                ;XREF[1]:     1000:38cf(j)
    SUB         AL,0xf0
    MOV         AH,AL
    MOV         AL,byte ES:[DI]
    XCHG        AX,BX
    MOV         BL,byte [BX + 0x2e51]
    XCHG        AX,BX
    MOV         byte ES:[DI],AL
    JMP         LAB_1000_38d6
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_390a:
                              ;XREF[1]:     1000:3706(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_398d
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         DX,word [SI + 0x6]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],BP
    MOV         word [DI + 0x6],DX
    POP         DI
    ADD         SI,0x8
    ROR         ESI,0x10
    MOV         SI,DI
    MOV         DI,DX
    CMP         AX,word [0xdbc0]
    JL          LAB_1000_3a6e
LAB_1000_3949:                ;XREF[2]:     1000:398b(j),1000:39f7(j)
    PUSH        CX
    MOV         word [SI],AX
    MOV         word [SI + 0x2],BX
    MOV         word [SI + 0x4],BP
    MOV         word [SI + 0x6],DI
    ADD         SI,0x8
    INC         word [0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         DI,word [SI + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         AX,word [0xdbc0]
    JL          LAB_1000_39fd
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_3949
LAB_1000_398d:                ;XREF[4]:     1000:3915(j),1000:39fb(j),1000:3a6b(j),1000:3aa0(j)
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
LAB_1000_3996:                ;XREF[1]:     1000:3a99(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         AX,word [0xdbc0]
    SUB         CX,word [0xdbc0]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbc0]
    MOV         word [SI],CX
    MOV         word [SI + 0x2],AX
    POP         CX
    POP         AX
    MOV         DX,BP
    ROR         EBP,0x10
    MOV         BX,BP
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x4],AX
    POP         CX
    POP         AX
    MOV         DX,DI
    ROR         EDI,0x10
    MOV         BX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x6],AX
    ADD         SI,0x8
    INC         word [0xe528]
    POP         DI
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    DEC         CX
    JNZ         LAB_1000_3949
    JMP         LAB_1000_398d
LAB_1000_39fd:                ;XREF[1]:     1000:3986(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         CX,word [0xdbc0]
    JZ          LAB_1000_3a64
    NOP
    NOP
    SUB         AX,word [0xdbc0]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbc0]
    MOV         word [SI],CX
    MOV         word [SI + 0x2],AX
    POP         CX
    POP         AX
    MOV         BX,BP
    ROR         EBP,0x10
    MOV         DX,BP
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x4],AX
    POP         CX
    POP         AX
    MOV         BX,DI
    ROR         EDI,0x10
    MOV         DX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x6],AX
    ADD         SI,0x8
    INC         word [0xe528]
LAB_1000_3a64:                ;XREF[1]:     1000:3a19(j)
    POP         DI
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_3a6e
    JMP         LAB_1000_398d
LAB_1000_3a6e:                ;XREF[3]:     1000:3945(j),1000:3a69(j),1000:3a9e(j)
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         DI,word [SI + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         AX,word [0xdbc0]
    JGE         LAB_1000_3996
    POP         CX
    LOOP        LAB_1000_3a6e
    JMP         LAB_1000_398d
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3aa3:
                              ;XREF[1]:     1000:370b(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_3b26
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         DX,word [SI + 0x6]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],BP
    MOV         word [DI + 0x6],DX
    POP         DI
    ADD         SI,0x8
    ROR         ESI,0x10
    MOV         SI,DI
    MOV         DI,DX
    CMP         AX,word [0xdbc2]
    JG          LAB_1000_3c07
LAB_1000_3ae2:                ;XREF[2]:     1000:3b24(j),1000:3b98(j)
    PUSH        CX
    MOV         word [SI],AX
    MOV         word [SI + 0x2],BX
    MOV         word [SI + 0x4],BP
    MOV         word [SI + 0x6],DI
    ADD         SI,0x8
    INC         word [0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         DI,word [SI + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         AX,word [0xdbc2]
    JG          LAB_1000_3b9e
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_3ae2
LAB_1000_3b26:                ;XREF[4]:     1000:3aae(j),1000:3b9c(j),1000:3c04(j),1000:3c39(j)
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
LAB_1000_3b2f:                ;XREF[1]:     1000:3c32(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         AX,word [0xdbc2]
    SUB         CX,word [0xdbc2]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbc2]
    MOV         word [SI],CX
    MOV         word [SI + 0x2],AX
    POP         CX
    POP         AX
    MOV         BX,BP
    ROR         EBP,0x10
    MOV         DX,BP
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x4],AX
    POP         CX
    POP         AX
    MOV         BX,DI
    ROR         EDI,0x10
    MOV         DX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x6],AX
    ADD         SI,0x8
    INC         word [0xe528]
    POP         DI
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    DEC         CX
    JNZ         LAB_1000_3ae2
    JMP         LAB_1000_3b26
LAB_1000_3b9e:                ;XREF[1]:     1000:3b1f(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         CX,word [0xdbc2]
    JZ          LAB_1000_3bfd
    NOP
    NOP
    SUB         AX,word [0xdbc2]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbc2]
    MOV         word [SI],CX
    MOV         word [SI + 0x2],AX
    POP         CX
    POP         AX
    MOV         DX,BP
    ROR         EBP,0x10
    MOV         BX,BP
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x4],AX
    POP         CX
    POP         AX
    MOV         DX,DI
    ROR         EDI,0x10
    MOV         BX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x6],AX
    ADD         SI,0x8
    INC         word [0xe528]
LAB_1000_3bfd:                ;XREF[1]:     1000:3bb2(j)
    POP         DI
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_3c07
    JMP         LAB_1000_3b26
LAB_1000_3c07:                ;XREF[3]:     1000:3ade(j),1000:3c02(j),1000:3c37(j)
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         DI,word [SI + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         AX,word [0xdbc2]
    JLE         LAB_1000_3b2f
    POP         CX
    LOOP        LAB_1000_3c07
    JMP         LAB_1000_3b26
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3c3c:
                              ;XREF[1]:     1000:3710(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_3cbf
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         DX,word [SI + 0x6]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],BP
    MOV         word [DI + 0x6],DX
    POP         DI
    ADD         SI,0x8
    ROR         ESI,0x10
    MOV         SI,DI
    MOV         DI,DX
    CMP         BX,word [0xdbbc]
    JL          LAB_1000_3da6
LAB_1000_3c7b:                ;XREF[2]:     1000:3cbd(j),1000:3d2c(j)
    PUSH        CX
    MOV         word [SI],AX
    MOV         word [SI + 0x2],BX
    MOV         word [SI + 0x4],BP
    MOV         word [SI + 0x6],DI
    ADD         SI,0x8
    INC         word [0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         DI,word [SI + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         BX,word [0xdbbc]
    JL          LAB_1000_3d32
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_3c7b
LAB_1000_3cbf:                ;XREF[4]:     1000:3c47(j),1000:3d30(j),1000:3da3(j),1000:3dd8(j)
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
LAB_1000_3cc8:                ;XREF[1]:     1000:3dd1(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [0xdbbc]
    SUB         CX,word [0xdbbc]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbbc]
    MOV         word [SI],AX
    MOV         word [SI + 0x2],CX
    POP         CX
    POP         AX
    MOV         DX,BP
    ROR         EBP,0x10
    MOV         BX,BP
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x4],AX
    POP         CX
    POP         AX
    MOV         DX,DI
    ROR         EDI,0x10
    MOV         BX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x6],AX
    ADD         SI,0x8
    INC         word [0xe528]
    POP         DI
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    DEC         CX
    JNZ         LAB_1000_3c7b
    JMP         LAB_1000_3cbf
LAB_1000_3d32:                ;XREF[1]:     1000:3cb8(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [0xdbbc]
    JZ          LAB_1000_3d9c
    NOP
    NOP
    SUB         AX,word [0xdbbc]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbbc]
    MOV         word [SI],AX
    MOV         word [SI + 0x2],CX
    POP         CX
    POP         AX
    MOV         BX,BP
    ROR         EBP,0x10
    MOV         DX,BP
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x4],AX
    POP         CX
    POP         AX
    MOV         BX,DI
    ROR         EDI,0x10
    MOV         DX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x6],AX
    ADD         SI,0x8
    INC         word [0xe528]
LAB_1000_3d9c:                ;XREF[1]:     1000:3d51(j)
    POP         DI
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_3da6
    JMP         LAB_1000_3cbf
LAB_1000_3da6:                ;XREF[3]:     1000:3c77(j),1000:3da1(j),1000:3dd6(j)
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         DI,word [SI + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         BX,word [0xdbbc]
    JGE         LAB_1000_3cc8
    POP         CX
    LOOP        LAB_1000_3da6
    JMP         LAB_1000_3cbf
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3ddb:
                              ;XREF[1]:     1000:3715(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_3e5e
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         DX,word [SI + 0x6]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    MOV         word [DI + 0x4],BP
    MOV         word [DI + 0x6],DX
    POP         DI
    ADD         SI,0x8
    ROR         ESI,0x10
    MOV         SI,DI
    MOV         DI,DX
    CMP         BX,word [0xdbbe]
    JG          LAB_1000_3f45
LAB_1000_3e1a:                ;XREF[2]:     1000:3e5c(j),1000:3ed3(j)
    PUSH        CX
    MOV         word [SI],AX
    MOV         word [SI + 0x2],BX
    MOV         word [SI + 0x4],BP
    MOV         word [SI + 0x6],DI
    ADD         SI,0x8
    INC         word [0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         DI,word [SI + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         BX,word [0xdbbe]
    JG          LAB_1000_3ed9
    POP         CX
    LOOP        LAB_1000_3e1a
LAB_1000_3e5e:                ;XREF[4]:     1000:3de6(j),1000:3ed7(j),1000:3f42(j),1000:3f77(j)
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
LAB_1000_3e67:                ;XREF[1]:     1000:3f70(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [0xdbbe]
    SUB         CX,word [0xdbbe]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbbe]
    MOV         word [SI],AX
    MOV         word [SI + 0x2],CX
    POP         CX
    POP         AX
    MOV         BX,BP
    ROR         EBP,0x10
    MOV         DX,BP
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x4],AX
    POP         CX
    POP         AX
    MOV         BX,DI
    ROR         EDI,0x10
    MOV         DX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x6],AX
    ADD         SI,0x8
    INC         word [0xe528]
    POP         DI
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    DEC         CX
    JNZ         LAB_1000_3e1a
    JMP         LAB_1000_3e5e
LAB_1000_3ed9:                ;XREF[1]:     1000:3e57(j)
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [0xdbbe]
    JZ          LAB_1000_3f3b
    NOP
    NOP
    SUB         AX,word [0xdbbe]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [0xdbbe]
    MOV         word [SI],AX
    MOV         word [SI + 0x2],CX
    POP         CX
    POP         AX
    MOV         DX,BP
    ROR         EBP,0x10
    MOV         BX,BP
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x4],AX
    POP         CX
    POP         AX
    MOV         DX,DI
    ROR         EDI,0x10
    MOV         BX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    MOV         word [SI + 0x6],AX
    ADD         SI,0x8
    INC         word [0xe528]
LAB_1000_3f3b:                ;XREF[1]:     1000:3ef0(j)
    POP         DI
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_3f45
    JMP         LAB_1000_3e5e
LAB_1000_3f45:                ;XREF[3]:     1000:3e16(j),1000:3f40(j),1000:3f75(j)
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    MOV         DI,word [SI + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         BX,word [0xdbbe]
    JLE         LAB_1000_3e67
    POP         CX
    LOOP        LAB_1000_3f45
    JMP         LAB_1000_3e5e
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3f7a:
                              ;XREF[21]:    1000:2e4e(c),1000:2e77(c),1000:2f0e(c),1000:2f34(c),
                              ;             1000:2fcb(c),1000:2ff6(c),1000:308f(c),1000:30b7(c),
                              ;             1000:39b0(c),1000:39cc(c),1000:39e2(c),1000:3a23(c),
                              ;             1000:3a3f(c),1000:3a55(c),1000:3b51(c),1000:3b6d(c),
                              ;             1000:3b83(c),1000:3bbc(c),1000:3bd8(c),1000:3bee(c),
                              ;             1000:3d5b(c)
    CMP         BX,DX
    JZ          LAB_1000_3f96
    NOP
    NOP
    PUSH        AX
    PUSH        CX
    NEG         AX
    IMUL        DX
    XCHG        DX,BX
    XCHG        AX,CX
    IMUL        DX
    ADD         AX,CX
    ADC         DX,BX
    POP         CX
    POP         BX
    SUB         CX,BX
    IDIV        CX
    RET
LAB_1000_3f96:                ;XREF[1]:     1000:3f7c(j)
    XCHG        AX,BX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3f98:
                              ;XREF[2]:     1000:1482(c),1000:59ad(c)
    CMP         AX,word [0xdbc0]
    JL          LAB_1000_3fce
    NOP
    NOP
    CMP         AX,word [0xdbc2]
    JG          LAB_1000_3fce
    NOP
    NOP
    CMP         BX,word [0xdbbc]
    JL          LAB_1000_3fce
    NOP
    NOP
    CMP         BX,word [0xdbbe]
    JG          LAB_1000_3fce
    NOP
    NOP
    PUSH        ES
    MOV         BH,BL
    XOR         BL,BL
    ADD         AX,BX
    SHR         BX,0x1
    SHR         BX,0x1
    ADD         BX,AX
    MOV         AX,[0xdb10]
    MOV         ES,AX
    MOV         byte ES:[BX],CL
    POP         ES
LAB_1000_3fce:                ;XREF[4]:     1000:3f9c(j),1000:3fa4(j),1000:3fac(j),1000:3fb4(j)
    RET

 ; 1000:3fcf [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3fd0:
                              ;XREF[1]:     1000:1981(c)
    MOV         word [0xe530],0x6
    MOV         BX,word [0x5f9]
    SAR         BX,0x6
    MOV         AX,[0xac]
    SHR         AX,0x8
    ADD         AX,BX
    MOV         [0xe53a],AX
    MOV         AX,[0xb0]
    SHR         AX,0x8
    ADD         AX,BX
    MOV         [0xe538],AX
    MOV         AX,[0xac]
    SHR         AX,0x8
    SUB         AX,BX
    MOV         [0xe532],AX
    MOV         BX,word [0x5f7]
    SAR         BX,0x6
    MOV         AX,[0xb0]
    SHR         AX,0x8
    ADD         AX,BX
    MOV         [0xe53c],AX
    MOV         AX,[0xac]
    SHR         AX,0x8
    SUB         AX,BX
    MOV         [0xe536],AX
    MOV         AX,[0xb0]
    SHR         AX,0x8
    SUB         AX,BX
    MOV         [0xe534],AX
    MOV         AX,[0x5f9]
    IMUL        word [0x5f1]
    MOV         BX,AX
    MOV         AX,[0x5f7]
    IMUL        word [0x5f3]
    MOV         CX,AX
    SUB         AX,BX
    MOV         DX,word [0xb0]
    SHR         DX,0x8
    SAR         AX,0x8
    ADD         AX,DX
    MOV         [0xe540],AX
    MOV         AX,CX
    NEG         AX
    SUB         AX,BX
    MOV         DX,word [0xb0]
    SHR         DX,0x8
    SAR         AX,0x8
    ADD         AX,DX
    MOV         [0xe548],AX
    MOV         AX,[0x5f9]
    IMUL        word [0x5f3]
    MOV         CX,AX
    MOV         AX,[0x5f7]
    IMUL        word [0x5f1]
    MOV         BX,AX
    MOV         AX,CX
    ADD         AX,BX
    SAR         AX,0x8
    MOV         DX,word [0xac]
    SHR         DX,0x8
    ADD         AX,DX
    MOV         [0xe53e],AX
    MOV         AX,BX
    SUB         AX,CX
    MOV         DX,word [0xac]
    SHR         DX,0x8
    SAR         AX,0x8
    ADD         AX,DX
    MOV         [0xe546],AX
    MOV         AX,[0x5ef]
    IMUL        word [0x5f9]
    MOV         BX,AX
    MOV         AX,[0x5ef]
    IMUL        word [0x5f7]
    MOV         CX,AX
    MOV         AX,[0xac]
    SHR         AX,0x8
    SAR         CX,0x8
    ADD         AX,CX
    MOV         [0xe542],AX
    MOV         AX,[0xb0]
    SHR         AX,0x8
    SAR         BX,0x8
    SUB         AX,BX
    MOV         [0xe544],AX
    CALL        FUN_1000_40c8
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_40c8:
                              ;XREF[1]:     1000:40c4(c)
    MOV         SI,0xe532
    MOV         DI,0xe55c
    CALL        FUN_1000_4394
    XCHG        DI,SI
    CALL        FUN_1000_444d
    XCHG        DI,SI
    CALL        FUN_1000_4506
    XCHG        DI,SI
    CALL        FUN_1000_45c3
    MOV         SI,DI
    MOV         CX,word [SI + -0x2]
    CMP         CX,0x3
    JC          LAB_1000_411f
    NOP
    NOP
    MOV         AX,[0xe586]
    MOV         [0xe58c],AX
    MOV         AX,[0xe584]
    MOV         [0xe58e],AX
    PUSH        SI
    DEC         CX
LAB_1000_40fa:                ;XREF[1]:     1000:410f(j)
    PUSH        CX
    PUSH        SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         CX,word [SI + 0x4]
    MOV         DX,word [SI + 0x6]
    CALL        FUN_1000_4120
    POP         SI
    POP         CX
    ADD         SI,0x4
    LOOP        LAB_1000_40fa
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    POP         SI
    MOV         CX,word [SI]
    MOV         DX,word [SI + 0x2]
    CALL        FUN_1000_4120
LAB_1000_411f:                ;XREF[1]:     1000:40e8(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4120:
                              ;XREF[2]:     1000:4107(c),1000:411c(c)
    XCHG        DX,CX
    CMP         BX,CX
    JLE         LAB_1000_414d
    NOP
    NOP
    XCHG        AX,DX
    XCHG        CX,BX
    CMP         BX,word [0xe58c]
    JGE         LAB_1000_4137
    NOP
    NOP
    MOV         word [0xe58c],BX
LAB_1000_4137:                ;XREF[1]:     1000:412f(j)
    CMP         CX,word [0xe58e]
    JLE         LAB_1000_4143
    NOP
    NOP
    MOV         word [0xe58e],CX
LAB_1000_4143:                ;XREF[1]:     1000:413b(j)
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0x2
    JMP         LAB_1000_416a
LAB_1000_414d:                ;XREF[1]:     1000:4124(j)
    CMP         BX,word [0xe58c]
    JGE         LAB_1000_4159
    NOP
    NOP
    MOV         word [0xe58c],BX
LAB_1000_4159:                ;XREF[1]:     1000:4151(j)
    CMP         CX,word [0xe58e]
    JLE         LAB_1000_4165
    NOP
    NOP
    MOV         word [0xe58e],CX
LAB_1000_4165:                ;XREF[1]:     1000:415d(j)
    SUB         CX,BX
    SHL         BX,0x2
LAB_1000_416a:                ;XREF[1]:     1000:414b(j)
    JCXZ        LAB_1000_41b1
    PUSH        DX
    SUB         DX,AX
    JS          LAB_1000_4191
    NOP
    NOP
    XOR         DI,DI
    MOV         SI,CX
LAB_1000_4177:                ;XREF[1]:     1000:4189(j)
    MOV         word [BX + 0xe590],AX
    ADD         BX,0x4
    SUB         DI,DX
    JNS         LAB_1000_4189
    NOP
    NOP
LAB_1000_4184:                ;XREF[1]:     1000:4187(j)
    INC         AX
    ADD         DI,SI
    JS          LAB_1000_4184
LAB_1000_4189:                ;XREF[1]:     1000:4180(j)
    LOOP        LAB_1000_4177
    POP         AX
    MOV         word [BX + 0xe590],AX
    RET
LAB_1000_4191:                ;XREF[1]:     1000:416f(j)
    NEG         DX
    XOR         DI,DI
    MOV         SI,CX
LAB_1000_4197:                ;XREF[1]:     1000:41a9(j)
    MOV         word [BX + 0xe590],AX
    ADD         BX,0x4
    SUB         DI,DX
    JNS         LAB_1000_41a9
    NOP
    NOP
LAB_1000_41a4:                ;XREF[1]:     1000:41a7(j)
    DEC         AX
    ADD         DI,SI
    JS          LAB_1000_41a4
LAB_1000_41a9:                ;XREF[1]:     1000:41a0(j)
    LOOP        LAB_1000_4197
    POP         AX
    MOV         word [BX + 0xe590],AX
    RET
LAB_1000_41b1:                ;XREF[1]:     1000:416a(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_41b2:
                              ;XREF[1]:     1000:1f94(c)
    MOV         word [0xe530],0x6
    MOV         BX,word [0x5f9]
    SAR         BX,0x6
    MOV         AX,[0xac]
    SHR         AX,0x8
    ADD         AX,BX
    MOV         [0xe53c],AX
    MOV         AX,[0xb0]
    SHR         AX,0x8
    ADD         AX,BX
    MOV         [0xe536],AX
    MOV         AX,[0xac]
    SHR         AX,0x8
    SUB         AX,BX
    MOV         [0xe534],AX
    MOV         BX,word [0x5f7]
    SAR         BX,0x6
    MOV         AX,[0xb0]
    SHR         AX,0x8
    ADD         AX,BX
    MOV         [0xe53a],AX
    MOV         AX,[0xac]
    SHR         AX,0x8
    SUB         AX,BX
    MOV         [0xe538],AX
    MOV         AX,[0xb0]
    SHR         AX,0x8
    SUB         AX,BX
    MOV         [0xe532],AX
    MOV         AX,[0x5f9]
    IMUL        word [0x5f1]
    MOV         BX,AX
    MOV         AX,[0x5f7]
    IMUL        word [0x5f3]
    MOV         CX,AX
    SUB         AX,BX
    MOV         DX,word [0xb0]
    SHR         DX,0x8
    SAR         AX,0x8
    ADD         AX,DX
    MOV         [0xe53e],AX
    MOV         AX,CX
    NEG         AX
    SUB         AX,BX
    MOV         DX,word [0xb0]
    SHR         DX,0x8
    SAR         AX,0x8
    ADD         AX,DX
    MOV         [0xe546],AX
    MOV         AX,[0x5f9]
    IMUL        word [0x5f3]
    MOV         CX,AX
    MOV         AX,[0x5f7]
    IMUL        word [0x5f1]
    MOV         BX,AX
    MOV         AX,CX
    ADD         AX,BX
    SAR         AX,0x8
    MOV         DX,word [0xac]
    SHR         DX,0x8
    ADD         AX,DX
    MOV         [0xe540],AX
    MOV         AX,BX
    SUB         AX,CX
    MOV         DX,word [0xac]
    SHR         DX,0x8
    SAR         AX,0x8
    ADD         AX,DX
    MOV         [0xe548],AX
    MOV         AX,[0x5ef]
    IMUL        word [0x5f9]
    MOV         BX,AX
    MOV         AX,[0x5ef]
    IMUL        word [0x5f7]
    MOV         CX,AX
    MOV         AX,[0xac]
    SHR         AX,0x8
    SAR         CX,0x8
    ADD         AX,CX
    MOV         [0xe544],AX
    MOV         AX,[0xb0]
    SHR         AX,0x8
    SAR         BX,0x8
    SUB         AX,BX
    MOV         [0xe542],AX
    CALL        FUN_1000_42aa
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_42aa:
                              ;XREF[1]:     1000:42a6(c)
    MOV         SI,0xe532
    MOV         DI,0xe55c
    CALL        FUN_1000_4394
    XCHG        DI,SI
    CALL        FUN_1000_444d
    XCHG        DI,SI
    CALL        FUN_1000_4506
    XCHG        DI,SI
    CALL        FUN_1000_45c3
    MOV         SI,DI
    MOV         CX,word [SI + -0x2]
    CMP         CX,0x3
    JC          LAB_1000_4301
    NOP
    NOP
    MOV         AX,[0xe586]
    MOV         [0xe58c],AX
    MOV         AX,[0xe584]
    MOV         [0xe58e],AX
    PUSH        SI
    DEC         CX
LAB_1000_42dc:                ;XREF[1]:     1000:42f1(j)
    PUSH        CX
    PUSH        SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         CX,word [SI + 0x4]
    MOV         DX,word [SI + 0x6]
    CALL        FUN_1000_4302
    POP         SI
    POP         CX
    ADD         SI,0x4
    LOOP        LAB_1000_42dc
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    POP         SI
    MOV         CX,word [SI]
    MOV         DX,word [SI + 0x2]
    CALL        FUN_1000_4302
LAB_1000_4301:                ;XREF[1]:     1000:42ca(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4302:
                              ;XREF[2]:     1000:42e9(c),1000:42fe(c)
    XCHG        DX,CX
    CMP         BX,CX
    JLE         LAB_1000_432c
    NOP
    NOP
    XCHG        AX,DX
    XCHG        CX,BX
    CMP         BX,word [0xe58c]
    JGE         LAB_1000_4319
    NOP
    NOP
    MOV         word [0xe58c],BX
LAB_1000_4319:                ;XREF[1]:     1000:4311(j)
    CMP         CX,word [0xe58e]
    JLE         LAB_1000_4325
    NOP
    NOP
    MOV         word [0xe58e],CX
LAB_1000_4325:                ;XREF[1]:     1000:431d(j)
    SUB         CX,BX
    SHL         BX,0x2
    JMP         LAB_1000_434c
LAB_1000_432c:                ;XREF[1]:     1000:4306(j)
    CMP         BX,word [0xe58c]
    JGE         LAB_1000_4338
    NOP
    NOP
    MOV         word [0xe58c],BX
LAB_1000_4338:                ;XREF[1]:     1000:4330(j)
    CMP         CX,word [0xe58e]
    JLE         LAB_1000_4344
    NOP
    NOP
    MOV         word [0xe58e],CX
LAB_1000_4344:                ;XREF[1]:     1000:433c(j)
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0x2
LAB_1000_434c:                ;XREF[1]:     1000:432a(j)
    JCXZ        LAB_1000_4393
    PUSH        DX
    SUB         DX,AX
    JS          LAB_1000_4373
    NOP
    NOP
    XOR         DI,DI
    MOV         SI,CX
LAB_1000_4359:                ;XREF[1]:     1000:436b(j)
    MOV         word [BX + 0xe590],AX
    ADD         BX,0x4
    SUB         DI,DX
    JNS         LAB_1000_436b
    NOP
    NOP
LAB_1000_4366:                ;XREF[1]:     1000:4369(j)
    INC         AX
    ADD         DI,SI
    JS          LAB_1000_4366
LAB_1000_436b:                ;XREF[1]:     1000:4362(j)
    LOOP        LAB_1000_4359
    POP         AX
    MOV         word [BX + 0xe590],AX
    RET
LAB_1000_4373:                ;XREF[1]:     1000:4351(j)
    NEG         DX
    XOR         DI,DI
    MOV         SI,CX
LAB_1000_4379:                ;XREF[1]:     1000:438b(j)
    MOV         word [BX + 0xe590],AX
    ADD         BX,0x4
    SUB         DI,DX
    JNS         LAB_1000_438b
    NOP
    NOP
LAB_1000_4386:                ;XREF[1]:     1000:4389(j)
    DEC         AX
    ADD         DI,SI
    JS          LAB_1000_4386
LAB_1000_438b:                ;XREF[1]:     1000:4382(j)
    LOOP        LAB_1000_4379
    POP         AX
    MOV         word [BX + 0xe590],AX
    RET
LAB_1000_4393:                ;XREF[1]:     1000:434c(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4394:
                              ;XREF[2]:     1000:40ce(c),1000:42b0(c)
    PUSH        SI
    PUSH        DI
    XOR         BP,BP
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_43dc
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x2
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    POP         DI
    ADD         SI,0x4
    CMP         AX,word [0xe588]
    JL          LAB_1000_4431
    NOP
    NOP
LAB_1000_43bb:                ;XREF[2]:     1000:43da(j),1000:4429(j)
    PUSH        CX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x4
    INC         BP
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x4
    CMP         AX,word [0xe588]
    JL          LAB_1000_43e2
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_43bb
LAB_1000_43dc:                ;XREF[1]:     1000:439b(j)
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_43e2:                ;XREF[1]:     1000:43d5(j)
    PUSH        AX
    PUSH        BX
    SUB         AX,word [0xe588]
    SUB         CX,word [0xe588]
    CALL        FUN_1000_4680
    MOV         BX,AX
    MOV         AX,[0xe588]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x4
    INC         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_4431
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_4408:                ;XREF[1]:     1000:4442(j)
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    SUB         AX,word [0xe588]
    SUB         CX,word [0xe588]
    CALL        FUN_1000_4680
    MOV         BX,AX
    MOV         AX,[0xe588]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x4
    INC         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_43bb
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_4431:                ;XREF[3]:     1000:43b7(j),1000:4400(j),1000:4445(j)
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x4
    CMP         AX,word [0xe588]
    JGE         LAB_1000_4408
    POP         CX
    LOOP        LAB_1000_4431
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_444d:
                              ;XREF[2]:     1000:40d3(c),1000:42b5(c)
    PUSH        SI
    PUSH        DI
    XOR         BP,BP
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_4495
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x2
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    POP         DI
    ADD         SI,0x4
    CMP         AX,word [0xe58a]
    JG          LAB_1000_44ea
    NOP
    NOP
LAB_1000_4474:                ;XREF[2]:     1000:4493(j),1000:44e2(j)
    PUSH        CX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x4
    INC         BP
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x4
    CMP         AX,word [0xe58a]
    JG          LAB_1000_449b
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_4474
LAB_1000_4495:                ;XREF[1]:     1000:4454(j)
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_449b:                ;XREF[1]:     1000:448e(j)
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    SUB         AX,word [0xe58a]
    SUB         CX,word [0xe58a]
    CALL        FUN_1000_4680
    MOV         BX,AX
    MOV         AX,[0xe58a]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x4
    INC         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_44ea
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_44c4:                ;XREF[1]:     1000:44fb(j)
    PUSH        AX
    PUSH        BX
    SUB         AX,word [0xe58a]
    SUB         CX,word [0xe58a]
    CALL        FUN_1000_4680
    MOV         BX,AX
    MOV         AX,[0xe58a]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x4
    INC         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_4474
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_44ea:                ;XREF[3]:     1000:4470(j),1000:44bc(j),1000:44fe(j)
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x4
    CMP         AX,word [0xe58a]
    JLE         LAB_1000_44c4
    POP         CX
    LOOP        LAB_1000_44ea
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4506:
                              ;XREF[2]:     1000:40d8(c),1000:42ba(c)
    PUSH        SI
    PUSH        DI
    XOR         BP,BP
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_454e
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x2
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    POP         DI
    ADD         SI,0x4
    CMP         BX,word [0xe584]
    JL          LAB_1000_45a7
    NOP
    NOP
LAB_1000_452d:                ;XREF[2]:     1000:454c(j),1000:459f(j)
    PUSH        CX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x4
    INC         BP
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x4
    CMP         BX,word [0xe584]
    JL          LAB_1000_4554
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_452d
LAB_1000_454e:                ;XREF[1]:     1000:450d(j)
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_4554:                ;XREF[1]:     1000:4547(j)
    PUSH        AX
    PUSH        BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [0xe584]
    SUB         CX,word [0xe584]
    CALL        FUN_1000_4680
    MOV         BX,word [0xe584]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x4
    INC         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_45a7
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_457c:                ;XREF[1]:     1000:45b8(j)
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [0xe584]
    SUB         CX,word [0xe584]
    CALL        FUN_1000_4680
    MOV         BX,word [0xe584]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x4
    INC         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_452d
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_45a7:                ;XREF[3]:     1000:4529(j),1000:4574(j),1000:45bb(j)
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x4
    CMP         BX,word [0xe584]
    JGE         LAB_1000_457c
    POP         CX
    LOOP        LAB_1000_45a7
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_45c3:
                              ;XREF[2]:     1000:40dd(c),1000:42bf(c)
    PUSH        SI
    PUSH        DI
    XOR         BP,BP
    MOV         CX,word [SI + -0x2]
    JCXZ        LAB_1000_460b
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x2
    ADD         DI,SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    POP         DI
    ADD         SI,0x4
    CMP         BX,word [0xe586]
    JG          LAB_1000_4664
    NOP
    NOP
LAB_1000_45ea:                ;XREF[2]:     1000:4609(j),1000:465c(j)
    PUSH        CX
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x4
    INC         BP
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x4
    CMP         BX,word [0xe586]
    JG          LAB_1000_4611
    NOP
    NOP
    POP         CX
    LOOP        LAB_1000_45ea
LAB_1000_460b:                ;XREF[1]:     1000:45ca(j)
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_4611:                ;XREF[1]:     1000:4604(j)
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [0xe586]
    SUB         CX,word [0xe586]
    CALL        FUN_1000_4680
    MOV         BX,word [0xe586]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x4
    INC         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_4664
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_463c:                ;XREF[1]:     1000:4675(j)
    PUSH        AX
    PUSH        BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [0xe586]
    SUB         CX,word [0xe586]
    CALL        FUN_1000_4680
    MOV         BX,word [0xe586]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x4
    INC         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        LAB_1000_45ea
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
LAB_1000_4664:                ;XREF[3]:     1000:45e6(j),1000:4634(j),1000:4678(j)
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x4
    CMP         BX,word [0xe586]
    JLE         LAB_1000_463c
    POP         CX
    LOOP        LAB_1000_4664
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4680:
                              ;XREF[8]:     1000:43ec(c),1000:4415(c),1000:44a8(c),1000:44ce(c),
                              ;             1000:4561(c),1000:458c(c),1000:4621(c),1000:4649(c)
    CMP         BX,DX
    JZ          LAB_1000_469c
    NOP
    NOP
    PUSH        AX
    PUSH        CX
    NEG         AX
    IMUL        DX
    XCHG        DX,BX
    XCHG        AX,CX
    IMUL        DX
    ADD         AX,CX
    ADC         DX,BX
    POP         CX
    POP         BX
    SUB         CX,BX
    IDIV        CX
    RET
LAB_1000_469c:                ;XREF[1]:     1000:4682(j)
    XCHG        AX,BX
    RET

 ; 1000:469f [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_46a0:
                              ;XREF[13]:    1000:14bf(c),1000:152a(c),1000:159b(c),1000:1617(c),
                              ;             1000:1699(c),1000:1d04(c),1000:1d30(c),1000:1d97(c),
                              ;             1000:1ded(c),1000:1e60(c),1000:1e89(c),1000:1eeb(c),
                              ;             1000:1f41(c)
    PUSH        DI
    XOR         DI,DI
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [0x120]
    MOV         [0xe992],AX
    JL          LAB_1000_46c2
    NOP
    NOP
    MOV         EAX,dword [SI + 0x6]
    MOV         dword [DI + 0xdb16],EAX
    MOV         dword [DI + 0xdb1a],EBX
    ADD         DI,0x8
LAB_1000_46c2:                ;XREF[1]:     1000:46ad(j)
    MOV         word [0xe996],DI
    POP         DI
    MOV         AX,word [SI]
    MOV         [0xe990],AX
    MOV         AX,word [SI + 0x4]
    MOV         [0xe994],AX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_46d3:
                              ;XREF[21]:    1000:14d4(c),1000:14e9(c),1000:1541(c),1000:15b5(c),
                              ;             1000:1639(c),1000:1d09(c),1000:1d0d(c),1000:1d34(c),
                              ;             1000:1d3a(c),1000:1da5(c),1000:1db5(c),1000:1dfd(c),
                              ;             1000:1e0f(c),1000:1e65(c),1000:1e69(c),1000:1e8d(c),
                              ;             1000:1e93(c),1000:1ef9(c),1000:1f09(c),1000:1f51(c),
                              ;             1000:1f63(c)
    MOV         EBP,EBX
    MOV         CX,word [0xe992]
    TEST        CX,CX
    JL          LAB_1000_4769
    PUSH        DI
    MOV         DI,word [0xe996]
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [0x120]
    JL          LAB_1000_4715
    NOP
    NOP
    MOV         [0xe992],AX
    MOV         EAX,dword [SI + 0x6]
    MOV         dword [DI + 0xdb16],EAX
    MOV         dword [DI + 0xdb1a],EBP
    ADD         DI,0x8
    MOV         word [0xe996],DI
    POP         DI
    MOV         AX,word [SI]
    MOV         [0xe990],AX
    MOV         AX,word [SI + 0x4]
    MOV         [0xe994],AX
    RET
LAB_1000_4715:                ;XREF[1]:     1000:46ec(j)
    PUSH        AX
    JCXZ        LAB_1000_4754
    MOV         BX,word [SI]
    MOV         DX,word [0xe990]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    POP         CX
    POP         AX
    PUSH        BX
    MOV         BX,word [SI + 0x4]
    MOV         DX,word [0xe994]
    CALL        FUN_1000_3f7a
    MOV         CX,AX
    POP         AX
    MOV         BX,word [0x120]
    CALL        FUN_1000_2760
    ADD         AX,0xa0
    NEG         BX
    ADD         BX,0x64
    MOV         word [DI + 0xdb16],AX
    MOV         word [DI + 0xdb18],BX
    MOV         dword [DI + 0xdb1a],EBP
    ADD         DI,0x8
LAB_1000_4754:                ;XREF[1]:     1000:4716(j)
    POP         word [0xe992]
    MOV         word [0xe996],DI
    POP         DI
    MOV         AX,word [SI]
    MOV         [0xe990],AX
    MOV         AX,word [SI + 0x4]
    MOV         [0xe994],AX
    RET
LAB_1000_4769:                ;XREF[1]:     1000:46dc(j)
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [0x120]
    JGE         LAB_1000_4783
    NOP
    NOP
    MOV         [0xe992],AX
    MOV         AX,word [SI]
    MOV         [0xe990],AX
    MOV         AX,word [SI + 0x4]
    MOV         [0xe994],AX
    RET
LAB_1000_4783:                ;XREF[1]:     1000:4770(j)
    PUSH        AX
    MOV         DX,word [SI]
    MOV         BX,word [0xe990]
    XCHG        AX,CX
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    POP         CX
    POP         AX
    PUSH        BX
    MOV         DX,word [SI + 0x4]
    MOV         BX,word [0xe994]
    CALL        FUN_1000_3f7a
    MOV         CX,AX
    POP         AX
    MOV         BX,word [0x120]
    CALL        FUN_1000_2760
    ADD         AX,0xa0
    NEG         BX
    ADD         BX,0x64
    PUSH        DI
    MOV         DI,word [0xe996]
    MOV         word [DI + 0xdb16],AX
    MOV         word [DI + 0xdb18],BX
    MOV         dword [DI + 0xdb1a],EBP
    ADD         DI,0x8
    MOV         EAX,dword [SI + 0x6]
    MOV         dword [DI + 0xdb16],EAX
    MOV         dword [DI + 0xdb1a],EBP
    ADD         DI,0x8
    MOV         word [0xe996],DI
    POP         DI
    POP         word [0xe992]
    MOV         AX,word [SI]
    MOV         [0xe990],AX
    MOV         AX,word [SI + 0x4]
    MOV         [0xe994],AX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_47ec:
                              ;XREF[13]:    1000:1500(c),1000:1559(c),1000:15d0(c),1000:165c(c),
                              ;             1000:16d2(c),1000:1d14(c),1000:1d40(c),1000:1dc8(c),
                              ;             1000:1e21(c),1000:1e70(c),1000:1e99(c),1000:1f1c(c),
                              ;             1000:1f75(c)
    MOV         EBP,EBX
    MOV         CX,word [0xe992]
    TEST        CX,CX
    JL          LAB_1000_4860
    NOP
    NOP
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [0x120]
    JL          LAB_1000_480e
    NOP
    NOP
    MOV         AX,[0xe996]
    SHR         AX,0x3
    MOV         [0xdb14],AX
    RET
LAB_1000_480e:                ;XREF[1]:     1000:4800(j)
    JCXZ        LAB_1000_4856
    PUSH        DI
    MOV         DI,word [0xe996]
    MOV         BX,word [SI]
    MOV         DX,word [0xe990]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    POP         CX
    POP         AX
    PUSH        BX
    MOV         BX,word [SI + 0x4]
    MOV         DX,word [0xe994]
    CALL        FUN_1000_3f7a
    MOV         CX,AX
    POP         AX
    MOV         BX,word [0x120]
    CALL        FUN_1000_2760
    ADD         AX,0xa0
    NEG         BX
    ADD         BX,0x64
    MOV         word [DI + 0xdb16],AX
    MOV         word [DI + 0xdb18],BX
    MOV         dword [DI + 0xdb1a],EBP
    ADD         DI,0x8
    MOV         word [0xe996],DI
    POP         DI
LAB_1000_4856:                ;XREF[1]:     1000:480e(j)
    MOV         AX,[0xe996]
    SHR         AX,0x3
    MOV         [0xdb14],AX
    RET
LAB_1000_4860:                ;XREF[1]:     1000:47f5(j)
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [0x120]
    JGE         LAB_1000_4875
    NOP
    NOP
    MOV         AX,[0xe996]
    SHR         AX,0x3
    MOV         [0xdb14],AX
    RET
LAB_1000_4875:                ;XREF[1]:     1000:4867(j)
    MOV         DX,word [SI]
    MOV         BX,word [0xe990]
    XCHG        AX,CX
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    POP         CX
    POP         AX
    PUSH        BX
    MOV         DX,word [SI + 0x4]
    MOV         BX,word [0xe994]
    CALL        FUN_1000_3f7a
    MOV         CX,AX
    POP         AX
    MOV         BX,word [0x120]
    CALL        FUN_1000_2760
    ADD         AX,0xa0
    NEG         BX
    ADD         BX,0x64
    PUSH        DI
    MOV         DI,word [0xe996]
    MOV         word [DI + 0xdb16],AX
    MOV         word [DI + 0xdb18],BX
    MOV         dword [DI + 0xdb1a],EBP
    ADD         DI,0x8
    MOV         word [0xe996],DI
    MOV         AX,DI
    POP         DI
    SHR         AX,0x3
    MOV         [0xdb14],AX
    RET

 ; 1000:48cf [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_48d0:
                              ;XREF[1]:     1000:56ba(c)
    PUSH        SI
    CALL        FUN_1000_4e0a
    POP         SI
    PUSH        SI
    CALL        FUN_1000_48db
    POP         SI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_48db:
                              ;XREF[1]:     1000:48d6(c)
    CALL        FUN_1000_0e28
    MOV         DI,SI
    ADD         DI,word [SI]
    MOV         AX,word [DI]
    MOV         [0xe9d4],AX
    MOV         word [0xe9d6],0x0
    ADD         DI,0x2
LAB_1000_48f0:                ;XREF[1]:     1000:4976(j)
    MOV         EAX,[0x6a]
    SUB         dword [DI + 0x14],EAX
    MOV         EAX,dword [DI]
    MOV         EBX,dword [DI + 0x4]
    MOV         ECX,dword [DI + 0x8]
    SHR         EAX,0x10
    SHR         EBX,0x10
    SHR         ECX,0x10
    PUSH        CX
    CALL        FUN_1000_532e
    POP         CX
    ADD         AX,word [DI + 0x18]
    MOV         [0xe9c6],AX
    CMP         AX,CX
    JNS         LAB_1000_4a0d
LAB_1000_4920:                ;XREF[1]:     1000:4a6e(j)
    MOV         AX,word [DI + 0x2]
    SUB         AX,word [DI + 0x18]
    CMP         AX,0x80
    JC          LAB_1000_497e
    NOP
    NOP
LAB_1000_492d:                ;XREF[1]:     1000:499f(j)
    MOV         AX,word [DI + 0x6]
    SUB         AX,word [DI + 0x18]
    CMP         AX,0x80
    JC          LAB_1000_49a1
    NOP
    NOP
LAB_1000_493a:                ;XREF[1]:     1000:49c2(j)
    MOV         AX,word [DI + 0x2]
    ADD         AX,word [DI + 0x18]
    CMP         AX,0xfe80
    JA          LAB_1000_49c5
LAB_1000_4947:                ;XREF[1]:     1000:49e6(j)
    MOV         AX,word [DI + 0x6]
    ADD         AX,word [DI + 0x18]
    CMP         AX,0xfe80
    JA          LAB_1000_49e9
LAB_1000_4954:                ;XREF[1]:     1000:4a0a(j)
    MOV         EAX,dword [DI + 0xc]
    MOV         EBX,dword [DI + 0x10]
    MOV         ECX,dword [DI + 0x14]
    ADD         dword [DI],EAX
    ADD         dword [DI + 0x4],EBX
    ADD         dword [DI + 0x8],ECX
    ADD         DI,0x1c
    INC         word [0xe9d6]
    DEC         word [0xe9d4]
    JNZ         LAB_1000_48f0
    CALL        FUN_1000_1003
    RET
LAB_1000_497e:                ;XREF[1]:     1000:4929(j)
    MOV         word [0xe9a2],0x8000
    MOV         word [0xe9a6],0x0
    MOV         word [0xe9aa],0x0
    MOV         word [0xe9ae],0x7f00
    MOV         byte [0xea28],0x0
    NOP
    CALL        FUN_1000_4a71
    JMP         LAB_1000_492d
LAB_1000_49a1:                ;XREF[1]:     1000:4936(j)
    MOV         word [0xe9a2],0x0
    MOV         word [0xe9a6],0x7fff
    MOV         word [0xe9aa],0x8000
    MOV         word [0xe9ae],0x0
    MOV         byte [0xea28],0x0
    NOP
    CALL        FUN_1000_4a71
    JMP         LAB_1000_493a
LAB_1000_49c5:                ;XREF[1]:     1000:4943(j)
    MOV         word [0xe9a2],0x7fff
    MOV         word [0xe9a6],0x0
    MOV         word [0xe9aa],0x0
    MOV         word [0xe9ae],0x7fff
    MOV         byte [0xea28],0x0
    NOP
    CALL        FUN_1000_4a71
    JMP         LAB_1000_4947
LAB_1000_49e9:                ;XREF[1]:     1000:4950(j)
    MOV         word [0xe9a2],0x0
    MOV         word [0xe9a6],0x7fff
    MOV         word [0xe9aa],0x7fff
    MOV         word [0xe9ae],0x0
    MOV         byte [0xea28],0x0
    NOP
    CALL        FUN_1000_4a71
    JMP         LAB_1000_4954
LAB_1000_4a0d:                ;XREF[1]:     1000:491c(j)
    MOVZX       BX,byte [0xea28]
    SHR         BX,0x4
    MOVZX       CX,byte [BX + 0xea49]
    JCXZ        LAB_1000_4a3d
    MOV         EAX,dword [DI + 0xc]
    SAR         EAX,CL
    SUB         dword [DI + 0xc],EAX
    MOV         EAX,dword [DI + 0x10]
    SAR         EAX,CL
    SUB         dword [DI + 0x10],EAX
    MOV         EAX,dword [DI + 0x14]
    SAR         EAX,CL
    SUB         dword [DI + 0x14],EAX
LAB_1000_4a3d:                ;XREF[1]:     1000:4a1a(j)
    MOV         AX,[0xea24]
    MOV         BX,0x100
    CALL        FUN_1000_2b08
    MOV         BX,AX
    CALL        FUN_1000_2aad
    MOV         [0xe9a2],AX
    CALL        FUN_1000_2ad8
    MOV         [0xe9a6],AX
    MOV         AX,[0xea26]
    MOV         BX,0x100
    CALL        FUN_1000_2b08
    MOV         BX,AX
    CALL        FUN_1000_2aad
    MOV         [0xe9aa],AX
    CALL        FUN_1000_2ad8
    MOV         [0xe9ae],AX
    CALL        FUN_1000_4a71
    JMP         LAB_1000_4920
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4a71:
                              ;XREF[5]:     1000:499c(c),1000:49bf(c),1000:49e3(c),1000:4a07(c),
                              ;             1000:4a6b(c)
    MOV         EAX,dword [DI + 0x14]
    IMUL        dword [0xe9a4]
    SHL         EDX,0x1
    MOV         EAX,EDX
    IMUL        dword [0xe9ac]
    SHL         EDX,0x1
    MOV         EBX,EDX
    MOV         EAX,dword [DI + 0xc]
    IMUL        dword [0xe9a0]
    SHL         EDX,0x1
    SUB         EBX,EDX
    MOV         EAX,dword [DI + 0x10]
    IMUL        dword [0xe9a8]
    SHL         EDX,0x1
    SUB         EBX,EDX
    JNS         LAB_1000_4bd8
    MOV         dword [0xe9c8],EBX
    CMP         EBX,0xfffa0000
    JG          LAB_1000_4ac2
    NOP
    NOP
    XOR         AX,AX
    CALL        FUN_1000_5864
LAB_1000_4ac2:                ;XREF[1]:     1000:4ab9(j)
    MOV         ECX,dword [0xe9c8]
    MOV         EAX,ECX
    SAR         EAX,0x2
    ADD         ECX,EAX
    MOV         EAX,[0xe9a0]
    IMUL        ECX
    ADD         dword [DI + 0xc],EDX
    SHL         EDX,0x1
    ADD         dword [DI],EDX
    MOV         EAX,[0xe9a8]
    IMUL        ECX
    ADD         dword [DI + 0x10],EDX
    SHL         EDX,0x1
    ADD         dword [DI + 0x4],EDX
    MOV         EAX,ECX
    IMUL        dword [0xe9a4]
    SHL         EDX,0x1
    MOV         EAX,EDX
    IMUL        dword [0xe9ac]
    SUB         dword [DI + 0x14],EDX
    SHL         EDX,0x1
    SUB         dword [DI + 0x8],EDX
    MOV         AX,word [DI + 0x1a]
    CMP         AX,0x0
    JZ          LAB_1000_4bdc
    CMP         AX,0xffff
    JZ          LAB_1000_4bd9
    JMP         LAB_1000_4b26

 ; 1000:4b25 [UNDEFINED BYTES REMOVED]

LAB_1000_4b26:                ;XREF[1]:     1000:4b23(j)
    MOV         EAX,dword [DI + 0xc]
    IMUL        dword [0xe9a4]
    SHL         EDX,0x1
    MOV         EBX,EDX
    MOV         EAX,dword [DI + 0x14]
    IMUL        dword [0xe9a0]
    SHL         EDX,0x1
    ADD         EBX,EDX
    MOV         dword [0xe9cc],EBX
    MOV         EAX,dword [DI + 0x10]
    IMUL        dword [0xe9ac]
    SHL         EDX,0x1
    MOV         EBX,EDX
    MOV         EAX,dword [DI + 0x14]
    IMUL        dword [0xe9a8]
    SHL         EDX,0x1
    ADD         EBX,EDX
    MOV         dword [0xe9d0],EBX
    MOV         AX,[0xe9d6]
    CALL        FUN_1000_0e69
    MOV         [0xe9b0],EAX
    MOV         dword [0xe9b4],EBX
    MOV         dword [0xe9b8],ECX
    NEG         EDX
    MOV         dword [0xe9da],EDX
    CALL        FUN_1000_4c26
    MOV         [0xe9bc],AX
    MOV         BX,AX
    CALL        FUN_1000_2ad8
    SHL         EAX,0x10
    MOV         [0xe9c2],EAX
    CALL        FUN_1000_2aad
    SHL         EAX,0x10
    MOV         [0xe9be],EAX
    MOV         EAX,[0xe9da]
    SHL         EAX,0x1
    MOV         EBX,EAX
    IMUL        dword [0xe9be]
    ADD         dword [0xe9cc],EDX
    MOV         EAX,EBX
    IMUL        dword [0xe9c2]
    SUB         dword [0xe9d0],EDX
    CALL        FUN_1000_4d0e
    MOV         EBX,dword [0xe9da]
    NEG         EBX
    MOV         AX,[0xe9d6]
    CALL        FUN_1000_0f67
LAB_1000_4bd8:                ;XREF[1]:     1000:4aa9(j)
    RET
LAB_1000_4bd9:                ;XREF[1]:     1000:4b1f(j)
    JMP         LAB_1000_4bdc

 ; 1000:4bdb [UNDEFINED BYTES REMOVED]

LAB_1000_4bdc:                ;XREF[2]:     1000:4b18(j),1000:4bd9(j)
    MOV         EAX,dword [DI + 0xc]
    IMUL        dword [0xe9a4]
    SHL         EDX,0x1
    MOV         EBX,EDX
    MOV         EAX,dword [DI + 0x14]
    IMUL        dword [0xe9a0]
    SHL         EDX,0x1
    ADD         EBX,EDX
    MOV         dword [0xe9cc],EBX
    MOV         EAX,dword [DI + 0x10]
    IMUL        dword [0xe9ac]
    SHL         EDX,0x1
    MOV         EBX,EDX
    MOV         EAX,dword [DI + 0x14]
    IMUL        dword [0xe9a8]
    SHL         EDX,0x1
    ADD         EBX,EDX
    MOV         dword [0xe9d0],EBX
    CALL        FUN_1000_4cc3
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4c26:
                              ;XREF[1]:     1000:4b88(c)
    PUSH        ECX
    PUSH        EBX
    PUSH        ECX
    SAR         EAX,0x4
    IMUL        dword [0xe9a4]
    MOV         BX,DX
    NEG         BX
    POP         EAX
    SAR         EAX,0x4
    IMUL        dword [0xe9a0]
    SUB         BX,DX
    MOV         CX,BX
    POP         EAX
    SAR         EAX,0x4
    IMUL        dword [0xe9ac]
    MOV         BX,DX
    POP         EAX
    SAR         EAX,0x4
    IMUL        dword [0xe9a8]
    ADD         BX,DX
    MOV         AX,CX
    CALL        FUN_1000_2b08
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4c68:
                              ;XREF[2]:     1000:4cc3(c),1000:4d0e(c)
    MOV         EAX,[0xe9cc]
    MOV         EBX,dword [0xe9d0]
    AND         EAX,EAX
    JGE         LAB_1000_4c7b
    NOP
    NOP
    NEG         EAX
LAB_1000_4c7b:                ;XREF[1]:     1000:4c74(j)
    AND         EBX,EBX
    JGE         LAB_1000_4c85
    NOP
    NOP
    NEG         EBX
LAB_1000_4c85:                ;XREF[1]:     1000:4c7e(j)
    ADD         EAX,EBX
    MOVZX       BX,byte [0xea28]
    SHR         BX,0x4
    SHL         BX,0x1
    MOVZX       ECX,word [BX + 0xea29]
    SHL         BX,0x1
    MOV         EDX,dword [BX + 0xea59]
    MOV         EBX,EAX
    MOV         EAX,[0xe9c8]
    NEG         EAX
    CMP         EAX,EDX
    JL          LAB_1000_4cb3
    NOP
    NOP
    MOV         EAX,EDX
LAB_1000_4cb3:                ;XREF[1]:     1000:4cac(j)
    CDQ
    IDIV        ECX
    SAR         EBX,0x6
    SAR         ECX,0x1
    CMP         EAX,EBX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4cc3:
                              ;XREF[1]:     1000:4c22(c)
    CALL        FUN_1000_4c68
    JG          LAB_1000_4ce8
    NOP
    NOP
    PUSH        ECX
    CALL        FUN_1000_4d96
    POP         ECX
    MOV         EAX,[0xe9d0]
    CDQ
    IDIV        ECX
    MOV         EBX,EAX
    MOV         EAX,[0xe9cc]
    CDQ
    IDIV        ECX
    JMP         LAB_1000_4cf1
LAB_1000_4ce8:                ;XREF[1]:     1000:4cc6(j)
    MOV         EAX,[0xe9cc]
    MOV         EBX,dword [0xe9d0]
LAB_1000_4cf1:                ;XREF[1]:     1000:4ce6(j)
    IMUL        dword [0xe9a4]
    SUB         dword [DI + 0xc],EDX
    SUB         dword [DI],EDX
    MOV         EAX,EBX
    IMUL        dword [0xe9ac]
    SUB         dword [DI + 0x10],EDX
    SUB         dword [DI + 0x4],EDX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4d0e:
                              ;XREF[1]:     1000:4bc7(c)
    CALL        FUN_1000_4c68
    JG          LAB_1000_4d3a
    NOP
    NOP
    PUSH        ECX
    CALL        FUN_1000_4d96
    POP         ECX
    MOV         EAX,[0xe9d0]
    CDQ
    IDIV        ECX
    MOV         EBX,EAX
    MOV         EAX,[0xe9cc]
    CDQ
    IDIV        ECX
    MOV         [0xe9cc],EAX
    MOV         dword [0xe9d0],EBX
LAB_1000_4d3a:                ;XREF[1]:     1000:4d11(j)
    MOV         EAX,[0xe9cc]
    IMUL        dword [0xe9be]
    MOV         ECX,EDX
    MOV         EAX,[0xe9d0]
    IMUL        dword [0xe9c2]
    SUB         ECX,EDX
    SUB         dword [0xe9da],ECX
    MOV         EAX,ECX
    MOV         EBX,EAX
    IMUL        dword [0xe9be]
    ADD         dword [0xe9cc],EDX
    MOV         EAX,EBX
    IMUL        dword [0xe9c2]
    SUB         dword [0xe9d0],EDX
    MOV         EAX,[0xe9cc]
    IMUL        dword [0xe9a4]
    SUB         dword [DI + 0xc],EDX
    SUB         dword [DI],EDX
    MOV         EAX,[0xe9d0]
    IMUL        dword [0xe9ac]
    SUB         dword [DI + 0x10],EDX
    SUB         dword [DI + 0x4],EDX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4d96:
                              ;XREF[3]:     1000:4ccc(c),1000:4d17(c),1000:52b7(c)
    PUSH        SI
    MOV         SI,word [0x3e51]
    CMP         SI,0x15e0
    JNC         LAB_1000_4e08
    NOP
    NOP
    MOV         EAX,dword [DI]
    MOV         EBX,dword [DI + 0x4]
    MOV         ECX,dword [DI + 0x8]
    MOV         dword [SI + 0x3e53],EAX
    MOV         dword [SI + 0x3e57],EBX
    MOVZX       EAX,word [DI + 0x18]
    SHL         EAX,0x10
    SUB         ECX,EAX
    MOV         dword [SI + 0x3e5b],ECX
    MOV         EAX,[0xe9cc]
    IMUL        dword [0xe9a4]
    SHL         EDX,0x1
    MOV         dword [SI + 0x3e5f],EDX
    MOV         EAX,[0xe9d0]
    IMUL        dword [0xe9ac]
    SHL         EDX,0x1
    MOV         dword [SI + 0x3e63],EDX
    MOV         ECX,dword [DI + 0x14]
    MOV         dword [SI + 0x3e67],ECX
    MOVZX       AX,byte [0xea28]
    MOV         word [SI + 0x3e6d],AX
    MOV         word [SI + 0x3e6b],0x64
    ADD         word [0x3e51],0x1c
LAB_1000_4e08:                ;XREF[1]:     1000:4d9f(j)
    POP         SI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4e0a:
                              ;XREF[1]:     1000:48d1(c)
    MOV         AX,SI
    ADD         AX,word [SI]
    ADD         AX,0x2
    MOV         [0xe9d8],AX
    ADD         SI,word [SI + 0x2]
    MOV         AX,word [SI]
    MOV         [0xe9e6],AX
    ADD         SI,0x2
LAB_1000_4e1f:                ;XREF[1]:     1000:4f6d(j)
    MOV         BP,SI
    MOV         DI,word [SI + 0x2]
    MOV         AX,DI
    SHL         DI,0x3
    SUB         DI,AX
    SHL         DI,0x2
    ADD         DI,word [0xe9d8]
    MOV         SI,word [SI]
    MOV         AX,SI
    SHL         SI,0x3
    SUB         SI,AX
    SHL         SI,0x2
    ADD         SI,word [0xe9d8]
    MOV         EAX,dword [SI]
    SUB         EAX,dword [DI]
    MOV         ECX,dword [SI + 0xc]
    SUB         ECX,dword [DI + 0xc]
    MOV         [0xe9f8],EAX
    ADD         EAX,ECX
    MOV         [0xe9ec],EAX
    MOV         EAX,dword [SI + 0x4]
    SUB         EAX,dword [DI + 0x4]
    MOV         ECX,dword [SI + 0x10]
    SUB         ECX,dword [DI + 0x10]
    MOV         [0xe9fc],EAX
    ADD         EAX,ECX
    MOV         [0xe9f0],EAX
    MOV         EAX,dword [SI + 0x8]
    SUB         EAX,dword [DI + 0x8]
    MOV         ECX,dword [SI + 0x14]
    SUB         ECX,dword [DI + 0x14]
    MOV         [0xea00],EAX
    ADD         EAX,ECX
    MOV         [0xe9f4],EAX
    FINIT
    FILD        dword [0xe9ec]
    FMUL        ST0
    FILD        dword [0xe9f0]
    FMUL        ST0
    FILD        dword [0xe9f4]
    FMUL        ST0
    FADDP
    FADDP
    FSQRT
    FISTP       dword [0xe9e8]
    MOV         EAX,[0xe9e8]
    SAR         EAX,0xa
    MOVSX       EBX,word DS:[BP + 0x4]
    TEST        BX,BX
    JS          LAB_1000_5000
    MOVZX       ECX,word DS:[BP + 0x8]
    MOV         word [0xea04],CX
    AND         CX,0xff
    JZ          LAB_1000_4f72
    JS          LAB_1000_4f64
    CMP         CX,0x1
    JG          LAB_1000_4f8e
    MOV         ECX,EBX
    SUB         ECX,EAX
    JZ          LAB_1000_4f64
    NOP
    NOP
    CMP         CX,word [0xe9e2]
    JG          LAB_1000_4fe3
    CMP         CX,word [0xe9e4]
    JL          LAB_1000_4ff7
    MOV         EBX,EAX
LAB_1000_4efe:                ;XREF[3]:     1000:4fcb(j),1000:4fe0(j),1000:4ff4(j)
    SHL         ECX,0x6
    SHL         EBX,0x6
    PUSH        EBP
    MOV         EBP,ECX
    MOV         CL,byte [0xea05]
    INC         CL
    MOV         EAX,[0xe9f8]
    IMUL        EBP
    IDIV        EBX
    MOV         EDX,EAX
    SAR         EAX,CL
    SUB         EDX,EAX
    ADD         dword [SI + 0xc],EAX
    SUB         dword [DI + 0xc],EDX
    MOV         EAX,[0xe9fc]
    IMUL        EBP
    IDIV        EBX
    MOV         EDX,EAX
    SAR         EAX,CL
    SUB         EDX,EAX
    ADD         dword [SI + 0x10],EAX
    SUB         dword [DI + 0x10],EDX
    MOV         EAX,[0xea00]
    IMUL        EBP
    IDIV        EBX
    MOV         EDX,EAX
    SAR         EAX,CL
    SUB         EDX,EAX
    ADD         dword [SI + 0x14],EAX
    SUB         dword [DI + 0x14],EDX
    POP         EBP
LAB_1000_4f64:                ;XREF[5]:     1000:4ed6(j),1000:4ee7(j),1000:4f8c(j),1000:4fd7(j),
                              ;             1000:4ffd(j)
    MOV         SI,BP
LAB_1000_4f66:                ;XREF[1]:     1000:5008(j)
    ADD         SI,0xe
    DEC         word [0xe9e6]
    JNZ         LAB_1000_4e1f
    RET
LAB_1000_4f72:                ;XREF[1]:     1000:4ed2(j)
    MOVZX       EDX,word DS:[BP + 0xc]
    CMP         EAX,EDX
    JG          LAB_1000_4fce
    NOP
    NOP
    MOVZX       EDX,word DS:[BP + 0xa]
    CMP         EAX,EDX
    JL          LAB_1000_4fce
    NOP
    NOP
    JMP         LAB_1000_4f64
LAB_1000_4f8e:                ;XREF[1]:     1000:4edd(j)
    MOVZX       EDX,word DS:[BP + 0xc]
    CMP         EAX,EDX
    JG          LAB_1000_4fce
    NOP
    NOP
    MOVZX       EDX,word DS:[BP + 0xa]
    CMP         EAX,EDX
    JL          LAB_1000_4fce
    NOP
    NOP
    XCHG        EAX,EBX
    SUB         EAX,EBX
    CDQ
    SHR         ECX,0x1
    IDIV        ECX
    MOV         ECX,EAX
    MOVZX       EAX,word DS:[BP + 0x6]
    SUB         EAX,EBX
    SAR         EAX,0x1
    ADD         ECX,EAX
    MOV         word DS:[BP + 0x6],BX
    JMP         LAB_1000_4efe
LAB_1000_4fce:                ;XREF[4]:     1000:4f7b(j),1000:4f88(j),1000:4f97(j),1000:4fa4(j)
    MOV         ECX,EDX
    SUB         ECX,EAX
    SAR         ECX,0x1
    JZ          LAB_1000_4f64
    MOV         EBX,EAX
    MOV         word DS:[BP + 0x6],BX
    JMP         LAB_1000_4efe
LAB_1000_4fe3:                ;XREF[1]:     1000:4eef(j)
    SAR         ECX,0x4
    XCHG        EAX,EBX
    SUB         EAX,ECX
    MOV         word DS:[BP + 0x4],AX
    MOV         word DS:[BP + 0x6],AX
    JMP         LAB_1000_4efe
LAB_1000_4ff7:                ;XREF[1]:     1000:4ef7(j)
    OR          word DS:[BP + 0x8],0x80
    JMP         LAB_1000_4f64
LAB_1000_5000:                ;XREF[1]:     1000:4ec0(j)
    MOV         SI,BP
    MOV         word [SI + 0x4],AX
    MOV         word [SI + 0x6],AX
    JMP         LAB_1000_4f66
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_500b:
                              ;XREF[1]:     1000:56c8(c)
    MOV         byte [0xea28],0x0
    NOP
    MOV         DI,0x5bbc
    MOV         CX,word [0x5bba]
LAB_1000_5018:                ;XREF[1]:     1000:508e(j)
    PUSH        CX
    PUSH        DI
    MOV         SI,word [DI]
    CALL        FUN_1000_5091
    MOV         DI,0x5bbc
    MOV         CX,word [0x5bba]
LAB_1000_5026:                ;XREF[1]:     1000:5087(j)
    PUSH        CX
    PUSH        DI
    MOV         DI,word [DI]
    CMP         DI,SI
    JZ          LAB_1000_5082
    NOP
    NOP
    PUSH        SI
    PUSH        DI
    ADD         SI,word [SI]
    ADD         SI,0x2
    ADD         DI,word [DI]
    ADD         DI,0x2
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [DI + 0x2]
    CMP         AX,0x200
    JG          LAB_1000_5080
    NOP
    NOP
    CMP         AX,0xfe00
    JL          LAB_1000_5080
    NOP
    NOP
    MOV         AX,word [SI + 0x6]
    SUB         AX,word [DI + 0x6]
    CMP         AX,0x200
    JG          LAB_1000_5080
    NOP
    NOP
    CMP         AX,0xfe00
    JL          LAB_1000_5080
    NOP
    NOP
    MOV         AX,word [SI + 0xa]
    SUB         AX,word [DI + 0xa]
    CMP         AX,0x200
    JG          LAB_1000_5080
    NOP
    NOP
    CMP         AX,0xfe00
    JL          LAB_1000_5080
    NOP
    NOP
    POP         DI
    POP         SI
    CALL        FUN_1000_51bd
    JMP         LAB_1000_5082

 ; 1000:507f [UNDEFINED BYTES REMOVED]

LAB_1000_5080:                ;XREF[6]:     1000:5045(j),1000:504c(j),1000:5059(j),1000:5060(j),
                              ;             1000:506d(j),1000:5074(j)
    POP         DI
    POP         SI
LAB_1000_5082:                ;XREF[2]:     1000:502c(j),1000:507d(j)
    POP         DI
    POP         CX
    ADD         DI,0x2
    LOOP        LAB_1000_5026
    POP         DI
    POP         CX
    ADD         DI,0x2
    LOOP        LAB_1000_5018
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_5091:
                              ;XREF[1]:     1000:501c(c)
    PUSH        SI
    MOV         DX,SI
    ADD         DX,word [SI]
    ADD         DX,0x2
    MOV         SI,0xec1b
    LODSW ;       SI
    MOV         CX,AX
    MOV         word [0xea99],0x0
LAB_1000_50a5:                ;XREF[1]:     1000:51b7(j)
    PUSH        CX
    LODSW ;       SI
    MOV         BX,AX
    SHL         BX,0x3
    SUB         BX,AX
    SHL         BX,0x2
    ADD         BX,DX
    LODSW ;       SI
    MOV         BP,AX
    SHL         BP,0x3
    SUB         BP,AX
    SHL         BP,0x2
    ADD         BP,DX
    LODSW ;       SI
    MOV         DI,AX
    SHL         DI,0x3
    SUB         DI,AX
    SHL         DI,0x2
    ADD         DI,DX
    PUSH        SI
    PUSH        DX
    MOV         SI,BP
    MOV         BP,word [0xea99]
    MOV         EAX,dword [BX + 0x4]
    MOV         dword DS:[BP + 0xeb5f],EAX
    SUB         EAX,dword [SI + 0x4]
    MOV         ECX,dword [BX + 0x8]
    SUB         ECX,dword [DI + 0x8]
    SAR         EAX,0xe
    SAR         ECX,0xe
    IMUL        EAX,ECX
    MOV         EDX,EAX
    MOV         EAX,dword [BX + 0x4]
    SUB         EAX,dword [DI + 0x4]
    MOV         ECX,dword [BX + 0x8]
    SUB         ECX,dword [SI + 0x8]
    SAR         EAX,0xe
    SAR         ECX,0xe
    IMUL        EAX,ECX
    SUB         EDX,EAX
    MOV         dword DS:[BP + 0xea9b],EDX
    MOV         EAX,dword [BX + 0x8]
    MOV         dword DS:[BP + 0xeb63],EAX
    SUB         EAX,dword [DI + 0x8]
    MOV         ECX,dword [BX]
    SUB         ECX,dword [SI]
    SAR         EAX,0xe
    SAR         ECX,0xe
    IMUL        EAX,ECX
    MOV         EDX,EAX
    MOV         EAX,dword [BX + 0x8]
    SUB         EAX,dword [SI + 0x8]
    MOV         ECX,dword [BX]
    SUB         ECX,dword [DI]
    SAR         EAX,0xe
    SAR         ECX,0xe
    IMUL        EAX,ECX
    SUB         EDX,EAX
    NEG         EDX
    MOV         dword DS:[BP + 0xea9f],EDX
    MOV         EAX,dword [BX]
    MOV         dword DS:[BP + 0xeb5b],EAX
    SUB         EAX,dword [DI]
    MOV         ECX,dword [BX + 0x4]
    SUB         ECX,dword [SI + 0x4]
    SAR         EAX,0xe
    SAR         ECX,0xe
    IMUL        EAX,ECX
    MOV         EDX,EAX
    MOV         EAX,dword [BX]
    SUB         EAX,dword [SI]
    MOV         ECX,dword [BX + 0x4]
    SUB         ECX,dword [DI + 0x4]
    SAR         EAX,0xe
    SAR         ECX,0xe
    IMUL        EAX,ECX
    SUB         EDX,EAX
    MOV         dword DS:[BP + 0xeaa3],EDX
    POP         DX
    POP         SI
    ADD         word [0xea99],0xc
    POP         CX
    DEC         CX
    JNZ         LAB_1000_50a5
    POP         SI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_51bd:
                              ;XREF[1]:     1000:507a(c)
    PUSH        DI
    PUSH        SI
    ADD         DI,word [DI]
    MOV         CX,word [DI]
    ADD         DI,0x2
LAB_1000_51c6:                ;XREF[1]:     1000:52bf(j)
    PUSH        CX
    XOR         SI,SI
    MOV         BX,SI
    MOV         ECX,0x80000000
LAB_1000_51d1:                ;XREF[1]:     1000:5224(j)
    MOV         EAX,dword [DI]
    SUB         EAX,dword [SI + 0xeb5b]
    SAR         EAX,0x10
    IMUL        EAX,dword [SI + 0xea9b]
    MOV         EDX,EAX
    MOV         EAX,dword [DI + 0x4]
    SUB         EAX,dword [SI + 0xeb5f]
    SAR         EAX,0x10
    IMUL        EAX,dword [SI + 0xea9f]
    ADD         EDX,EAX
    MOV         EAX,dword [DI + 0x8]
    SUB         EAX,dword [SI + 0xeb63]
    SAR         EAX,0x10
    IMUL        EAX,dword [SI + 0xeaa3]
    ADD         EDX,EAX
    JNS         LAB_1000_52ba
    CMP         EDX,ECX
    JG          LAB_1000_52c6
LAB_1000_521d:                ;XREF[1]:     1000:52cb(j)
    ADD         SI,0xc
    CMP         SI,word [0xea99]
    JC          LAB_1000_51d1
    MOV         EAX,dword [BX + 0xea9b]
    ADD         dword [DI + 0xc],EAX
    MOV         EAX,dword [BX + 0xea9f]
    ADD         dword [DI + 0x10],EAX
    MOV         EAX,dword [BX + 0xeaa3]
    ADD         dword [DI + 0x14],EAX
    POP         CX
    POP         SI
    PUSH        SI
    PUSH        CX
    PUSH        BX
    ADD         SI,word [SI]
    MOV         CX,word [SI]
    ADD         SI,0x2
    MOV         DX,0x7fff
    MOV         BP,SI
LAB_1000_5252:                ;XREF[1]:     1000:5282(j)
    MOV         AX,word [SI + 0x2]
    AND         AX,AX
    JGE         LAB_1000_525d
    NOP
    NOP
    NEG         AX
LAB_1000_525d:                ;XREF[1]:     1000:5257(j)
    MOV         BX,AX
    MOV         AX,word [SI + 0x6]
    AND         AX,AX
    JGE         LAB_1000_526a
    NOP
    NOP
    NEG         AX
LAB_1000_526a:                ;XREF[1]:     1000:5264(j)
    ADD         BX,AX
    MOV         AX,word [SI + 0xa]
    AND         AX,AX
    JGE         LAB_1000_5277
    NOP
    NOP
    NEG         AX
LAB_1000_5277:                ;XREF[1]:     1000:5271(j)
    ADD         BX,AX
    CMP         BX,DX
    JL          LAB_1000_52ce
    NOP
    NOP
LAB_1000_527f:                ;XREF[1]:     1000:52d2(j)
    ADD         SI,0x1c
    LOOP        LAB_1000_5252
    MOV         SI,BP
    POP         BX
    MOV         EAX,dword [BX + 0xea9b]
    SAR         EAX,0x1
    SUB         dword [SI + 0xc],EAX
    ADD         dword [DI + 0xc],EAX
    MOV         EAX,dword [BX + 0xea9f]
    SAR         EAX,0x1
    SUB         dword [SI + 0x10],EAX
    ADD         dword [DI + 0x10],EAX
    MOV         EAX,dword [BX + 0xeaa3]
    SAR         EAX,0x1
    SUB         dword [SI + 0x14],EAX
    ADD         dword [DI + 0x14],EAX
    CALL        FUN_1000_4d96
LAB_1000_52ba:                ;XREF[1]:     1000:5212(j)
    ADD         DI,0x1c
    POP         CX
    DEC         CX
    JNZ         LAB_1000_51c6
    POP         SI
    POP         DI
    RET
LAB_1000_52c6:                ;XREF[1]:     1000:5219(j)
    MOV         ECX,EDX
    MOV         BX,SI
    JMP         LAB_1000_521d
LAB_1000_52ce:                ;XREF[1]:     1000:527b(j)
    MOV         DX,BX
    MOV         BP,SI
    JMP         LAB_1000_527f
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_52d4:
                              ;XREF[2]:     1000:5393(c),1000:53e4(c)
    MOV         AX,[0xea0c]
    IMUL        word [0xea14]
    MOV         [0xea22],AX
    MOV         AX,[0xea0e]
    IMUL        word [0xea12]
    SUB         word [0xea22],AX
    MOV         AX,[0xea18]
    IMUL        word [0xea14]
    MOV         [0xea1e],AX
    MOV         AX,[0xea1a]
    IMUL        word [0xea12]
    SUB         word [0xea1e],AX
    MOV         AX,[0xea1a]
    IMUL        word [0xea0c]
    MOV         [0xea20],AX
    MOV         AX,[0xea18]
    IMUL        word [0xea0e]
    SUB         word [0xea20],AX
    MOV         AX,[0xea10]
    IMUL        word [0xea1e]
    MOV         BX,AX
    MOV         CX,DX
    MOV         AX,[0xea16]
    IMUL        word [0xea20]
    ADD         AX,BX
    ADC         DX,CX
    IDIV        word [0xea22]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_532e:
                              ;XREF[1]:     1000:4910(c)
    MOV         word [0xea1c],CX
    MOV         word [0xea0c],0x80
    MOV         word [0xea0e],0x0
    MOV         word [0xea12],0x0
    MOV         word [0xea14],0x80
    SHR         AL,0x1
    SHR         BL,0x1
    MOV         CL,AL
    ADD         CL,BL
    CMP         CL,0x80
    JA          LAB_1000_539b
    NOP
    NOP
    MOV         [0xea18],AL
    MOV         byte [0xea1a],BL
    MOV         BL,AH
    MOV         AL,byte FS:[BX]
    MOV         [0xea28],AL
    MOVZX       AX,byte GS:[BX]
    SHL         AX,0x4
    MOV         CX,AX
    MOVZX       AX,byte GS:[BX + 0x1]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         [0xea10],AX
    MOV         [0xea24],AX
    MOVZX       AX,byte GS:[BX + 0x100]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         [0xea16],AX
    MOV         [0xea26],AX
    PUSH        CX
    CALL        FUN_1000_52d4
    POP         CX
    ADD         AX,CX
    JMP         LAB_1000_53ea
LAB_1000_539b:                ;XREF[1]:     1000:5355(j)
    NEG         AL
    NEG         BL
    ADD         AL,0x80
    ADD         BL,0x80
    MOV         [0xea18],AL
    MOV         byte [0xea1a],BL
    MOV         BL,AH
    MOV         AL,byte FS:[BX]
    MOV         [0xea28],AL
    MOVZX       AX,byte GS:[BX + 0x101]
    SHL         AX,0x4
    MOV         CX,AX
    MOVZX       AX,byte GS:[BX + 0x1]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         [0xea16],AX
    NEG         AX
    MOV         [0xea26],AX
    MOVZX       AX,byte GS:[BX + 0x100]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         [0xea10],AX
    NEG         AX
    MOV         [0xea24],AX
    PUSH        CX
    CALL        FUN_1000_52d4
    POP         CX
    ADD         AX,CX
LAB_1000_53ea:                ;XREF[1]:     1000:5399(j)
    RET

 ; 1000:542f [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
fun_setup_interrupts:
                              ;XREF[1]:     1000:0229(c)
    PUSH        ES
    MOV         AX,CS
    MOV         ES,AX
    MOV         DI,DAT_keys_571e
    MOV         AL,0xff
    CLD
    MOV         CL,0x80
                              ; FWD[2]:     1000:571e(W),1000:571f(W)
    REP STOSB ;   ES:DI  ; =>DAT_keys_571e
    POP         ES
    CLI
    IN          AL,0x21
    MOV         CS:[BYTE_1000_553e],AL
    MOV         AL,0xff
    OUT         0x21,AL
    PUSH        DS
    PUSH        ES
    PUSH        FS
    XOR         AX,AX
    MOV         FS,AX
    MOV         ES,word FS:[0x22]
    MOV         BX,word FS:[0x20]
    POP         FS
    MOV         word CS:[WORD_1000_5532],BX
    MOV         word CS:[WORD_1000_5534],ES
    MOV         AX,CS
    MOV         DS,AX
    MOV         DX,iFUN_timer_5680
    PUSH        FS
    XOR         AX,AX
    MOV         FS,AX
    MOV         word FS:[0x22],DS
    MOV         word FS:[0x20],DX
    POP         FS
    MOV         AX,0x3509
    INT         0x21
    MOV         word CS:[WORD_1000_5536],BX
    MOV         word CS:[WORD_1000_5538],ES
    MOV         AX,CS
    MOV         DS,AX
    MOV         DX,iFUN_keyboard_56df
    MOV         AX,0x2509
    INT         0x21
    MOV         AX,0x3500
    INT         0x21
    MOV         word CS:[WORD_1000_552e],BX
    MOV         word CS:[WORD_1000_5530],ES
    MOV         AX,CS
    MOV         DS,AX
    MOV         DX,0x553f
    MOV         AX,0x2500
    INT         0x21
    MOV         AX,0x35f1
    INT         0x21
    MOV         word CS:[WORD_1000_553a],BX
    MOV         word CS:[WORD_1000_553c],ES
    MOV         AX,CS
    MOV         DS,AX
    MOV         DX,iFUN_int_f1_579e
    MOV         AX,0x25f1
    INT         0x21
    POP         ES
    POP         DS
    MOV         CX,word [0xec50]
    MOV         AX,0x34dc
    MOV         DX,0x12
    DIV         CX
    CALL        FUN_1000_551f
    MOV         AL,CS:[BYTE_1000_553e]
    OUT         0x21,AL
    STI
    RET

 ; 1000:551e [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_551f:
                              ;XREF[1]:     1000:54e1(c)
    MOV         BX,AX
    MOV         AL,0x36
    OUT         0x43,AL
    MOV         AX,BX
    OUT         0x40,AL
    MOV         AL,AH
    OUT         0x40,AL
    RET
WORD_1000_552e:               ;XREF[1]:     1000:54a2(W)
    dw          0h
WORD_1000_5530:               ;XREF[1]:     1000:54a7(W)
    dw          0h
WORD_1000_5532:               ;XREF[1]:     1000:545f(W)
    dw          0h
WORD_1000_5534:               ;XREF[1]:     1000:5464(W)
    dw          0h
WORD_1000_5536:               ;XREF[1]:     1000:5487(W)
    dw          0h
WORD_1000_5538:               ;XREF[1]:     1000:548c(W)
    dw          0h
WORD_1000_553a:               ;XREF[1]:     1000:54bd(W)
    dw          0h
WORD_1000_553c:               ;XREF[1]:     1000:54c2(W)
    dw          0h
BYTE_1000_553e:               ;XREF[2]:     1000:5443(W),1000:54e4(R)
    db          0h

 ; 1000:55ec [UNDEFINED BYTES REMOVED]

; ds          "!core"
; ds          "\r\nDivide overflow at segment="

 ; 1000:5611 [UNDEFINED BYTES REMOVED]

; ds          ", offset="

 ; 1000:561c [UNDEFINED BYTES REMOVED]

; ds          ", flags="

 ; 1000:5626 [UNDEFINED BYTES REMOVED]

; ds          ", registers="

 ; 1000:564e [UNDEFINED BYTES REMOVED]

; ds          ", memory="

 ; 1000:567f [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
iFUN_timer_5680:
    CLI
    PUSHAD
    PUSH        DS
    PUSH        ES
    PUSH        FS
    PUSH        GS
    MOV         AX,0x15cd
    MOV         DS,AX
    CMP         byte [0x006e],0x1
    JNZ         LAB_1000_56d1
    NOP
    NOP
    MOV         ES,AX
    MOV         AX,[0x1a47]
    MOV         FS,AX
    MOV         AX,[0x1a45]
    MOV         GS,AX
    MOV         DI,0x5bbc
    MOV         CX,word [0x5bba]      ;= 0001h
    MOV         BP,0x5ad9
LAB_1000_56ad:                ;XREF[1]:     1000:56c6(j)
                              ; FWD[2]:     15cd:5bbc(R),15cd:5bbe(R)
    MOV         SI,word [DI]  ; =>0x5bbc
    PUSH        CX
    PUSH        DI
    PUSH        BP
    MOV         DI,BP
    CALL        FUN_1000_0d2a
    CALL        FUN_1000_1004
    CALL        FUN_1000_48d0
    POP         BP
    POP         DI
    POP         CX
    ADD         DI,0x2
    ADD         BP,0x6
    LOOP        LAB_1000_56ad
    CALL        FUN_1000_500b
    CALL        FUN_1000_0bb5
    CALL        FUN_1000_0a3b
LAB_1000_56d1:                ;XREF[1]:     1000:5693(j)
    MOV         AL,0x20
    OUT         0x20,AL
    POP         GS
    POP         FS
    POP         ES
    POP         DS
    POPAD
    STI
    IRET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
iFUN_keyboard_56df:
    CLI
    PUSH        AX
    PUSH        BX
    IN          AL,0x60
    MOV         BL,AL
    AND         BX,0x7f
    AND         AL,0x80
    JNS         LAB_1000_56ff
    NOP
    NOP
    MOV         byte CS:[BX + DAT_keys_571e],0xff
    NOP
    MOV         byte CS:[DAT_keys_571e],0x0
    NOP
    JMP         LAB_1000_570a
LAB_1000_56ff:                ;XREF[1]:     1000:56eb(j)
    AND         byte CS:[BX + DAT_keys_571e],0x7f
    MOV         byte CS:[DAT_keys_571e],BL
LAB_1000_570a:                ;XREF[1]:     1000:56fd(j)
    IN          AL,0x61
    MOV         AH,AL
    OR          AL,0x80
    OUT         0x61,AL
    MOV         AL,AH
    OUT         0x61,AL
    MOV         AL,0x20
    OUT         0x20,AL
    POP         BX
    POP         AX
    STI
    IRET
DAT_keys_571e:                ;XREF[14,9]:  1000:04fa(R),1000:0513(R),1000:052b(R),1000:0544(R),
                              ;             1000:055d(R),1000:05ac(W),1000:0a3d(R),1000:0a47(R),
                              ;             1000:0a55(RW),1000:0a6c(RW),1000:543d(W),1000:543d(W),
                              ;             1000:56f6(W),1000:5705(W),1000:04fa(R),1000:0513(R),
                              ;             1000:052b(R),1000:0544(R),1000:0a3d(R),1000:0a47(R),
                              ;             1000:0a55(RW),1000:0a6c(RW),1000:543d(W)
    times 128 db 0xFF
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
iFUN_int_f1_579e:
    CMP         AL,0x0
    JZ          LAB_1000_57bd
    NOP
    NOP
    CMP         AL,0x1
    JZ          LAB_1000_57c1
    NOP
    NOP
    CMP         AL,0x2
    JZ          LAB_1000_57c5
    NOP
    NOP
    CMP         AL,0x10
    JZ          LAB_1000_57cb
    NOP
    NOP
    CMP         AL,0x11
    JZ          LAB_1000_57d1
    NOP
    NOP
    IRET
LAB_1000_57bd:                ;XREF[1]:     1000:57a0(j)
    CALL        FUN_1000_2aad
    IRET
LAB_1000_57c1:                ;XREF[1]:     1000:57a6(j)
    CALL        FUN_1000_2ad8
    IRET
LAB_1000_57c5:                ;XREF[1]:     1000:57ac(j)
    MOV         AX,CX
    CALL        FUN_1000_2b08
    IRET
LAB_1000_57cb:                ;XREF[1]:     1000:57b2(j)
    MOV         AX,DX
    CALL        FUN_1000_271d
    IRET
LAB_1000_57d1:                ;XREF[1]:     1000:57b8(j)
    MOV         EAX,EDX
    CALL        FUN_1000_2726
    IRET

 ; 1000:57df [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_57e0:
                              ;XREF[1]:     1000:022c(c)
    MOV         AX,0x120
    CALL        FUN_1000_58fc
    MOV         AX,0x800
    CALL        FUN_1000_58fc
    MOV         AX,0xbdc0
    CALL        FUN_1000_58fc
    MOV         AX,0xb000
LAB_1000_57f5:                ;XREF[1]:     1000:57ff(j)
    PUSH        AX
    CALL        FUN_1000_58fc
    POP         AX
    INC         AH
    CMP         AH,0xb8
    JBE         LAB_1000_57f5
    MOV         AL,0x0
    MOV         SI,0xecb8
    CALL        FUN_1000_589b
    MOV         AL,0x1
    MOV         SI,0xecb8
    CALL        FUN_1000_589b
    MOV         AX,0x443f
    CALL        FUN_1000_58fc
    MOV         CX,0xf00
    MOV         AL,CL
    MOV         AH,0xa1
    CALL        FUN_1000_58fc
    MOV         AL,CH
    OR          AL,0x20
    MOV         AH,0xb1
    CALL        FUN_1000_58fc
    MOV         DX,0x5831
    MOV         AX,0x588b
    RET

 ; 1000:5863 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_5864:
                              ;XREF[1]:     1000:4abf(c)
    PUSH        SI
    PUSH        DX
    MOV         DX,0x388
    SHL         AX,0x4
    MOV         SI,0xecd9
    ADD         SI,AX
    MOV         AX,0xb800
    CALL        FUN_1000_58fc
    MOV         AL,0x8
    CALL        FUN_1000_589b
    LODSB ;       SI
    MOV         AH,0xa8
    CALL        FUN_1000_58fc
    LODSB ;       SI
    MOV         AH,0xb8
    CALL        FUN_1000_58fc
    POP         DX
    POP         SI
    RET

 ; 1000:589a [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_589b:
                              ;XREF[3]:     1000:5806(c),1000:580e(c),1000:5879(c)
    MOVZX       BX,AL
    MOV         BL,byte CS:[BX + DAT_unk_592c]
    MOV         AH,0x20
    ADD         AH,BL
    LODSB ;       SI
    CALL        FUN_1000_58fc
    MOV         AH,0x40
    ADD         AH,BL
    LODSB ;       SI
    CALL        FUN_1000_58fc
    MOV         AH,0x60
    ADD         AH,BL
    LODSB ;       SI
    CALL        FUN_1000_58fc
    MOV         AH,0x80
    ADD         AH,BL
    LODSB ;       SI
    CALL        FUN_1000_58fc
    MOV         AH,0xe0
    ADD         AH,BL
    LODSB ;       SI
    CALL        FUN_1000_58fc
    MOV         AH,0x23
    ADD         AH,BL
    LODSB ;       SI
    CALL        FUN_1000_58fc
    MOV         AH,0x43
    ADD         AH,BL
    LODSB ;       SI
    CALL        FUN_1000_58fc
    MOV         AH,0x63
    ADD         AH,BL
    LODSB ;       SI
    CALL        FUN_1000_58fc
    MOV         AH,0x83
    ADD         AH,BL
    LODSB ;       SI
    CALL        FUN_1000_58fc
    MOV         AH,0xe3
    ADD         AH,BL
    LODSB ;       SI
    CALL        FUN_1000_58fc
    MOV         AH,0xc0
    ADD         AH,BL
    LODSB ;       SI
    CALL        FUN_1000_58fc
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_58fc:
                              ;XREF[21]:    1000:57e3(c),1000:57e9(c),1000:57ef(c),1000:57f6(c),
                              ;             1000:5814(c),1000:581e(c),1000:5827(c),1000:5874(c),
                              ;             1000:587f(c),1000:5885(c),1000:58a8(c),1000:58b0(c),
                              ;             1000:58b8(c),1000:58c0(c),1000:58c8(c),1000:58d0(c),
                              ;             1000:58d8(c),1000:58e0(c),1000:58e8(c),1000:58f0(c),
                              ;             1000:58f8(c)
    PUSH        AX
    XCHG        AH,AL
    MOV         DX,0x388
    OUT         DX,AL
    IN          AL,DX
    IN          AL,DX
    IN          AL,DX
    IN          AL,DX
    IN          AL,DX
    IN          AL,DX
    INC         DX
    MOV         AL,AH
    OUT         DX,AL
    PUSH        ECX
    MOV         ECX,0x1c
LAB_1000_5915:                ;XREF[1]:     1000:5916(j)
    IN          AL,DX
    LOOP        LAB_1000_5915
    POP         ECX
    DEC         DX
    POP         AX
    RET

 ; 1000:592b [UNDEFINED BYTES REMOVED]

DAT_unk_592c:
;    db[20]
         db          0h
         db          1h
         db          2h
         db          8h
         db          9h
         db          0xA
         db          10h
         db          11h
         db          12h
         db          0h
         db          0h
         db          0h
         db          0h
         db          0h
         db          0h
         db          0h
         db          0h
         db          0h
         db          0h
         db          0h
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_5940:
                              ;XREF[2]:     1000:04e6(c),1000:04f4(c)
    MOV         byte CS:[BYTE_1000_59c1],CL         ;= Fh
    MOV         CX,AX
    CLD
LAB_1000_5948:                ;XREF[4]:     1000:5959(j),1000:596d(j),1000:5978(j),1000:59bf(j)
    LODSB ;       SI
    CMP         AL,0x0
    JNZ         LAB_1000_5950
    NOP
    NOP
    RET
LAB_1000_5950:                ;XREF[1]:     1000:594b(j)
    CMP         AL,0x9
    JNZ         LAB_1000_595b
    NOP
    NOP
    ADD         CX,0x14
    JMP         LAB_1000_5948
LAB_1000_595b:                ;XREF[1]:     1000:5952(j)
    CMP         AL,0xd
    JNZ         LAB_1000_5962
    NOP
    NOP
    RET
LAB_1000_5962:                ;XREF[1]:     1000:595d(j)
    CMP         AL,0x1b
    JNZ         LAB_1000_596f
    NOP
    NOP
    LODSB ;       SI
    MOV         CS:[BYTE_1000_59c1],AL                  ;= Fh
    JMP         LAB_1000_5948
LAB_1000_596f:                ;XREF[1]:     1000:5964(j)
    CMP         AL,0x20
    JNZ         LAB_1000_597a
    NOP
    NOP
    ADD         CX,0x5
    JMP         LAB_1000_5948
LAB_1000_597a:                ;XREF[1]:     1000:5971(j)
    PUSH        SI
    PUSH        BX
    MOV         SI,0xed17
    SUB         AH,AH
    ADD         AX,AX
    MOV         BX,AX
    ADD         SI,word [BX + 0xed17]
    ADD         SI,0x100
    POP         BX
    MOV         AX,CX
LAB_1000_5990:                ;XREF[1]:     1000:59b8(j)
    PUSH        BX
    MOV         DL,byte [SI]
    TEST        DL,DL
    JZ          LAB_1000_59ba
    NOP
    NOP
LAB_1000_5999:                ;XREF[2]:     1000:59a4(j),1000:59b3(j)
    SHR         DL,0x1
    JC          LAB_1000_59a6
    NOP
    NOP
    JZ          LAB_1000_59b5
    NOP
    NOP
    INC         BX
    JMP         LAB_1000_5999
LAB_1000_59a6:                ;XREF[1]:     1000:599b(j)
    PUSH        AX
    PUSH        BX
    MOV         CL,byte CS:[BYTE_1000_59c1]         ;= Fh
    CALL        FUN_1000_3f98
    POP         BX
    POP         AX
    INC         BX
    JMP         LAB_1000_5999
LAB_1000_59b5:                ;XREF[1]:     1000:599f(j)
    POP         BX
    INC         AX
    INC         SI
    JMP         LAB_1000_5990
LAB_1000_59ba:                ;XREF[1]:     1000:5995(j)
    POP         BX
    POP         SI
    MOV         CX,AX
    INC         CX
    JMP         LAB_1000_5948
BYTE_1000_59c1:               ;XREF[3]:     1000:5940(W),1000:5969(W),1000:59a8(R)
    db          0xF

 ; 1000:5a5f [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_5a60:
                              ;XREF[3]:     1000:24ca(c),1000:24da(c),1000:2566(c)
    MOV         DX,DX
    MOV         AL,0x0
    MOV         AH,0x3d
    INT         0x21
    MOV         BX,AX
    JC          LAB_1000_5a94
    NOP
    NOP
    CALL        FUN_1000_5a95
    JC          LAB_1000_5a94
    NOP
    NOP
    MOV         CX,0x0
    MOV         DX,0x80
    MOV         AX,0x4200
    INT         0x21
    JC          LAB_1000_5a94
    NOP
    NOP
    CALL        FUN_1000_5acf
    JC          LAB_1000_5a94
    NOP
    NOP
    MOV         AH,0x3e
    INT         0x21
    JC          LAB_1000_5a94
    NOP
    NOP
    RET
LAB_1000_5a94:                ;XREF[5]:     1000:5a6a(j),1000:5a71(j),1000:5a80(j),1000:5a87(j),
                              ;             1000:5a8f(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_5a95:
                              ;XREF[3]:     1000:01d3(c),1000:24ec(c),1000:5a6e(c)
    MOV         DX,0xef88
    MOV         CX,0x80
    MOV         AH,0x3f
    INT         0x21
    JC          LAB_1000_5ace
    NOP
    NOP
    MOV         AX,[0xef90]
    SUB         AX,word [0xef8c]
    INC         AX
    MOV         [0xef80],AX
    MOV         CX,word [0xef92]
    SUB         CX,word [0xef8e]
    INC         CX
    MOV         word [0xef82],CX
    CMP         byte [0xef8b],0x8
    JNZ         LAB_1000_5ace
    NOP
    NOP
    CMP         byte [0xefc9],0x1
    JNZ         LAB_1000_5ace
    NOP
    NOP
    RET
LAB_1000_5ace:                ;XREF[3]:     1000:5a9f(j),1000:5ac0(j),1000:5ac9(j)
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_5acf:
                              ;XREF[3]:     1000:01ff(c),1000:251d(c),1000:5a84(c)
    CLD
    MOV         DX,0xf008
    MOV         SI,0xf308
    MOV         AX,0x0
    MOV         CX,word [0xef82]
    CMP         CX,0x100
    JLE         LAB_1000_5ae8
    NOP
    NOP
    MOV         CX,0x100
LAB_1000_5ae8:                ;XREF[2]:     1000:5ae1(j),1000:5b22(j)
    PUSH        CX
    XOR         CX,CX
LAB_1000_5aeb:                ;XREF[1]:     1000:5b1f(j)
    AND         AH,AH
    JZ          LAB_1000_5af6
    NOP
    NOP
    DEC         AH
    JMP         LAB_1000_5b11

 ; 1000:5af5 [UNDEFINED BYTES REMOVED]

LAB_1000_5af6:                ;XREF[1]:     1000:5aed(j)
    CALL        FUN_1000_5b26
    MOV         AH,AL
    AND         AH,0xc0
    CMP         AH,0xc0
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_5b01:
                              ;XREF[3]:     1000:0327(c),1000:03f3(c),1000:04b3(c)
    MOV         AH,0x0
    JNZ         LAB_1000_5b11
    NOP
    NOP
    MOV         AH,AL
    AND         AH,0x3f
    CALL        FUN_1000_5b26
    DEC         AH
LAB_1000_5b11:                ;XREF[2]:     1000:5af3(j),1000:5b03(j)
    CMP         CX,0x100
    JNC         LAB_1000_5b1a
    NOP
    NOP
    STOSB ;       ES:DI
LAB_1000_5b1a:                ;XREF[1]:     1000:5b15(j)
    INC         CX
    CMP         CX,word [0xef80]
    JC          LAB_1000_5aeb
    POP         CX
    LOOP        LAB_1000_5ae8
    CLC
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_5b26:
                              ;XREF[2]:     1000:5af6(c),1000:5b0c(c)
    CMP         SI,0xf308
    JNZ         LAB_1000_5b41
    NOP
    NOP
    PUSH        AX
    PUSH        CX
    MOV         CX,0x300
    MOV         DX,0xf008
    MOV         CX,CX
    MOV         AH,0x3f
    INT         0x21
    POP         CX
    POP         AX
    MOV         SI,0xf008
LAB_1000_5b41:                ;XREF[1]:     1000:5b2a(j)
    LODSB ;       SI
    RET

 ; 1000:5cce [UNDEFINED BYTES REMOVED]

;FIM:
