
f_init:
    MOV         word [base_mem + 0x5bba], -2     ;just to be sure

    MOV         word [base_mem + 0xec50],0x78    ;= 00C8h
    MOV         dword [base_mem + 0x6a],0x1800 ;= 00000C00h
    MOV         word [base_mem + 0xe9e2],0x800   ;= 0320h
    MOV         word [base_mem + 0xe9e4],0xf000  ;= F000h
    MOV         word [base_mem + 0xdbc0],0x0
    MOV         word [base_mem + 0xdbb8],0xa0    ;= 00A0h
    MOV         word [base_mem + 0xdbc2],0x13f   ;= 013Fh
    MOV         word [base_mem + 0xdbbc],0x0
    MOV         word [base_mem + 0xdbba],0x50    ;= 0064h
    MOV         word [base_mem + 0xdbbe],0xc7    ;= 00C7h
    MOV         DX,0x1a3d
    MOV         AL,0x0
    MOV         AH,0x3d
    call DOS3Call
    MOV         BX,AX
    JC          .LAB_LOC_1
    MOV         DX,0xe9e2
    MOV         CX,0x2
    MOV         AH,0x3f
    call DOS3Call
    MOV         DX,0xe9e4
    MOV         CX,0x2
    MOV         AH,0x3f
    call DOS3Call
    MOV         AH,0x3e
    call DOS3Call
.LAB_LOC_1:
    MOV         AH,0x48
    MOV         BX,0x1000
    call DOS3Call
    JC          .LAB_LOC_6
    MOV         word [base_mem + 0x1a45],AX
    ld_seg      dword [ptr_seg_GeS],AX
    MOV         AH,0x48
    MOV         BX,0x1000
    call DOS3Call
    JC          .LAB_LOC_6
    MOV         word [base_mem + 0x1a47],AX
    ld_seg      dword [ptr_seg_FeS],AX
    MOV         AH,0x48
    MOV         BX,0x1000
    call DOS3Call
    JC          .LAB_LOC_6
    MOV         word [base_mem + 0x1a49],AX
    MOV         AH,0x48
    MOV         BX,0x1000
    call DOS3Call
    JC          .LAB_LOC_6
    MOV         word [base_mem + 0x1a4b],AX
    CALL        FUN_1000_24c0
    CALL        FUN_1000_255c
    MOV         word [base_mem + 0x5bba],0x0     ;= 0001h
    MOV         DI,0x5bd0
    MOV         word [base_mem + 0x5bbc],DI
    XOR         SI,SI
.load_cars_loop:
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x5bbc]
    MOV         AX,SI
    NEG         AX
    SHL         AX,0x7
    ADD         AX,0x8000
    MOV         BX,0x7a00
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x5af7] ;= 5B01h
    PUSH        SI
    CALL        FUN_1000_2454
    POP         SI
    JC          .LAB_LOC_5
    PUSH        AX
    PUSH        DI
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP + 0x5bbc]
    CALL        FUN_1000_2431
    POP         SI
    POP         DI
    POP         AX
    PUSH        AX
    PUSH        DI
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x5b2e]
    MOV         DX,DX
    MOV         AL,0x0
    MOV         AH,0x3d
    call DOS3Call
    MOV         BX,AX
    JC          .LAB_LOC_4
    CALL        FUN_1000_5a95
    PUSH        BX
    CMP         AX,0x100
    JLE         .LAB_LOC_2
    MOV         AX,0x100
.LAB_LOC_2:
    MUL         CX
    SHR         AX,0x4
    INC         AX
    MOV         BX,AX
    MOV         AH,0x48
    call DOS3Call
    POP         BX
    JC          .LAB_LOC_3
    POP         SI
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x5bbc]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x1e],AX
    ld_seg      dword [ptr_seg_EeS],AX
    XOR         DI,DI
    CALL        FUN_1000_5acf
.LAB_LOC_3:
    MOV         AH,0x3e
    call DOS3Call
.LAB_LOC_4:
    POP         SI
    POP         DI
    POP         AX
    INC         word [base_mem + 0x5bba]         ;= 0001h
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x5bbc]
    ADD         DI,AX
    INC         SI
    INC         SI
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x5bbc],DI
    JMP         .load_cars_loop

.LAB_LOC_5:
    CALL        FUN_1000_2b70
    JC          .LAB_LOC_6
    ;CALL        FUN_1000_57e0 ;FIXME restore sound!
    MOV         word [base_mem + 0x6f],DX
    MOV         word [base_mem + 0x71],AX
    
    MOV         byte [base_mem + 0x6e],0x1

    MOV ax, 0 
    ret

.LAB_LOC_6:
    MOV ax, 1
    ret

f_cam_select:
    SHL BX, 1
    AND EBX, 15
    JMP         [CS:EBX * 2 + .JMP_TABLE_CAMERAS]
    .JMP_TABLE_CAMERAS:
        dd  .CAMERA_1
        dd  .CAMERA_2
        dd  .CAMERA_3
        dd  .CAMERA_4
        dd  .CAMERA_5
            
        times 3 dd .LAB_RUIM

    .LAB_RUIM:
    ud2

    .CAMERA_1:
    call F_0693  ;= 0693h
    ret

    .CAMERA_2:
    call F_073f  ;= 073Fh
    ret

    .CAMERA_3:
    call F_0828  ;= 0828h
    ret

    .CAMERA_4:
    call F_0893  ;= 0893h
    ret

    .CAMERA_5:
    call F_0948
    ret

FUN_main_render:
    ;needed now that it runs on paint message
    ld_seg      dword [ptr_seg_FeS], word [base_mem + 0x1a47]
    ld_seg      dword [ptr_seg_GeS], word [base_mem + 0x1a45]

    TEST        byte [base_mem + 0x7d],0xff
    JNZ         .LAB_LOC_5

    ;singleplayer
    MOV         word [base_mem + 0xdbc0],0x0
    MOV         word [base_mem + 0xdbb8],0xa0    ;= 00A0h
    MOV         word [base_mem + 0xdbc2],0x13f   ;= 013Fh
    MOV         word [base_mem + 0xdbbc],0x0
    MOV         word [base_mem + 0xdbba],0x50    ;= 0064h
    MOV         word [base_mem + 0xdbbe],0xc7    ;= 00C7h
    MOV         SI,word [base_mem + 0xa4]
    SHL         SI,0x1
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP + 0x5bbc]
    MOVZX       BX,byte [base_mem + 0x7e]      ;= 03h
    MOV         DI,0x80
    CALL f_cam_select
    MOV         BX,word [base_mem + 0xc6]
    CALL        FUN_1000_2aad
    SAR         AX,0x7
    MOV         word [base_mem + 0x5f7],AX
    CALL        FUN_1000_2ad8
    SAR         AX,0x7
    MOV         word [base_mem + 0x5f9],AX
    MOV         SI,0xc2
    MOV         DI,0xce
    CALL        FUN_1000_2989
    CALL        FUN_1000_27f1
    MOV         EAX,0xffffffff
    CALL        FUN_1000_2b98
    CALL        FUN_1000_1965
    CALL        FUN_1000_0b25
    MOV         SI,word [base_mem + 0xa4]
    SHL         SI,0x1
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP + 0x5bbc]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x8]
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x42]
    mk_addr     EBP, [SI]
    ADD         EAX,dword [EBP + 0x46]
    SAR         EAX,0xe
    mk_addr     EBP, [SI]
    MOV         EBX,dword [EBP + 0x4a]
    mk_addr     EBP, [SI]
    ADD         EBX,dword [EBP + 0x4e]
    SAR         EBX,0xe
    TEST        CX,CX
    JZ          .LAB_LOC_2
    DEC         CX
    JZ          .LAB_LOC_1
    ADD         EAX,EBX
    SAR         EAX,0x1
.LAB_LOC_1:
    MOV         EBX,EAX
.LAB_LOC_2:
    AND         BX,BX
    JGE         .LAB_LOC_3
    NEG         BX
.LAB_LOC_3:
    ADD         BX,0x1030
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0xc]
    SAR         CX,0x9
    AND         CX,CX
    JGE         .LAB_LOC_4
    NEG         CX
.LAB_LOC_4:
    ADD         CX,0x2c
    MOV         AL,0x0
                              ; FWD[2]:     1000:5b01(c),15cd:006f(R)
    CALL        FUN_1000_5831 ;was indirect
    JMP         .LAB_LOC_14
.LAB_LOC_5:
    ;split-screen
    MOV         word [base_mem + 0xdbc0],0x0
    MOV         word [base_mem + 0xdbb8],0xa0    ;= 00A0h
    MOV         word [base_mem + 0xdbc2],0x13f   ;= 013Fh
    MOV         word [base_mem + 0xdbbc],0x0
    MOV         word [base_mem + 0xdbba],0x32    ;= 0064h
    MOV         word [base_mem + 0xdbbe],0x62    ;= 00C7h
    MOV         SI,word [base_mem + 0xa4]
    SHL         SI,0x1
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP + 0x5bbc]
    MOVZX       BX,byte [base_mem + 0x7e]      ;= 03h
    MOV         DI,0x80
    CALL f_cam_select
    MOV         BX,word [base_mem + 0xc6]
    CALL        FUN_1000_2aad
    SAR         AX,0x7
    MOV         word [base_mem + 0x5f7],AX
    CALL        FUN_1000_2ad8
    SAR         AX,0x7
    MOV         word [base_mem + 0x5f9],AX
    MOV         SI,0xc2
    MOV         DI,0xce
    CALL        FUN_1000_2989
    CALL        FUN_1000_27f1
    MOV         EAX,0xffffffff
    CALL        FUN_1000_2b98
    CALL        FUN_1000_1965
    CALL        FUN_1000_0b25
    MOV         SI,word [base_mem + 0xa4]
    SHL         SI,0x1
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP + 0x5bbc]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x8]
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x42]
    mk_addr     EBP, [SI]
    ADD         EAX,dword [EBP + 0x46]
    SAR         EAX,0xe
    mk_addr     EBP, [SI]
    MOV         EBX,dword [EBP + 0x4a]
    mk_addr     EBP, [SI]
    ADD         EBX,dword [EBP + 0x4e]
    SAR         EBX,0xe
    TEST        CX,CX
    JZ          .LAB_LOC_7
    DEC         CX
    JZ          .LAB_LOC_6
    ADD         EAX,EBX
    SAR         EAX,0x1
.LAB_LOC_6:
    MOV         EBX,EAX
.LAB_LOC_7:
    AND         BX,BX
    JGE         .LAB_LOC_8
    NEG         BX
.LAB_LOC_8:
    ADD         BX,0x1030
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0xc]
    SAR         CX,0x9
    AND         CX,CX
    JGE         .LAB_LOC_9
    NEG         CX
.LAB_LOC_9:
    ADD         CX,0x2c
    MOV         AL,0x0
                              ; FWD[2]:     1000:5b01(c),15cd:006f(R)
    CALL        FUN_1000_5831 ;was indirect
    MOV         word [base_mem + 0xdbc0],0x0
    MOV         word [base_mem + 0xdbb8],0xa0    ;= 00A0h
    MOV         word [base_mem + 0xdbc2],0x13f   ;= 013Fh
    MOV         word [base_mem + 0xdbbc],0x64
    MOV         word [base_mem + 0xdbba],0x96    ;= 0064h
    MOV         word [base_mem + 0xdbbe],0xc7    ;= 00C7h
    MOV         SI,word [base_mem + 0xa6]
    SHL         SI,0x1
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP + 0x5bbc]
    MOVZX       BX,byte [base_mem + 0x7f]      ;= 03h
    MOV         DI,0x92
    CALL f_cam_select
    MOV         BX,word [base_mem + 0xc6]
    CALL        FUN_1000_2aad
    SAR         AX,0x7
    MOV         word [base_mem + 0x5f7],AX
    CALL        FUN_1000_2ad8
    SAR         AX,0x7
    MOV         word [base_mem + 0x5f9],AX
    MOV         SI,0xc2
    MOV         DI,0xce
    CALL        FUN_1000_2989
    CALL        FUN_1000_27f1
    CALL        FUN_1000_1965
    CALL        FUN_1000_0b25
    MOV         SI,word [base_mem + 0xa6]
    SHL         SI,0x1
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP + 0x5bbc]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x8]
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x42]
    mk_addr     EBP, [SI]
    ADD         EAX,dword [EBP + 0x46]
    SAR         EAX,0xe
    mk_addr     EBP, [SI]
    MOV         EBX,dword [EBP + 0x4a]
    mk_addr     EBP, [SI]
    ADD         EBX,dword [EBP + 0x4e]
    SAR         EBX,0xe
    TEST        CX,CX
    JZ          .LAB_LOC_11
    DEC         CX
    JZ          .LAB_LOC_10
    ADD         EAX,EBX
    SAR         EAX,0x1
.LAB_LOC_10:
    MOV         EBX,EAX
.LAB_LOC_11:
    AND         BX,BX
    JGE         .LAB_LOC_12
    NEG         BX
.LAB_LOC_12:
    ADD         BX,0x1030
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0xc]
    SAR         CX,0x9
    AND         CX,CX
    JGE         .LAB_LOC_13
    NEG         CX
.LAB_LOC_13:
    ADD         CX,0x2c
    MOV         AL,0x1
                              ; FWD[2]:     1000:5b01(c),15cd:006f(R)
    CALL        FUN_1000_5831 ;was indirect
.LAB_LOC_14:
    MOV         word [base_mem + 0xdbc0],0x0
    MOV         word [base_mem + 0xdbb8],0xa0    ;= 00A0h
    MOV         word [base_mem + 0xdbc2],0x13f   ;= 013Fh
    MOV         word [base_mem + 0xdbbc],0x0
    MOV         word [base_mem + 0xdbba],0x50    ;= 0064h
    MOV         word [base_mem + 0xdbbe],0xc7    ;= 00C7h
    MOV         SI,0x0
    MOV         AX,0xa
    MOV         BX,0xa
    MOV         CL,0xf
    CALL        FUN_1000_5940_render_text
    MOV         SI,0x4b
    MOV         AX,0x64
    MOV         BX,0xbe
    MOV         CL,0xf
    CALL        FUN_1000_5940_render_text

    MOV         SI, nova_linha - base_mem ;string
    MOV         AX, 5         ;X
    MOV         BX, 190       ;Y
    MOV         CL, byte [giracor]       ;color
    SHR         CL, 2
    CALL        FUN_1000_5940_render_text
    INC         byte [giracor]

    CALL        FUN_1000_2baa
    TEST        byte [CSD_DAT_keys_571e + 78],0x80
    JS          .LAB_LOC_15
    CMP         word [base_mem + 0x11c],0x3e8   ;= 0100h
    JG          .LAB_LOC_15
    ADD         word [base_mem + 0x11c],0x14    ;= 0100h
.LAB_LOC_15:
    TEST        byte [CSD_DAT_keys_571e + 74],0x80
    JS          .LAB_LOC_16
    CMP         word [base_mem + 0x11c],0x32    ;= 0100h
    JL          .LAB_LOC_16
    SUB         word [base_mem + 0x11c],0x14    ;= 0100h
.LAB_LOC_16:
    TEST        byte [CSD_DAT_keys_571e + 53],0x80
    JS          .LAB_LOC_17
    CMP         word [base_mem + 0x11e],0x1000  ;= 0400h
    JG          .LAB_LOC_17
    ADD         word [base_mem + 0x11e],0x28    ;= 0400h
.LAB_LOC_17:
    TEST        byte [CSD_DAT_keys_571e + 55],0x80
    JS          .LAB_LOC_18
    CMP         word [base_mem + 0x11e],0x100   ;= 0400h
    JL          .LAB_LOC_18
    SUB         word [base_mem + 0x11e],0x28    ;= 0400h
.LAB_LOC_18:
    MOV         AL,[CSD_DAT_keys_571e]
    ;Esc
    CMP         AL,0x1
    JZ          .LAB_LOC_33

    ;Tab
    CMP         AL,0xf
    JZ          .LAB_LOC_28
    
    ;Q
    CMP         AL,0x10
    JZ          .LAB_LOC_30
    
    ;F1
    CMP         AL,0x3b
    JZ          .LAB_LOC_20
    
    ;F2
    CMP         AL,0x3c
    JZ          .LAB_LOC_21
    
    ;F3
    CMP         AL,0x3d
    JZ          .LAB_LOC_22
    
    ;F4
    CMP         AL,0x3e
    JZ          .LAB_LOC_23
    
    ;F5
    CMP         AL,0x3f
    JZ          .LAB_LOC_24

    ;F6
    CMP         AL,0x40
    JZ          .CYCLE_2ND_CAM

    ;[
    CMP         AL,0x1a
    JZ          .LAB_LOC_26
    
    ;]
    CMP         AL,0x1b
    JZ          .LAB_LOC_27
    
    ;F10
    CMP         AL,0x44
    JZ          .LAB_LOC_32
    
    ;F9
    CMP         AL,0x43
    JZ          .LAB_LOC_25
    mov ax, 0
    ret
.LAB_LOC_19:
                              ;             1000:05db(j),1000:05e2(j),1000:05ea(j),1000:05f2(j),
                              ;             1000:0607(j),1000:061c(j),1000:0624(j)
    MOV         byte [CSD_DAT_keys_571e],0x0
    mov ax, 0
    ret
.LAB_LOC_20:
    MOV         byte [base_mem + 0x7e],0x0     ;= 03h
    JMP         .LAB_LOC_19
.LAB_LOC_21:
    MOV         byte [base_mem + 0x7e],0x1     ;= 03h
    JMP         .LAB_LOC_19
.LAB_LOC_22:
    MOV         byte [base_mem + 0x7e],0x2     ;= 03h
    JMP         .LAB_LOC_19
.LAB_LOC_23:
    MOV         byte [base_mem + 0x7e],0x3     ;= 03h
    JMP         .LAB_LOC_19
.LAB_LOC_24:
    MOV         byte [base_mem + 0x7e],0x4     ;= 03h
    JMP         .LAB_LOC_19
.LAB_LOC_25:
    XOR         byte [base_mem + 0x7d],0x1
    JMP         .LAB_LOC_19
.LAB_LOC_26:
    ADD         dword [base_mem + 0x6a],0x32   ;= 00000C00h
    JMP         .LAB_LOC_19
.LAB_LOC_27:
    SUB         dword [base_mem + 0x6a],0x32   ;= 00000C00h
    JMP         .LAB_LOC_19
.LAB_LOC_28:
    MOV         SI,word [base_mem + 0xa4]
    INC         SI
    CMP         SI,word [base_mem + 0x5bba]      ;= 0001h
    JC          .LAB_LOC_29
    XOR         SI,SI
.LAB_LOC_29:
    MOV         word [base_mem + 0xa4],SI
    JMP         .LAB_LOC_19
.LAB_LOC_30:
    MOV         SI,word [base_mem + 0xa6]
    INC         SI
    CMP         SI,word [base_mem + 0x5bba]      ;= 0001h
    JC          .LAB_LOC_31
    XOR         SI,SI
.LAB_LOC_31:
    MOV         word [base_mem + 0xa6],SI
    JMP         .LAB_LOC_19
.LAB_LOC_32:
    XOR         word [base_mem + 0x5f5],0x600   ;= 0600h
    JMP         .LAB_LOC_19

.CYCLE_2ND_CAM:
    INC   byte [base_mem + 0x7f]
    CMP   byte [base_mem + 0x7f], 5
    JL    .LAB_LOC_19
    MOV   byte [base_mem + 0x7f], 0
    JL    .LAB_LOC_19

 ; 1000:0653 [UNDEFINED BYTES REMOVED]

.LAB_LOC_33:
    mov ax, 1
    ret

 ; 1000:0692 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
F_0693:
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP + 0x20]
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP]
    MOV         dword [base_mem + 0xaa],EAX
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x4]
    MOV         dword [base_mem + 0xae],EAX
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x8]
    MOV         dword [base_mem + 0xb2],EAX
    POP         SI
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    INC         SI
    INC         SI
    CALL        FUN_1000_1091
    MOV         dword [base_mem + 0xe0],EAX
    MOV         dword [base_mem + 0xe4],EBX
    MOV         dword [base_mem + 0xe8],ECX
    CALL        FUN_1000_10b6
    MOV         dword [base_mem + 0xec],EAX
    MOV         dword [base_mem + 0xf0],EBX
    MOV         dword [base_mem + 0xf4],ECX
    POP         SI
    MOV         AX, word [base_mem + 0xed]
    MOV         BX,word [base_mem + 0xf1]
    NEG         AX
    CALL        FUN_1000_2b08
    PUSH        AX
    SUB         AX,word [base_mem + 0xc6]
    ADD         word [base_mem + 0xc6],AX
    MOV         AX, word [base_mem + 0xe1]
    MOV         BX,word [base_mem + 0xe5]
    CALL        FUN_1000_26dd
    MOV         CX,AX
    MOV         AX, word [base_mem + 0xe1]
    MOV         BX,word [base_mem + 0xe5]
    NEG         AX
    CALL        FUN_1000_2b08
    POP         BX
    SUB         BX,AX
    MOV         BX,CX
    JNS         .LAB_LOC_1
    NEG         BX
.LAB_LOC_1:
    MOV         AX, word [base_mem + 0xe9]
    CALL        FUN_1000_2b08
    NEG         AX
    SUB         AX,word [base_mem + 0xc2]
    ADD         word [base_mem + 0xc2],AX
    MOV         AX, word [base_mem + 0xed]
    MOV         BX,word [base_mem + 0xf1]
    MOV         CX,word [base_mem + 0xf5]
    CALL        FUN_1000_26dd
    MOV         BX,AX
    MOV         AX,CX
    CALL        FUN_1000_2b08
    NEG         AX
    SUB         AX,word [base_mem + 0xc4]
    ADD         word [base_mem + 0xc4],AX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
F_073f:
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP + 0x20]
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP]
    MOV         dword [base_mem + 0xaa],EAX
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x4]
    MOV         dword [base_mem + 0xae],EAX
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x8]
    MOV         dword [base_mem + 0xb2],EAX
    POP         SI
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    INC         SI
    INC         SI
    CALL        FUN_1000_1091
    MOV         dword [base_mem + 0xe0],EAX
    MOV         dword [base_mem + 0xe4],EBX
    MOV         dword [base_mem + 0xe8],ECX
    CALL        FUN_1000_10b6
    MOV         dword [base_mem + 0xec],EAX
    MOV         dword [base_mem + 0xf0],EBX
    MOV         dword [base_mem + 0xf4],ECX
    POP         SI
    MOV         AX, word [base_mem + 0xed]
    MOV         BX,word [base_mem + 0xf1]
    NEG         EAX
    CALL        FUN_1000_2b08
    SUB         AX,word [base_mem + 0xc6]
    ADD         word [base_mem + 0xc6],AX
    MOV         BX,word [base_mem + 0xc6]
    CALL        FUN_1000_2ad8
    NEG         AX
    SAR         AX,0x5
    ADD         AX,word [base_mem + 0xb0]
    PUSH        AX
    CALL        FUN_1000_2aad
    SAR         AX,0x5
    ADD         AX,word [base_mem + 0xac]
    POP         BX
    CALL        FUN_1000_25c5
    SUB         AX,word [base_mem + 0xb4]
    MOV         BX,0x3ff
    CALL        FUN_1000_2b08
    SUB         AX,word [base_mem + 0xc4]
    SAR         AX,0x2
    ADD         word [base_mem + 0xc4],AX
    MOV         BX,word [base_mem + 0xc6]
    ADD         BX,0x2000
    CALL        FUN_1000_2ad8
    NEG         AX
    SAR         AX,0x6
    ADD         AX,word [base_mem + 0xb0]
    PUSH        AX
    CALL        FUN_1000_2aad
    SAR         AX,0x6
    POP         BX
    ADD         AX,word [base_mem + 0xac]
    CALL        FUN_1000_25c5
    PUSH        AX
    MOV         BX,word [base_mem + 0xc6]
    SUB         BX,0x2000
    CALL        FUN_1000_2ad8
    NEG         AX
    SAR         AX,0x6
    ADD         AX,word [base_mem + 0xb0]
    PUSH        AX
    CALL        FUN_1000_2aad
    SAR         AX,0x6
    POP         BX
    ADD         AX,word [base_mem + 0xac]
    CALL        FUN_1000_25c5
    POP         BX
    SUB         AX,BX
    MOV         BX,0x1ff
    CALL        FUN_1000_2b08
    SUB         AX,word [base_mem + 0xc2]
    SAR         AX,0x2
    ADD         word [base_mem + 0xc2],AX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
F_0828:
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP]
    MOV         dword [base_mem + 0xaa],EAX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x4]
    MOV         dword [base_mem + 0xae],EAX
    MOV         AX, word [base_mem + 0xac]
    MOV         BX,word [base_mem + 0xb0]
    CALL        FUN_1000_25c5
    ADD         AX,word [base_mem + 0x11c]
    SHL         EAX,0x10
    MOV         dword [base_mem + 0xb2],EAX
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP + 0x20]
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x2]
    SUB         AX,word [base_mem + 0xac]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x6]
    SUB         BX,word [base_mem + 0xb0]
    NEG         BX
    PUSH        AX
    PUSH        BX
    CALL        FUN_1000_2b08
    SUB         AX,word [base_mem + 0xc6]
    ADD         word [base_mem + 0xc6],AX
    POP         BX
    POP         AX
    CALL        FUN_1000_26dd
    MOV         BX,AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0xa]
    SUB         AX,word [base_mem + 0xb4]
    CALL        FUN_1000_2b08
    SUB         AX,word [base_mem + 0xc4]
    ADD         word [base_mem + 0xc4],AX
    XOR         AX,AX
    SUB         AX,word [base_mem + 0xc2]
    ADD         word [base_mem + 0xc2],AX
    POP         SI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
F_0893:
                              ;XREF[3]:     1000:029a(c),1000:0366(c),1000:042f(c)
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP + 0x20]
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    SUB         AX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x6]
    mk_addr     EBP, [DI]
    SUB         BX,word [EBP + 0x6]
    NEG         BX
    CALL        FUN_1000_2b08
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xc],AX
    MOV         BX,AX
    CALL        FUN_1000_2ad8
    MOV         CX,AX
    CALL        FUN_1000_2aad
    MOV         BX,CX
    MOV         CX,word [base_mem + 0x11e]
    SHL         CX,0x1
    IMUL        CX
    MOV         AX,DX
    XCHG        AX,BX
    IMUL        CX
    MOV         AX,DX
    XCHG        AX,BX
    NEG         AX
    mk_addr     EBP, [SI]
    ADD         AX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    ADD         BX,word [EBP + 0x6]
    mk_addr     EBP, [DI]
    SUB         AX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    ADD         word [EBP + 0x2],AX
    mk_addr     EBP, [DI]
    SUB         BX,word [EBP + 0x6]
    mk_addr     EBP, [DI]
    ADD         word [EBP + 0x6],BX
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    MOV         BX,word [EBP + 0x6]
    CALL        FUN_1000_25c5
    MOV         BX,AX
    ADD         BX,0x28
    ADD         AX,word [base_mem + 0x11c]
    mk_addr     EBP, [DI]
    SUB         AX,word [EBP + 0xa]
    SAR         AX,0x3
    mk_addr     EBP, [DI]
    ADD         word [EBP + 0xa],AX
    mk_addr     EBP, [DI]
    CMP         BX,word [EBP + 0xa]
    JA          .LAB_LOC_2
.LAB_LOC_1:
    MOV         BX,word [base_mem + 0x11e]
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0xa]
    mk_addr     EBP, [DI]
    SUB         AX,word [EBP + 0xa]
    CALL        FUN_1000_2b08
    mk_addr     EBP, [DI]
    SUB         AX,word [EBP + 0xe]
    SAR         AX,0x2
    mk_addr     EBP, [DI]
    ADD         word [EBP + 0xe],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x10],0x0
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0xc]
    MOV         word [base_mem + 0xc6],AX
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0xe]
    MOV         word [base_mem + 0xc4],AX
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x10]
    MOV         word [base_mem + 0xc2],AX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP]
    MOV         dword [base_mem + 0xaa],EAX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x4]
    MOV         dword [base_mem + 0xae],EAX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x8]
    MOV         dword [base_mem + 0xb2],EAX
    POP         SI
    RET
.LAB_LOC_2:
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xa],BX
    JMP         .LAB_LOC_1
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
F_0948:
    XOR         EAX,EAX
    XOR         EBX,EBX
    XOR         EDX,EDX
    MOV         CX,word [base_mem + 0x5bba]
    XOR         DI,DI
.LAB_LOC_1:
    mk_addr     EBP, [DI]
    MOV         SI,word [EBP + 0x5bbc]
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP + 0x20]
    mk_addr     EBP, [SI]
    movzx_m2m   dword [mitemp_02],word [EBP + 0x2]
    ADD         EAX,dword [mitemp_02]
    mk_addr     EBP, [SI]
    movzx_m2m   dword [mitemp_02],word [EBP + 0x6]
    ADD         EBX,dword [mitemp_02]
    mk_addr     EBP, [SI]
    movzx_m2m   dword [mitemp_02],word [EBP + 0xa]
    ADD         EDX,dword [mitemp_02]
    ADD         DI,0x2
    L_LOOP      .LAB_LOC_1
    MOV         ECX,EDX
    movzx_m2m   dword [mitemp_02],word [base_mem + 0x5bba]
    CDQ
    DIV         dword [mitemp_02]
    MOV         word [base_mem + 0xc8],AX
    MOV         EAX,EBX
    CDQ
    DIV         dword [mitemp_02]
    MOV         word [base_mem + 0xca],AX
    MOV         EAX,ECX
    CDQ
    IDIV        dword [mitemp_02]

    ; probably unecessary, but better safe than sorry
    mov_m2m     dword [ye_old_bep], dword [mitemp_02]

    MOV         word [base_mem + 0xcc],AX
    MOV         AX, word [base_mem + 0xc8]
    MOV         BX,word [base_mem + 0xca]
    SUB         AX,word [base_mem + 0xac]
    SUB         BX,word [base_mem + 0xb0]
    NEG         BX
    CALL        FUN_1000_2b08
    MOV         word [base_mem + 0xc6],AX
    MOV         BX,AX
    CALL        FUN_1000_2ad8
    MOV         CX,AX
    CALL        FUN_1000_2aad
    MOV         BX,CX
    MOV         CX,word [base_mem + 0x11e]
    SHL         CX,0x1
    IMUL        CX
    MOV         AX,DX
    XCHG        AX,BX
    IMUL        CX
    MOV         AX,DX
    XCHG        AX,BX
    NEG         AX
    ADD         AX,word [base_mem + 0xc8]
    ADD         BX,word [base_mem + 0xca]
    SUB         AX,word [base_mem + 0xac]
    ADD         word [base_mem + 0xac],AX
    SUB         BX,word [base_mem + 0xb0]
    ADD         word [base_mem + 0xb0],BX
    MOV         AX, word [base_mem + 0xac]
    MOV         BX,word [base_mem + 0xb0]
    CALL        FUN_1000_25c5
    MOV         BX,AX
    ADD         BX,0x28
    ADD         AX,word [base_mem + 0x11c]
    SUB         AX,word [base_mem + 0xb4]
    SAR         AX,0x3
    ADD         word [base_mem + 0xb4],AX
    CMP         BX,word [base_mem + 0xb4]
    JA          .LAB_LOC_3
.LAB_LOC_2:
    MOV         BX,word [base_mem + 0x11e]
    MOV         AX, word [base_mem + 0xcc]
    SUB         AX,word [base_mem + 0xb4]
    CALL        FUN_1000_2b08
    SUB         AX,word [base_mem + 0xc4]
    SAR         AX,0x2
    ADD         word [base_mem + 0xc4],AX
    MOV         word [base_mem + 0xc2],0x0
    RET
.LAB_LOC_3:
    MOV         word [base_mem + 0xb4],BX
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0a3b:
                              ;XREF[1]:     1000:56ce(c)
    PUSH        SI
    PUSH        DI
    TEST        byte [CSD_DAT_keys_571e + 2],0xc0
    JNS         .LAB_LOC_3
.LAB_LOC_1:
    TEST        byte [CSD_DAT_keys_571e + 3],0xc0
    JNS         .LAB_LOC_4
.LAB_LOC_2:
    POP         DI
    POP         SI
    RET
.LAB_LOC_3:
    PUSHF
    AND         byte [CSD_DAT_keys_571e + 2],0x3f
    MOV         SI,word [base_mem + 0xa4]
    SHL         SI,0x1
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP + 0x5bbc]
    POPF
    CALL        FUN_1000_0a82
    JMP         .LAB_LOC_1
.LAB_LOC_4:
    PUSHF
    AND         byte [CSD_DAT_keys_571e + 3],0x3f
    MOV         SI,word [base_mem + 0xa6]
    SHL         SI,0x1
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP + 0x5bbc]
    POPF
    CALL        FUN_1000_0a82
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0a82:
                              ;XREF[2]:     1000:0a66(c),1000:0a7d(c)
    PUSHF
    MOV         DI,SI
    mk_addr     EBP, [SI]
    ADD         DI,word [EBP]
    mk_addr     EBP, [DI]
    MOVZX       EAX,word [EBP]
    MOV         CX,AX
    SHR         EAX,0x1
    INC         EAX
    IMUL        EAX,dword [base_mem + 0x6a]
    POPF
    JP          .LAB_LOC_3
    INC         DI
    INC         DI
    MOV         DX,DI
    mk_addr     EBP, [DI]
    MOV         BX,word [EBP + 0xa]
    ADD         DI,0x1c
    DEC         CX
.LAB_LOC_1:
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0xa]
    CMP         AX,BX
    JL          .LAB_LOC_4
.LAB_LOC_2:
    ADD         DI,0x1c
    L_LOOP      .LAB_LOC_1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x22],DX
.LAB_LOC_3:
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x22]
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0x14],EAX
    RET
.LAB_LOC_4:
    MOV         BX,AX
    MOV         DX,DI
    JMP         .LAB_LOC_2

 ; 1000:0b24 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;ANALYSIS: related to smoke, debris, particle effects in general
FUN_1000_0b25:
                              ;XREF[3]:     1000:02cc(c),1000:0398(c),1000:0458(c)
    PUSH        dword [ptr_seg_FeS]
    ld_seg      dword [ptr_seg_FeS],word [base_mem + 0x1a49]
    XOR         DI,DI
    CMP         DI,word [base_mem + 0x3e51]
    JNC         .LAB_LOC_4
.LAB_LOC_1:
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x3e55]
    mk_addr     EBP, [DI]
    MOV         BX,word [EBP + 0x3e59]
    PUSH        AX
    PUSH        BX
    TEST        byte [base_mem + 0x5fb],0x1
    JZ          .LAB_LOC_2
    XCHG        AX,BX
.LAB_LOC_2:
    MOVZX       BX,BH
    MOVZX       AX,AH
    CMP         BX,word [base_mem + 0xe58c]
    JL          .LAB_LOC_5
    CMP         BX,word [base_mem + 0xe58e]
    JG          .LAB_LOC_5
    SHL         BX,0x2
    mk_addr     EBP, [BX]
    CMP         AX,word [EBP + 0xe590]
    JL          .LAB_LOC_5
    mk_addr     EBP, [BX]
    CMP         AX,word [EBP + 0xe592]
    JG          .LAB_LOC_5
    POP         BX
    POP         AX
    mk_addr     EBP, [DI]
    MOV         CX,word [EBP + 0x3e5d]
    SUB         AX,word [base_mem + 0xac]
    SUB         BX,word [base_mem + 0xb0]
    SUB         CX,word [base_mem + 0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    CALL        FUN_1000_2418
    JC          .LAB_LOC_3
    mk_addr     EBP, [DI]
    MOVZX       SI,byte [EBP + 0x3e6d]
    SHR         SI,0x4
    SHL         SI,0x1
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP + 0x5a53]
    CALL        FUN_1000_0cd3
.LAB_LOC_3:
    ADD         DI,0x1c
    CMP         DI,word [base_mem + 0x3e51]
    JC          .LAB_LOC_1
.LAB_LOC_4:
    POP         dword [ptr_seg_FeS]
    RET
.LAB_LOC_5:
    POP         BX
    POP         AX
    JMP         .LAB_LOC_3
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0bb5:
                              ;XREF[1]:     1000:56cb(c)
    XOR         DI,DI
    CMP         DI,word [base_mem + 0x3e51]
    JNC         .LAB_LOC_4
.LAB_LOC_1:
    mk_addr     EBP, [DI]
    SUB         word [EBP + 0x3e6b],0x2
    JS          .LAB_LOC_8
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x3e5f]
    mk_addr     EBP, [DI]
    MOV         EBX,dword [EBP + 0x3e63]
    mk_addr     EBP, [DI]
    MOV         ECX,dword [EBP + 0x3e67]
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0x3e53],EAX
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0x3e57],EBX
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0x3e5b],ECX
    mk_addr     EBP, [DI]
    CMP         word [EBP + 0x3e6d],0xf
    JNZ         .LAB_LOC_2
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x3e53]
    mk_addr     EBP, [DI]
    MOV         EBX,dword [EBP + 0x3e57]
    mk_addr     EBP, [DI]
    MOV         ECX,dword [EBP + 0x3e5b]
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
    JNS         .LAB_LOC_6
    MOV         EAX, dword [base_mem + 0x6a]
    SAR         EAX,0x1
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0x3e67],EAX
.LAB_LOC_2:
    ADD         DI,0x1c
.LAB_LOC_3:
    CMP         DI,word [base_mem + 0x3e51]
    JC          .LAB_LOC_1
.LAB_LOC_4:
    RET
.LAB_LOC_5:

    RET
.LAB_LOC_6:
    PUSH        AX
    PUSH        BX
    MOV         BL,AH
    mk_addr_seg EBP, ptr_seg_FeS, [BX]
    MOV         AL,byte [EBP]
    TEST        AL,0xf
    JZ          .LAB_LOC_7
    DEC         AL
    mk_addr_seg EBP, ptr_seg_FeS, [BX]
    MOV         byte [EBP],AL
.LAB_LOC_7:
    POP         BX
    POP         AX
    ADD         BX,0x80
    ADD         AX,0x80
    MOV         BL,AH
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    DEC         byte [EBP]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x3e6d],0x1
    MOV         EAX,0x0
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0x3e5f],EAX
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0x3e63],EAX
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0x3e67],0x2710
    JMP         .LAB_LOC_2
.LAB_LOC_8:

    MOV         SI,word [base_mem + 0x3e51]
    SUB         SI,0x1c
    MOV         word [base_mem + 0x3e51],SI
    JZ          .LAB_LOC_5
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x3e53]
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0x3e53],EAX
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x3e57]
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0x3e57],EAX
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x3e5b]
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0x3e5b],EAX
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x3e5f]
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0x3e5f],EAX
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x3e63]
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0x3e63],EAX
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x3e67]
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0x3e67],EAX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x3e6b]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x3e6b],AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x3e6d]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x3e6d],AX
    SUB         SI,0x1c

    JMP         .LAB_LOC_3
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0cd3:
                              ;XREF[1]:     1000:0ba2(c)
    CMP         CX,word [base_mem + 0x120]
    JL          .LAB_LOC_1
    MOV         word [ye_old_lil_bep],BX
    MOV         BX,AX
    CALL  F_WRAP_LODSW 
    CWD
    IDIV        CX
    MOV         DX,AX
    PUSH        dword [ptr_seg_EeS]
    PUSH        DI
    PUSH        dword [ptr_seg_DeS]
    POP         dword [ptr_seg_EeS]
    MOV         DI,0xdb16
    MOV         AX,BX
    SUB         AX,DX
    CALL  F_WRAP_STOSW 
    MOV         AX,word [ye_old_lil_bep]
    SUB         AX,DX
    CALL  F_WRAP_STOSW 
    CALL  F_WRAP_MOVSD 
    MOV         AX,BX
    ADD         AX,DX
    CALL  F_WRAP_STOSW 
    MOV         AX,word [ye_old_lil_bep]
    SUB         AX,DX
    CALL  F_WRAP_STOSW 
    CALL  F_WRAP_MOVSD 
    MOV         AX,BX
    ADD         AX,DX
    CALL  F_WRAP_STOSW 
    MOV         AX,word [ye_old_lil_bep]
    ADD         AX,DX
    CALL  F_WRAP_STOSW 
    CALL  F_WRAP_MOVSD 
    MOV         AX,BX
    SUB         AX,DX
    CALL  F_WRAP_STOSW 
    MOV         AX,word [ye_old_lil_bep]
    ADD         AX,DX
    CALL  F_WRAP_STOSW 
    CALL  F_WRAP_MOVSD 
    MOV         word [base_mem + 0xdb14],0x4
    CALL        FUN_1000_36fe
    POP         DI
    POP         dword [ptr_seg_EeS]
.LAB_LOC_1:
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0d2a:
                              ;XREF[1]:     1000:56b4(c)
    mk_addr     EBP, [DI]
    MOVZX       BX,byte [EBP]
    movsx ebp, BX
    MOV         AL,byte [EBP + CSD_DAT_keys_571e]
    mk_addr     EBP, [DI]
    MOVZX       BX,byte [EBP + 0x1]
    movsx ebp, BX
    MOV         AH,byte [EBP + CSD_DAT_keys_571e]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0xc]
    MOV         CX,0x32
    TEST        AL,0x80
    JS          .LAB_LOC_2
    CMP         BX,0x2000
    JG          .LAB_LOC_2
    TEST        BX,BX
    JNS         .LAB_LOC_1
    SHL         CX,0x2
.LAB_LOC_1:
    ADD         BX,CX
.LAB_LOC_2:
    TEST        AH,0x80
    JS          .LAB_LOC_4
    CMP         BX,0xe000
    JL          .LAB_LOC_4
    TEST        BX,BX
    JS          .LAB_LOC_3
    SHL         CX,0x2
.LAB_LOC_3:
    SUB         BX,CX
.LAB_LOC_4:
    XOR         AX,0x8080
    TEST        AX,0x8080
    JNZ         .LAB_LOC_6
    MOV         CX,0x12c
    TEST        BX,BX
    JZ          .LAB_LOC_6
    JNS         .LAB_LOC_5
    NEG         CX
.LAB_LOC_5:
    SUB         BX,CX
.LAB_LOC_6:
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0xc],BX
    mk_addr     EBP, [DI]
    MOVZX       BX,byte [EBP + 0x2]
    movsx ebp, BX
    MOV         AL,byte [EBP + CSD_DAT_keys_571e]
    mk_addr     EBP, [DI]
    MOVZX       BX,byte [EBP + 0x3]
    movsx ebp, BX
    MOV         AH,byte [EBP + CSD_DAT_keys_571e]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0xa]
    mk_addr     EBP, [SI]
    MOV         ECX,dword [EBP + 0x42]
    mk_addr     EBP, [SI]
    ADD         ECX,dword [EBP + 0x46]
    AND         CX,CX
    JGE         .LAB_LOC_7
    NEG         CX
.LAB_LOC_7:
    SHR         ECX,0x10
    NEG         CX
    ADD         CX,0x40
    TEST        AL,0x80
    JS          .LAB_LOC_9
    CMP         BX,0xe000
    JL          .LAB_LOC_9
    TEST        BX,BX
    JS          .LAB_LOC_8
    SHL         CX,0x2
.LAB_LOC_8:
    SUB         BX,CX
.LAB_LOC_9:
    TEST        AH,0x80
    JS          .LAB_LOC_11
    CMP         BX,0x2000
    JG          .LAB_LOC_11
    TEST        BX,BX
    JNS         .LAB_LOC_10
    SHL         CX,0x2
.LAB_LOC_10:
    ADD         BX,CX
.LAB_LOC_11:
    XOR         AX,0x8080
    TEST        AX,0x8080
    JNZ         .LAB_LOC_13
    MOV         CX,0x50
    TEST        BX,BX
    JZ          .LAB_LOC_13
    JNS         .LAB_LOC_12
    NEG         CX
.LAB_LOC_12:
    SUB         BX,CX
.LAB_LOC_13:
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0xa],BX
    XOR         AX,AX
    mk_addr     EBP, [DI]
    MOVZX       BX,byte [EBP + 0x4]
    movsx ebp, BX
    TEST        byte [EBP + CSD_DAT_keys_571e],0x80
    JNZ         .LAB_LOC_14
    OR          AX,0x1
.LAB_LOC_14:
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0xe],AX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0e28:
                              ;XREF[1]:     1000:48db(c)
    MOV         DI,SI
    mk_addr     EBP, [SI]
    ADD         DI,word [EBP]
    ADD         DI,0x2
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x72]
    mk_addr     EBP, [DI]
    MOV         BX,word [EBP + 0xaa]
    SHR         AX,0x1
    SHR         BX,0x1
    ADD         AX,BX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x10],AX
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x76]
    mk_addr     EBP, [DI]
    MOV         BX,word [EBP + 0xae]
    SHR         AX,0x1
    SHR         BX,0x1
    ADD         AX,BX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x12],AX
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x7a]
    mk_addr     EBP, [DI]
    MOV         BX,word [EBP + 0xb2]
    SHR         AX,0x1
    SHR         BX,0x1
    ADD         AX,BX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x14],AX
    MOV         word [CSD_WORD_1000_0e67],0x0
    RET


;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0e69:
                              ;XREF[1]:     1000:4b6f(c)
    CMP         AX,0x0
    JZ          .LAB_LOC_1
    CMP         AX,0x1
    JZ          .LAB_LOC_3
    CMP         AX,0x2
    JZ          .LAB_LOC_5
    CMP         AX,0x3
    JZ          .LAB_LOC_7
    XOR         EAX,EAX
    XOR         EBX,EBX
    XOR         ECX,ECX
    RET
.LAB_LOC_1:
    TEST        word [CSD_WORD_1000_0e67],0x1
    JNZ         .LAB_LOC_2
    CALL        FUN_1000_1136
    OR          word [CSD_WORD_1000_0e67],0x1
.LAB_LOC_2:
    MOV         EAX,[CSD_DWORD_1000_12a7]
    MOV         EBX,dword [CSD_DWORD_1000_12ab]
    MOV         ECX,dword [CSD_DWORD_1000_12af]
    mk_addr     EBP, [SI]
    MOV         EDX,dword [EBP + 0x42]
    RET
.LAB_LOC_3:
    TEST        word [CSD_WORD_1000_0e67],0x1
    JNZ         .LAB_LOC_4
    CALL        FUN_1000_1136
    OR          word [CSD_WORD_1000_0e67],0x1
.LAB_LOC_4:
    MOV         EAX,[CSD_DWORD_1000_12a7]
    MOV         EBX,dword [CSD_DWORD_1000_12ab]
    MOV         ECX,dword [CSD_DWORD_1000_12af]
    mk_addr     EBP, [SI]
    MOV         EDX,dword [EBP + 0x46]
    RET
.LAB_LOC_5:
    TEST        word [CSD_WORD_1000_0e67],0x2
    JNZ         .LAB_LOC_6
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    ADD         SI,0x2
    CALL        FUN_1000_10b6
    MOV         [CSD_DWORD_1000_12bf],EAX
    MOV         dword [CSD_DWORD_1000_12c3],EBX
    MOV         dword [CSD_DWORD_1000_12c7],ECX
    POP         SI
    OR          word [CSD_WORD_1000_0e67],0x2
.LAB_LOC_6:
    MOV         EAX,[CSD_DWORD_1000_12bf]
    MOV         EBX,dword [CSD_DWORD_1000_12c3]
    MOV         ECX,dword [CSD_DWORD_1000_12c7]
    mk_addr     EBP, [SI]
    MOV         EDX,dword [EBP + 0x4a]
    RET
.LAB_LOC_7:
    TEST        word [CSD_WORD_1000_0e67],0x2
    JNZ         .LAB_LOC_8
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    ADD         SI,0x2
    CALL        FUN_1000_10b6
    MOV         [CSD_DWORD_1000_12bf],EAX
    MOV         dword [CSD_DWORD_1000_12c3],EBX
    MOV         dword [CSD_DWORD_1000_12c7],ECX
    POP         SI
    OR          word [CSD_WORD_1000_0e67],0x2
.LAB_LOC_8:
    MOV         EAX,[CSD_DWORD_1000_12bf]
    MOV         EBX,dword [CSD_DWORD_1000_12c3]
    MOV         ECX,dword [CSD_DWORD_1000_12c7]
    mk_addr     EBP, [SI]
    MOV         EDX,dword [EBP + 0x4e]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0f67:
                              ;XREF[1]:     1000:4bd5(c)
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x8]
    CMP         AX,0x0
    JZ          .LAB_LOC_1
    CMP         AX,0x1
    JZ          .LAB_LOC_3
    CMP         AX,0x2
    JZ          .LAB_LOC_5
    CMP         AX,0x3
    JZ          .LAB_LOC_7
    RET
.LAB_LOC_1:
    TEST        CX,CX
    JZ          .LAB_LOC_2
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x42]
    SUB         EAX,EBX
    SAR         EAX,0x2
    ADD         EAX,EBX
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x42],EAX
    RET
.LAB_LOC_2:
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x42],EBX
    RET
.LAB_LOC_3:
    TEST        CX,CX
    JZ          .LAB_LOC_4
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x46]
    SUB         EAX,EBX
    SAR         EAX,0x2
    ADD         EAX,EBX
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x46],EAX
    RET
.LAB_LOC_4:
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x46],EBX
    RET
.LAB_LOC_5:
    TEST        CX,0x1
    JZ          .LAB_LOC_6
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x4a]
    SUB         EAX,EBX
    SAR         EAX,0x2
    ADD         EAX,EBX
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x4a],EAX
    RET
.LAB_LOC_6:
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x4a],EBX
    RET
.LAB_LOC_7:
    TEST        CX,0x1
    JZ          .LAB_LOC_8
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x4e]
    SUB         EAX,EBX
    SAR         EAX,0x2
    ADD         EAX,EBX
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x4e],EAX
    RET
.LAB_LOC_8:
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x4e],EBX
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
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0xa]
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x16],AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0xc]
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x18],AX
    MOV         CX,0x10
    MOV         BX,0x0
.LAB_LOC_1:
    mk_addr     EBP, [BX + SI]
    MOV         EAX,dword [EBP + 0x42]
    SAR         EAX,0x7
    mk_addr     EBP, [BX + SI]
    SUB         dword [EBP + 0x42],EAX
    ADD         BX,0x4
    L_LOOP      .LAB_LOC_1
    mk_addr     EBP, [SI]
    TEST        word [EBP + 0xe],0x1
    JZ          .LAB_LOC_3
    MOV         CX,0x10
    MOV         BX,0x0
.LAB_LOC_2:
    mk_addr     EBP, [BX + SI]
    MOV         EAX,dword [EBP + 0x42]
    SAR         EAX,0x2
    mk_addr     EBP, [BX + SI]
    SUB         dword [EBP + 0x42],EAX
    ADD         BX,0x4
    L_LOOP      .LAB_LOC_2
.LAB_LOC_3:
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x18]
    CWD
    MOV         CX,0x4000
    IMUL        CX
    MOVSX       EAX,DX
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x8]
    TEST        BX,BX
    JZ          .LAB_LOC_4
    DEC         BX
    JZ          .LAB_LOC_5
    ROL         EAX,0x3
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0x42],EAX
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0x46],EAX
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0x4a],EAX
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0x4e],EAX
    RET
.LAB_LOC_4:
    ROL         EAX,0x4
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0x4a],EAX
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0x4e],EAX
    RET
.LAB_LOC_5:
    ROL         EAX,0x4
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0x42],EAX
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0x46],EAX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1091:
                              ;XREF[4]:     1000:06b4(c),1000:0760(c),1000:113c(c),1000:11f6(c)
    mk_addr     EBP, [SI]
    MOV         EDX,dword [EBP + 0xc4]
    mk_addr     EBP, [SI]
    SUB         EDX,dword [EBP + 0xa8]
    mk_addr     EBP, [SI]
    MOV         EBX,dword [EBP + 0xc8]
    mk_addr     EBP, [SI]
    SUB         EBX,dword [EBP + 0xac]
    mk_addr     EBP, [SI]
    MOV         ECX,dword [EBP + 0xcc]
    mk_addr     EBP, [SI]
    SUB         ECX,dword [EBP + 0xb0]
    MOV         EAX,EDX
    CALL        FUN_1000_2726
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_10b6:
                              ;XREF[6]:     1000:06c5(c),1000:0771(c),1000:0ef4(c),1000:0f36(c),
                              ;             1000:1150(c),1000:120a(c)
    mk_addr     EBP, [SI]
    MOV         EDX,dword [EBP + 0x70]
    mk_addr     EBP, [SI]
    SUB         EDX,dword [EBP + 0xa8]
    mk_addr     EBP, [SI]
    ADD         EDX,dword [EBP + 0x8c]
    mk_addr     EBP, [SI]
    SUB         EDX,dword [EBP + 0xc4]
    mk_addr     EBP, [SI]
    MOV         EBX,dword [EBP + 0x74]
    mk_addr     EBP, [SI]
    SUB         EBX,dword [EBP + 0xac]
    mk_addr     EBP, [SI]
    ADD         EBX,dword [EBP + 0x90]
    mk_addr     EBP, [SI]
    SUB         EBX,dword [EBP + 0xc8]
    mk_addr     EBP, [SI]
    MOV         ECX,dword [EBP + 0x78]
    mk_addr     EBP, [SI]
    SUB         ECX,dword [EBP + 0xb0]
    mk_addr     EBP, [SI]
    ADD         ECX,dword [EBP + 0x94]
    mk_addr     EBP, [SI]
    SUB         ECX,dword [EBP + 0xcc]
    MOV         EAX,EDX
    CALL        FUN_1000_2726
    RET

 ; 1000:1135 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;ANALYSIS: related to steering, disabling this function disables steering
FUN_1000_1136:
                              ;XREF[2]:     1000:0e9a(c),1000:0ec4(c)
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    ADD         SI,0x2
    CALL        FUN_1000_1091
    MOV         [CSD_DWORD_1000_12b3],EAX
    MOV         dword [CSD_DWORD_1000_12b7],EBX
    MOV         dword [CSD_DWORD_1000_12bb],ECX
    CALL        FUN_1000_10b6
    MOV         [CSD_DWORD_1000_12bf],EAX
    MOV         dword [CSD_DWORD_1000_12c3],EBX
    MOV         dword [CSD_DWORD_1000_12c7],ECX
    POP         SI
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x16]
    CALL        FUN_1000_2aad
    SHL         EAX,0x10
    MOV         [CSD_DWORD_1000_129f],EAX
    CALL        FUN_1000_2ad8
    SHL         EAX,0x10
    MOV         [CSD_DWORD_1000_12a3],EAX                ;= 7FFF0000h
    MOV         EAX,[CSD_DWORD_1000_12bf]
    IMUL        dword [CSD_DWORD_1000_12a3]          ;= 7FFF0000h
    MOV         EBX,EDX
    MOV         EAX,[CSD_DWORD_1000_12b3]
    IMUL        dword [CSD_DWORD_1000_129f]
    SUB         EBX,EDX
    SHL         EBX,0x1
    MOV         dword [CSD_DWORD_1000_12a7],EBX
    MOV         EAX,[CSD_DWORD_1000_12c3]
    IMUL        dword [CSD_DWORD_1000_12a3]          ;= 7FFF0000h
    MOV         EBX,EDX
    MOV         EAX,[CSD_DWORD_1000_12b7]
    IMUL        dword [CSD_DWORD_1000_129f]
    SUB         EBX,EDX
    SHL         EBX,0x1
    MOV         dword [CSD_DWORD_1000_12ab],EBX
    MOV         EAX,[CSD_DWORD_1000_12c7]
    IMUL        dword [CSD_DWORD_1000_12a3]          ;= 7FFF0000h
    MOV         EBX,EDX
    MOV         EAX,[CSD_DWORD_1000_12bb]
    IMUL        dword [CSD_DWORD_1000_129f]
    SUB         EBX,EDX
    SHL         EBX,0x1
    MOV         dword [CSD_DWORD_1000_12af],EBX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;also relate do steering maybe, disabling it just makes the game crash
FUN_1000_11f0:
                              ;XREF[1]:     1000:138f(c)
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    ADD         SI,0x2
    CALL        FUN_1000_1091
    MOV         [CSD_DWORD_1000_12b3],EAX
    MOV         dword [CSD_DWORD_1000_12b7],EBX
    MOV         dword [CSD_DWORD_1000_12bb],ECX
    CALL        FUN_1000_10b6
    MOV         [CSD_DWORD_1000_12bf],EAX
    MOV         dword [CSD_DWORD_1000_12c3],EBX
    MOV         dword [CSD_DWORD_1000_12c7],ECX
    POP         SI
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x16]
    CALL        FUN_1000_2aad
    SHL         EAX,0x10
    MOV         [CSD_DWORD_1000_129f],EAX
    CALL        FUN_1000_2ad8
    SHL         EAX,0x10
    MOV         [CSD_DWORD_1000_12a3],EAX                ;= 7FFF0000h
    MOV         EAX,[CSD_DWORD_1000_12bf]
    IMUL        dword [CSD_DWORD_1000_129f]
    MOV         EBX,EDX
    MOV         EAX,[CSD_DWORD_1000_12b3]
    IMUL        dword [CSD_DWORD_1000_12a3]          ;= 7FFF0000h
    ADD         EBX,EDX
    SHL         EBX,0x7
    PUSH        EBX
    MOV         EAX,[CSD_DWORD_1000_12c3]
    IMUL        dword [CSD_DWORD_1000_129f]
    MOV         EBX,EDX
    MOV         EAX,[CSD_DWORD_1000_12b7]
    IMUL        dword [CSD_DWORD_1000_12a3]          ;= 7FFF0000h
    ADD         EBX,EDX
    SHL         EBX,0x7
    MOV         EAX,[CSD_DWORD_1000_12c7]
    IMUL        dword [CSD_DWORD_1000_129f]
    MOV         ECX,EDX
    MOV         EAX,[CSD_DWORD_1000_12bb]
    IMUL        dword [CSD_DWORD_1000_12a3]          ;= 7FFF0000h
    ADD         ECX,EDX
    SHL         ECX,0x7
    POP         EAX
    RET


 ; 1000:1322 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1323:
                              ;XREF[1]:     1000:195c(c)
    PUSHA
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x1e]
    TEST        AX,AX
    JNZ         .LAB_LOC_1
    MOV         AX, word [base_mem + 0x1a49]
.LAB_LOC_1:
    PUSH        dword [ptr_seg_FeS]
    ld_seg      dword [ptr_seg_FeS],AX
    PUSH        SI
    CALL        FUN_1000_1347
    PUSH        dword [ptr_seg_DeS]
    POP         dword [ptr_seg_EeS]
    POP         SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP + 0x4]
    CALL        FUN_1000_1408
    POP         dword [ptr_seg_FeS]
    POPA
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1347:
                              ;XREF[1]:     1000:1335(c)
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP]
    ADD         SI,0x2
    MOV         DI,0x126
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP]
    mk_addr     EBP, [SI]
    MOV         EBX,dword [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         ECX,dword [EBP + 0x8]
    CALL        FUN_1000_13cc
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP]
    mk_addr     EBP, [SI]
    MOV         EBX,dword [EBP + 0x4]
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
    L_LOOP      .LAB_LOC_1
    POP         SI
    CALL        FUN_1000_11f0
    PUSH        EAX
    PUSH        EBX
    PUSH        ECX
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    ADD         SI,0x2
    mk_addr     EBP, [SI]
    ADD         EAX,dword [EBP]
    mk_addr     EBP, [SI]
    ADD         EBX,dword [EBP + 0x4]
    mk_addr     EBP, [SI]
    ADD         ECX,dword [EBP + 0x8]
    CALL        FUN_1000_13cc
    POP         ECX
    POP         EBX
    POP         EAX
    ADD         SI,0x1c
    NEG         EAX
    NEG         EBX
    NEG         ECX
    mk_addr     EBP, [SI]
    ADD         EAX,dword [EBP]
    mk_addr     EBP, [SI]
    ADD         EBX,dword [EBP + 0x4]
    mk_addr     EBP, [SI]
    ADD         ECX,dword [EBP + 0x8]
    CALL        FUN_1000_13cc
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_13cc:
                              ;XREF[4]:     1000:135e(c),1000:1385(c),1000:13a8(c),1000:13c8(c)
    SUB         EAX,dword [base_mem + 0xaa]
    SUB         EBX,dword [base_mem + 0xae]
    SUB         ECX,dword [base_mem + 0xb2]
    SAR         EAX,0x10
    SAR         EBX,0x10
    SAR         ECX,0x10
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],CX
    CALL        FUN_1000_2418
    JC          .LAB_LOC_1
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x8],BX
.LAB_LOC_1:
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
    NOP
    .L_1408_START:                     
    CALL  F_WRAP_LODSB 
    MOVZX       BX,AL
    SHL         BX, 1
    AND EBX, 63
    JMP         [CS:EBX * 2 + .JMP_TABLE_1413]
.JMP_TABLE_1413:
    ;addr[21]
         dd  .LAB_LOC_1
         dd  .LAB_LOC_6
         dd  .LAB_LOC_7
         dd  .LAB_LOC_8
         dd  .LAB_LOC_9
         dd  .LAB_LOC_11
         dd  .LAB_LOC_12
         dd  .LAB_LOC_14
         dd  .LAB_LOC_16
         dd  .LAB_LOC_18
         dd  .LAB_LOC_20
         dd  .LAB_LOC_1
         dd  .LAB_LOC_1
         dd  .LAB_LOC_1
         dd  .LAB_LOC_1
         dd  .LAB_LOC_1
         dd  .LAB_LOC_24
         dd  .LAB_LOC_2
         dd  .LAB_LOC_3
         dd  .LAB_LOC_4
         dd  .LAB_LOC_5

         times 11 dd .LAB_RUIM

.LAB_RUIM:
    ud2

.LAB_LOC_1:
                              ;             1000:142f(*),1000:1431(*)
    RET
.LAB_LOC_2:
    CALL  F_WRAP_LODSW 
    ADD         SI,AX
    JMP    .L_1408_START
.LAB_LOC_3:
    CALL  F_WRAP_LODSW 
    PUSH        SI
    ADD         SI,AX
    CALL        FUN_1000_1408
    POP         SI
    JMP    .L_1408_START
.LAB_LOC_4:
    MOV         AL, byte [base_mem + 0x5ee]
    SAHF
    CALL  F_WRAP_LODSW 
    JS     .L_1408_START
    ADD         SI,AX
    JMP    .L_1408_START
.LAB_LOC_5:
    MOV         AL, byte [base_mem + 0x5ee]
    SAHF
    CALL  F_WRAP_LODSW 
    JNS    .L_1408_START
    ADD         SI,AX
    JMP    .L_1408_START
.LAB_LOC_6:
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    MOV         AX, word [base_mem + 0x120]
    mk_addr     EBP, [DI]
    CMP         word [EBP + 0x2],AX
    CALL  F_WRAP_LODSW 
    MOV         CL,AL
    JL     .L_1408_START
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x6]
    mk_addr     EBP, [DI]
    MOV         BX,word [EBP + 0x8]
    CALL        FUN_1000_3f98
    JMP    .L_1408_START
.LAB_LOC_7:
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    mk_addr     EBP, [DI]
    MOV         BX,word [EBP + 0x128]
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x128]
    CALL  F_WRAP_LODSW 
    CMP         BX,AX
    LAHF
    MOV         byte [base_mem + 0x5ee],AL
    JMP    .L_1408_START
.LAB_LOC_8:
    XOR         BX,BX
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + -0x6]
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
    MOV         byte [base_mem + 0x5ee],AL
    POP         SI
    JMP    .L_1408_START
.LAB_LOC_9:
    CALL  F_WRAP_LODSB 
    MOVZX       CX,AL
    XOR         BX,BX
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    DEC         CX
.LAB_LOC_10:
    CALL  F_WRAP_LODSW 
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
    L_LOOP      .LAB_LOC_10
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_47ec
    XCHG        DI,SI
    MOV         BL,AL
    CALL  F_WRAP_LODSW 
    MOV         word [base_mem + 0xdb12],AX
    CMP         BL,0x3
    JL     .L_1408_START
    PUSH        SI
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    LAHF
    MOV         byte [base_mem + 0x5ee],AL
    POP         SI
    JS     .L_1408_START
    CALL        FUN_1000_2bec
    JMP    .L_1408_START
.LAB_LOC_11:
    JMP    .L_1408_START
.LAB_LOC_12:
    CALL  F_WRAP_LODSB 
    MOVZX       CX,AL
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    CALL  F_WRAP_LODSW 
    MOV         BX,AX
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    DEC         CX
.LAB_LOC_13:
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    CALL  F_WRAP_LODSW 
    MOV         BX,AX
    PUSH        CX
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    POP         CX
    L_LOOP      .LAB_LOC_13
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    CALL  F_WRAP_LODSW 
    MOV         BX,AX
    XCHG        DI,SI
    CALL        FUN_1000_47ec
    XCHG        DI,SI
    MOV         BL,AL
    CMP         BL,0x3
    JL     .L_1408_START
    PUSH        SI
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    LAHF
    MOV         byte [base_mem + 0x5ee],AL
    POP         SI
    JS     .L_1408_START
    CALL        FUN_1000_30ee
    JMP    .L_1408_START
.LAB_LOC_14:
    CALL  F_WRAP_LODSB 
    MOVZX       CX,AL
    CALL  F_WRAP_LODSW 
    MOV         word [base_mem + 0xdb12],AX
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    CALL  F_WRAP_LODSW 
    MOV         BX,AX
    mk_addr     EBP, [BX]
    MOV         BX,word [EBP + 0x50e]
    ADD         BX,word [base_mem + 0xdb12]
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    DEC         CX
.LAB_LOC_15:
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    CALL  F_WRAP_LODSW 
    MOV         BX,AX
    mk_addr     EBP, [BX]
    MOV         BX,word [EBP + 0x50e]
    ADD         BX,word [base_mem + 0xdb12]
    PUSH        CX
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    POP         CX
    L_LOOP      .LAB_LOC_15
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    CALL  F_WRAP_LODSW 
    MOV         BX,AX
    mk_addr     EBP, [BX]
    MOV         BX,word [EBP + 0x50e]
    ADD         BX,word [base_mem + 0xdb12]
    XCHG        DI,SI
    CALL        FUN_1000_47ec
    XCHG        DI,SI
    MOV         BL,AL
    CMP         BL,0x3
    JL     .L_1408_START
    PUSH        SI
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    LAHF
    MOV         byte [base_mem + 0x5ee],AL
    POP         SI
    JS     .L_1408_START
    CALL        FUN_1000_30ee
    JMP    .L_1408_START
.LAB_LOC_16:
    CALL  F_WRAP_LODSB 
    MOVZX       CX,AL
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    CALL  F_WRAP_LODSD 
    MOV         EBX,EAX
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    DEC         CX
.LAB_LOC_17:
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    CALL  F_WRAP_LODSD 
    MOV         EBX,EAX
    PUSH        CX
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    POP         CX
    L_LOOP      .LAB_LOC_17
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    CALL  F_WRAP_LODSD 
    MOV         EBX,EAX
    XCHG        DI,SI
    CALL        FUN_1000_47ec
    XCHG        DI,SI
    MOV         BL,AL
    CMP         BL,0x3
    JL     .L_1408_START
    PUSH        SI
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    LAHF
    MOV         byte [base_mem + 0x5ee],AL
    POP         SI
    JS     .L_1408_START
    CALL        FUN_1000_36fe
    JMP    .L_1408_START
.LAB_LOC_18:
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    mk_addr     EBP, [DI]
    MOV         CX,word [EBP + 0x2]
    CMP         CX,word [base_mem + 0x120]
    JL          .LAB_LOC_19
    mk_addr     EBP, [DI]
    MOV         BX,word [EBP + 0x6]
    mk_addr     EBP, [DI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x8]
    CALL  F_WRAP_LODSW 
    CWD
    IDIV        CX
    MOV         DX,AX
    PUSH        dword [ptr_seg_EeS]
    PUSH        dword [ptr_seg_DeS]
    POP         dword [ptr_seg_EeS]
    MOV         DI,0xdb16
    MOV         AX,BX
    SUB         AX,DX
    CALL  F_WRAP_STOSW 
    MOV         AX,word [ye_old_lil_bep]
    SUB         AX,DX
    CALL  F_WRAP_STOSW 
    CALL  F_WRAP_MOVSD 
    MOV         AX,BX
    ADD         AX,DX
    CALL  F_WRAP_STOSW 
    MOV         AX,word [ye_old_lil_bep]
    SUB         AX,DX
    CALL  F_WRAP_STOSW 
    CALL  F_WRAP_MOVSD 
    MOV         AX,BX
    ADD         AX,DX
    CALL  F_WRAP_STOSW 
    MOV         AX,word [ye_old_lil_bep]
    ADD         AX,DX
    CALL  F_WRAP_STOSW 
    CALL  F_WRAP_MOVSD 
    MOV         AX,BX
    SUB         AX,DX
    CALL  F_WRAP_STOSW 
    MOV         AX,word [ye_old_lil_bep]
    ADD         AX,DX
    CALL  F_WRAP_STOSW 
    CALL  F_WRAP_MOVSD 
    POP         dword [ptr_seg_EeS]
    MOV         word [base_mem + 0xdb14],0x4
    CALL        FUN_1000_36fe
    JMP    .L_1408_START
.LAB_LOC_19:
    ADD         SI,0x12
    JMP    .L_1408_START
.LAB_LOC_20:
    PUSH        SI
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         BX,AX
    SHL         AX,0x2
    ADD         BX,AX
    mk_addr     EBP, [BX]
    MOV         AX,word [EBP + 0x128]
    CMP         AX,word [base_mem + 0x120]
    JL          .LAB_LOC_23
    CALL  F_WRAP_LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    CALL  F_WRAP_LODSW 
    PUSH        BX
    PUSH        SI
    MOV         SI,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x126]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x128]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x12a]
    mk_addr     EBP, [DI]
    SUB         AX,word [EBP + 0x126]
    mk_addr     EBP, [DI]
    SUB         BX,word [EBP + 0x128]
    mk_addr     EBP, [DI]
    SUB         CX,word [EBP + 0x12a]
    CALL        FUN_1000_271d
    movsx_m2m   dword [ye_old_bep],AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x126]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x128]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x12a]
    CALL        FUN_1000_271d
    IMUL        dword [ye_old_bep]
    MOV         dword [ye_old_bep],EAX
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x126]
    mk_addr     EBP, [SI]
    SUB         AX,word [EBP + 0x126]
    CWD
    mk_addr     EBP, [SI]
    IMUL        word [EBP + 0x126]
    MOV         BX,AX
    MOV         CX,DX
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x128]
    mk_addr     EBP, [SI]
    SUB         AX,word [EBP + 0x128]
    CWD
    mk_addr     EBP, [SI]
    IMUL        word [EBP + 0x128]
    ADD         BX,AX
    ADC         CX,DX
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x12a]
    mk_addr     EBP, [SI]
    SUB         AX,word [EBP + 0x12a]
    CWD
    mk_addr     EBP, [SI]
    IMUL        word [EBP + 0x12a]
    ADD         AX,BX
    ADC         DX,CX
    XCHG        AX,DX
    ROR         EAX,0x10
    MOV         AX,DX
    SAR         dword [ye_old_bep],0x9
    SHL         EAX,0x6
    CDQ
    IDIV        dword [ye_old_bep]
    SAR         EAX,0x1
    MOV         CX,0x8
    MOV         BX,0x5de
.LAB_LOC_21:
    mk_addr     EBP, [BX]
    CMP         AX,word [EBP]
    JL          .LAB_LOC_22
    ADD         BX,0x2
    L_LOOP      .LAB_LOC_21
.LAB_LOC_22:
    POP         SI
    POP         BX
    SHL         CX,0x2
    ADD         SI,CX
    SHL         CX,0x2
    ADD         SI,CX
    mk_addr     EBP, [BX]
    MOV         CX,word [EBP + 0x128]
    mk_addr     EBP, [BX]
    MOV         DX,word [EBP + 0x12c]
    mk_addr     EBP, [BX]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x12e]
    PUSH        DX
    PUSH        word [ye_old_lil_bep]
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x12c]
    mk_addr     EBP, [DI]
    MOV         BX,word [EBP + 0x12e]
    SUB         AX,DX
    SUB         BX,word [ye_old_lil_bep]
    CALL        FUN_1000_2b08
    MOV         BX,AX
    CALL        FUN_1000_2aad
    MOV         word [ye_old_lil_bep],AX
    CALL        FUN_1000_2ad8
    MOV         BX,AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    IMUL        BX
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         AX,DX
    CWD
    IDIV        CX
    MOV         word [base_mem + 0x5d8],AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    IMUL        word [ye_old_lil_bep]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         AX,DX
    CWD
    IDIV        CX
    MOV         word [base_mem + 0x5d6],AX
    ADD         SI,0x2
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    IMUL        BX
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         AX,DX
    CWD
    IDIV        CX
    MOV         word [base_mem + 0x5dc],AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    IMUL        word [ye_old_lil_bep]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         AX,DX
    CWD
    IDIV        CX
    MOV         word [base_mem + 0x5da],AX
    ADD         SI,0x2
    POP         word [ye_old_lil_bep]
    POP         BX
    PUSH        dword [ptr_seg_EeS]
    PUSH        dword [ptr_seg_DeS]
    POP         dword [ptr_seg_EeS]
    MOV         DI,0xdb16
    MOV         AX,BX
    SUB         AX,word [base_mem + 0x5d8]
    SUB         AX,word [base_mem + 0x5da]
    CALL  F_WRAP_STOSW 
    MOV         AX,word [ye_old_lil_bep]
    ADD         AX,word [base_mem + 0x5d6]
    SUB         AX,word [base_mem + 0x5dc]
    CALL  F_WRAP_STOSW 
    CALL  F_WRAP_MOVSD 
    MOV         AX,BX
    SUB         AX,word [base_mem + 0x5d8]
    ADD         AX,word [base_mem + 0x5da]
    CALL  F_WRAP_STOSW 
    MOV         AX,word [ye_old_lil_bep]
    ADD         AX,word [base_mem + 0x5d6]
    ADD         AX,word [base_mem + 0x5dc]
    CALL  F_WRAP_STOSW 
    CALL  F_WRAP_MOVSD 
    MOV         AX,BX
    ADD         AX,word [base_mem + 0x5d8]
    ADD         AX,word [base_mem + 0x5da]
    CALL  F_WRAP_STOSW 
    MOV         AX,word [ye_old_lil_bep]
    SUB         AX,word [base_mem + 0x5d6]
    ADD         AX,word [base_mem + 0x5dc]
    CALL  F_WRAP_STOSW 
    CALL  F_WRAP_MOVSD 
    MOV         AX,BX
    ADD         AX,word [base_mem + 0x5d8]
    SUB         AX,word [base_mem + 0x5da]
    CALL  F_WRAP_STOSW 
    MOV         AX,word [ye_old_lil_bep]
    SUB         AX,word [base_mem + 0x5d6]
    SUB         AX,word [base_mem + 0x5dc]
    CALL  F_WRAP_STOSW 
    CALL  F_WRAP_MOVSD 
    POP         dword [ptr_seg_EeS]
    MOV         word [base_mem + 0xdb14],0x4
    CALL        FUN_1000_36fe
.LAB_LOC_23:
    POP         SI
    ADD         SI,0xba
    JMP    .L_1408_START
.LAB_LOC_24:
    MOV         AL, byte [base_mem + 0x5ee]
    SAHF
    JS          .LAB_LOC_25
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    ADD         SI,AX
    CALL        FUN_1000_1408
    POP         SI
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x2]
    ADD         SI,AX
    CALL        FUN_1000_1408
    POP         SI
    ADD         SI,0x4
    JMP    .L_1408_START
.LAB_LOC_25:
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x2]
    ADD         SI,AX
    CALL        FUN_1000_1408
    POP         SI
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    ADD         SI,AX
    CALL        FUN_1000_1408
    POP         SI
    ADD         SI,0x4
    JMP    .L_1408_START
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_194c:
                              ;XREF[8]:     1000:1a50(c),1000:1b06(c),1000:1bfa(c),1000:1caa(c),
                              ;             1000:2063(c),1000:2117(c),1000:220c(c),1000:22bc(c)
    MOV         DI,0x5bbc
    MOV         CX,word [base_mem + 0x5bba]
.LAB_LOC_1:
    mk_addr     EBP, [DI]
    MOV         SI,word [EBP]
    mk_addr     EBP, [SI]
    CMP         DX,word [EBP + 0x1a]
    JNZ         .LAB_LOC_2
    CALL        FUN_1000_1323
.LAB_LOC_2:
    ADD         DI,0x2
    L_LOOP      .LAB_LOC_1
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1965:
                              ;XREF[3]:     1000:02c9(c),1000:0395(c),1000:0455(c)
    MOV         word [base_mem + 0x19ff],0x0
    MOV         word [base_mem + 0x1a01],0xa00
    MOV         AX, word [base_mem + 0xc6]
    TEST        AH,0x60
    ;jumping to another function, some kind of tail call optimization
    JNP         FUN_1965_NP
    MOV         byte [base_mem + 0x5fb],0x0
    CALL        FUN_1000_3fd0
    MOV         AX, word [base_mem + 0xc6]
    TEST        AH,0xa0
    JNP         .LAB_LOC_12
    MOV         DI,0x5bbc
    MOV         CX,word [base_mem + 0x5bba]
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         SI,word [EBP]
    CALL        FUN_1000_22f0
    ADD         DI,0x2
    POP         CX
    L_LOOP      .LAB_LOC_1
    MOV         SI,0xe590
    MOV         AX, word [base_mem + 0xe58c]
    MOV         BH,AL
    SHL         AX,0x2
    ADD         SI,AX
.LAB_LOC_2:
    PUSH        BX
    mk_addr     EBP, [SI]
    MOV         BL,byte [EBP]
    MOVZX       DX,BL
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [base_mem + 0x19ff]
.LAB_LOC_3:
    MOV         word [base_mem + 0x5fd],BX
    PUSH        BX
    mk_addr_seg EBP, ptr_seg_FeS, [BX]
    MOV         AL,byte [EBP + 0xfeff]
    MOV         byte [base_mem + 0x5fc],AL
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       CX,byte [EBP]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [base_mem + 0xac]
    SUB         BX,word [base_mem + 0xb0]
    SUB         CX,word [base_mem + 0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],CX
    CMP         BX,word [base_mem + 0x120]
    JL          .LAB_LOC_4
    CALL        FUN_1000_2760
    ADD         AX,word [base_mem + 0xdbb8]
    NEG         BX
    ADD         BX,word [base_mem + 0xdbba]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x8],BX
.LAB_LOC_4:
    MOV         DX,word [base_mem + 0x5fd]
    CMP         DH,byte [base_mem + 0xe58c]
    JZ          .LAB_LOC_5
    mk_addr     EBP, [SI]
    CMP         DL,byte [EBP]
    JZ          .LAB_LOC_5
    mk_addr     EBP, [SI]
    CMP         DL,byte [EBP + -0x4]
    JBE         .LAB_LOC_5
    mk_addr     EBP, [SI]
    CMP         DL,byte [EBP + -0x2]
    JA          .LAB_LOC_5
    PUSH        SI
    PUSH        DI
    SUB         DI,0xa
    MOV         SI,DI
    SUB         DI,word [base_mem + 0x19ff]
    ADD         DI,word [base_mem + 0x1a01]
    CALL        FUN_1000_1cde
    MOV         DX,word [base_mem + 0x5fd]
    SUB         DX,0x101
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
.LAB_LOC_5:
    POP         BX
    CMP         BL,byte [base_mem + 0xad]
    JNC         .LAB_LOC_6
    INC         BL
    ADD         DI,0xa
    JMP         .LAB_LOC_3
.LAB_LOC_6:
    mk_addr     EBP, [SI]
    MOV         BL,byte [EBP + 0x2]
    MOVZX       DX,BL
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [base_mem + 0x19ff]
.LAB_LOC_7:
    MOV         word [base_mem + 0x5fd],BX
    PUSH        BX
    mk_addr_seg EBP, ptr_seg_FeS, [BX]
    MOV         AL,byte [EBP + 0xff00]
    MOV         byte [base_mem + 0x5fc],AL
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       CX,byte [EBP]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [base_mem + 0xac]
    SUB         BX,word [base_mem + 0xb0]
    SUB         CX,word [base_mem + 0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],CX
    CMP         BX,word [base_mem + 0x120]
    JL          .LAB_LOC_8
    CALL        FUN_1000_2760
    ADD         AX,word [base_mem + 0xdbb8]
    NEG         BX
    ADD         BX,word [base_mem + 0xdbba]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x8],BX
.LAB_LOC_8:
    MOV         DX,word [base_mem + 0x5fd]
    CMP         DH,byte [base_mem + 0xe58c]
    JZ          .LAB_LOC_9
    mk_addr     EBP, [SI]
    CMP         DL,byte [EBP + 0x2]
    JZ          .LAB_LOC_9
    mk_addr     EBP, [SI]
    CMP         DL,byte [EBP + -0x4]
    JC          .LAB_LOC_9
    mk_addr     EBP, [SI]
    CMP         DL,byte [EBP + -0x2]
    JNC         .LAB_LOC_9
    PUSH        SI
    PUSH        DI
    MOV         SI,DI
    SUB         DI,word [base_mem + 0x19ff]
    ADD         DI,word [base_mem + 0x1a01]
    CALL        FUN_1000_1cde
    MOV         DX,word [base_mem + 0x5fd]
    SUB         DX,0x100
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
.LAB_LOC_9:
    POP         BX
    CMP         BL,byte [base_mem + 0xad]
    JBE         .LAB_LOC_10
    DEC         BL
    SUB         DI,0xa
    JMP         .LAB_LOC_7
.LAB_LOC_10:
    POP         BX
    CMP         BH,byte [base_mem + 0xe58e]
    JNC         .LAB_LOC_11
    INC         BH
    ADD         SI,0x4
    XOR         word [base_mem + 0x19ff],0xa00
    XOR         word [base_mem + 0x1a01],0xa00
    JMP         .LAB_LOC_2
.LAB_LOC_11:
    RET
.LAB_LOC_12:
    MOV         DI,0x5bbc
    MOV         CX,word [base_mem + 0x5bba]
.LAB_LOC_13:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         SI,word [EBP]
    CALL        FUN_1000_233b
    ADD         DI,0x2
    POP         CX
    L_LOOP      .LAB_LOC_13
    MOV         SI,0xe590
    MOV         AX, word [base_mem + 0xe58e]
    MOV         BH,AL
    SHL         AX,0x2
    ADD         SI,AX
.LAB_LOC_14:
    PUSH        BX
    mk_addr     EBP, [SI]
    MOV         BL,byte [EBP]
    MOVZX       DX,BL
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [base_mem + 0x19ff]
.LAB_LOC_15:
    MOV         word [base_mem + 0x5fd],BX
    PUSH        BX
    mk_addr_seg EBP, ptr_seg_FeS, [BX]
    MOV         AL,byte [EBP + -0x1]
    MOV         byte [base_mem + 0x5fc],AL
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       CX,byte [EBP]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [base_mem + 0xac]
    SUB         BX,word [base_mem + 0xb0]
    SUB         CX,word [base_mem + 0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],CX
    CMP         BX,word [base_mem + 0x120]
    JL          .LAB_LOC_16
    CALL        FUN_1000_2760
    ADD         AX,word [base_mem + 0xdbb8]
    NEG         BX
    ADD         BX,word [base_mem + 0xdbba]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x8],BX
.LAB_LOC_16:
    MOV         DX,word [base_mem + 0x5fd]
    CMP         DH,byte [base_mem + 0xe58e]
    JZ          .LAB_LOC_17
    mk_addr     EBP, [SI]
    CMP         DL,byte [EBP]
    JZ          .LAB_LOC_17
    mk_addr     EBP, [SI]
    CMP         DL,byte [EBP + 0x4]
    JBE         .LAB_LOC_17
    mk_addr     EBP, [SI]
    CMP         DL,byte [EBP + 0x6]
    JA          .LAB_LOC_17
    PUSH        SI
    PUSH        DI
    SUB         DI,0xa
    MOV         SI,DI
    SUB         SI,word [base_mem + 0x19ff]
    ADD         SI,word [base_mem + 0x1a01]
    CALL        FUN_1000_1cde
    MOV         DX,word [base_mem + 0x5fd]
    SUB         DL,0x1
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
.LAB_LOC_17:
    POP         BX
    CMP         BL,byte [base_mem + 0xad]
    JNC         .LAB_LOC_18
    INC         BL
    ADD         DI,0xa
    JMP         .LAB_LOC_15
.LAB_LOC_18:
    mk_addr     EBP, [SI]
    MOV         BL,byte [EBP + 0x2]
    MOVZX       DX,BL
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [base_mem + 0x19ff]
.LAB_LOC_19:
    MOV         word [base_mem + 0x5fd],BX
    PUSH        BX
    mk_addr_seg EBP, ptr_seg_FeS, [BX]
    MOV         AL,byte [EBP]
    MOV         byte [base_mem + 0x5fc],AL
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       CX,byte [EBP]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [base_mem + 0xac]
    SUB         BX,word [base_mem + 0xb0]
    SUB         CX,word [base_mem + 0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],CX
    CMP         BX,word [base_mem + 0x120]
    JL          .LAB_LOC_20
    CALL        FUN_1000_2760
    ADD         AX,word [base_mem + 0xdbb8]
    NEG         BX
    ADD         BX,word [base_mem + 0xdbba]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x8],BX
.LAB_LOC_20:
    MOV         DX,word [base_mem + 0x5fd]
    CMP         DH,byte [base_mem + 0xe58e]
    JZ          .LAB_LOC_21
    mk_addr     EBP, [SI]
    CMP         DL,byte [EBP + 0x2]
    JZ          .LAB_LOC_21
    mk_addr     EBP, [SI]
    CMP         DL,byte [EBP + 0x4]
    JC          .LAB_LOC_21
    mk_addr     EBP, [SI]
    CMP         DL,byte [EBP + 0x6]
    JNC         .LAB_LOC_21
    PUSH        SI
    PUSH        DI
    MOV         SI,DI
    SUB         SI,word [base_mem + 0x19ff]
    ADD         SI,word [base_mem + 0x1a01]
    CALL        FUN_1000_1cde
    MOV         DX,word [base_mem + 0x5fd]
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
.LAB_LOC_21:
    POP         BX
    CMP         BL,byte [base_mem + 0xad]
    JBE         .LAB_LOC_22
    DEC         BL
    SUB         DI,0xa
    JMP         .LAB_LOC_19
.LAB_LOC_22:
    POP         BX
    CMP         BH,byte [base_mem + 0xe58c]
    JBE         .LAB_LOC_23
    DEC         BH
    SUB         SI,0x4
    XOR         word [base_mem + 0x19ff],0xa00
    XOR         word [base_mem + 0x1a01],0xa00
    JMP         .LAB_LOC_14
.LAB_LOC_23:
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1cde:
                              ;XREF[4]:     1000:1a45(c),1000:1afb(c),1000:1bf0(c),1000:1ca3(c)
    MOV         AL, byte [base_mem + 0x5fc]
    MOV         BX,0x1d51
    mk_addr     EBP, [DI]
    MOV         CX,word [EBP + 0xc]
    mk_addr     EBP, [SI]
    ADD         CX,word [EBP + 0x2]
    SAR         CX,0x2
    CMP         CX,word [base_mem + 0x5f5]
    JL          .LAB_LOC_4
    ADD         BH,CH
    CALL  F_WRAP_XLAT      
    MOV         AH,AL
    MOV         word [base_mem + 0xdb12],AX
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
    JL          .LAB_LOC_1
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JNS         .LAB_LOC_1
    CALL        FUN_1000_2bec
.LAB_LOC_1:
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
    JL          .LAB_LOC_3
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JNS         .LAB_LOC_3
    MOV         AX, word [base_mem + 0xdb12]
    TEST        AL,0xf
    JZ          .LAB_LOC_2
    SUB         word [base_mem + 0xdb12],0x101
.LAB_LOC_2:
    CALL        FUN_1000_2bec
.LAB_LOC_3:
    RET
.LAB_LOC_4:
    PUSH        dword [ptr_seg_FeS]
    ld_seg      dword [ptr_seg_FeS],word [base_mem + 0x1a4b]
    MOV         AH,byte [base_mem + 0x5fc]
    MOV         BH,AL
    AND         BH,0xf0
    SHL         AH,0x4
    MOV         BL,0x80
    MOV         AL,0x80
    SHL         EBX,0x10
    MOV         BX,AX
    MOV         dword [base_mem + 0x1d4d],EBX
    PUSH        SI
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf00
    CALL        FUN_1000_46a0
    MOV         SI,DI
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0x0
    CALL        FUN_1000_46d3
    POP         SI
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf000000
    CALL        FUN_1000_46d3
    PUSH        SI
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf00
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          .LAB_LOC_5
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JNS         .LAB_LOC_5
    CALL        FUN_1000_36fe
.LAB_LOC_5:
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf00
    CALL        FUN_1000_46a0
    POP         SI
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf000000
    CALL        FUN_1000_46d3
    ADD         SI,0xa
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf000f00
    CALL        FUN_1000_46d3
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf00
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          .LAB_LOC_6
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JNS         .LAB_LOC_6
    CALL        FUN_1000_36fe
.LAB_LOC_6:
    POP         dword [ptr_seg_FeS]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_1e3a:
                              ;XREF[4]:     1000:2058(c),1000:210d(c),1000:2202(c),1000:22b5(c)
    MOV         AL, byte [base_mem + 0x5fc]
    MOV         BX,0x1d51
    mk_addr     EBP, [DI]
    MOV         CX,word [EBP + 0xc]
    mk_addr     EBP, [SI]
    ADD         CX,word [EBP + 0x2]
    SAR         CX,0x2
    CMP         CX,word [base_mem + 0x5f5]
    JL          .LAB_LOC_4
    ADD         BH,CH
    CALL  F_WRAP_XLAT     
    MOV         AH,AL
    MOV         word [base_mem + 0xdb12],AX
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
    JL          .LAB_LOC_1
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JS          .LAB_LOC_1
    CALL        FUN_1000_2bec
.LAB_LOC_1:
    LEA         SI,[DI + 0xa]
    CALL        FUN_1000_46a0
    POP         SI
    CALL        FUN_1000_46d3
    ADD         SI,0xa
    CALL        FUN_1000_46d3
    LEA         SI,[DI + 0xa]
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          .LAB_LOC_3
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JS          .LAB_LOC_3
    MOV         AX, word [base_mem + 0xdb12]
    TEST        AL,0xf
    JZ          .LAB_LOC_2
    SUB         word [base_mem + 0xdb12],0x101
.LAB_LOC_2:
    CALL        FUN_1000_2bec
.LAB_LOC_3:
    RET
.LAB_LOC_4:
    PUSH        dword [ptr_seg_FeS]
    ld_seg      dword [ptr_seg_FeS],word [base_mem + 0x1a4b]
    MOV         AH,byte [base_mem + 0x5fc]
    MOV         BH,AL
    AND         BH,0xf0
    SHL         AH,0x4
    MOV         BL,0x80
    MOV         AL,0x80
    SHL         EBX,0x10
    MOV         BX,AX
    MOV         dword [base_mem + 0x1d4d],EBX
    PUSH        SI
    LEA         SI,[DI + 0xa]
    OR          EBX,0xf000000
    CALL        FUN_1000_46a0
    MOV         SI,DI
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0x0
    CALL        FUN_1000_46d3
    POP         SI
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf00
    CALL        FUN_1000_46d3
    PUSH        SI
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf000000
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          .LAB_LOC_5
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JS          .LAB_LOC_5
    CALL        FUN_1000_36fe
.LAB_LOC_5:
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf000000
    CALL        FUN_1000_46a0
    POP         SI
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf00
    CALL        FUN_1000_46d3
    ADD         SI,0xa
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf000f00
    CALL        FUN_1000_46d3
    LEA         SI,[DI + 0xa]
    MOV         EBX,dword [base_mem + 0x1d4d]
    OR          EBX,0xf000000
    CALL        FUN_1000_47ec
    CMP         AL,0x3
    JL          .LAB_LOC_6
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JS          .LAB_LOC_6
    CALL        FUN_1000_36fe
.LAB_LOC_6:
    POP         dword [ptr_seg_FeS]
    RET

;seems like a alternative version of FUN_1000_1965, what it does? who knows?
FUN_1965_NP:
.LAB_LOC_1:
    MOV         byte [base_mem + 0x5fb],0x1
    CALL        FUN_1000_41b2
    MOV         AX, word [base_mem + 0xc6]
    TEST        AH,0xc0
    JNS         .LAB_LOC_13
    MOV         DI,0x5bbc
    MOV         CX,word [base_mem + 0x5bba]
.LAB_LOC_2:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         SI,word [EBP]
    CALL        FUN_1000_2384
    ADD         DI,0x2
    POP         CX
    L_LOOP      .LAB_LOC_2
    MOV         SI,0xe590
    MOV         AX, word [base_mem + 0xe58c]
    MOV         BL,AL
    SHL         AX,0x2
    ADD         SI,AX
.LAB_LOC_3:
    PUSH        BX
    mk_addr     EBP, [SI]
    MOV         BH,byte [EBP]
    MOVZX       DX,BH
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [base_mem + 0x19ff]
.LAB_LOC_4:
    MOV         word [base_mem + 0x5fd],BX
    PUSH        BX
    mk_addr_seg EBP, ptr_seg_FeS, [BX]
    MOV         AL,byte [EBP + 0xfeff]
    MOV         byte [base_mem + 0x5fc],AL
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       CX,byte [EBP]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [base_mem + 0xac]
    SUB         BX,word [base_mem + 0xb0]
    SUB         CX,word [base_mem + 0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],CX
    CMP         BX,word [base_mem + 0x120]
    JL          .LAB_LOC_5
    CALL        FUN_1000_2760
    ADD         AX,word [base_mem + 0xdbb8]
    NEG         BX
    ADD         BX,word [base_mem + 0xdbba]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x8],BX
.LAB_LOC_5:
    MOV         DX,word [base_mem + 0x5fd]
    CMP         DL,byte [base_mem + 0xe58c]
    JZ          .LAB_LOC_6
    mk_addr     EBP, [SI]
    CMP         DH,byte [EBP]
    JZ          .LAB_LOC_6
    mk_addr     EBP, [SI]
    CMP         DH,byte [EBP + -0x4]
    JBE         .LAB_LOC_6
    mk_addr     EBP, [SI]
    CMP         DH,byte [EBP + -0x2]
    JA          .LAB_LOC_6
    PUSH        SI
    PUSH        DI
    SUB         DI,0xa
    MOV         SI,DI
    SUB         DI,word [base_mem + 0x19ff]
    ADD         DI,word [base_mem + 0x1a01]
    CALL        FUN_1000_1e3a
    MOV         DX,word [base_mem + 0x5fd]
    SUB         DX,0x101
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
.LAB_LOC_6:
    POP         BX
    CMP         BH,byte [base_mem + 0xb1]
    JNC         .LAB_LOC_7
    INC         BH
    ADD         DI,0xa
    JMP         .LAB_LOC_4
.LAB_LOC_7:
    mk_addr     EBP, [SI]
    MOV         BH,byte [EBP + 0x2]
    MOVZX       DX,BH
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [base_mem + 0x19ff]
.LAB_LOC_8:
    MOV         word [base_mem + 0x5fd],BX
    PUSH        BX
    mk_addr_seg EBP, ptr_seg_FeS, [BX]
    MOV         AL,byte [EBP + -0x1]
    MOV         byte [base_mem + 0x5fc],AL
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       CX,byte [EBP]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [base_mem + 0xac]
    SUB         BX,word [base_mem + 0xb0]
    SUB         CX,word [base_mem + 0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],CX
    CMP         BX,word [base_mem + 0x120]
    JL          .LAB_LOC_9
    CALL        FUN_1000_2760
    ADD         AX,word [base_mem + 0xdbb8]
    NEG         BX
    ADD         BX,word [base_mem + 0xdbba]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x8],BX
.LAB_LOC_9:
    MOV         DX,word [base_mem + 0x5fd]
    CMP         DL,byte [base_mem + 0xe58c]
    JZ          .LAB_LOC_10
    mk_addr     EBP, [SI]
    CMP         DH,byte [EBP + 0x2]
    JZ          .LAB_LOC_10
    mk_addr     EBP, [SI]
    CMP         DH,byte [EBP + -0x4]
    JC          .LAB_LOC_10
    mk_addr     EBP, [SI]
    CMP         DH,byte [EBP + -0x2]
    JNC         .LAB_LOC_10
    PUSH        SI
    PUSH        DI
    MOV         SI,DI
    SUB         DI,word [base_mem + 0x19ff]
    ADD         DI,word [base_mem + 0x1a01]
    CALL        FUN_1000_1e3a
    MOV         DX,word [base_mem + 0x5fd]
    SUB         DX,0x1
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
.LAB_LOC_10:
    POP         BX
    CMP         BH,byte [base_mem + 0xb1]
    JBE         .LAB_LOC_11
    DEC         BH
    SUB         DI,0xa
    JMP         .LAB_LOC_8
.LAB_LOC_11:
    POP         BX
    CMP         BL,byte [base_mem + 0xe58e]
    JNC         .LAB_LOC_12
    INC         BL
    ADD         SI,0x4
    XOR         word [base_mem + 0x19ff],0xa00
    XOR         word [base_mem + 0x1a01],0xa00
    JMP         .LAB_LOC_3
.LAB_LOC_12:
    RET
.LAB_LOC_13:
    MOV         DI,0x5bbc
    MOV         CX,word [base_mem + 0x5bba]
.LAB_LOC_14:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         SI,word [EBP]
    CALL        FUN_1000_23cf
    ADD         DI,0x2
    POP         CX
    L_LOOP      .LAB_LOC_14
    MOV         SI,0xe590
    MOV         AX, word [base_mem + 0xe58e]
    MOV         BL,AL
    SHL         AX,0x2
    ADD         SI,AX
.LAB_LOC_15:
    PUSH        BX
    mk_addr     EBP, [SI]
    MOV         BH,byte [EBP]
    MOVZX       DX,BH
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [base_mem + 0x19ff]
.LAB_LOC_16:
    MOV         word [base_mem + 0x5fd],BX
    PUSH        BX
    mk_addr_seg EBP, ptr_seg_FeS, [BX]
    MOV         AL,byte [EBP + 0xff00]
    MOV         byte [base_mem + 0x5fc],AL
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       CX,byte [EBP]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [base_mem + 0xac]
    SUB         BX,word [base_mem + 0xb0]
    SUB         CX,word [base_mem + 0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],CX
    CMP         BX,word [base_mem + 0x120]
    JL          .LAB_LOC_17
    CALL        FUN_1000_2760
    ADD         AX,word [base_mem + 0xdbb8]
    NEG         BX
    ADD         BX,word [base_mem + 0xdbba]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x8],BX
.LAB_LOC_17:
    MOV         DX,word [base_mem + 0x5fd]
    CMP         DL,byte [base_mem + 0xe58e]
    JZ          .LAB_LOC_18
    mk_addr     EBP, [SI]
    CMP         DH,byte [EBP]
    JZ          .LAB_LOC_18
    mk_addr     EBP, [SI]
    CMP         DH,byte [EBP + 0x4]
    JBE         .LAB_LOC_18
    mk_addr     EBP, [SI]
    CMP         DH,byte [EBP + 0x6]
    JA          .LAB_LOC_18
    PUSH        SI
    PUSH        DI
    SUB         DI,0xa
    MOV         SI,DI
    SUB         SI,word [base_mem + 0x19ff]
    ADD         SI,word [base_mem + 0x1a01]
    CALL        FUN_1000_1e3a
    MOV         DX,word [base_mem + 0x5fd]
    SUB         DH,0x1
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
.LAB_LOC_18:
    POP         BX
    CMP         BH,byte [base_mem + 0xb1]
    JNC         .LAB_LOC_19
    INC         BH
    ADD         DI,0xa
    JMP         .LAB_LOC_16
.LAB_LOC_19:
    mk_addr     EBP, [SI]
    MOV         BH,byte [EBP + 0x2]
    MOVZX       DX,BH
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [base_mem + 0x19ff]
.LAB_LOC_20:
    MOV         word [base_mem + 0x5fd],BX
    PUSH        BX
    mk_addr_seg EBP, ptr_seg_FeS, [BX]
    MOV         AL,byte [EBP]
    MOV         byte [base_mem + 0x5fc],AL
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       CX,byte [EBP]
    SHL         CX,0x4
    MOV         AH,BL
    XOR         AL,AL
    XOR         BL,BL
    SUB         AX,word [base_mem + 0xac]
    SUB         BX,word [base_mem + 0xb0]
    SUB         CX,word [base_mem + 0xb4]
    MOV         DX,0xce
    CALL        FUN_1000_277e
    NEG         BX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],CX
    CMP         BX,word [base_mem + 0x120]
    JL          .LAB_LOC_21
    CALL        FUN_1000_2760
    ADD         AX,word [base_mem + 0xdbb8]
    NEG         BX
    ADD         BX,word [base_mem + 0xdbba]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x8],BX
.LAB_LOC_21:
    MOV         DX,word [base_mem + 0x5fd]
    CMP         DL,byte [base_mem + 0xe58e]
    JZ          .LAB_LOC_22
    mk_addr     EBP, [SI]
    CMP         DH,byte [EBP + 0x2]
    JZ          .LAB_LOC_22
    mk_addr     EBP, [SI]
    CMP         DH,byte [EBP + 0x4]
    JC          .LAB_LOC_22
    mk_addr     EBP, [SI]
    CMP         DH,byte [EBP + 0x6]
    JNC         .LAB_LOC_22
    PUSH        SI
    PUSH        DI
    MOV         SI,DI
    SUB         SI,word [base_mem + 0x19ff]
    ADD         SI,word [base_mem + 0x1a01]
    CALL        FUN_1000_1e3a
    MOV         DX,word [base_mem + 0x5fd]
    CALL        FUN_1000_194c
    POP         DI
    POP         SI
.LAB_LOC_22:
    POP         BX
    CMP         BH,byte [base_mem + 0xb1]
    JBE         .LAB_LOC_23
    DEC         BH
    SUB         DI,0xa
    JMP         .LAB_LOC_20
.LAB_LOC_23:
    POP         BX
    CMP         BL,byte [base_mem + 0xe58c]
    JBE         .LAB_LOC_24
    DEC         BL
    SUB         SI,0x4
    XOR         word [base_mem + 0x19ff],0xa00
    XOR         word [base_mem + 0x1a01],0xa00
    JMP         .LAB_LOC_15
.LAB_LOC_24:
    RET

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_22f0:
                              ;XREF[1]:     1000:1998(c)
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP]
    ADD         SI,0x2
    MOV         BX,0x0
    MOV         CX,0x7f7f
.LAB_LOC_1:
    mk_addr     EBP, [SI]
    MOV         AH,byte [EBP + 0x7]
    mk_addr     EBP, [SI]
    MOV         AL,byte [EBP + 0x3]
    MOV         DX,AX
    SUB         AH,byte [base_mem + 0xb1]
    SUB         AL,byte [base_mem + 0xad]
    NEG         AH
    AND         AL,AL
    JGE         .LAB_LOC_2
    NEG         AL
.LAB_LOC_2:
    CMP         AL,CL
    JL          .LAB_LOC_5
.LAB_LOC_3:
    CMP         AH,CH
    JL          .LAB_LOC_6
.LAB_LOC_4:
    ADD         SI,0x1c
    DEC         word [ye_old_lil_bep]
    JNZ         .LAB_LOC_1
    POP         SI
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x1a],BX
    RET
.LAB_LOC_5:
    MOV         BL,DL
    MOV         CL,AL
    JMP         .LAB_LOC_3
.LAB_LOC_6:
    MOV         BH,DH
    MOV         CH,AH
    JMP         .LAB_LOC_4
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_233b:
                              ;XREF[1]:     1000:1b44(c)
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP]
    ADD         SI,0x2
    MOV         BX,0x0
    MOV         CX,0x7f7f
.LAB_LOC_1:
    mk_addr     EBP, [SI]
    MOV         AH,byte [EBP + 0x7]
    mk_addr     EBP, [SI]
    MOV         AL,byte [EBP + 0x3]
    MOV         DX,AX
    SUB         AH,byte [base_mem + 0xb1]
    SUB         AL,byte [base_mem + 0xad]
    AND         AL,AL
    JGE         .LAB_LOC_2
    NEG         AL
.LAB_LOC_2:
    CMP         AL,CL
    JL          .LAB_LOC_5
.LAB_LOC_3:
    CMP         AH,CH
    JL          .LAB_LOC_6
.LAB_LOC_4:
    ADD         SI,0x1c
    DEC         word [ye_old_lil_bep]
    JNZ         .LAB_LOC_1
    POP         SI
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x1a],BX
    RET
.LAB_LOC_5:
    MOV         BL,DL
    MOV         CL,AL
    JMP         .LAB_LOC_3
.LAB_LOC_6:
    MOV         BH,DH
    MOV         CH,AH
    JMP         .LAB_LOC_4
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2384:
                              ;XREF[1]:     1000:1fab(c)
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP]
    ADD         SI,0x2
    MOV         BX,0x0
    MOV         CX,0x7f7f
.LAB_LOC_1:
    mk_addr     EBP, [SI]
    MOV         AH,byte [EBP + 0x7]
    mk_addr     EBP, [SI]
    MOV         AL,byte [EBP + 0x3]
    MOV         DX,AX
    SUB         AH,byte [base_mem + 0xb1]
    SUB         AL,byte [base_mem + 0xad]
    AND         AH,AH
    JGE         .LAB_LOC_2
    NEG         AH
.LAB_LOC_2:
    NEG         AL
    CMP         AL,CL
    JL          .LAB_LOC_5
.LAB_LOC_3:
    CMP         AH,CH
    JL          .LAB_LOC_6
.LAB_LOC_4:
    ADD         SI,0x1c
    DEC         word [ye_old_lil_bep]
    JNZ         .LAB_LOC_1
    POP         SI
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x1a],BX
    RET
.LAB_LOC_5:
    MOV         BL,DL
    MOV         CL,AL
    JMP         .LAB_LOC_3
.LAB_LOC_6:
    MOV         BH,DH
    MOV         CH,AH
    JMP         .LAB_LOC_4
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_23cf:
                              ;XREF[1]:     1000:2155(c)
    PUSH        SI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP]
    ADD         SI,0x2
    MOV         BX,0x0
    MOV         CX,0x7f7f
.LAB_LOC_1:
    mk_addr     EBP, [SI]
    MOV         AH,byte [EBP + 0x7]
    mk_addr     EBP, [SI]
    MOV         AL,byte [EBP + 0x3]
    MOV         DX,AX
    SUB         AH,byte [base_mem + 0xb1]
    SUB         AL,byte [base_mem + 0xad]
    AND         AH,AH
    JGE         .LAB_LOC_2
    NEG         AH
.LAB_LOC_2:
    CMP         AL,CL
    JL          .LAB_LOC_5
.LAB_LOC_3:
    CMP         AH,CH
    JL          .LAB_LOC_6
.LAB_LOC_4:
    ADD         SI,0x1c
    DEC         word [ye_old_lil_bep]
    JNZ         .LAB_LOC_1
    POP         SI
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x1a],BX
    RET
.LAB_LOC_5:
    MOV         BL,DL
    MOV         CL,AL
    JMP         .LAB_LOC_3
.LAB_LOC_6:
    MOV         BH,DH
    MOV         CH,AH
    JMP         .LAB_LOC_4
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2418:
                              ;XREF[2]:     1000:0b8d(c),1000:13f7(c)
    CMP         BX,word [base_mem + 0x120]
    JL          .LAB_LOC_1
    CALL        FUN_1000_2760
    ADD         AX,word [base_mem + 0xdbb8]
    NEG         BX
    ADD         BX,word [base_mem + 0xdbba]
    CLC
    RET
.LAB_LOC_1:
    STC
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2431:
                              ;XREF[1]:     1000:01b8(c)
    MOV         DI,SI
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP]
    INC         CX
    INC         CX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x20],CX
    MOV         DI,SI
    ADD         DI,CX
    mk_addr     EBP, [DI]
    MOV         CX,word [EBP]
.LAB_LOC_1:
    mk_addr     EBP, [DI]
    CMP         word [EBP + 0x1a],-0x1
    JZ          .LAB_LOC_2
    ADD         DI,0x1c
    L_LOOP      .LAB_LOC_1
    RET
.LAB_LOC_2:
    SUB         DI,SI
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x20],DI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2454:
                              ;XREF[1]:     1000:01a9(c)

    PUSH        AX
    PUSH        BX
    PUSH        dword [ptr_seg_EeS]
    PUSH        DI
    PUSH        dword [ptr_seg_DeS]
    POP         dword [ptr_seg_EeS]
    MOV         CX,0x41
    XOR         AX,AX
    CLD
CALL F_WRAP_REP_STOSW
    POP         DI
    POP         dword [ptr_seg_EeS]
    MOV         DX,DX
    MOV         AL,0x0
    MOV         AH,0x3d
    call DOS3Call
    MOV         BX,AX
    JC          .LAB_LOC_2
    MOV         DX,DI
    MOV         CX,0x2710
    MOV         AH,0x3f
    call DOS3Call
    MOV         word [ye_old_lil_bep],AX
    MOV         AH,0x3e
    call DOS3Call
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
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP]
    ADD         SI,0x2
.LAB_LOC_1:
    mk_addr     EBP, [SI]
    ADD         dword [EBP],EAX
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0x4],EBX
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0x8],EDX
    ADD         SI,0x1c
    L_LOOP      .LAB_LOC_1
    MOV         AX,word [ye_old_lil_bep]

    RET
.LAB_LOC_2:
    POP         BX
    POP         AX

    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_24c0:
                              ;XREF[1]:     1000:017e(c)
    PUSH        dword [ptr_seg_EeS]
    MOV         DX,0x1a03
    ld_seg      dword [ptr_seg_EeS],word [base_mem + 0x1a45]
    XOR         DI,DI
    CALL        FUN_1000_5a60
    JC          .LAB_LOC_1
    MOV         DX,0x1a20
    ld_seg      dword [ptr_seg_EeS],word [base_mem + 0x1a4b]
    XOR         DI,DI
    CALL        FUN_1000_5a60
    JC          .LAB_LOC_1
    MOV         DX,0x1a0b
    MOV         AL,0x0
    MOV         AH,0x3d
    call DOS3Call
    MOV         BX,AX
    CALL        FUN_1000_5a95
    JC          .LAB_LOC_1
    MOV         CX,0xffff
    MOV         DX,0xfd00
    MOV         AX,0x4202
    call DOS3Call
    JC          .LAB_LOC_1
    MOV         DX,0x1a4d
    MOV         CX,0x300
    MOV         AH,0x3f
    call DOS3Call
    MOV         CX,0x0
    MOV         DX,0x80
    MOV         AX,0x4200
    call DOS3Call
    ld_seg      dword [ptr_seg_EeS],word [base_mem + 0x1a47]
    XOR         DI,DI
    CALL        FUN_1000_5acf
    JC          .LAB_LOC_1
    MOV         AH,0x3e
    call DOS3Call
    MOV         DX,0x1a2b
    MOV         AL,0x0
    MOV         AH,0x3d
    call DOS3Call
    MOV         BX,AX
    MOV         DX,0x1d51
    MOV         CX,0x1100
    MOV         AH,0x3f
    call DOS3Call
    MOV         AH,0x3e
    call DOS3Call
    MOV         DX,0x1a33
    MOV         AL,0x0
    MOV         AH,0x3d
    call DOS3Call
    MOV         BX,AX
    MOV         DX,0x2e51
    MOV         CX,0x1000
    MOV         AH,0x3f
    call DOS3Call
    MOV         AH,0x3e
    call DOS3Call
.LAB_LOC_1:
                              ;             1000:2520(j)
    POP         dword [ptr_seg_EeS]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_255c:
                              ;XREF[1]:     1000:0181(c)
    PUSH        dword [ptr_seg_EeS]
    MOV         DX,0x1a13
    ld_seg      dword [ptr_seg_EeS],word [base_mem + 0x1a49]
    XOR         DI,DI
    CALL        FUN_1000_5a60
    POP         dword [ptr_seg_EeS]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_256b:
                              ;XREF[2]:     1000:261a(c),1000:265b(c)
    MOV         AX, word [base_mem + 0x5ac1]
    IMUL        word [base_mem + 0x5ac9]
    MOV         word [base_mem + 0x5ad7],AX
    MOV         AX, word [base_mem + 0x5ac3]
    IMUL        word [base_mem + 0x5ac7]
    SUB         word [base_mem + 0x5ad7],AX
    MOV         AX, word [base_mem + 0x5acd]
    IMUL        word [base_mem + 0x5ac9]
    MOV         word [base_mem + 0x5ad3],AX
    MOV         AX, word [base_mem + 0x5acf]
    IMUL        word [base_mem + 0x5ac7]
    SUB         word [base_mem + 0x5ad3],AX
    MOV         AX, word [base_mem + 0x5acf]
    IMUL        word [base_mem + 0x5ac1]
    MOV         word [base_mem + 0x5ad5],AX
    MOV         AX, word [base_mem + 0x5acd]
    IMUL        word [base_mem + 0x5ac3]
    SUB         word [base_mem + 0x5ad5],AX
    MOV         AX, word [base_mem + 0x5ac5]
    IMUL        word [base_mem + 0x5ad3]
    MOV         BX,AX
    MOV         CX,DX
    MOV         AX, word [base_mem + 0x5acb]
    IMUL        word [base_mem + 0x5ad5]
    ADD         AX,BX
    ADC         DX,CX
    IDIV        word [base_mem + 0x5ad7]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_25c5:
                              ;XREF[9]:     1000:07b4(c),1000:07ec(c),1000:0810(c),1000:083e(c),
                              ;             1000:08e1(c),1000:09f6(c),1000:0c0d(c),1000:1372(c),
                              ;             1000:2486(c)
    MOV         word [base_mem + 0x5ac1],0x80
    MOV         word [base_mem + 0x5ac3],0x0
    MOV         word [base_mem + 0x5ac7],0x0
    MOV         word [base_mem + 0x5ac9],0x80
    SHR         AL,0x1
    SHR         BL,0x1
    MOV         CL,AL
    ADD         CL,BL
    CMP         CL,0x80
    JA          .LAB_LOC_1
    MOV         byte [base_mem + 0x5acd],AL
    MOV         byte [base_mem + 0x5acf],BL
    MOV         BL,AH
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       AX,byte [EBP]
    SHL         AX,0x4
    MOV         CX,AX
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       AX,byte [EBP + 0x1]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         word [base_mem + 0x5ac5],AX
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       AX,byte [EBP + 0x100]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         word [base_mem + 0x5acb],AX
    PUSH        CX
    CALL        FUN_1000_256b
    POP         CX
    ADD         AX,CX
    JMP         .LAB_LOC_2
.LAB_LOC_1:
    NEG         AL
    NEG         BL
    ADD         AL,0x80
    ADD         BL,0x80
    MOV         byte [base_mem + 0x5acd],AL
    MOV         byte [base_mem + 0x5acf],BL
    MOV         BL,AH
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       AX,byte [EBP + 0x101]
    SHL         AX,0x4
    MOV         CX,AX
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       AX,byte [EBP + 0x1]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         word [base_mem + 0x5acb],AX
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       AX,byte [EBP + 0x100]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         word [base_mem + 0x5ac5],AX
    PUSH        CX
    CALL        FUN_1000_256b
    POP         CX
    ADD         AX,CX
.LAB_LOC_2:
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2662:
                              ;XREF[13]:    1000:1509(c),1000:156f(c),1000:15e2(c),1000:166e(c),
                              ;             1000:16e4(c),1000:1d20(c),1000:1d4c(c),1000:1dd4(c),
                              ;             1000:1e2d(c),1000:1e7c(c),1000:1ea5(c),1000:1f28(c),
                              ;             1000:1f81(c)
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    SUB         AX,word [EBP + 0x8]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x12]
    mk_addr     EBP, [SI]
    SUB         DX,word [EBP + 0xa]
    IMUL        DX
    MOV         CX,AX
    MOV         BX,DX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x10]
    mk_addr     EBP, [SI]
    SUB         AX,word [EBP + 0x8]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    SUB         DX,word [EBP + 0xa]
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
    JP          .LAB_LOC_1
    MOV         BX,AX
    CALL        FUN_1000_2aad
    MOVSX       EBX,AX
    ADD         ESP,0x2
    POP         AX
    SHL         EAX,0x10
    SAR         EAX,0x1
    CDQ
    IDIV        EBX
    RET
.LAB_LOC_1:
    MOV         BX,AX
    CALL        FUN_1000_2ad8
    MOVSX       EBX,AX
    POP         AX
    ADD         ESP,0x2
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
;ANALYSIS: seems to be related to camera rotation and maybe position, if I nop it the camera stops rotating and following the car
;MODIFICATIONS: before ES and BP was used as temporary storage, this broke protected mode (the writing to ES part), modified to use globals as locals (leaf function, no problem)
FUN_1000_277e:
                              ;XREF[10]:    1000:0b88(c),1000:13ea(c),1000:19ee(c),1000:1aa6(c),
                              ;             1000:1b99(c),1000:1c4e(c),1000:2001(c),1000:20b8(c),
                              ;             1000:21ab(c),1000:2260(c)
    XCHG        AX,BX
    XCHG        AX,CX
    PUSH        DI
    MOV         DI,DX
    MOV         [pseudolocal_a],AX
    MOV         AX,BX
    mk_addr     EBP, [DI]
    IMUL        word [EBP]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         [pseudolocal_b],DX
    MOV         AX,CX
    mk_addr     EBP, [DI]
    IMUL        word [EBP + 0x6]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         [pseudolocal_b],DX
    MOV         AX, [pseudolocal_a]
    mk_addr     EBP, [DI]
    IMUL        word [EBP + 0xc]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         [pseudolocal_b],DX
    PUSH        word [pseudolocal_b]
    MOV         AX,BX
    mk_addr     EBP, [DI]
    IMUL        word [EBP + 0x2]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         [pseudolocal_b],DX
    MOV         AX,CX
    mk_addr     EBP, [DI]
    IMUL        word [EBP + 0x8]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         [pseudolocal_b],DX
    MOV         AX,[pseudolocal_a]
    mk_addr     EBP, [DI]
    IMUL        word [EBP + 0xe]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         [pseudolocal_b],DX
    PUSH        word [pseudolocal_b]
    MOV         AX,BX
    mk_addr     EBP, [DI]
    IMUL        word [EBP + 0x4]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         [pseudolocal_b],DX
    MOV         AX,CX
    mk_addr     EBP, [DI]
    IMUL        word [EBP + 0xa]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         [pseudolocal_b],DX
    MOV         AX,[pseudolocal_a]
    mk_addr     EBP, [DI]
    IMUL        word [EBP + 0x10]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         [pseudolocal_b],DX
    MOV         CX,[pseudolocal_b]
    POP         BX
    POP         AX
    POP         DI

    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_27f1:
                              ;XREF[3]:     1000:02bd(c),1000:0389(c),1000:0452(c)
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    XCHG        word [EBP + 0x6],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],AX
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x4]
    mk_addr     EBP, [DI]
    XCHG        word [EBP + 0xc],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],AX
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0xa]
    mk_addr     EBP, [DI]
    XCHG        word [EBP + 0xe],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xa],AX
    RET

 ; 1000:2988 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2989:
                              ;XREF[3]:     1000:02ba(c),1000:0386(c),1000:044f(c)
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP]
    CALL        FUN_1000_2aad
    MOV         word [base_mem + 0xd100],AX
    CALL        FUN_1000_2ad8
    MOV         word [base_mem + 0xd102],AX
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    CALL        FUN_1000_2aad
    MOV         word [base_mem + 0xd104],AX
    CALL        FUN_1000_2ad8
    MOV         word [base_mem + 0xd106],AX
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x4]
    CALL        FUN_1000_2aad
    NEG         AX
    MOV         word [base_mem + 0xd108],AX
    CALL        FUN_1000_2ad8
    MOV         word [base_mem + 0xd10a],AX
    MOV         AX, word [base_mem + 0xd100]
    IMUL        word [base_mem + 0xd104]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         AX,DX
    MOV         BX,AX
    IMUL        word [base_mem + 0xd108]
    SHL         AX,0x1
    RCL         DX,0x1
    CMP         DX,0x8000
    JNZ         .LAB_LOC_1
    INC         DX
.LAB_LOC_1:
    NEG         DX
    MOV         CX,DX
    MOV         AX, word [base_mem + 0xd102]
    IMUL        word [base_mem + 0xd10a]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         AX,DX
    ADD         DX,CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],DX
    XCHG        AX,BX
    IMUL        word [base_mem + 0xd10a]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         CX,DX
    MOV         AX, word [base_mem + 0xd108]
    IMUL        word [base_mem + 0xd102]
    SHL         AX,0x1
    RCL         DX,0x1
    XCHG        DX,CX
    ADD         DX,CX
    CMP         DX,0x8000
    JNZ         .LAB_LOC_2
    INC         DX
.LAB_LOC_2:
    NEG         DX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],DX
    MOV         AX, word [base_mem + 0xd100]
    IMUL        word [base_mem + 0xd106]
    SHL         AX,0x1
    RCL         DX,0x1
    CMP         DX,0x8000
    JNZ         .LAB_LOC_3
    INC         DX
.LAB_LOC_3:
    NEG         DX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],DX
    MOV         AX, word [base_mem + 0xd108]
    IMUL        word [base_mem + 0xd106]
    SHL         AX,0x1
    RCL         DX,0x1
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],DX
    MOV         AX, word [base_mem + 0xd10a]
    IMUL        word [base_mem + 0xd106]
    SHL         AX,0x1
    RCL         DX,0x1
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x8],DX
    MOV         DX,word [base_mem + 0xd104]
    CMP         DX,0x8000
    JNZ         .LAB_LOC_4
    INC         DX
.LAB_LOC_4:
    NEG         DX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xa],DX
    MOV         AX,CX
    IMUL        word [base_mem + 0xd104]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         CX,DX
    MOV         AX, word [base_mem + 0xd10a]
    IMUL        word [base_mem + 0xd100]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         DX,CX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xc],DX
    MOV         AX,BX
    IMUL        word [base_mem + 0xd104]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         CX,DX
    MOV         AX, word [base_mem + 0xd100]
    IMUL        word [base_mem + 0xd108]
    SHL         AX,0x1
    RCL         DX,0x1
    CMP         DX,0x8000
    JNZ         .LAB_LOC_5
    INC         DX
.LAB_LOC_5:
    NEG         DX
    ADD         DX,CX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xe],DX
    MOV         AX, word [base_mem + 0xd102]
    IMUL        word [base_mem + 0xd106]
    SHL         AX,0x1
    RCL         DX,0x1
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x10],DX
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
    JZ          .LAB_LOC_1
    NEG         AX
    ADD         AX,0x8000
.LAB_LOC_1:
    SHR         AX,0x1
    SHR         AX,0x1
    SHR         AX,0x1
    AND         AL,0xfe
    PUSH        BX
    MOV         BX,AX
    mk_addr     EBP, [BX]
    MOV         AX,word [EBP + 0xd10c]
    POP         BX
    TEST        BH,0x80
    JZ          .LAB_LOC_2
    NEG         AX
.LAB_LOC_2:
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
    JZ          .LAB_LOC_1
    SUB         AX,0x4000
    JMP         .LAB_LOC_2
.LAB_LOC_1:
    NEG         AX
    ADD         AX,0x4000
.LAB_LOC_2:
    SHR         AX,0x1
    SHR         AX,0x1
    SHR         AX,0x1
    AND         AL,0xfe
    PUSH        BX
    MOV         BX,AX
    mk_addr     EBP, [BX]
    MOV         AX,word [EBP + 0xd10c]
    POP         BX
    TEST        BH,0xc0
    JP          .LAB_LOC_3
    NEG         AX
.LAB_LOC_3:
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
    JS          .LAB_LOC_2
    JNZ         FUN_1000_2b1f
    MOV         AX,0x0
    TEST        BX,BX
    JNS         .LAB_LOC_1
    ADD         AX,0x8000
.LAB_LOC_1:
    RET

.LAB_LOC_2:
    NOT         AX
    CALL        FUN_1000_2b1f
    NEG         AX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2b1f:
                              ;XREF[2]:     1000:2b0e(j),1000:2b63(c)
    AND         BX,BX
    JS          .LAB_LOC_1
    JNZ         FUN_1000_2b2d
    MOV         AX,0x4000
    RET

.LAB_LOC_1:
    NOT         BX
    CALL        FUN_1000_2b2d
    NEG         AX
    ADD         AX,0x8000
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2b2d:
                              ;XREF[2]:     1000:2b25(j),1000:2b58(c)
    CMP         AX,BX
    JG          .LAB_LOC_1
    JL          FUN_1000_2b3b
    MOV         AX,0x2000
    RET

.LAB_LOC_1:
    XCHG        AX,BX
    CALL        FUN_1000_2b3b
    NEG         AX
    ADD         AX,0x4000
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
    mk_addr     EBP, [BX]
    MOV         AX,word [EBP + 0xd90e]
    RET

 ; 1000:2b6f [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;MODIFIED: now it only alocates and doesnt set vga to mode 13h
FUN_1000_2b70:
                              ;XREF[1]:     1000:021c(c)
    MOV         AH,0x48
    MOV         BX,0xfa0
    call DOS3Call
    JC          .LAB_LOC_1
    MOV         word [base_mem + 0xdb10],AX
.LAB_LOC_1:
    RET

 ; 1000:2b97 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;ANALYSIS: this clears the framebuffer
FUN_1000_2b98:
                              ;XREF[2]:     1000:02c6(c),1000:0392(c)
    PUSH        dword [ptr_seg_EeS]
    PUSH        DI
    ld_seg      dword [ptr_seg_EeS],word [base_mem + 0xdb10]
    XOR         DI,DI
    MOV         CX,0x7D00
    CLD
CALL F_WRAP_REP_STOSW
    POP         DI
    POP         dword [ptr_seg_EeS]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2baa:
                              ;XREF[1]:     1000:04f7(c)
;REMOVED, was copy to VGA mem
    RET

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;ANALYSIS: this has something to do with flat shaded polygons, disabling this function makes only the textured ones render
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
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    CMP         CX,0x3
    JC          .LAB_LOC_2
    MOV         AX, word [base_mem + 0xdbbe]
    MOV         word [base_mem + 0xdbc4],AX
    MOV         AX, word [base_mem + 0xdbbc]
    MOV         word [base_mem + 0xdbc6],AX
    PUSH        SI
    DEC         CX
.LAB_LOC_1:
    PUSH        CX
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x8]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0xa]
    CALL        FUN_1000_2c4b
    POP         SI
    POP         CX
    ADD         SI,0x8
    L_LOOP      .LAB_LOC_1
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    POP         SI
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x2]
    CALL        FUN_1000_2c4b
    CALL        FUN_1000_2d61
.LAB_LOC_2:
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
    JLE         .LAB_LOC_3
    XCHG        AX,DX
    XCHG        CX,BX
    CMP         BX,word [base_mem + 0xdbc4]
    JGE         .LAB_LOC_1
    MOV         word [base_mem + 0xdbc4],BX
.LAB_LOC_1:
    CMP         CX,word [base_mem + 0xdbc6]
    JLE         .LAB_LOC_2
    MOV         word [base_mem + 0xdbc6],CX
.LAB_LOC_2:
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0xdbca
    JMP         .LAB_LOC_6
.LAB_LOC_3:
    CMP         BX,word [base_mem + 0xdbc4]
    JGE         .LAB_LOC_4
    MOV         word [base_mem + 0xdbc4],BX
.LAB_LOC_4:
    CMP         CX,word [base_mem + 0xdbc6]
    JLE         .LAB_LOC_5
    MOV         word [base_mem + 0xdbc6],CX
.LAB_LOC_5:
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0xdbc8
.LAB_LOC_6:
    L_JCXZ      .LAB_LOC_8
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
.LAB_LOC_7:
    ROR         EAX,0x10
    mk_addr     EBP, [BX]
    MOV         word [EBP],AX
    ADD         BX,0x4
    ROL         EAX,0x10
    ADD         EAX,EDX
    L_LOOP      .LAB_LOC_7
    ROR         EAX,0x10
    mk_addr     EBP, [BX]
    MOV         word [EBP],AX
.LAB_LOC_8:
    RET

 ; 1000:2d60 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2d61:
                              ;XREF[1]:     1000:2c45(c)
    MOV         BX,word [base_mem + 0xdbc4]
    MOV         DX,word [base_mem + 0xdbc6]
    SUB         DX,BX
    JZ          .LAB_LOC_4
    INC         DX
    SHL         BX,0x2
    PUSH        dword [ptr_seg_EeS]
    ld_seg      dword [ptr_seg_EeS], word [base_mem + 0xdb10]
    MOV         SI,BX
    CMP         word [base_mem + 0xdb12],0xf0f0
    JNC         .LAB_LOC_5
.LAB_LOC_1:
    MOV         DI,SI
    SHL         DI,0x2
    ADD         DI,SI
    SHL         DI,0x4
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0xdbc8]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0xdbca]
    SUB         CX,AX
    JNS         .LAB_LOC_2
    ADD         AX,CX
    NEG         CX
.LAB_LOC_2:
    INC         CX
    ADD         DI,AX
    CLD
    MOV         AX, word [base_mem + 0xdb12]
    SHR         CX,0x1
CALL F_WRAP_REP_STOSW 
    JNC         .LAB_LOC_3
    CALL  F_WRAP_STOSB 
.LAB_LOC_3:
    ADD         SI,0x4
    DEC         DX
    JNZ         .LAB_LOC_1
    POP         dword [ptr_seg_EeS]
.LAB_LOC_4:
    RET
.LAB_LOC_5:
    MOV         BX,word [base_mem + 0xdb12]
    SUB         BH,0xf0
.LAB_LOC_6:
    MOV         DI,SI
    SHL         DI,0x2
    ADD         DI,SI
    SHL         DI,0x4
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0xdbc8]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0xdbca]
    SUB         CX,AX
    JNS         .LAB_LOC_7
    ADD         AX,CX
    NEG         CX
.LAB_LOC_7:
    INC         CX
    ADD         DI,AX
    CLD
.LAB_LOC_8:
    mk_addr_seg EBP, ptr_seg_EeS, [DI]
    MOV         BL,byte [EBP]
    mk_addr     EBP, [BX]
    MOV         AL,byte [EBP + 0x2e51]
    CALL  F_WRAP_STOSB 
    L_LOOP      .LAB_LOC_8
    ADD         SI,0x4
    DEC         DX
    JNZ         .LAB_LOC_6
    POP         dword [ptr_seg_EeS]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2df2:
                              ;XREF[1]:     1000:2bf4(c)
    PUSH        SI
    PUSH        DI
    MOV         word [ye_old_lil_bep], 0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    POP         DI
    ADD         SI,0x8
    CMP         AX,word [base_mem + 0xdbc0]
    JL          .LAB_LOC_6
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x8
    INC         word [ye_old_lil_bep]
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x8
    CMP         AX,word [base_mem + 0xdbc0]
    JL          .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    SUB         CX,word [base_mem + 0xdbc0]
    JZ          .LAB_LOC_4
    SUB         AX,word [base_mem + 0xdbc0]
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    MOV         AX, word [base_mem + 0xdbc0]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x8
    INC         word [ye_old_lil_bep]
.LAB_LOC_4:
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_6
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_5:
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    SUB         AX,word [base_mem + 0xdbc0]
    SUB         CX,word [base_mem + 0xdbc0]
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    MOV         AX, word [base_mem + 0xdbc0]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x8
    INC         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_1
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_6:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x8
    CMP         AX,word [base_mem + 0xdbc0]
    JGE         .LAB_LOC_5
    POP         CX
    L_LOOP      .LAB_LOC_6
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2eaf:
                              ;XREF[1]:     1000:2bf9(c)
    PUSH        SI
    PUSH        DI
    MOV         word [ye_old_lil_bep], 0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    POP         DI
    ADD         SI,0x8
    CMP         AX,word [base_mem + 0xdbc2]
    JG          .LAB_LOC_6
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x8
    INC         word [ye_old_lil_bep]
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x8
    CMP         AX,word [base_mem + 0xdbc2]
    JG          .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    SUB         CX,word [base_mem + 0xdbc2]
    JZ          .LAB_LOC_4
    SUB         AX,word [base_mem + 0xdbc2]
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    MOV         AX, word [base_mem + 0xdbc2]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x8
    INC         word [ye_old_lil_bep]
.LAB_LOC_4:
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_6
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_5:
    PUSH        AX
    PUSH        BX
    SUB         AX,word [base_mem + 0xdbc2]
    SUB         CX,word [base_mem + 0xdbc2]
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    MOV         AX, word [base_mem + 0xdbc2]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x8
    INC         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_1
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_6:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x8
    CMP         AX,word [base_mem + 0xdbc2]
    JLE         .LAB_LOC_5
    POP         CX
    L_LOOP      .LAB_LOC_6
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2f6c:
                              ;XREF[1]:     1000:2bfe(c)
    PUSH        SI
    PUSH        DI
    MOV         word [ye_old_lil_bep], 0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    POP         DI
    ADD         SI,0x8
    CMP         BX,word [base_mem + 0xdbbc]
    JL          .LAB_LOC_6
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x8
    INC         word [ye_old_lil_bep]
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x8
    CMP         BX,word [base_mem + 0xdbbc]
    JL          .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [base_mem + 0xdbbc]
    JZ          .LAB_LOC_4
    SUB         AX,word [base_mem + 0xdbbc]
    CALL        FUN_1000_3f7a
    MOV         BX,word [base_mem + 0xdbbc]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x8
    INC         word [ye_old_lil_bep]
.LAB_LOC_4:
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_6
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_5:
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [base_mem + 0xdbbc]
    SUB         CX,word [base_mem + 0xdbbc]
    CALL        FUN_1000_3f7a
    MOV         BX,word [base_mem + 0xdbbc]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x8
    INC         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_1
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_6:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x8
    CMP         BX,word [base_mem + 0xdbbc]
    JGE         .LAB_LOC_5
    POP         CX
    L_LOOP      .LAB_LOC_6
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_302d:
                              ;XREF[1]:     1000:2c03(c)
    PUSH        SI
    PUSH        DI
    MOV         word [ye_old_lil_bep], 0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    POP         DI
    ADD         SI,0x8
    CMP         BX,word [base_mem + 0xdbbe]
    JG          .LAB_LOC_6
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x8
    INC         word [ye_old_lil_bep]
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x8
    CMP         BX,word [base_mem + 0xdbbe]
    JG          .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [base_mem + 0xdbbe]
    JZ          .LAB_LOC_4
    SUB         AX,word [base_mem + 0xdbbe]
    CALL        FUN_1000_3f7a
    MOV         BX,word [base_mem + 0xdbbe]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x8
    INC         word [ye_old_lil_bep]
.LAB_LOC_4:
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_6
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_5:
    PUSH        AX
    PUSH        BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [base_mem + 0xdbbe]
    SUB         CX,word [base_mem + 0xdbbe]
    CALL        FUN_1000_3f7a
    MOV         BX,word [base_mem + 0xdbbe]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x8
    INC         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_1
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_6:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x8
    CMP         BX,word [base_mem + 0xdbbe]
    JLE         .LAB_LOC_5
    POP         CX
    L_LOOP      .LAB_LOC_6
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;TODO find out when this is called
FUN_1000_30ee:
                              ;XREF[2]:     1000:15ee(c),1000:167a(c)
    PUSH        SI
    PUSH        DI
    MOV         SI,0xdb16
    MOV         DI,0xdb68
    ;TODO parametrize and all that jazz
    CALL        FUN_1000_324f
    XCHG        DI,SI
    CALL        FUN_1000_3376
    XCHG        DI,SI
    CALL        FUN_1000_34a2
    XCHG        DI,SI
    CALL        FUN_1000_35cf
    MOV         SI,DI
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    CMP         CX,0x3
    JC          .LAB_LOC_3
    MOV         AX, word [base_mem + 0xdbbe]
    MOV         word [base_mem + 0xdbc4],AX
    MOV         AX, word [base_mem + 0xdbbc]
    MOV         word [base_mem + 0xdbc6],AX
    PUSH        SI
    DEC         CX
.LAB_LOC_1:
    PUSH        CX
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x8]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0xa]
    CALL        FUN_1000_2c4b
    POP         SI
    POP         CX
    ADD         SI,0x8
    L_LOOP      .LAB_LOC_1
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    POP         SI
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x2]
    CALL        FUN_1000_2c4b
    MOV         SI,0xdb16
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    DEC         CX
.LAB_LOC_2:
    PUSH        CX
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0xc]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0xa]
    CALL        FUN_1000_317d
    POP         SI
    POP         CX
    ADD         SI,0x8
    L_LOOP      .LAB_LOC_2
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    POP         SI
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x2]
    CALL        FUN_1000_317d
    CALL        FUN_1000_31d1
.LAB_LOC_3:
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
    JLE         .LAB_LOC_1
    XCHG        AX,DX
    XCHG        CX,BX
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0xdeea
    JMP         .LAB_LOC_2
.LAB_LOC_1:
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0xdee8
.LAB_LOC_2:
    L_JCXZ      .LAB_LOC_4
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
.LAB_LOC_3:
    ROR         EAX,0x10
    mk_addr     EBP, [BX]
    MOV         word [EBP],AX
    ADD         BX,0x4
    ROL         EAX,0x10
    ADD         EAX,EDX
    L_LOOP      .LAB_LOC_3
    ROR         EAX,0x10
    mk_addr     EBP, [BX]
    MOV         word [EBP],AX
.LAB_LOC_4:
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_31d1:
                              ;XREF[1]:     1000:3177(c)
    MOV         BX,word [base_mem + 0xdbc4]
    MOV         DX,word [base_mem + 0xdbc6]
    SUB         DX,BX
    JZ          .LAB_LOC_4
    INC         DX
    SHL         BX,0x2
    PUSH        dword [ptr_seg_EeS]
    ld_seg      dword [ptr_seg_EeS], word [base_mem + 0xdb10]
.LAB_LOC_1:
    MOV         DI,BX
    SHL         DI,0x2
    ADD         DI,BX
    SHL         DI,0x4
    PUSH        BX
    PUSH        DX
    mk_addr     EBP, [BX]
    MOV         AX,word [EBP + 0xdbc8]
    mk_addr     EBP, [BX]
    MOV         CX,word [EBP + 0xdbca]
    mk_addr     EBP, [BX]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0xdee8]
    mk_addr     EBP, [BX]
    MOV         DX,word [EBP + 0xdeea]
    SUB         DX,word [ye_old_lil_bep]
    SUB         CX,AX
    JNS         .LAB_LOC_2
    ADD         AX,CX
    NEG         CX
    ADD         word [ye_old_lil_bep],DX
    NEG         DX
.LAB_LOC_2:
    PUSH        word [ye_old_lil_bep]
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
.LAB_LOC_3:
    ROR         EAX,0x10
    CALL  F_WRAP_STOSB 
    ROL         EAX,0x10
    ADD         EAX,EBX
    L_LOOP      .LAB_LOC_3
    POP         DX
    POP         BX
    ADD         BX,0x4
    DEC         DX
    JNZ         .LAB_LOC_1
    POP         dword [ptr_seg_EeS]
.LAB_LOC_4:
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_324f:
                              ;XREF[1]:     1000:30f6(c)
    PUSH        SI
    PUSH        DI
    MOV         word [base_mem + 0xe528],0x0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    POP         DI
    ADD         SI,0x8
    CMP         AX,word [base_mem + 0xdbc0]
    JL          .LAB_LOC_6
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    ADD         DI,0x8
    INC         word [base_mem + 0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    ADD         SI,0x8
    CMP         AX,word [base_mem + 0xdbc0]
    JL          .LAB_LOC_4
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX, word [base_mem + 0xe528]
    mk_addr     EBP, [DI]
    MOV         word [EBP + -0x2],AX
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         AX,word [base_mem + 0xdbc0]
    SUB         CX,word [base_mem + 0xdbc0]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbc0]
    mk_addr     EBP, [DI]
    MOV         word [EBP],CX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],AX
    POP         CX
    POP         AX
    MOV         DX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         BX,word [ye_old_lil_bep]
    CALL        FUN_1000_3f7a
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],AX
    ADD         DI,0x8
    INC         word [base_mem + 0xe528]
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_1
    JMP         .LAB_LOC_2
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         CX,word [base_mem + 0xdbc0]
    JZ          .LAB_LOC_5
    SUB         AX,word [base_mem + 0xdbc0]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbc0]
    mk_addr     EBP, [DI]
    MOV         word [EBP],CX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],AX
    POP         CX
    POP         AX
    MOV         BX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         DX,word [ye_old_lil_bep]
    CALL        FUN_1000_3f7a
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],AX
    ADD         DI,0x8
    INC         word [base_mem + 0xe528]
.LAB_LOC_5:
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    ADD         SI,0x8
    CMP         AX,word [base_mem + 0xdbc0]
    JGE         .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3376:
                              ;XREF[1]:     1000:30fb(c)
    PUSH        SI
    PUSH        DI
    MOV         word [base_mem + 0xe528],0x0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    POP         DI
    ADD         SI,0x8
    CMP         AX,word [base_mem + 0xdbc2]
    JG          .LAB_LOC_6
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    ADD         DI,0x8
    INC         word [base_mem + 0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    ADD         SI,0x8
    CMP         AX,word [base_mem + 0xdbc2]
    JG          .LAB_LOC_4
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX, word [base_mem + 0xe528]
    MOV         AX, word [base_mem + 0xe528]
    mk_addr     EBP, [DI]
    MOV         word [EBP + -0x2],AX
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         AX,word [base_mem + 0xdbc2]
    SUB         CX,word [base_mem + 0xdbc2]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbc2]
    mk_addr     EBP, [DI]
    MOV         word [EBP],CX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],AX
    POP         CX
    POP         AX
    MOV         BX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         DX,word [ye_old_lil_bep]
    CALL        FUN_1000_3f7a
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],AX
    ADD         DI,0x8
    INC         word [base_mem + 0xe528]
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    DEC         CX
    JZ          .LAB_LOC_2
    JMP         .LAB_LOC_1
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         CX,word [base_mem + 0xdbc2]
    JZ          .LAB_LOC_5
    SUB         AX,word [base_mem + 0xdbc2]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbc2]
    mk_addr     EBP, [DI]
    MOV         word [EBP],CX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],AX
    POP         CX
    POP         AX
    MOV         DX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         BX,word [ye_old_lil_bep]
    CALL        FUN_1000_3f7a
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],AX
    ADD         DI,0x8
    INC         word [base_mem + 0xe528]
.LAB_LOC_5:
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    ADD         SI,0x8
    CMP         AX,word [base_mem + 0xdbc2]
    JLE         .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_34a2:
                              ;XREF[1]:     1000:3100(c)
    PUSH        SI
    PUSH        DI
    MOV         word [base_mem + 0xe528],0x0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    POP         DI
    ADD         SI,0x8
    CMP         BX,word [base_mem + 0xdbbc]
    JL          .LAB_LOC_6
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    ADD         DI,0x8
    INC         word [base_mem + 0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    ADD         SI,0x8
    CMP         BX,word [base_mem + 0xdbbc]
    JL          .LAB_LOC_4
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX, word [base_mem + 0xe528]
    mk_addr     EBP, [DI]
    MOV         word [EBP + -0x2],AX
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [base_mem + 0xdbbc]
    SUB         CX,word [base_mem + 0xdbbc]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbbc]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],CX
    POP         CX
    POP         AX
    MOV         DX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         BX,word [ye_old_lil_bep]
    CALL        FUN_1000_3f7a
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],AX
    ADD         DI,0x8
    INC         word [base_mem + 0xe528]
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_1
    JMP         .LAB_LOC_2
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [base_mem + 0xdbbc]
    JZ          .LAB_LOC_5
    SUB         AX,word [base_mem + 0xdbbc]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbbc]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],CX
    POP         CX
    POP         AX
    MOV         BX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         DX,word [ye_old_lil_bep]
    CALL        FUN_1000_3f7a
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],AX
    ADD         DI,0x8
    INC         word [base_mem + 0xe528]
.LAB_LOC_5:
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    ADD         SI,0x8
    CMP         BX,word [base_mem + 0xdbbc]
    JGE         .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_35cf:
                              ;XREF[1]:     1000:3105(c)
    PUSH        SI
    PUSH        DI
    MOV         word [base_mem + 0xe528],0x0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    POP         DI
    ADD         SI,0x8
    CMP         BX,word [base_mem + 0xdbbe]
    JG          .LAB_LOC_6
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    ADD         DI,0x8
    INC         word [base_mem + 0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    ADD         SI,0x8
    CMP         BX,word [base_mem + 0xdbbe]
    JG          .LAB_LOC_4
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX, word [base_mem + 0xe528]
    mk_addr     EBP, [DI]
    MOV         word [EBP + -0x2],AX
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [base_mem + 0xdbbe]
    SUB         CX,word [base_mem + 0xdbbe]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbbe]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],CX
    POP         CX
    POP         AX
    MOV         BX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         DX,word [ye_old_lil_bep]
    CALL        FUN_1000_3f7a
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],AX
    ADD         DI,0x8
    INC         word [base_mem + 0xe528]
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    DEC         CX
    JZ          .LAB_LOC_2
    JMP         .LAB_LOC_1
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [base_mem + 0xdbbe]
    JZ          .LAB_LOC_5
    SUB         AX,word [base_mem + 0xdbbe]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbbe]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],CX
    POP         CX
    POP         AX
    MOV         DX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         BX,word [ye_old_lil_bep]
    CALL        FUN_1000_3f7a
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x4],AX
    ADD         DI,0x8
    INC         word [base_mem + 0xe528]
.LAB_LOC_5:
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    ADD         SI,0x8
    CMP         BX,word [base_mem + 0xdbbe]
    JLE         .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;ANALYSIS: related to textured polygons
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
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    CMP         CX,0x3
    JC          .LAB_LOC_3
    MOV         AX, word [base_mem + 0xdbbe]
    MOV         word [base_mem + 0xdbc4],AX
    MOV         AX, word [base_mem + 0xdbbc]
    MOV         word [base_mem + 0xdbc6],AX
    PUSH        SI
    DEC         CX
.LAB_LOC_1:
    PUSH        CX
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x8]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0xa]
    CALL        FUN_1000_2c4b
    POP         SI
    POP         CX
    ADD         SI,0x8
    L_LOOP      .LAB_LOC_1
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    POP         SI
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x2]
    CALL        FUN_1000_2c4b
    MOV         SI,0xdb16
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    DEC         CX
.LAB_LOC_2:
    PUSH        CX
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x6]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0xc]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0xe]
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0xa]
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP + 0x2]
    CALL        FUN_1000_379b
    POP         SI
    POP         CX
    ADD         SI,0x8
    L_LOOP      .LAB_LOC_2
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x6]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x2]
    POP         SI
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x6]
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x2]
    MOV         SI,word [ye_old_lil_bep]
    CALL        FUN_1000_379b
    CALL        FUN_1000_3827
.LAB_LOC_3:
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
    JLE         .LAB_LOC_1
    XCHG        DI,SI
    XCHG        AX,CX
    XCHG        DX,BX
    SUB         DI,SI
    SHL         SI,0x2
    ADD         SI,0xdeea
    JMP         .LAB_LOC_2
.LAB_LOC_1:
    SUB         DI,SI
    SHL         SI,0x2
    ADD         SI,0xdee8
.LAB_LOC_2:
    TEST        DI,DI
    JZ          .LAB_LOC_4
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
.LAB_LOC_3:
    ROR         EAX,0x10
    ROR         EBX,0x10
    mk_addr     EBP, [SI]
    MOV         word [EBP],AX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x320],BX
    ADD         SI,0x4
    ROL         EAX,0x10
    ROL         EBX,0x10
    ADD         EAX,EDI
    ADD         EBX,EDX
    L_LOOP      .LAB_LOC_3
    ROR         EAX,0x10
    ROR         EBX,0x10
    mk_addr     EBP, [SI]
    MOV         word [EBP],AX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x320],BX
.LAB_LOC_4:
    POP         SI
    POP         DI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;ANALYSIS: seems to be related to rendering textured polygons, disabling it makes only flat polygons render, also it show a lot on the profiler
FUN_1000_3827:
                              ;XREF[1]:     1000:3795(c)
    MOV         SI,word [base_mem + 0xdbc4]
    MOV         DI,word [base_mem + 0xdbc6]
    SUB         DI,SI
    JZ          .LAB_LOC_5
    INC         DI
    SHL         SI,0x2
    PUSH        dword [ptr_seg_EeS]
    ld_seg      dword [ptr_seg_EeS], word [base_mem + 0xdb10]
.LAB_LOC_1:
    PUSH        DI
    MOV         DI,SI
    SHL         DI,0x2
    ADD         DI,SI
    SHL         DI,0x4
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0xdbc8]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0xdbca]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0xdee8]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0xdeea]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0xe208]
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP + 0xe20a]
    SUB         SI,word [ye_old_lil_bep]
    SUB         DX,BX
    SUB         CX,AX
    JNS         .LAB_LOC_2
    ADD         AX,CX
    NEG         CX
    ADD         BX,DX
    NEG         DX
    ADD         word [ye_old_lil_bep],SI
    NEG         SI
.LAB_LOC_2:
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
    movzx_m2m   dword [ye_old_bep],word [ye_old_lil_bep]
    SHL         EBX,0x8
    SHL         dword [ye_old_bep],0x8
    CLD
.LAB_LOC_3:
    ROR         EBX,0x10
    ROR         dword [ye_old_bep],0x10
    ROR         ESI,0x10
    MOV         SI,word [ye_old_lil_bep]
    SHL         SI,0x8
    mk_addr_seg EBP, ptr_seg_FeS, [BX + SI]
    MOV         AL,byte [EBP]
    CMP         AL,0xff
    JZ          .LAB_LOC_4
    CMP         AL,0xf0
    JNC         .LAB_LOC_6
    mk_addr_seg EBP, ptr_seg_EeS, [DI]
    MOV         byte [EBP],AL
.LAB_LOC_4:
    INC         DI
    ROL         ESI,0x10
    ROL         EBX,0x10
    ROL         dword [ye_old_bep],0x10
    ADD         EBX,ECX
    ADD         dword [ye_old_bep],EDX
    DEC         SI
    JNZ         .LAB_LOC_3
    POP         SI
    POP         DI
    ADD         SI,0x4
    DEC         DI
    JNZ         .LAB_LOC_1
    POP         dword [ptr_seg_EeS]
.LAB_LOC_5:
    RET
.LAB_LOC_6:
    SUB         AL,0xf0
    MOV         AH,AL
    mk_addr_seg EBP, ptr_seg_EeS, [DI]
    MOV         AL,byte [EBP]
    XCHG        AX,BX
    mk_addr     EBP, [BX]
    MOV         BL,byte [EBP + 0x2e51]
    XCHG        AX,BX
    mk_addr_seg EBP, ptr_seg_EeS, [DI]
    MOV         byte [EBP],AL
    JMP         .LAB_LOC_4
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;ANALYSIS: seems to also be related to rendering textured polygons
FUN_1000_390a:
                              ;XREF[1]:     1000:3706(c)
    PUSH        SI
    PUSH        DI
    MOV         word [base_mem + 0xe528],0x0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x6]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],DX
    POP         DI
    ADD         SI,0x8
    ROR         ESI,0x10
    MOV         SI,DI
    MOV         DI,DX
    CMP         AX,word [base_mem + 0xdbc0]
    JL          .LAB_LOC_6
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [SI]
    MOV         word [EBP],AX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [SI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],DI
    ADD         SI,0x8
    INC         word [base_mem + 0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         AX,word [base_mem + 0xdbc0]
    JL          .LAB_LOC_4
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX, word [base_mem + 0xe528]
    mk_addr     EBP, [DI]
    MOV         word [EBP + -0x2],AX
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    PUSH        DI
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         AX,word [base_mem + 0xdbc0]
    SUB         CX,word [base_mem + 0xdbc0]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbc0]
    mk_addr     EBP, [SI]
    MOV         word [EBP],CX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x2],AX
    POP         CX
    POP         AX
    MOV         DX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         BX,word [ye_old_lil_bep]
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x4],AX
    POP         CX
    POP         AX
    MOV         DX,DI
    ROR         EDI,0x10
    MOV         BX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],AX
    ADD         SI,0x8
    INC         word [base_mem + 0xe528]
    POP         DI
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    DEC         CX
    JNZ         .LAB_LOC_1
    JMP         .LAB_LOC_2
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    PUSH        DI
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         CX,word [base_mem + 0xdbc0]
    JZ          .LAB_LOC_5
    SUB         AX,word [base_mem + 0xdbc0]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbc0]
    mk_addr     EBP, [SI]
    MOV         word [EBP],CX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x2],AX
    POP         CX
    POP         AX
    MOV         BX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         DX,word [ye_old_lil_bep]
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x4],AX
    POP         CX
    POP         AX
    MOV         BX,DI
    ROR         EDI,0x10
    MOV         DX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],AX
    ADD         SI,0x8
    INC         word [base_mem + 0xe528]
.LAB_LOC_5:
    POP         DI
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         AX,word [base_mem + 0xdbc0]
    JGE         .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3aa3:
                              ;XREF[1]:     1000:370b(c)
    PUSH        SI
    PUSH        DI
    MOV         word [base_mem + 0xe528],0x0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x6]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],DX
    POP         DI
    ADD         SI,0x8
    ROR         ESI,0x10
    MOV         SI,DI
    MOV         DI,DX
    CMP         AX,word [base_mem + 0xdbc2]
    JG          .LAB_LOC_6
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [SI]
    MOV         word [EBP],AX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [SI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],DI
    ADD         SI,0x8
    INC         word [base_mem + 0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         AX,word [base_mem + 0xdbc2]
    JG          .LAB_LOC_4
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX, word [base_mem + 0xe528]
    mk_addr     EBP, [DI]
    MOV         word [EBP + -0x2],AX
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    PUSH        DI
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         AX,word [base_mem + 0xdbc2]
    SUB         CX,word [base_mem + 0xdbc2]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbc2]
    mk_addr     EBP, [SI]
    MOV         word [EBP],CX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x2],AX
    POP         CX
    POP         AX
    MOV         BX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         DX,word [ye_old_lil_bep]
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x4],AX
    POP         CX
    POP         AX
    MOV         BX,DI
    ROR         EDI,0x10
    MOV         DX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],AX
    ADD         SI,0x8
    INC         word [base_mem + 0xe528]
    POP         DI
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    DEC         CX
    JNZ         .LAB_LOC_1
    JMP         .LAB_LOC_2
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    PUSH        DI
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         CX,word [base_mem + 0xdbc2]
    JZ          .LAB_LOC_5
    SUB         AX,word [base_mem + 0xdbc2]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbc2]
    mk_addr     EBP, [SI]
    MOV         word [EBP],CX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x2],AX
    POP         CX
    POP         AX
    MOV         DX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         BX,word [ye_old_lil_bep]
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x4],AX
    POP         CX
    POP         AX
    MOV         DX,DI
    ROR         EDI,0x10
    MOV         BX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],AX
    ADD         SI,0x8
    INC         word [base_mem + 0xe528]
.LAB_LOC_5:
    POP         DI
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         AX,word [base_mem + 0xdbc2]
    JLE         .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3c3c:
                              ;XREF[1]:     1000:3710(c)
    PUSH        SI
    PUSH        DI
    MOV         word [base_mem + 0xe528],0x0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x6]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],DX
    POP         DI
    ADD         SI,0x8
    ROR         ESI,0x10
    MOV         SI,DI
    MOV         DI,DX
    CMP         BX,word [base_mem + 0xdbbc]
    JL          .LAB_LOC_6
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [SI]
    MOV         word [EBP],AX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [SI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],DI
    ADD         SI,0x8
    INC         word [base_mem + 0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         BX,word [base_mem + 0xdbbc]
    JL          .LAB_LOC_4
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX, word [base_mem + 0xe528]
    mk_addr     EBP, [DI]
    MOV         word [EBP + -0x2],AX
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    PUSH        DI
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [base_mem + 0xdbbc]
    SUB         CX,word [base_mem + 0xdbbc]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbbc]
    mk_addr     EBP, [SI]
    MOV         word [EBP],AX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x2],CX
    POP         CX
    POP         AX
    MOV         DX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         BX,word [ye_old_lil_bep]
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x4],AX
    POP         CX
    POP         AX
    MOV         DX,DI
    ROR         EDI,0x10
    MOV         BX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],AX
    ADD         SI,0x8
    INC         word [base_mem + 0xe528]
    POP         DI
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    DEC         CX
    JNZ         .LAB_LOC_1
    JMP         .LAB_LOC_2
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    PUSH        DI
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [base_mem + 0xdbbc]
    JZ          .LAB_LOC_5
    SUB         AX,word [base_mem + 0xdbbc]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbbc]
    mk_addr     EBP, [SI]
    MOV         word [EBP],AX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x2],CX
    POP         CX
    POP         AX
    MOV         BX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         DX,word [ye_old_lil_bep]
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x4],AX
    POP         CX
    POP         AX
    MOV         BX,DI
    ROR         EDI,0x10
    MOV         DX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],AX
    ADD         SI,0x8
    INC         word [base_mem + 0xe528]
.LAB_LOC_5:
    POP         DI
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         BX,word [base_mem + 0xdbbc]
    JGE         .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3ddb:
                              ;XREF[1]:     1000:3715(c)
    PUSH        SI
    PUSH        DI
    MOV         word [base_mem + 0xe528],0x0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x3
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x6]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x6],DX
    POP         DI
    ADD         SI,0x8
    ROR         ESI,0x10
    MOV         SI,DI
    MOV         DI,DX
    CMP         BX,word [base_mem + 0xdbbe]
    JG          .LAB_LOC_6
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [SI]
    MOV         word [EBP],AX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x2],BX
    mk_addr     EBP, [SI]
    mov_m2m     word [EBP + 0x4],word [ye_old_lil_bep]
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],DI
    ADD         SI,0x8
    INC         word [base_mem + 0xe528]
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         BX,word [base_mem + 0xdbbe]
    JG          .LAB_LOC_4
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX, word [base_mem + 0xe528]
    mk_addr     EBP, [DI]
    MOV         word [EBP + -0x2],AX
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    PUSH        DI
    ROR         EAX,0x10
    ROR         EBX,0x10
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [base_mem + 0xdbbe]
    SUB         CX,word [base_mem + 0xdbbe]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbbe]
    mk_addr     EBP, [SI]
    MOV         word [EBP],AX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x2],CX
    POP         CX
    POP         AX
    MOV         BX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         DX,word [ye_old_lil_bep]
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x4],AX
    POP         CX
    POP         AX
    MOV         BX,DI
    ROR         EDI,0x10
    MOV         DX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],AX
    ADD         SI,0x8
    INC         word [base_mem + 0xe528]
    POP         DI
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    DEC         CX
    JNZ         .LAB_LOC_1
    JMP         .LAB_LOC_2
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        word [ye_old_lil_bep]
    PUSH        DI
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [base_mem + 0xdbbe]
    JZ          .LAB_LOC_5
    SUB         AX,word [base_mem + 0xdbbe]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         CX,word [base_mem + 0xdbbe]
    mk_addr     EBP, [SI]
    MOV         word [EBP],AX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x2],CX
    POP         CX
    POP         AX
    MOV         DX,word [ye_old_lil_bep]
    ROR         dword [ye_old_bep],0x10
    MOV         BX,word [ye_old_lil_bep]
    PUSH        AX
    PUSH        CX
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x4],AX
    POP         CX
    POP         AX
    MOV         DX,DI
    ROR         EDI,0x10
    MOV         BX,DI
    SHR         DX,0x1
    SHR         BX,0x1
    CALL        FUN_1000_3f7a
    SHL         AX,0x1
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],AX
    ADD         SI,0x8
    INC         word [base_mem + 0xe528]
.LAB_LOC_5:
    POP         DI
    POP         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         dword [ye_old_bep],0x10
    SHL         EDI,0x10
    ROR         ESI,0x10
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    mov_m2m     word [ye_old_lil_bep],word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x6]
    ADD         SI,0x8
    ROR         ESI,0x10
    CMP         BX,word [base_mem + 0xdbbe]
    JLE         .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_6
    JMP         .LAB_LOC_2
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
    JZ          .LAB_LOC_1
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
.LAB_LOC_1:
    XCHG        AX,BX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3f98:
                              ;XREF[2]:     1000:1482(c),1000:59ad(c)
    CMP         AX,word [base_mem + 0xdbc0]
    JL          .LAB_LOC_1
    CMP         AX,word [base_mem + 0xdbc2]
    JG          .LAB_LOC_1
    CMP         BX,word [base_mem + 0xdbbc]
    JL          .LAB_LOC_1
    CMP         BX,word [base_mem + 0xdbbe]
    JG          .LAB_LOC_1
    PUSH        dword [ptr_seg_EeS]
    MOV         BH,BL
    XOR         BL,BL
    ADD         AX,BX
    SHR         BX,0x1
    SHR         BX,0x1
    ADD         BX,AX
    ld_seg      dword [ptr_seg_EeS], word [base_mem + 0xdb10]
    mk_addr_seg EBP, ptr_seg_EeS, [BX]
    MOV         byte [EBP],CL
    POP         dword [ptr_seg_EeS]
.LAB_LOC_1:
    RET

 ; 1000:3fcf [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3fd0:
                              ;XREF[1]:     1000:1981(c)
    MOV         word [base_mem + 0xe530],0x6
    MOV         BX,word [base_mem + 0x5f9]
    SAR         BX,0x6
    MOV         AX, word [base_mem + 0xac]
    SHR         AX,0x8
    ADD         AX,BX
    MOV         word [base_mem + 0xe53a],AX
    MOV         AX, word [base_mem + 0xb0]
    SHR         AX,0x8
    ADD         AX,BX
    MOV         word [base_mem + 0xe538],AX
    MOV         AX, word [base_mem + 0xac]
    SHR         AX,0x8
    SUB         AX,BX
    MOV         word [base_mem + 0xe532],AX
    MOV         BX,word [base_mem + 0x5f7]
    SAR         BX,0x6
    MOV         AX, word [base_mem + 0xb0]
    SHR         AX,0x8
    ADD         AX,BX
    MOV         word [base_mem + 0xe53c],AX
    MOV         AX, word [base_mem + 0xac]
    SHR         AX,0x8
    SUB         AX,BX
    MOV         word [base_mem + 0xe536],AX
    MOV         AX, word [base_mem + 0xb0]
    SHR         AX,0x8
    SUB         AX,BX
    MOV         word [base_mem + 0xe534],AX
    MOV         AX, word [base_mem + 0x5f9]
    IMUL        word [base_mem + 0x5f1]
    MOV         BX,AX
    MOV         AX, word [base_mem + 0x5f7]
    IMUL        word [base_mem + 0x5f3]
    MOV         CX,AX
    SUB         AX,BX
    MOV         DX,word [base_mem + 0xb0]
    SHR         DX,0x8
    SAR         AX,0x8
    ADD         AX,DX
    MOV         word [base_mem + 0xe540],AX
    MOV         AX,CX
    NEG         AX
    SUB         AX,BX
    MOV         DX,word [base_mem + 0xb0]
    SHR         DX,0x8
    SAR         AX,0x8
    ADD         AX,DX
    MOV         word [base_mem + 0xe548],AX
    MOV         AX, word [base_mem + 0x5f9]
    IMUL        word [base_mem + 0x5f3]
    MOV         CX,AX
    MOV         AX, word [base_mem + 0x5f7]
    IMUL        word [base_mem + 0x5f1]
    MOV         BX,AX
    MOV         AX,CX
    ADD         AX,BX
    SAR         AX,0x8
    MOV         DX,word [base_mem + 0xac]
    SHR         DX,0x8
    ADD         AX,DX
    MOV         word [base_mem + 0xe53e],AX
    MOV         AX,BX
    SUB         AX,CX
    MOV         DX,word [base_mem + 0xac]
    SHR         DX,0x8
    SAR         AX,0x8
    ADD         AX,DX
    MOV         word [base_mem + 0xe546],AX
    MOV         AX, word [base_mem + 0x5ef]
    IMUL        word [base_mem + 0x5f9]
    MOV         BX,AX
    MOV         AX, word [base_mem + 0x5ef]
    IMUL        word [base_mem + 0x5f7]
    MOV         CX,AX
    MOV         AX, word [base_mem + 0xac]
    SHR         AX,0x8
    SAR         CX,0x8
    ADD         AX,CX
    MOV         word [base_mem + 0xe542],AX
    MOV         AX, word [base_mem + 0xb0]
    SHR         AX,0x8
    SAR         BX,0x8
    SUB         AX,BX
    MOV         word [base_mem + 0xe544],AX
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
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    CMP         CX,0x3
    JC          .LAB_LOC_2
    MOV         AX, word [base_mem + 0xe586]
    MOV         word [base_mem + 0xe58c],AX
    MOV         AX, word [base_mem + 0xe584]
    MOV         word [base_mem + 0xe58e],AX
    PUSH        SI
    DEC         CX
.LAB_LOC_1:
    PUSH        CX
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x6]
    CALL        FUN_1000_4120
    POP         SI
    POP         CX
    ADD         SI,0x4
    L_LOOP      .LAB_LOC_1
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    POP         SI
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x2]
    CALL        FUN_1000_4120
.LAB_LOC_2:
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4120:
                              ;XREF[2]:     1000:4107(c),1000:411c(c)
    XCHG        DX,CX
    CMP         BX,CX
    JLE         .LAB_LOC_3
    XCHG        AX,DX
    XCHG        CX,BX
    CMP         BX,word [base_mem + 0xe58c]
    JGE         .LAB_LOC_1
    MOV         word [base_mem + 0xe58c],BX
.LAB_LOC_1:
    CMP         CX,word [base_mem + 0xe58e]
    JLE         .LAB_LOC_2
    MOV         word [base_mem + 0xe58e],CX
.LAB_LOC_2:
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0x2
    JMP         .LAB_LOC_6
.LAB_LOC_3:
    CMP         BX,word [base_mem + 0xe58c]
    JGE         .LAB_LOC_4
    MOV         word [base_mem + 0xe58c],BX
.LAB_LOC_4:
    CMP         CX,word [base_mem + 0xe58e]
    JLE         .LAB_LOC_5
    MOV         word [base_mem + 0xe58e],CX
.LAB_LOC_5:
    SUB         CX,BX
    SHL         BX,0x2
.LAB_LOC_6:
    L_JCXZ      .LAB_LOC_14
    PUSH        DX
    SUB         DX,AX
    JS          .LAB_LOC_10
    XOR         DI,DI
    MOV         SI,CX
.LAB_LOC_7:
    mk_addr     EBP, [BX]
    MOV         word [EBP + 0xe590],AX
    ADD         BX,0x4
    SUB         DI,DX
    JNS         .LAB_LOC_9
.LAB_LOC_8:
    INC         AX
    ADD         DI,SI
    JS          .LAB_LOC_8
.LAB_LOC_9:
    L_LOOP      .LAB_LOC_7
    POP         AX
    mk_addr     EBP, [BX]
    MOV         word [EBP + 0xe590],AX
    RET
.LAB_LOC_10:
    NEG         DX
    XOR         DI,DI
    MOV         SI,CX
.LAB_LOC_11:
    mk_addr     EBP, [BX]
    MOV         word [EBP + 0xe590],AX
    ADD         BX,0x4
    SUB         DI,DX
    JNS         .LAB_LOC_13
.LAB_LOC_12:
    DEC         AX
    ADD         DI,SI
    JS          .LAB_LOC_12
.LAB_LOC_13:
    L_LOOP      .LAB_LOC_11
    POP         AX
    mk_addr     EBP, [BX]
    MOV         word [EBP + 0xe590],AX
    RET
.LAB_LOC_14:
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_41b2:
                              ;XREF[1]:     1000:1f94(c)
    MOV         word [base_mem + 0xe530],0x6
    MOV         BX,word [base_mem + 0x5f9]
    SAR         BX,0x6
    MOV         AX, word [base_mem + 0xac]
    SHR         AX,0x8
    ADD         AX,BX
    MOV         word [base_mem + 0xe53c],AX
    MOV         AX, word [base_mem + 0xb0]
    SHR         AX,0x8
    ADD         AX,BX
    MOV         word [base_mem + 0xe536],AX
    MOV         AX, word [base_mem + 0xac]
    SHR         AX,0x8
    SUB         AX,BX
    MOV         word [base_mem + 0xe534],AX
    MOV         BX,word [base_mem + 0x5f7]
    SAR         BX,0x6
    MOV         AX, word [base_mem + 0xb0]
    SHR         AX,0x8
    ADD         AX,BX
    MOV         word [base_mem + 0xe53a],AX
    MOV         AX, word [base_mem + 0xac]
    SHR         AX,0x8
    SUB         AX,BX
    MOV         word [base_mem + 0xe538],AX
    MOV         AX, word [base_mem + 0xb0]
    SHR         AX,0x8
    SUB         AX,BX
    MOV         word [base_mem + 0xe532],AX
    MOV         AX, word [base_mem + 0x5f9]
    IMUL        word [base_mem + 0x5f1]
    MOV         BX,AX
    MOV         AX, word [base_mem + 0x5f7]
    IMUL        word [base_mem + 0x5f3]
    MOV         CX,AX
    SUB         AX,BX
    MOV         DX,word [base_mem + 0xb0]
    SHR         DX,0x8
    SAR         AX,0x8
    ADD         AX,DX
    MOV         word [base_mem + 0xe53e],AX
    MOV         AX,CX
    NEG         AX
    SUB         AX,BX
    MOV         DX,word [base_mem + 0xb0]
    SHR         DX,0x8
    SAR         AX,0x8
    ADD         AX,DX
    MOV         word [base_mem + 0xe546],AX
    MOV         AX, word [base_mem + 0x5f9]
    IMUL        word [base_mem + 0x5f3]
    MOV         CX,AX
    MOV         AX, word [base_mem + 0x5f7]
    IMUL        word [base_mem + 0x5f1]
    MOV         BX,AX
    MOV         AX,CX
    ADD         AX,BX
    SAR         AX,0x8
    MOV         DX,word [base_mem + 0xac]
    SHR         DX,0x8
    ADD         AX,DX
    MOV         word [base_mem + 0xe540],AX
    MOV         AX,BX
    SUB         AX,CX
    MOV         DX,word [base_mem + 0xac]
    SHR         DX,0x8
    SAR         AX,0x8
    ADD         AX,DX
    MOV         word [base_mem + 0xe548],AX
    MOV         AX, word [base_mem + 0x5ef]
    IMUL        word [base_mem + 0x5f9]
    MOV         BX,AX
    MOV         AX, word [base_mem + 0x5ef]
    IMUL        word [base_mem + 0x5f7]
    MOV         CX,AX
    MOV         AX, word [base_mem + 0xac]
    SHR         AX,0x8
    SAR         CX,0x8
    ADD         AX,CX
    MOV         word [base_mem + 0xe544],AX
    MOV         AX, word [base_mem + 0xb0]
    SHR         AX,0x8
    SAR         BX,0x8
    SUB         AX,BX
    MOV         word [base_mem + 0xe542],AX
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
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    CMP         CX,0x3
    JC          .LAB_LOC_2
    MOV         AX, word [base_mem + 0xe586]
    MOV         word [base_mem + 0xe58c],AX
    MOV         AX, word [base_mem + 0xe584]
    MOV         word [base_mem + 0xe58e],AX
    PUSH        SI
    DEC         CX
.LAB_LOC_1:
    PUSH        CX
    PUSH        SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x6]
    CALL        FUN_1000_4302
    POP         SI
    POP         CX
    ADD         SI,0x4
    L_LOOP      .LAB_LOC_1
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    POP         SI
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x2]
    CALL        FUN_1000_4302
.LAB_LOC_2:
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4302:
                              ;XREF[2]:     1000:42e9(c),1000:42fe(c)
    XCHG        DX,CX
    CMP         BX,CX
    JLE         .LAB_LOC_3
    XCHG        AX,DX
    XCHG        CX,BX
    CMP         BX,word [base_mem + 0xe58c]
    JGE         .LAB_LOC_1
    MOV         word [base_mem + 0xe58c],BX
.LAB_LOC_1:
    CMP         CX,word [base_mem + 0xe58e]
    JLE         .LAB_LOC_2
    MOV         word [base_mem + 0xe58e],CX
.LAB_LOC_2:
    SUB         CX,BX
    SHL         BX,0x2
    JMP         .LAB_LOC_6
.LAB_LOC_3:
    CMP         BX,word [base_mem + 0xe58c]
    JGE         .LAB_LOC_4
    MOV         word [base_mem + 0xe58c],BX
.LAB_LOC_4:
    CMP         CX,word [base_mem + 0xe58e]
    JLE         .LAB_LOC_5
    MOV         word [base_mem + 0xe58e],CX
.LAB_LOC_5:
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0x2
.LAB_LOC_6:
    L_JCXZ      .LAB_LOC_14
    PUSH        DX
    SUB         DX,AX
    JS          .LAB_LOC_10
    XOR         DI,DI
    MOV         SI,CX
.LAB_LOC_7:
    mk_addr     EBP, [BX]
    MOV         word [EBP + 0xe590],AX
    ADD         BX,0x4
    SUB         DI,DX
    JNS         .LAB_LOC_9
.LAB_LOC_8:
    INC         AX
    ADD         DI,SI
    JS          .LAB_LOC_8
.LAB_LOC_9:
    L_LOOP      .LAB_LOC_7
    POP         AX
    mk_addr     EBP, [BX]
    MOV         word [EBP + 0xe590],AX
    RET
.LAB_LOC_10:
    NEG         DX
    XOR         DI,DI
    MOV         SI,CX
.LAB_LOC_11:
    mk_addr     EBP, [BX]
    MOV         word [EBP + 0xe590],AX
    ADD         BX,0x4
    SUB         DI,DX
    JNS         .LAB_LOC_13
.LAB_LOC_12:
    DEC         AX
    ADD         DI,SI
    JS          .LAB_LOC_12
.LAB_LOC_13:
    L_LOOP      .LAB_LOC_11
    POP         AX
    mk_addr     EBP, [BX]
    MOV         word [EBP + 0xe590],AX
    RET
.LAB_LOC_14:
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4394:
                              ;XREF[2]:     1000:40ce(c),1000:42b0(c)
    PUSH        SI
    PUSH        DI
    MOV         word [ye_old_lil_bep], 0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x2
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    POP         DI
    ADD         SI,0x4
    CMP         AX,word [base_mem + 0xe588]
    JL          .LAB_LOC_5
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x4
    INC         word [ye_old_lil_bep]
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x4
    CMP         AX,word [base_mem + 0xe588]
    JL          .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    SUB         AX,word [base_mem + 0xe588]
    SUB         CX,word [base_mem + 0xe588]
    CALL        FUN_1000_4680
    MOV         BX,AX
    MOV         AX, word [base_mem + 0xe588]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x4
    INC         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_5
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    SUB         AX,word [base_mem + 0xe588]
    SUB         CX,word [base_mem + 0xe588]
    CALL        FUN_1000_4680
    MOV         BX,AX
    MOV         AX, word [base_mem + 0xe588]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x4
    INC         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_1
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_5:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x4
    CMP         AX,word [base_mem + 0xe588]
    JGE         .LAB_LOC_4
    POP         CX
    L_LOOP      .LAB_LOC_5
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_444d:
                              ;XREF[2]:     1000:40d3(c),1000:42b5(c)
    PUSH        SI
    PUSH        DI
    MOV         word [ye_old_lil_bep], 0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x2
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    POP         DI
    ADD         SI,0x4
    CMP         AX,word [base_mem + 0xe58a]
    JG          .LAB_LOC_5
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x4
    INC         word [ye_old_lil_bep]
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x4
    CMP         AX,word [base_mem + 0xe58a]
    JG          .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    SUB         AX,word [base_mem + 0xe58a]
    SUB         CX,word [base_mem + 0xe58a]
    CALL        FUN_1000_4680
    MOV         BX,AX
    MOV         AX, word [base_mem + 0xe58a]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x4
    INC         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_5
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    SUB         AX,word [base_mem + 0xe58a]
    SUB         CX,word [base_mem + 0xe58a]
    CALL        FUN_1000_4680
    MOV         BX,AX
    MOV         AX, word [base_mem + 0xe58a]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x4
    INC         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_1
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_5:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x4
    CMP         AX,word [base_mem + 0xe58a]
    JLE         .LAB_LOC_4
    POP         CX
    L_LOOP      .LAB_LOC_5
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4506:
                              ;XREF[2]:     1000:40d8(c),1000:42ba(c)
    PUSH        SI
    PUSH        DI
    MOV         word [ye_old_lil_bep], 0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x2
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    POP         DI
    ADD         SI,0x4
    CMP         BX,word [base_mem + 0xe584]
    JL          .LAB_LOC_5
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x4
    INC         word [ye_old_lil_bep]
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x4
    CMP         BX,word [base_mem + 0xe584]
    JL          .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [base_mem + 0xe584]
    SUB         CX,word [base_mem + 0xe584]
    CALL        FUN_1000_4680
    MOV         BX,word [base_mem + 0xe584]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x4
    INC         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_5
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [base_mem + 0xe584]
    SUB         CX,word [base_mem + 0xe584]
    CALL        FUN_1000_4680
    MOV         BX,word [base_mem + 0xe584]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x4
    INC         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_1
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_5:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x4
    CMP         BX,word [base_mem + 0xe584]
    JGE         .LAB_LOC_4
    POP         CX
    L_LOOP      .LAB_LOC_5
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_45c3:
                              ;XREF[2]:     1000:40dd(c),1000:42bf(c)
    PUSH        SI
    PUSH        DI
    MOV         word [ye_old_lil_bep], 0
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP + -0x2]
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,CX
    SHL         DI,0x2
    ADD         DI,SI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    POP         DI
    ADD         SI,0x4
    CMP         BX,word [base_mem + 0xe586]
    JG          .LAB_LOC_5
.LAB_LOC_1:
    PUSH        CX
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x4
    INC         word [ye_old_lil_bep]
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x4
    CMP         BX,word [base_mem + 0xe586]
    JG          .LAB_LOC_3
    POP         CX
    L_LOOP      .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [base_mem + 0xe586]
    SUB         CX,word [base_mem + 0xe586]
    CALL        FUN_1000_4680
    MOV         BX,word [base_mem + 0xe586]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x4
    INC         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_5
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         AX,word [base_mem + 0xe586]
    SUB         CX,word [base_mem + 0xe586]
    CALL        FUN_1000_4680
    MOV         BX,word [base_mem + 0xe586]
    mk_addr     EBP, [DI]
    MOV         word [EBP],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0x2],BX
    ADD         DI,0x4
    INC         word [ye_old_lil_bep]
    POP         BX
    POP         AX
    POP         CX
    L_LOOP      .LAB_LOC_1
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
.LAB_LOC_5:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x2]
    ADD         SI,0x4
    CMP         BX,word [base_mem + 0xe586]
    JLE         .LAB_LOC_4
    POP         CX
    L_LOOP      .LAB_LOC_5
    POP         DI
    POP         SI
    mk_addr     EBP, [DI]
    mov_m2m     word [EBP + -0x2],word [ye_old_lil_bep]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4680:
                              ;XREF[8]:     1000:43ec(c),1000:4415(c),1000:44a8(c),1000:44ce(c),
                              ;             1000:4561(c),1000:458c(c),1000:4621(c),1000:4649(c)
    CMP         BX,DX
    JZ          .LAB_LOC_1
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
.LAB_LOC_1:
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
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x2]
    SUB         AX,word [base_mem + 0x120]
    MOV         word [base_mem + 0xe992],AX
    JL          .LAB_LOC_1
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x6]
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0xdb16],EAX
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0xdb1a],EBX
    ADD         DI,0x8
.LAB_LOC_1:
    MOV         word [base_mem + 0xe996],DI
    POP         DI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    MOV         word [base_mem + 0xe990],AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x4]
    MOV         word [base_mem + 0xe994],AX
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
    MOV         dword [ye_old_bep],EBX
    MOV         CX,word [base_mem + 0xe992]
    TEST        CX,CX
    JL          .LAB_LOC_3
    PUSH        DI
    MOV         DI,word [base_mem + 0xe996]
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x2]
    SUB         AX,word [base_mem + 0x120]
    JL          .LAB_LOC_1
    MOV         word [base_mem + 0xe992],AX
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x6]
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0xdb16],EAX
    mk_addr     EBP, [DI]
    mov_m2m     dword [EBP + 0xdb1a],dword [ye_old_bep]
    ADD         DI,0x8
    MOV         word [base_mem + 0xe996],DI
    POP         DI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    MOV         word [base_mem + 0xe990],AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x4]
    MOV         word [base_mem + 0xe994],AX
    RET
.LAB_LOC_1:
    PUSH        AX
    L_JCXZ      .LAB_LOC_2
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP]
    MOV         DX,word [base_mem + 0xe990]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    POP         CX
    POP         AX
    PUSH        BX
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x4]
    MOV         DX,word [base_mem + 0xe994]
    CALL        FUN_1000_3f7a
    MOV         CX,AX
    POP         AX
    MOV         BX,word [base_mem + 0x120]
    CALL        FUN_1000_2760
    ADD         AX,0xa0
    NEG         BX
    ADD         BX,0x64
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xdb16],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xdb18],BX
    mk_addr     EBP, [DI]
    mov_m2m     dword [EBP + 0xdb1a],dword [ye_old_bep]
    ADD         DI,0x8
.LAB_LOC_2:
    POP         word [base_mem + 0xe992]
    MOV         word [base_mem + 0xe996],DI
    POP         DI
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    MOV         word [base_mem + 0xe990],AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x4]
    MOV         word [base_mem + 0xe994],AX
    RET
.LAB_LOC_3:
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x2]
    SUB         AX,word [base_mem + 0x120]
    JGE         .LAB_LOC_4
    MOV         word [base_mem + 0xe992],AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    MOV         word [base_mem + 0xe990],AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x4]
    MOV         word [base_mem + 0xe994],AX
    RET
.LAB_LOC_4:
    PUSH        AX
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP]
    MOV         BX,word [base_mem + 0xe990]
    XCHG        AX,CX
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    POP         CX
    POP         AX
    PUSH        BX
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x4]
    MOV         BX,word [base_mem + 0xe994]
    CALL        FUN_1000_3f7a
    MOV         CX,AX
    POP         AX
    MOV         BX,word [base_mem + 0x120]
    CALL        FUN_1000_2760
    ADD         AX,0xa0
    NEG         BX
    ADD         BX,0x64
    PUSH        DI
    MOV         DI,word [base_mem + 0xe996]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xdb16],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xdb18],BX
    mk_addr     EBP, [DI]
    mov_m2m     dword [EBP + 0xdb1a],dword [ye_old_bep]
    ADD         DI,0x8
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x6]
    mk_addr     EBP, [DI]
    MOV         dword [EBP + 0xdb16],EAX
    mk_addr     EBP, [DI]
    mov_m2m     dword [EBP + 0xdb1a],dword [ye_old_bep]
    ADD         DI,0x8
    MOV         word [base_mem + 0xe996],DI
    POP         DI
    POP         word [base_mem + 0xe992]
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    MOV         word [base_mem + 0xe990],AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x4]
    MOV         word [base_mem + 0xe994],AX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_47ec:
                              ;XREF[13]:    1000:1500(c),1000:1559(c),1000:15d0(c),1000:165c(c),
                              ;             1000:16d2(c),1000:1d14(c),1000:1d40(c),1000:1dc8(c),
                              ;             1000:1e21(c),1000:1e70(c),1000:1e99(c),1000:1f1c(c),
                              ;             1000:1f75(c)
    MOV         dword [ye_old_bep],EBX
    MOV         CX,word [base_mem + 0xe992]
    TEST        CX,CX
    JL          .LAB_LOC_3
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x2]
    SUB         AX,word [base_mem + 0x120]
    JL          .LAB_LOC_1
    MOV         AX, word [base_mem + 0xe996]
    SHR         AX,0x3
    MOV         word [base_mem + 0xdb14],AX
    RET
.LAB_LOC_1:
    L_JCXZ      .LAB_LOC_2
    PUSH        DI
    MOV         DI,word [base_mem + 0xe996]
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP]
    MOV         DX,word [base_mem + 0xe990]
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    POP         CX
    POP         AX
    PUSH        BX
    mk_addr     EBP, [SI]
    MOV         BX,word [EBP + 0x4]
    MOV         DX,word [base_mem + 0xe994]
    CALL        FUN_1000_3f7a
    MOV         CX,AX
    POP         AX
    MOV         BX,word [base_mem + 0x120]
    CALL        FUN_1000_2760
    ADD         AX,0xa0
    NEG         BX
    ADD         BX,0x64
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xdb16],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xdb18],BX
    mk_addr     EBP, [DI]
    mov_m2m     dword [EBP + 0xdb1a],dword [ye_old_bep]
    ADD         DI,0x8
    MOV         word [base_mem + 0xe996],DI
    POP         DI
.LAB_LOC_2:
    MOV         AX, word [base_mem + 0xe996]
    SHR         AX,0x3
    MOV         word [base_mem + 0xdb14],AX
    RET
.LAB_LOC_3:
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x2]
    SUB         AX,word [base_mem + 0x120]
    JGE         .LAB_LOC_4
    MOV         AX, word [base_mem + 0xe996]
    SHR         AX,0x3
    MOV         word [base_mem + 0xdb14],AX
    RET
.LAB_LOC_4:
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP]
    MOV         BX,word [base_mem + 0xe990]
    XCHG        AX,CX
    PUSH        AX
    PUSH        CX
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    POP         CX
    POP         AX
    PUSH        BX
    mk_addr     EBP, [SI]
    MOV         DX,word [EBP + 0x4]
    MOV         BX,word [base_mem + 0xe994]
    CALL        FUN_1000_3f7a
    MOV         CX,AX
    POP         AX
    MOV         BX,word [base_mem + 0x120]
    CALL        FUN_1000_2760
    ADD         AX,0xa0
    NEG         BX
    ADD         BX,0x64
    PUSH        DI
    MOV         DI,word [base_mem + 0xe996]
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xdb16],AX
    mk_addr     EBP, [DI]
    MOV         word [EBP + 0xdb18],BX
    mk_addr     EBP, [DI]
    mov_m2m     dword [EBP + 0xdb1a],dword [ye_old_bep]
    ADD         DI,0x8
    MOV         word [base_mem + 0xe996],DI
    MOV         AX,DI
    POP         DI
    SHR         AX,0x3
    MOV         word [base_mem + 0xdb14],AX
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
    mk_addr     EBP, [SI]
    ADD         DI,word [EBP]
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP]
    MOV         word [base_mem + 0xe9d4],AX
    MOV         word [base_mem + 0xe9d6],0x0
    ADD         DI,0x2
.LAB_LOC_1:
    MOV         EAX, dword [base_mem + 0x6a]
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0x14],EAX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP]
    mk_addr     EBP, [DI]
    MOV         EBX,dword [EBP + 0x4]
    mk_addr     EBP, [DI]
    MOV         ECX,dword [EBP + 0x8]
    SHR         EAX,0x10
    SHR         EBX,0x10
    SHR         ECX,0x10
    PUSH        CX
    CALL        FUN_1000_532e
    POP         CX
    mk_addr     EBP, [DI]
    ADD         AX,word [EBP + 0x18]
    MOV         word [base_mem + 0xe9c6],AX
    CMP         AX,CX
    JNS         .LAB_LOC_11
.LAB_LOC_2:
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    SUB         AX,word [EBP + 0x18]
    CMP         AX,0x80
    JC          .LAB_LOC_7
.LAB_LOC_3:
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x6]
    mk_addr     EBP, [DI]
    SUB         AX,word [EBP + 0x18]
    CMP         AX,0x80
    JC          .LAB_LOC_8
.LAB_LOC_4:
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    ADD         AX,word [EBP + 0x18]
    CMP         AX,0xfe80
    JA          .LAB_LOC_9
.LAB_LOC_5:
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x6]
    mk_addr     EBP, [DI]
    ADD         AX,word [EBP + 0x18]
    CMP         AX,0xfe80
    JA          .LAB_LOC_10
.LAB_LOC_6:
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0xc]
    mk_addr     EBP, [DI]
    MOV         EBX,dword [EBP + 0x10]
    mk_addr     EBP, [DI]
    MOV         ECX,dword [EBP + 0x14]
    mk_addr     EBP, [DI]
    ADD         dword [EBP],EAX
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0x4],EBX
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0x8],ECX
    ADD         DI,0x1c
    INC         word [base_mem + 0xe9d6]
    DEC         word [base_mem + 0xe9d4]
    JNZ         .LAB_LOC_1
    CALL        FUN_1000_1003
    RET
.LAB_LOC_7:
    MOV         word [base_mem + 0xe9a2],0x8000
    MOV         word [base_mem + 0xe9a6],0x0
    MOV         word [base_mem + 0xe9aa],0x0
    MOV         word [base_mem + 0xe9ae],0x7f00
    MOV         byte [base_mem + 0xea28],0x0
    CALL        FUN_1000_4a71
    JMP         .LAB_LOC_3
.LAB_LOC_8:
    MOV         word [base_mem + 0xe9a2],0x0
    MOV         word [base_mem + 0xe9a6],0x7fff
    MOV         word [base_mem + 0xe9aa],0x8000
    MOV         word [base_mem + 0xe9ae],0x0
    MOV         byte [base_mem + 0xea28],0x0
    CALL        FUN_1000_4a71
    JMP         .LAB_LOC_4
.LAB_LOC_9:
    MOV         word [base_mem + 0xe9a2],0x7fff
    MOV         word [base_mem + 0xe9a6],0x0
    MOV         word [base_mem + 0xe9aa],0x0
    MOV         word [base_mem + 0xe9ae],0x7fff
    MOV         byte [base_mem + 0xea28],0x0
    CALL        FUN_1000_4a71
    JMP         .LAB_LOC_5
.LAB_LOC_10:
    MOV         word [base_mem + 0xe9a2],0x0
    MOV         word [base_mem + 0xe9a6],0x7fff
    MOV         word [base_mem + 0xe9aa],0x7fff
    MOV         word [base_mem + 0xe9ae],0x0
    MOV         byte [base_mem + 0xea28],0x0
    CALL        FUN_1000_4a71
    JMP         .LAB_LOC_6
.LAB_LOC_11:
    MOVZX       BX,byte [base_mem + 0xea28]
    SHR         BX,0x4
    mk_addr     EBP, [BX]
    MOVZX       CX,byte [EBP + 0xea49]
    L_JCXZ      .LAB_LOC_12
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0xc]
    SAR         EAX,CL
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0xc],EAX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x10]
    SAR         EAX,CL
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0x10],EAX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x14]
    SAR         EAX,CL
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0x14],EAX
.LAB_LOC_12:
    MOV         AX, word [base_mem + 0xea24]
    MOV         BX,0x100
    CALL        FUN_1000_2b08
    MOV         BX,AX
    CALL        FUN_1000_2aad
    MOV         word [base_mem + 0xe9a2],AX
    CALL        FUN_1000_2ad8
    MOV         word [base_mem + 0xe9a6],AX
    MOV         AX, word [base_mem + 0xea26]
    MOV         BX,0x100
    CALL        FUN_1000_2b08
    MOV         BX,AX
    CALL        FUN_1000_2aad
    MOV         word [base_mem + 0xe9aa],AX
    CALL        FUN_1000_2ad8
    MOV         word [base_mem + 0xe9ae],AX
    CALL        FUN_1000_4a71
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4a71:
                              ;XREF[5]:     1000:499c(c),1000:49bf(c),1000:49e3(c),1000:4a07(c),
                              ;             1000:4a6b(c)
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x14]
    IMUL        dword [base_mem + 0xe9a4]
    SHL         EDX,0x1
    MOV         EAX,EDX
    IMUL        dword [base_mem + 0xe9ac]
    SHL         EDX,0x1
    MOV         EBX,EDX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0xc]
    IMUL        dword [base_mem + 0xe9a0]
    SHL         EDX,0x1
    SUB         EBX,EDX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x10]
    IMUL        dword [base_mem + 0xe9a8]
    SHL         EDX,0x1
    SUB         EBX,EDX
    JNS         .LAB_LOC_3
    MOV         dword [base_mem + 0xe9c8],EBX
    CMP         EBX,0xfffa0000
    JG          .LAB_LOC_1
    XOR         AX,AX
    CALL        FUN_1000_5864
.LAB_LOC_1:
    MOV         ECX,dword [base_mem + 0xe9c8]
    MOV         EAX,ECX
    SAR         EAX,0x2
    ADD         ECX,EAX
    MOV         EAX, dword [base_mem + 0xe9a0]
    IMUL        ECX
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0xc],EDX
    SHL         EDX,0x1
    mk_addr     EBP, [DI]
    ADD         dword [EBP],EDX
    MOV         EAX, dword [base_mem + 0xe9a8]
    IMUL        ECX
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0x10],EDX
    SHL         EDX,0x1
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0x4],EDX
    MOV         EAX,ECX
    IMUL        dword [base_mem + 0xe9a4]
    SHL         EDX,0x1
    MOV         EAX,EDX
    IMUL        dword [base_mem + 0xe9ac]
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0x14],EDX
    SHL         EDX,0x1
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0x8],EDX
    mk_addr     EBP, [DI]
    MOV         AX,word [EBP + 0x1a]
    CMP         AX,0x0
    JZ          .LAB_LOC_5
    CMP         AX,0xffff
    JZ          .LAB_LOC_4
    JMP         .LAB_LOC_2

 ; 1000:4b25 [UNDEFINED BYTES REMOVED]

.LAB_LOC_2:
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0xc]
    IMUL        dword [base_mem + 0xe9a4]
    SHL         EDX,0x1
    MOV         EBX,EDX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x14]
    IMUL        dword [base_mem + 0xe9a0]
    SHL         EDX,0x1
    ADD         EBX,EDX
    MOV         dword [base_mem + 0xe9cc],EBX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x10]
    IMUL        dword [base_mem + 0xe9ac]
    SHL         EDX,0x1
    MOV         EBX,EDX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x14]
    IMUL        dword [base_mem + 0xe9a8]
    SHL         EDX,0x1
    ADD         EBX,EDX
    MOV         dword [base_mem + 0xe9d0],EBX
    MOV         AX, word [base_mem + 0xe9d6]
    CALL        FUN_1000_0e69
    MOV         dword [base_mem + 0xe9b0],EAX
    MOV         dword [base_mem + 0xe9b4],EBX
    MOV         dword [base_mem + 0xe9b8],ECX
    NEG         EDX
    MOV         dword [base_mem + 0xe9da],EDX
    CALL        FUN_1000_4c26
    MOV         word [base_mem + 0xe9bc],AX
    MOV         BX,AX
    CALL        FUN_1000_2ad8
    SHL         EAX,0x10
    MOV         dword [base_mem + 0xe9c2],EAX
    CALL        FUN_1000_2aad
    SHL         EAX,0x10
    MOV         dword [base_mem + 0xe9be],EAX
    MOV         EAX, dword [base_mem + 0xe9da]
    SHL         EAX,0x1
    MOV         EBX,EAX
    IMUL        dword [base_mem + 0xe9be]
    ADD         dword [base_mem + 0xe9cc],EDX
    MOV         EAX,EBX
    IMUL        dword [base_mem + 0xe9c2]
    SUB         dword [base_mem + 0xe9d0],EDX
    CALL        FUN_1000_4d0e
    MOV         EBX,dword [base_mem + 0xe9da]
    NEG         EBX
    MOV         AX, word [base_mem + 0xe9d6]
    CALL        FUN_1000_0f67
.LAB_LOC_3:
    RET
.LAB_LOC_4:
    JMP         .LAB_LOC_5

 ; 1000:4bdb [UNDEFINED BYTES REMOVED]

.LAB_LOC_5:
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0xc]
    IMUL        dword [base_mem + 0xe9a4]
    SHL         EDX,0x1
    MOV         EBX,EDX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x14]
    IMUL        dword [base_mem + 0xe9a0]
    SHL         EDX,0x1
    ADD         EBX,EDX
    MOV         dword [base_mem + 0xe9cc],EBX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x10]
    IMUL        dword [base_mem + 0xe9ac]
    SHL         EDX,0x1
    MOV         EBX,EDX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x14]
    IMUL        dword [base_mem + 0xe9a8]
    SHL         EDX,0x1
    ADD         EBX,EDX
    MOV         dword [base_mem + 0xe9d0],EBX
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
    IMUL        dword [base_mem + 0xe9a4]
    MOV         BX,DX
    NEG         BX
    POP         EAX
    SAR         EAX,0x4
    IMUL        dword [base_mem + 0xe9a0]
    SUB         BX,DX
    MOV         CX,BX
    POP         EAX
    SAR         EAX,0x4
    IMUL        dword [base_mem + 0xe9ac]
    MOV         BX,DX
    POP         EAX
    SAR         EAX,0x4
    IMUL        dword [base_mem + 0xe9a8]
    ADD         BX,DX
    MOV         AX,CX
    CALL        FUN_1000_2b08
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4c68:
                              ;XREF[2]:     1000:4cc3(c),1000:4d0e(c)
    MOV         EAX, dword [base_mem + 0xe9cc]
    MOV         EBX,dword [base_mem + 0xe9d0]
    AND         EAX,EAX
    JGE         .LAB_LOC_1
    NEG         EAX
.LAB_LOC_1:
    AND         EBX,EBX
    JGE         .LAB_LOC_2
    NEG         EBX
.LAB_LOC_2:
    ADD         EAX,EBX
    MOVZX       BX,byte [base_mem + 0xea28]
    SHR         BX,0x4
    SHL         BX,0x1
    mk_addr     EBP, [BX]
    MOVZX       ECX,word [EBP + 0xea29]
    SHL         BX,0x1
    mk_addr     EBP, [BX]
    MOV         EDX,dword [EBP + 0xea59]
    MOV         EBX,EAX
    MOV         EAX, dword [base_mem + 0xe9c8]
    NEG         EAX
    CMP         EAX,EDX
    JL          .LAB_LOC_3
    MOV         EAX,EDX
.LAB_LOC_3:
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
    JG          .LAB_LOC_1
    PUSH        ECX
    CALL        FUN_1000_4d96
    POP         ECX
    MOV         EAX, dword [base_mem + 0xe9d0]
    CDQ
    IDIV        ECX
    MOV         EBX,EAX
    MOV         EAX, dword [base_mem + 0xe9cc]
    CDQ
    IDIV        ECX
    JMP         .LAB_LOC_2
.LAB_LOC_1:
    MOV         EAX, dword [base_mem + 0xe9cc]
    MOV         EBX,dword [base_mem + 0xe9d0]
.LAB_LOC_2:
    IMUL        dword [base_mem + 0xe9a4]
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0xc],EDX
    mk_addr     EBP, [DI]
    SUB         dword [EBP],EDX
    MOV         EAX,EBX
    IMUL        dword [base_mem + 0xe9ac]
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0x10],EDX
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0x4],EDX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4d0e:
                              ;XREF[1]:     1000:4bc7(c)
    CALL        FUN_1000_4c68
    JG          .LAB_LOC_1
    PUSH        ECX
    CALL        FUN_1000_4d96
    POP         ECX
    MOV         EAX, dword [base_mem + 0xe9d0]
    CDQ
    IDIV        ECX
    MOV         EBX,EAX
    MOV         EAX, dword [base_mem + 0xe9cc]
    CDQ
    IDIV        ECX
    MOV         dword [base_mem + 0xe9cc],EAX
    MOV         dword [base_mem + 0xe9d0],EBX
.LAB_LOC_1:
    MOV         EAX, dword [base_mem + 0xe9cc]
    IMUL        dword [base_mem + 0xe9be]
    MOV         ECX,EDX
    MOV         EAX, dword [base_mem + 0xe9d0]
    IMUL        dword [base_mem + 0xe9c2]
    SUB         ECX,EDX
    SUB         dword [base_mem + 0xe9da],ECX
    MOV         EAX,ECX
    MOV         EBX,EAX
    IMUL        dword [base_mem + 0xe9be]
    ADD         dword [base_mem + 0xe9cc],EDX
    MOV         EAX,EBX
    IMUL        dword [base_mem + 0xe9c2]
    SUB         dword [base_mem + 0xe9d0],EDX
    MOV         EAX, dword [base_mem + 0xe9cc]
    IMUL        dword [base_mem + 0xe9a4]
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0xc],EDX
    mk_addr     EBP, [DI]
    SUB         dword [EBP],EDX
    MOV         EAX, dword [base_mem + 0xe9d0]
    IMUL        dword [base_mem + 0xe9ac]
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0x10],EDX
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0x4],EDX
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4d96:
                              ;XREF[3]:     1000:4ccc(c),1000:4d17(c),1000:52b7(c)
    PUSH        SI
    MOV         SI,word [base_mem + 0x3e51]
    CMP         SI,0x15e0
    JNC         .LAB_LOC_1
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP]
    mk_addr     EBP, [DI]
    MOV         EBX,dword [EBP + 0x4]
    mk_addr     EBP, [DI]
    MOV         ECX,dword [EBP + 0x8]
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x3e53],EAX
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x3e57],EBX
    mk_addr     EBP, [DI]
    MOVZX       EAX,word [EBP + 0x18]
    SHL         EAX,0x10
    SUB         ECX,EAX
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x3e5b],ECX
    MOV         EAX, dword [base_mem + 0xe9cc]
    IMUL        dword [base_mem + 0xe9a4]
    SHL         EDX,0x1
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x3e5f],EDX
    MOV         EAX, dword [base_mem + 0xe9d0]
    IMUL        dword [base_mem + 0xe9ac]
    SHL         EDX,0x1
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x3e63],EDX
    mk_addr     EBP, [DI]
    MOV         ECX,dword [EBP + 0x14]
    mk_addr     EBP, [SI]
    MOV         dword [EBP + 0x3e67],ECX
    MOVZX       AX,byte [base_mem + 0xea28]
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x3e6d],AX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x3e6b],0x64
    ADD         word [base_mem + 0x3e51],0x1c
.LAB_LOC_1:
    POP         SI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4e0a:
                              ;XREF[1]:     1000:48d1(c)
    MOV         AX,SI
    mk_addr     EBP, [SI]
    ADD         AX,word [EBP]
    ADD         AX,0x2
    MOV         word [base_mem + 0xe9d8],AX
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP + 0x2]
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP]
    MOV         word [base_mem + 0xe9e6],AX
    ADD         SI,0x2
.LAB_LOC_1:
    MOV         BX,SI
    mk_addr     EBP, [SI]
    MOV         DI,word [EBP + 0x2]
    MOV         AX,DI
    SHL         DI,0x3
    SUB         DI,AX
    SHL         DI,0x2
    ADD         DI,word [base_mem + 0xe9d8]
    mk_addr     EBP, [SI]
    MOV         SI,word [EBP]
    MOV         AX,SI
    SHL         SI,0x3
    SUB         SI,AX
    SHL         SI,0x2
    ADD         SI,word [base_mem + 0xe9d8]
    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP]
    mk_addr     EBP, [DI]
    SUB         EAX,dword [EBP]
    mk_addr     EBP, [SI]
    MOV         ECX,dword [EBP + 0xc]
    mk_addr     EBP, [DI]
    SUB         ECX,dword [EBP + 0xc]
    MOV         dword [base_mem + 0xe9f8],EAX
    ADD         EAX,ECX
    xorps    xmm0, xmm0
    cvtsi2ss xmm0, eax
    mulss    xmm0, xmm0

    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x4]
    mk_addr     EBP, [DI]
    SUB         EAX,dword [EBP + 0x4]
    mk_addr     EBP, [SI]
    MOV         ECX,dword [EBP + 0x10]
    mk_addr     EBP, [DI]
    SUB         ECX,dword [EBP + 0x10]
    MOV         dword [base_mem + 0xe9fc],EAX
    ADD         EAX,ECX
    xorps    xmm1, xmm1
    cvtsi2ss xmm1, eax
    mulss    xmm1, xmm1

    mk_addr     EBP, [SI]
    MOV         EAX,dword [EBP + 0x8]
    mk_addr     EBP, [DI]
    SUB         EAX,dword [EBP + 0x8]
    mk_addr     EBP, [SI]
    MOV         ECX,dword [EBP + 0x14]
    mk_addr     EBP, [DI]
    SUB         ECX,dword [EBP + 0x14]
    MOV         dword [base_mem + 0xea00],EAX
    ADD         EAX,ECX
    xorps    xmm2, xmm2
    cvtsi2ss xmm2, eax
    mulss    xmm2, xmm2

    addss xmm1, xmm0
    addss xmm2, xmm1

    xorps  xmm3, xmm3
    sqrtss xmm3, xmm2

    cvtss2si eax, xmm3

    SAR         EAX,0xa
    mk_addr     EBP, [BX]
    movsx_m2m   dword [mitemp_BeX], word [EBP + 0x4]
    TEST        dword [mitemp_BeX], 0x80000000
    JS          .LAB_LOC_10
    mk_addr     EBP, [BX]
    MOVZX       ECX,word [EBP + 0x8]
    MOV         word [base_mem + 0xea04],CX
    AND         CX,0xff
    JZ          .LAB_LOC_5
    JS          .LAB_LOC_3
    CMP         CX,0x1
    JG          .LAB_LOC_6
    MOV         ECX,dword [mitemp_BeX]
    SUB         ECX,EAX
    JZ          .LAB_LOC_3
    CMP         CX,word [base_mem + 0xe9e2]
    JG          .LAB_LOC_8
    CMP         CX,word [base_mem + 0xe9e4]
    JL          .LAB_LOC_9
    MOV         dword [mitemp_BeX],EAX
.LAB_LOC_2:
    SHL         ECX,0x6
    SHL         dword [mitemp_BeX],0x6
    MOV         dword [mitemp_01],ECX
    MOV         CL,byte [base_mem + 0xea05]
    INC         CL
    MOV         EAX, dword [base_mem + 0xe9f8]
    IMUL        dword [mitemp_01]
    IDIV        dword [mitemp_BeX]
    MOV         EDX,EAX
    SAR         EAX,CL
    SUB         EDX,EAX
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0xc],EAX
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0xc],EDX
    MOV         EAX, dword [base_mem + 0xe9fc]
    IMUL        dword [mitemp_01]
    IDIV        dword [mitemp_BeX]
    MOV         EDX,EAX
    SAR         EAX,CL
    SUB         EDX,EAX
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0x10],EAX
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0x10],EDX
    MOV         EAX, dword [base_mem + 0xea00]
    IMUL        dword [mitemp_01]
    IDIV        dword [mitemp_BeX]
    MOV         EDX,EAX
    SAR         EAX,CL
    SUB         EDX,EAX
    mk_addr     EBP, [SI]
    ADD         dword [EBP + 0x14],EAX
    mk_addr     EBP, [DI]
    SUB         dword [EBP + 0x14],EDX
.LAB_LOC_3:
                              ;             1000:4ffd(j)
    MOV         SI,BX
.LAB_LOC_4:
    ADD         SI,0xe
    DEC         word [base_mem + 0xe9e6]
    JNZ         .LAB_LOC_1
    RET
.LAB_LOC_5:
    mk_addr     EBP, [BX]
    MOVZX       EDX,word [EBP + 0xc]
    CMP         EAX,EDX
    JG          .LAB_LOC_7
    mk_addr     EBP, [BX]
    MOVZX       EDX,word [EBP + 0xa]
    CMP         EAX,EDX
    JL          .LAB_LOC_7
    JMP         .LAB_LOC_3
.LAB_LOC_6:
    mk_addr     EBP, [BX]
    MOVZX       EDX,word [EBP + 0xc]
    CMP         EAX,EDX
    JG          .LAB_LOC_7
    mk_addr     EBP, [BX]
    MOVZX       EDX,word [EBP + 0xa]
    CMP         EAX,EDX
    JL          .LAB_LOC_7
    XCHG        EAX,dword [mitemp_BeX]
    SUB         EAX,dword [mitemp_BeX]
    CDQ
    SHR         ECX,0x1
    IDIV        ECX
    MOV         ECX,EAX
    mk_addr     EBP, [BX]
    MOVZX       EAX,word [EBP + 0x6]
    SUB         EAX,dword [mitemp_BeX]
    SAR         EAX,0x1
    ADD         ECX,EAX
    mk_addr     EBP, [BX]
    mov_m2m     word [EBP + 0x6], word [mitemp_BeX]
    JMP         .LAB_LOC_2
.LAB_LOC_7:
    MOV         ECX,EDX
    SUB         ECX,EAX
    SAR         ECX,0x1
    JZ          .LAB_LOC_3
    MOV         dword [mitemp_BeX],EAX
    mk_addr     EBP, [BX]
    mov_m2m     word [EBP + 0x6], word [mitemp_BeX]
    JMP         .LAB_LOC_2
.LAB_LOC_8:
    SAR         ECX,0x4
    XCHG        EAX,dword [mitemp_BeX]
    SUB         EAX,ECX
    mk_addr     EBP, [BX]
    MOV         word [EBP + 0x4],AX
    mk_addr     EBP, [BX]
    MOV         word [EBP + 0x6],AX
    JMP         .LAB_LOC_2
.LAB_LOC_9:
    mk_addr     EBP, [BX]
    OR          word [EBP + 0x8],0x80
    JMP         .LAB_LOC_3
.LAB_LOC_10:
    MOV         SI,BX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x4],AX
    mk_addr     EBP, [SI]
    MOV         word [EBP + 0x6],AX
    JMP         .LAB_LOC_4
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_500b:
                              ;XREF[1]:     1000:56c8(c)
    MOV         byte [base_mem + 0xea28],0x0
    MOV         DI,0x5bbc
    MOV         CX,word [base_mem + 0x5bba]
.LAB_LOC_1:
    PUSH        CX
    PUSH        DI
    mk_addr     EBP, [DI]
    MOV         SI,word [EBP]
    CALL        FUN_1000_5091
    MOV         DI,0x5bbc
    MOV         CX,word [base_mem + 0x5bba]
.LAB_LOC_2:
    PUSH        CX
    PUSH        DI
    mk_addr     EBP, [DI]
    MOV         DI,word [EBP]
    CMP         DI,SI
    JZ          .LAB_LOC_4
    PUSH        SI
    PUSH        DI
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    ADD         SI,0x2
    mk_addr     EBP, [DI]
    ADD         DI,word [EBP]
    ADD         DI,0x2
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x2]
    mk_addr     EBP, [DI]
    SUB         AX,word [EBP + 0x2]
    CMP         AX,0x200
    JG          .LAB_LOC_3
    CMP         AX,0xfe00
    JL          .LAB_LOC_3
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x6]
    mk_addr     EBP, [DI]
    SUB         AX,word [EBP + 0x6]
    CMP         AX,0x200
    JG          .LAB_LOC_3
    CMP         AX,0xfe00
    JL          .LAB_LOC_3
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0xa]
    mk_addr     EBP, [DI]
    SUB         AX,word [EBP + 0xa]
    CMP         AX,0x200
    JG          .LAB_LOC_3
    CMP         AX,0xfe00
    JL          .LAB_LOC_3
    POP         DI
    POP         SI
    CALL        FUN_1000_51bd
    JMP         .LAB_LOC_4

 ; 1000:507f [UNDEFINED BYTES REMOVED]

.LAB_LOC_3:
                              ;             1000:506d(j),1000:5074(j)
    POP         DI
    POP         SI
.LAB_LOC_4:
    POP         DI
    POP         CX
    ADD         DI,0x2
    L_LOOP      .LAB_LOC_2
    POP         DI
    POP         CX
    ADD         DI,0x2
    L_LOOP      .LAB_LOC_1
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;ANALYSIS: related to colision, nop-ing it makes the cars just phase thru one another
FUN_1000_5091:
                              ;XREF[1]:     1000:501c(c)
    PUSH        SI
    MOV         DX,SI
    mk_addr     EBP, [SI]
    ADD         DX,word [EBP]
    ADD         DX,0x2
    MOV         SI,0xec1b
    CALL  F_WRAP_LODSW 
    MOV         CX,AX
    MOV         word [base_mem + 0xea99],0x0
.LAB_LOC_1:
    PUSH        CX
    CALL  F_WRAP_LODSW 
    MOV         BX,AX
    SHL         BX,0x3
    SUB         BX,AX
    SHL         BX,0x2
    ADD         BX,DX
    CALL  F_WRAP_LODSW 
    MOV         word [mitemp_03],AX
    SHL         word [mitemp_03],0x3
    SUB         word [mitemp_03],AX
    SHL         word [mitemp_03],0x2
    ADD         word [mitemp_03],DX
    CALL  F_WRAP_LODSW 
    MOV         DI,AX
    SHL         DI,0x3
    SUB         DI,AX
    SHL         DI,0x2
    ADD         DI,DX
    PUSH        SI
    PUSH        DX
    MOV         SI,word [mitemp_03]

    mk_addr     EBP, [BX]
    MOV         EAX,dword [EBP + 0x4]
    MOV         dword [pslc_eb5f],EAX
    mk_addr     EBP, [SI]
    SUB         EAX,dword [EBP + 0x4]
    mk_addr     EBP, [BX]
    MOV         ECX,dword [EBP + 0x8]
    mk_addr     EBP, [DI]
    SUB         ECX,dword [EBP + 0x8]
    SAR         EAX,0xe
    SAR         ECX,0xe
    IMUL        EAX,ECX
    MOV         EDX,EAX
    mk_addr     EBP, [BX]
    MOV         EAX,dword [EBP + 0x4]
    mk_addr     EBP, [DI]
    SUB         EAX,dword [EBP + 0x4]
    mk_addr     EBP, [BX]
    MOV         ECX,dword [EBP + 0x8]
    mk_addr     EBP, [SI]
    SUB         ECX,dword [EBP + 0x8]
    SAR         EAX,0xe
    SAR         ECX,0xe
    IMUL        EAX,ECX
    SUB         EDX,EAX
    MOV         dword [pslc_ea9b],EDX
    mk_addr     EBP, [BX]
    MOV         EAX,dword [EBP + 0x8]
    MOV         dword [pslc_eb63],EAX
    mk_addr     EBP, [DI]
    SUB         EAX,dword [EBP + 0x8]
    mk_addr     EBP, [BX]
    MOV         ECX,dword [EBP]
    mk_addr     EBP, [SI]
    SUB         ECX,dword [EBP]
    SAR         EAX,0xe
    SAR         ECX,0xe
    IMUL        EAX,ECX
    MOV         EDX,EAX
    mk_addr     EBP, [BX]
    MOV         EAX,dword [EBP + 0x8]
    mk_addr     EBP, [SI]
    SUB         EAX,dword [EBP + 0x8]
    mk_addr     EBP, [BX]
    MOV         ECX,dword [EBP]
    mk_addr     EBP, [DI]
    SUB         ECX,dword [EBP]
    SAR         EAX,0xe
    SAR         ECX,0xe
    IMUL        EAX,ECX
    SUB         EDX,EAX
    NEG         EDX
    MOV         dword [pslc_ea9f],EDX
    mk_addr     EBP, [BX]
    MOV         EAX,dword [EBP]
    MOV         dword [pslc_eb5b],EAX
    mk_addr     EBP, [DI]
    SUB         EAX,dword [EBP]
    mk_addr     EBP, [BX]
    MOV         ECX,dword [EBP + 0x4]
    mk_addr     EBP, [SI]
    SUB         ECX,dword [EBP + 0x4]
    SAR         EAX,0xe
    SAR         ECX,0xe
    IMUL        EAX,ECX
    MOV         EDX,EAX
    mk_addr     EBP, [BX]
    MOV         EAX,dword [EBP]
    mk_addr     EBP, [SI]
    SUB         EAX,dword [EBP]
    mk_addr     EBP, [BX]
    MOV         ECX,dword [EBP + 0x4]
    mk_addr     EBP, [DI]
    SUB         ECX,dword [EBP + 0x4]
    SAR         EAX,0xe
    SAR         ECX,0xe
    IMUL        EAX,ECX
    SUB         EDX,EAX
    MOV         dword [pslc_eaa3],EDX
    POP         DX
    POP         SI

    mov  BX, word [base_mem + 0xea99]
    mk_addr     EBP, [BX]
    mov_m2m  dword [EBP + 0xeb5f], dword [pslc_eb5f]
    mk_addr     EBP, [BX]
    mov_m2m  dword [EBP + 0xea9b], dword [pslc_ea9b]
    mk_addr     EBP, [BX]
    mov_m2m  dword [EBP + 0xeb63], dword [pslc_eb63]

    mk_addr     EBP, [BX]
    mov_m2m  dword [EBP + 0xea9f], dword [pslc_ea9f]
    mk_addr     EBP, [BX]
    mov_m2m  dword [EBP + 0xeb5b], dword [pslc_eb5b]
    mk_addr     EBP, [BX]
    mov_m2m  dword [EBP + 0xeaa3], dword [pslc_eaa3]
    ;no need to restore bx, it will be rewritten next loop

    ADD         word [base_mem + 0xea99],0xc
    POP         CX
    DEC         CX
    JNZ         .LAB_LOC_1
    POP         SI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_51bd:
                              ;XREF[1]:     1000:507a(c)
    PUSH        DI
    PUSH        SI
    mk_addr     EBP, [DI]
    ADD         DI,word [EBP]
    mk_addr     EBP, [DI]
    MOV         CX,word [EBP]
    ADD         DI,0x2
.LAB_LOC_1:
    PUSH        CX
    XOR         SI,SI
    MOV         BX,SI
    MOV         ECX,0x80000000
.LAB_LOC_2:
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP]
    mk_addr     EBP, [SI]
    SUB         EAX,dword [EBP + 0xeb5b]
    SAR         EAX,0x10
    mk_addr     EBP, [SI]
    IMUL        EAX,dword [EBP + 0xea9b]
    MOV         EDX,EAX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x4]
    mk_addr     EBP, [SI]
    SUB         EAX,dword [EBP + 0xeb5f]
    SAR         EAX,0x10
    mk_addr     EBP, [SI]
    IMUL        EAX,dword [EBP + 0xea9f]
    ADD         EDX,EAX
    mk_addr     EBP, [DI]
    MOV         EAX,dword [EBP + 0x8]
    mk_addr     EBP, [SI]
    SUB         EAX,dword [EBP + 0xeb63]
    SAR         EAX,0x10
    mk_addr     EBP, [SI]
    IMUL        EAX,dword [EBP + 0xeaa3]
    ADD         EDX,EAX
    JNS         .LAB_LOC_9
    CMP         EDX,ECX
    JG          .LAB_LOC_10
.LAB_LOC_3:
    ADD         SI,0xc
    CMP         SI,word [base_mem + 0xea99]
    JC          .LAB_LOC_2
    mk_addr     EBP, [BX]
    MOV         EAX,dword [EBP + 0xea9b]
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0xc],EAX
    mk_addr     EBP, [BX]
    MOV         EAX,dword [EBP + 0xea9f]
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0x10],EAX
    mk_addr     EBP, [BX]
    MOV         EAX,dword [EBP + 0xeaa3]
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0x14],EAX
    POP         CX
    POP         SI
    PUSH        SI
    PUSH        CX
    PUSH        BX
    mk_addr     EBP, [SI]
    ADD         SI,word [EBP]
    mk_addr     EBP, [SI]
    MOV         CX,word [EBP]
    ADD         SI,0x2
    MOV         DX,0x7fff
    MOV         word [ye_old_lil_bep],SI
.LAB_LOC_4:
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x2]
    AND         AX,AX
    JGE         .LAB_LOC_5
    NEG         AX
.LAB_LOC_5:
    MOV         BX,AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0x6]
    AND         AX,AX
    JGE         .LAB_LOC_6
    NEG         AX
.LAB_LOC_6:
    ADD         BX,AX
    mk_addr     EBP, [SI]
    MOV         AX,word [EBP + 0xa]
    AND         AX,AX
    JGE         .LAB_LOC_7
    NEG         AX
.LAB_LOC_7:
    ADD         BX,AX
    CMP         BX,DX
    JL          .LAB_LOC_11
.LAB_LOC_8:
    ADD         SI,0x1c
    L_LOOP      .LAB_LOC_4
    MOV         SI,word [ye_old_lil_bep]
    POP         BX
    mk_addr     EBP, [BX]
    MOV         EAX,dword [EBP + 0xea9b]
    SAR         EAX,0x1
    mk_addr     EBP, [SI]
    SUB         dword [EBP + 0xc],EAX
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0xc],EAX
    mk_addr     EBP, [BX]
    MOV         EAX,dword [EBP + 0xea9f]
    SAR         EAX,0x1
    mk_addr     EBP, [SI]
    SUB         dword [EBP + 0x10],EAX
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0x10],EAX
    mk_addr     EBP, [BX]
    MOV         EAX,dword [EBP + 0xeaa3]
    SAR         EAX,0x1
    mk_addr     EBP, [SI]
    SUB         dword [EBP + 0x14],EAX
    mk_addr     EBP, [DI]
    ADD         dword [EBP + 0x14],EAX
    CALL        FUN_1000_4d96
.LAB_LOC_9:
    ADD         DI,0x1c
    POP         CX
    DEC         CX
    JNZ         .LAB_LOC_1
    POP         SI
    POP         DI
    RET
.LAB_LOC_10:
    MOV         ECX,EDX
    MOV         BX,SI
    JMP         .LAB_LOC_3
.LAB_LOC_11:
    MOV         DX,BX
    MOV         word [ye_old_lil_bep],SI
    JMP         .LAB_LOC_8
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_52d4:
                              ;XREF[2]:     1000:5393(c),1000:53e4(c)
    MOV         AX, word [base_mem + 0xea0c]
    IMUL        word [base_mem + 0xea14]
    MOV         word [base_mem + 0xea22],AX
    MOV         AX, word [base_mem + 0xea0e]
    IMUL        word [base_mem + 0xea12]
    SUB         word [base_mem + 0xea22],AX
    MOV         AX, word [base_mem + 0xea18]
    IMUL        word [base_mem + 0xea14]
    MOV         word [base_mem + 0xea1e],AX
    MOV         AX, word [base_mem + 0xea1a]
    IMUL        word [base_mem + 0xea12]
    SUB         word [base_mem + 0xea1e],AX
    MOV         AX, word [base_mem + 0xea1a]
    IMUL        word [base_mem + 0xea0c]
    MOV         word [base_mem + 0xea20],AX
    MOV         AX, word [base_mem + 0xea18]
    IMUL        word [base_mem + 0xea0e]
    SUB         word [base_mem + 0xea20],AX
    MOV         AX, word [base_mem + 0xea10]
    IMUL        word [base_mem + 0xea1e]
    MOV         BX,AX
    MOV         CX,DX
    MOV         AX, word [base_mem + 0xea16]
    IMUL        word [base_mem + 0xea20]
    ADD         AX,BX
    ADC         DX,CX
    IDIV        word [base_mem + 0xea22]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_532e:
                              ;XREF[1]:     1000:4910(c)
    MOV         word [base_mem + 0xea1c],CX
    MOV         word [base_mem + 0xea0c],0x80
    MOV         word [base_mem + 0xea0e],0x0
    MOV         word [base_mem + 0xea12],0x0
    MOV         word [base_mem + 0xea14],0x80
    SHR         AL,0x1
    SHR         BL,0x1
    MOV         CL,AL
    ADD         CL,BL
    CMP         CL,0x80
    JA          .LAB_LOC_1
    MOV         byte [base_mem + 0xea18],AL
    MOV         byte [base_mem + 0xea1a],BL
    MOV         BL,AH
    mk_addr_seg EBP, ptr_seg_FeS, [BX]
    MOV         AL,byte [EBP]
    MOV         byte [base_mem + 0xea28],AL
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       AX,byte [EBP]
    SHL         AX,0x4
    MOV         CX,AX
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       AX,byte [EBP + 0x1]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         word [base_mem + 0xea10],AX
    MOV         word [base_mem + 0xea24],AX
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       AX,byte [EBP + 0x100]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         word [base_mem + 0xea16],AX
    MOV         word [base_mem + 0xea26],AX
    PUSH        CX
    CALL        FUN_1000_52d4
    POP         CX
    ADD         AX,CX
    JMP         .LAB_LOC_2
.LAB_LOC_1:
    NEG         AL
    NEG         BL
    ADD         AL,0x80
    ADD         BL,0x80
    MOV         byte [base_mem + 0xea18],AL
    MOV         byte [base_mem + 0xea1a],BL
    MOV         BL,AH
    mk_addr_seg EBP, ptr_seg_FeS, [BX]
    MOV         AL,byte [EBP]
    MOV         byte [base_mem + 0xea28],AL
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       AX,byte [EBP + 0x101]
    SHL         AX,0x4
    MOV         CX,AX
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       AX,byte [EBP + 0x1]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         word [base_mem + 0xea16],AX
    NEG         AX
    MOV         word [base_mem + 0xea26],AX
    mk_addr_seg EBP, ptr_seg_GeS, [BX]
    MOVZX       AX,byte [EBP + 0x100]
    SHL         AX,0x4
    SUB         AX,CX
    MOV         word [base_mem + 0xea10],AX
    NEG         AX
    MOV         word [base_mem + 0xea24],AX
    PUSH        CX
    CALL        FUN_1000_52d4
    POP         CX
    ADD         AX,CX
.LAB_LOC_2:
    RET



;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_timer_5680:
    PUSHAD
    PUSH        dword [ptr_seg_DeS]
    PUSH        dword [ptr_seg_EeS]
    PUSH        dword [ptr_seg_FeS]
    PUSH        dword [ptr_seg_GeS]
    MOV         AX, _DATA2
    ld_seg      dword [ptr_seg_DeS],AX
    ld_seg      dword [ptr_seg_EeS],AX
    CMP         byte [base_mem + 0x6e],0x1
    JNZ         .LAB_LOC_2
    ld_seg      dword [ptr_seg_FeS], word [base_mem + 0x1a47]
    ld_seg      dword [ptr_seg_GeS], word [base_mem + 0x1a45]
    MOV         DI,0x5bbc
    MOV         CX,word [base_mem + 0x5bba]      ;= 0001h
    MOV         word [ye_old_lil_bep],0x5ad9
.LAB_LOC_1:
                              ; FWD[2]:     15cd:5bbc(R),15cd:5bbe(R)
    mk_addr     EBP, [DI]
    MOV         SI,word [EBP]  ; =>0x5bbc
    PUSH        CX
    PUSH        DI
    PUSH        word [ye_old_lil_bep]
    MOV         DI,word [ye_old_lil_bep]
    CALL        FUN_1000_0d2a
    CALL        FUN_1000_1004
    CALL        FUN_1000_48d0
    POP         word [ye_old_lil_bep]
    POP         DI
    POP         CX
    ADD         DI,0x2
    ADD         word [ye_old_lil_bep],0x6
    L_LOOP      .LAB_LOC_1
    CALL        FUN_1000_500b
    CALL        FUN_1000_0bb5
    CALL        FUN_1000_0a3b
.LAB_LOC_2:
    POP         dword [ptr_seg_GeS]
    POP         dword [ptr_seg_FeS]
    POP         dword [ptr_seg_EeS]
    POP         dword [ptr_seg_DeS]
    POPAD
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_keyboard_56df:

    mov bx, _DATA2
    mov ds, bx

    MOV         BL, AL
    AND         BX,0x7f
    AND         AL,0x80
    JNS         .LAB_LOC_1
    movsx ebp, BX
    MOV         byte [EBP + CSD_DAT_keys_571e],0xff
    MOV         byte [CSD_DAT_keys_571e],0x0
    ret

.LAB_LOC_1:
    movsx ebp, BX
    AND         byte [EBP + CSD_DAT_keys_571e],0x7f
    MOV         byte [CSD_DAT_keys_571e],BL
    ret


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
.LAB_LOC_1:
    PUSH        AX
    CALL        FUN_1000_58fc
    POP         AX
    INC         AH
    CMP         AH,0xb8
    JBE         .LAB_LOC_1
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
    MOV         AX, FUN_dummy_1000_588b
    RET

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_5831:
    MOV         CH,AL
    MOV         DX,0x388
    MOV         AL,BL
    MOV         AH,0xa0
    ADD         AH,CH
    CALL        FUN_1000_58fc
    MOV         AL,BH
    OR          AL,0x20
    MOV         AH,0xb0
    ADD         AH,CH
    CALL        FUN_1000_58fc
    MOV         AL,0x3f
    SUB         AL,CL
    CMP         AL,0x3f
    JBE         .LAB_LOC_1
    MOV         AL,0x3f
.LAB_LOC_1:
    MOV         AH,0x43
    MOVZX       BX,CH
    movsx ebp, BX
    ADD         AH,byte [EBP + CSD_DAT_unk_592c]
    CALL        FUN_1000_58fc
    RET

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
    CALL  F_WRAP_LODSB 
    MOV         AH,0xa8
    CALL        FUN_1000_58fc
    CALL  F_WRAP_LODSB 
    MOV         AH,0xb8
    CALL        FUN_1000_58fc
    POP         DX
    POP         SI
    RET

FUN_dummy_1000_588b:
    ud2
    ret


;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_589b:
                              ;XREF[3]:     1000:5806(c),1000:580e(c),1000:5879(c)
    MOVZX       BX,AL
    movsx ebp, BX
    MOV         BL,byte [EBP + CSD_DAT_unk_592c]
    MOV         AH,0x20
    ADD         AH,BL
    CALL  F_WRAP_LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x40
    ADD         AH,BL
    CALL  F_WRAP_LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x60
    ADD         AH,BL
    CALL  F_WRAP_LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x80
    ADD         AH,BL
    CALL  F_WRAP_LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0xe0
    ADD         AH,BL
    CALL  F_WRAP_LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x23
    ADD         AH,BL
    CALL  F_WRAP_LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x43
    ADD         AH,BL
    CALL  F_WRAP_LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x63
    ADD         AH,BL
    CALL  F_WRAP_LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x83
    ADD         AH,BL
    CALL  F_WRAP_LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0xe3
    ADD         AH,BL
    CALL  F_WRAP_LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0xc0
    ADD         AH,BL
    CALL  F_WRAP_LODSB 
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
    PUSH BX

    ;TODO actually do something with AX

    POP BX
    POP         AX
    RET

 ; 1000:592b [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_5940_render_text:
                              ;XREF[2]:     1000:04e6(c),1000:04f4(c)
    MOV         byte [CSD_BYTE_1000_59c1],CL         ;= Fh
    MOV         CX,AX
    CLD
.LAB_LOC_1:
    CALL  F_WRAP_LODSB 
    CMP         AL,0x0
    JNZ         .LAB_LOC_2
    RET
.LAB_LOC_2:
    CMP         AL,0x9
    JNZ         .LAB_LOC_3
    ADD         CX,0x14
    JMP         .LAB_LOC_1
.LAB_LOC_3:
    CMP         AL,0xd
    JNZ         .LAB_LOC_4
    RET
.LAB_LOC_4:
    CMP         AL,0x1b
    JNZ         .LAB_LOC_5
    CALL  F_WRAP_LODSB 
    MOV         [CSD_BYTE_1000_59c1],AL                  ;= Fh
    JMP         .LAB_LOC_1
.LAB_LOC_5:
    CMP         AL,0x20
    JNZ         .LAB_LOC_6
    ADD         CX,0x5
    JMP         .LAB_LOC_1
.LAB_LOC_6:
    PUSH        SI
    PUSH        BX
    MOV         SI,0xed17
    SUB         AH,AH
    ADD         AX,AX
    MOV         BX,AX
    mk_addr     EBP, [BX]
    ADD         SI,word [EBP + 0xed17]
    ADD         SI,0x100
    POP         BX
    MOV         AX,CX
.LAB_LOC_7:
    PUSH        BX
    mk_addr     EBP, [SI]
    MOV         DL,byte [EBP]
    TEST        DL,DL
    JZ          .LAB_LOC_11
.LAB_LOC_8:
    SHR         DL,0x1
    JC          .LAB_LOC_9
    JZ          .LAB_LOC_10
    INC         BX
    JMP         .LAB_LOC_8
.LAB_LOC_9:
    PUSH        AX
    PUSH        BX
    MOV         CL,byte [CSD_BYTE_1000_59c1]         ;= Fh
    CALL        FUN_1000_3f98
    POP         BX
    POP         AX
    INC         BX
    JMP         .LAB_LOC_8
.LAB_LOC_10:
    POP         BX
    INC         AX
    INC         SI
    JMP         .LAB_LOC_7
.LAB_LOC_11:
    POP         BX
    POP         SI
    MOV         CX,AX
    INC         CX
    JMP         .LAB_LOC_1

 ; 1000:5a5f [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_5a60:
                              ;XREF[3]:     1000:24ca(c),1000:24da(c),1000:2566(c)
    MOV         DX,DX
    MOV         AL,0x0
    MOV         AH,0x3d
    call DOS3Call
    MOV         BX,AX
    JC          .LAB_LOC_1
    CALL        FUN_1000_5a95
    JC          .LAB_LOC_1
    MOV         CX,0x0
    MOV         DX,0x80
    MOV         AX,0x4200
    call DOS3Call
    JC          .LAB_LOC_1
    CALL        FUN_1000_5acf
    JC          .LAB_LOC_1
    MOV         AH,0x3e
    call DOS3Call
    JC          .LAB_LOC_1
    RET
.LAB_LOC_1:
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
    call DOS3Call
    JC          .LAB_LOC_1
    MOV         AX, word [base_mem + 0xef90]
    SUB         AX,word [base_mem + 0xef8c]
    INC         AX
    MOV         word [base_mem + 0xef80],AX
    MOV         CX,word [base_mem + 0xef92]
    SUB         CX,word [base_mem + 0xef8e]
    INC         CX
    MOV         word [base_mem + 0xef82],CX
    CMP         byte [base_mem + 0xef8b],0x8
    JNZ         .LAB_LOC_1
    CMP         byte [base_mem + 0xefc9],0x1
    JNZ         .LAB_LOC_1
    RET
.LAB_LOC_1:
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
    MOV         CX,word [base_mem + 0xef82]
    CMP         CX,0x100
    JLE         .LAB_LOC_1
    MOV         CX,0x100
.LAB_LOC_1:
    PUSH        CX
    XOR         CX,CX
.LAB_LOC_2:
    AND         AH,AH
    JZ          .LAB_LOC_3
    DEC         AH
    JMP         .LAB_LOC_4

 ; 1000:5af5 [UNDEFINED BYTES REMOVED]

.LAB_LOC_3:
    CALL        FUN_1000_5b26
    MOV         AH,AL
    AND         AH,0xc0
    CMP         AH,0xc0
    MOV         AH,0x0
    JNZ         .LAB_LOC_4
    MOV         AH,AL
    AND         AH,0x3f
    CALL        FUN_1000_5b26
    DEC         AH
.LAB_LOC_4:
    CMP         CX,0x100
    JNC         .LAB_LOC_5
    CALL  F_WRAP_STOSB 
.LAB_LOC_5:
    INC         CX
    CMP         CX,word [base_mem + 0xef80]
    JC          .LAB_LOC_2
    POP         CX
    L_LOOP      .LAB_LOC_1
    CLC
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_5b26:
                              ;XREF[2]:     1000:5af6(c),1000:5b0c(c)
    CMP         SI,0xf308
    JNZ         .LAB_LOC_1
    PUSH        AX
    PUSH        CX
    MOV         CX,0x300
    MOV         DX,0xf008
    MOV         CX,CX
    MOV         AH,0x3f
    call DOS3Call
    POP         CX
    POP         AX
    MOV         SI,0xf008
.LAB_LOC_1:
    CALL  F_WRAP_LODSB 
    RET

 ; 1000:5cce [UNDEFINED BYTES REMOVED]

;FIM:
