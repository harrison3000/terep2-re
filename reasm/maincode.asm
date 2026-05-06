
f_init:
    MOV         word [v_num_loaded_cars], -2     ;just to be sure

    MOV         word [0xec50],0x78    ;= 00C8h
    MOV         dword [v_gravity],0x1800 ;= 00000C00h
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
    call far DOS3Call
    MOV         BX,AX
    JC          .LAB_LOC_1
    MOV         DX,0xe9e2
    MOV         CX,0x2
    MOV         AH,0x3f
    call far DOS3Call
    MOV         DX,0xe9e4
    MOV         CX,0x2
    MOV         AH,0x3f
    call far DOS3Call
    MOV         AH,0x3e
    call far DOS3Call
.LAB_LOC_1:
    MOV         AH,0x48
    MOV         BX,0x1000
    call far DOS3Call
    JC          .LAB_LOC_6
    MOV         [v_memblock_a],AX
    MOV         GS,AX
    MOV         AH,0x48
    MOV         BX,0x1000
    call far DOS3Call
    JC          .LAB_LOC_6
    MOV         [v_memblock_b],AX
    MOV         FS,AX
    MOV         AH,0x48
    MOV         BX,0x1000
    call far DOS3Call
    JC          .LAB_LOC_6
    MOV         [v_memblock_c],AX
    MOV         AH,0x48
    MOV         BX,0x1000
    call far DOS3Call
    JC          .LAB_LOC_6
    MOV         [v_memblock_d],AX
    CALL        FUN_1000_24c0
    CALL        FUN_1000_255c
    MOV         word [v_num_loaded_cars],0x0     ;= 0001h
    MOV         DI,0x5bd0
    MOV         word [0x5bbc],DI
    MOV         SI, 0
.load_cars_loop:
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
    JC          .LAB_LOC_5
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
    call far DOS3Call
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
    call far DOS3Call
    POP         BX
    JC          .LAB_LOC_3
    POP         SI
    PUSH        SI
    MOV         DI,word [SI + 0x5bbc]
    MOV         word [DI + 0x1e],AX
    MOV         ES,AX
    MOV         DI, 0
    CALL        FUN_1000_5acf
.LAB_LOC_3:
    MOV         AH,0x3e
    call far DOS3Call
.LAB_LOC_4:
    POP         SI
    POP         DI
    POP         AX
    INC         word [v_num_loaded_cars]         ;= 0001h
    MOV         DI,word [SI + 0x5bbc]
    ADD         DI,AX
    INC         SI
    INC         SI
    MOV         word [SI + 0x5bbc],DI
    JMP         .load_cars_loop

.LAB_LOC_5:
    CALL        FUN_1000_2b70
    JC          .LAB_LOC_6
    ;CALL        FUN_1000_57e0 ;FIXME restore sound!
    MOV         word [0x6f],DX
    MOV         [0x71],AX
    
    MOV         byte [0x6e],0x1

    MOV ax, 0 
    ret

.LAB_LOC_6:
    MOV ax, 1
    ret

f_cam_select:
    SHL BX, 1
    AND BX, 15
    JMP         [CS:BX + .JMP_TABLE_CAMERAS]
    .JMP_TABLE_CAMERAS:
        dw  .CAMERA_1
        dw  .CAMERA_2
        dw  .CAMERA_3
        dw  .CAMERA_4
        dw  .CAMERA_5
            
        times 3 dw .LAB_RUIM

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
    MOV         FS, word [v_memblock_b]
    MOV         GS, word [v_memblock_a]

    ;clears the framebuffer
    MOV         EAX,0xffffffff
    CALL        FUN_1000_2b98

    TEST        byte [0x7d],0xff
    JNZ         .LAB_LOC_5

    ;singleplayer
    MOV         word [0xdbc0],0x0
    MOV         word [0xdbb8],0xa0    ;= 00A0h
    MOV         word [0xdbc2],0x13f   ;= 013Fh
    MOV         word [0xdbbc],0x0
    MOV         word [0xdbba],0x50    ;= 0064h
    MOV         word [0xdbbe],0xc7    ;= 00C7h
    MOV         SI,word [0xa4]
    MOVZX       BX,byte [0x7e]      ;= 03h
    MOV         DI,0x80
    call f_sanic_the_hendgerong
    MOV         AL,0x0
    CALL        FUN_1000_5831 ;was indirect
    JMP         .LAB_LOC_14
.LAB_LOC_5:
    ;split-screen
    MOV         word [0xdbc0],0x0
    MOV         word [0xdbb8],0xa0    ;= 00A0h
    MOV         word [0xdbc2],0x13f   ;= 013Fh
    MOV         word [0xdbbc],0x0
    MOV         word [0xdbba],0x32    ;= 0064h
    MOV         word [0xdbbe],0x62    ;= 00C7h
    MOV         SI,word [0xa4]
    MOVZX       BX,byte [0x7e]      ;= 03h
    MOV         DI,0x80
    call f_sanic_the_hendgerong
    MOV         AL,0x0
    CALL        FUN_1000_5831 ;was indirect

    MOV         word [0xdbc0],0x0
    MOV         word [0xdbb8],0xa0    ;= 00A0h
    MOV         word [0xdbc2],0x13f   ;= 013Fh
    MOV         word [0xdbbc],0x64
    MOV         word [0xdbba],0x96    ;= 0064h
    MOV         word [0xdbbe],0xc7    ;= 00C7h
    MOV         SI,word [0xa6]
    MOVZX       BX,byte [0x7f]      ;= 03h
    MOV         DI,0x92
    call f_sanic_the_hendgerong
    MOV         AL,0x1
    CALL        FUN_1000_5831 ;was indirect
.LAB_LOC_14:
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
    TEST        byte [CSD_DAT_keys_571e + 78],0x80
    JS          .LAB_LOC_15
    CMP         word [0x11c],0x3e8   ;= 0100h
    JG          .LAB_LOC_15
    ADD         word [0x11c],0x14    ;= 0100h
.LAB_LOC_15:
    TEST        byte [CSD_DAT_keys_571e + 74],0x80
    JS          .LAB_LOC_16
    CMP         word [0x11c],0x32    ;= 0100h
    JL          .LAB_LOC_16
    SUB         word [0x11c],0x14    ;= 0100h
.LAB_LOC_16:
    TEST        byte [CSD_DAT_keys_571e + 53],0x80
    JS          .LAB_LOC_17
    CMP         word [0x11e],0x1000  ;= 0400h
    JG          .LAB_LOC_17
    ADD         word [0x11e],0x28    ;= 0400h
.LAB_LOC_17:
    TEST        byte [CSD_DAT_keys_571e + 55],0x80
    JS          .LAB_LOC_18
    CMP         word [0x11e],0x100   ;= 0400h
    JL          .LAB_LOC_18
    SUB         word [0x11e],0x28    ;= 0400h
.LAB_LOC_18:
    MOV         AL,[CSD_DAT_keys_571e]
    CMP         AL,0x1      ;Esc
    JZ          .LAB_LOC_33
    CMP         AL,0xf      ;Tab
    JZ          .LAB_LOC_28
    CMP         AL,0x10     ;Q
    JZ          .LAB_LOC_30
    CMP         AL,0x3b     ;F1
    JZ          .LAB_LOC_20
    CMP         AL,0x3c     ;F2
    JZ          .LAB_LOC_21
    CMP         AL,0x3d     ;F3
    JZ          .LAB_LOC_22
    CMP         AL,0x3e     ;F4
    JZ          .LAB_LOC_23
    CMP         AL,0x3f     ;F5
    JZ          .LAB_LOC_24
    CMP         AL,0x1a     ;[
    JZ          .LAB_LOC_26
    CMP         AL,0x1b     ;]
    JZ          .LAB_LOC_27
    CMP         AL,0x44     ;F10
    JZ          .LAB_LOC_32
    CMP         AL,0x43     ;F9
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
    MOV         byte [0x7e],0x0     ;= 03h
    JMP         .LAB_LOC_19
.LAB_LOC_21:
    MOV         byte [0x7e],0x1     ;= 03h
    JMP         .LAB_LOC_19
.LAB_LOC_22:
    MOV         byte [0x7e],0x2     ;= 03h
    JMP         .LAB_LOC_19
.LAB_LOC_23:
    MOV         byte [0x7e],0x3     ;= 03h
    JMP         .LAB_LOC_19
.LAB_LOC_24:
    MOV         byte [0x7e],0x4     ;= 03h
    JMP         .LAB_LOC_19
.LAB_LOC_25:
    XOR         byte [0x7d],0x1
    JMP         .LAB_LOC_19
.LAB_LOC_26:
    ADD         dword [v_gravity],0x32   ;= 00000C00h
    JMP         .LAB_LOC_19
.LAB_LOC_27:
    SUB         dword [v_gravity],0x32   ;= 00000C00h
    JMP         .LAB_LOC_19
.LAB_LOC_28:
    MOV         SI,word [0xa4]
    INC         SI
    CMP         SI, word [v_num_loaded_cars]      ;= 0001h
    JC          .LAB_LOC_29
    MOV         SI, 0
.LAB_LOC_29:
    MOV         word [0xa4],SI
    JMP         .LAB_LOC_19
.LAB_LOC_30:
    MOV         SI,word [0xa6]
    INC         SI
    CMP         SI, word [v_num_loaded_cars]      ;= 0001h
    JC          .LAB_LOC_31
    MOV         SI, 0
.LAB_LOC_31:
    MOV         word [0xa6],SI
    JMP         .LAB_LOC_19
.LAB_LOC_32:
    XOR         word [0x5f5],0x600   ;= 0600h
    JMP         .LAB_LOC_19

 ; 1000:0653 [UNDEFINED BYTES REMOVED]

.LAB_LOC_33:
    mov ax, 1
    ret

 ; 1000:0692 [UNDEFINED BYTES REMOVED]


f_sanic_the_hendgerong:    
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5bbc]
    PUSH SI
    CALL f_cam_select
    MOV         BX,word [0xc6]
    CALL        FUN_1000_2aad
    SAR         AX,0x7
    MOV         [0x5f7],AX
    CALL        FUN_1000_2ad8
    SAR         AX,0x7
    MOV         [0x5f9],AX
    MOV         SI,0xc2
    MOV         DI,0xce
    CALL        FUN_1000_2989
    CALL        FUN_1000_27f1
    CALL        FUN_1000_1965
    CALL        FUN_1000_0b25
    POP SI
    MOV         CX,word [SI + 0x8]
    MOV         EAX,dword [SI + 0x42]
    ADD         EAX,dword [SI + 0x46]
    SAR         EAX,0xe
    MOV         EBX,dword [SI + 0x4a]
    ADD         EBX,dword [SI + 0x4e]
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
    MOV         CX,word [SI + 0xc]
    SAR         CX,0x9
    AND         CX,CX
    JGE         .LAB_LOC_9
    NEG         CX
.LAB_LOC_9:
    ADD         CX,0x2c

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
    JNS         .LAB_LOC_1
    NEG         BX
.LAB_LOC_1:
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
    MOV         AX, 0
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
    JA          .LAB_LOC_2
.LAB_LOC_1:
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
.LAB_LOC_2:
    MOV         word [DI + 0xa],BX
    JMP         .LAB_LOC_1
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
F_0948:
    MOV         EAX, 0
    MOV         EBX, 0
    MOV         EDX, 0
    MOV         CX, word [v_num_loaded_cars]
    MOV         DI, 0
.LAB_LOC_1:
    MOV         SI,word [DI + 0x5bbc]
    ADD         SI,word [SI + 0x20]
    MOVZX       EBP,word [SI + 0x2]
    ADD         EAX,EBP
    MOVZX       EBP,word [SI + 0x6]
    ADD         EBX,EBP
    MOVZX       EBP,word [SI + 0xa]
    ADD         EDX,EBP
    ADD         DI,0x2
    LOOP        .LAB_LOC_1
    MOV         ECX,EDX
    MOVZX       EBP, word [v_num_loaded_cars]
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
    JA          .LAB_LOC_3
.LAB_LOC_2:
    MOV         BX,word [0x11e]
    MOV         AX,[0xcc]
    SUB         AX,word [0xb4]
    CALL        FUN_1000_2b08
    SUB         AX,word [0xc4]
    SAR         AX,0x2
    ADD         word [0xc4],AX
    MOV         word [0xc2],0x0
    RET
.LAB_LOC_3:
    MOV         word [0xb4],BX
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
    MOV         SI,word [0xa4]
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5bbc]
    POPF
    CALL        FUN_1000_0a82
    JMP         .LAB_LOC_1
.LAB_LOC_4:
    PUSHF
    AND         byte [CSD_DAT_keys_571e + 3],0x3f
    MOV         SI,word [0xa6]
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5bbc]
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
    ADD         DI,word [SI]
    MOVZX       EAX,word [DI]
    MOV         CX,AX
    SHR         EAX,0x1
    INC         EAX
    IMUL        EAX, dword [v_gravity]
    POPF
    JP          .LAB_LOC_3
    INC         DI
    INC         DI
    MOV         DX,DI
    MOV         BX,word [DI + 0xa]
    ADD         DI,0x1c
    DEC         CX
.LAB_LOC_1:
    MOV         AX,word [DI + 0xa]
    CMP         AX,BX
    JL          .LAB_LOC_4
.LAB_LOC_2:
    ADD         DI,0x1c
    LOOP        .LAB_LOC_1
    MOV         word [SI + 0x22],DX
.LAB_LOC_3:
    MOV         DI,word [SI + 0x22]
    ADD         dword [DI + 0x14],EAX
    RET
.LAB_LOC_4:
    MOV         BX,AX
    MOV         DX,DI
    JMP         .LAB_LOC_2

 ; 1000:0b24 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0b25:
                              ;XREF[3]:     1000:02cc(c),1000:0398(c),1000:0458(c)
    PUSH        FS
    MOV         FS, word [v_memblock_c]
    MOV         DI, 0
    CMP         DI,word [0x3e51]
    JNC         .LAB_LOC_4
.LAB_LOC_1:
    MOV         AX,word [DI + 0x3e55]
    MOV         BX,word [DI + 0x3e59]
    PUSH        AX
    PUSH        BX
    TEST        byte [0x5fb],0x1
    JZ          .LAB_LOC_2
    XCHG        AX,BX
.LAB_LOC_2:
    MOVZX       BX,BH
    MOVZX       AX,AH
    CMP         BX,word [0xe58c]
    JL          .LAB_LOC_5
    CMP         BX,word [0xe58e]
    JG          .LAB_LOC_5
    SHL         BX,0x2
    CMP         AX,word [BX + 0xe590]
    JL          .LAB_LOC_5
    CMP         AX,word [BX + 0xe592]
    JG          .LAB_LOC_5
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
    JC          .LAB_LOC_3
    MOVZX       SI,byte [DI + 0x3e6d]
    SHR         SI,0x4
    SHL         SI,0x1
    MOV         SI,word [SI + 0x5a53]
    CALL        FUN_1000_0cd3
.LAB_LOC_3:
    ADD         DI,0x1c
    CMP         DI,word [0x3e51]
    JC          .LAB_LOC_1
.LAB_LOC_4:
    POP         FS
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
    MOV         DI, 0
    CMP         DI,word [0x3e51]
    JNC         .LAB_LOC_4
.LAB_LOC_1:
    SUB         word [DI + 0x3e6b],0x2
    JS          .LAB_LOC_8
    MOV         EAX,dword [DI + 0x3e5f]
    MOV         EBX,dword [DI + 0x3e63]
    MOV         ECX,dword [DI + 0x3e67]
    ADD         dword [DI + 0x3e53],EAX
    ADD         dword [DI + 0x3e57],EBX
    ADD         dword [DI + 0x3e5b],ECX
    CMP         word [DI + 0x3e6d],0xf
    JNZ         .LAB_LOC_2
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
    JNS         .LAB_LOC_6
    MOV         EAX, [v_gravity]
    SAR         EAX,0x1
    SUB         dword [DI + 0x3e67],EAX
.LAB_LOC_2:
    ADD         DI,0x1c
.LAB_LOC_3:
    CMP         DI,word [0x3e51]
    JC          .LAB_LOC_1
.LAB_LOC_4:
    RET
.LAB_LOC_5:

    RET
.LAB_LOC_6:
    PUSH        AX
    PUSH        BX
    MOV         BL,AH
    MOV         AL,byte FS:[BX]
    TEST        AL,0xf
    JZ          .LAB_LOC_7
    DEC         AL
    MOV         byte FS:[BX],AL
.LAB_LOC_7:
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
    JMP         .LAB_LOC_2
.LAB_LOC_8:

    MOV         SI,word [0x3e51]
    SUB         SI,0x1c
    MOV         word [0x3e51],SI
    JZ          .LAB_LOC_5
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

    JMP         .LAB_LOC_3
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0cd3:
                              ;XREF[1]:     1000:0ba2(c)
    CMP         CX,word [0x120]
    JL          .LAB_LOC_1
    MOV         BP,BX
    MOV         BX,AX
    LODSW 
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
    STOSW 
    MOV         AX,BP
    SUB         AX,DX
    STOSW 
    MOVSD 
    MOV         AX,BX
    ADD         AX,DX
    STOSW 
    MOV         AX,BP
    SUB         AX,DX
    STOSW 
    MOVSD 
    MOV         AX,BX
    ADD         AX,DX
    STOSW 
    MOV         AX,BP
    ADD         AX,DX
    STOSW 
    MOVSD 
    MOV         AX,BX
    SUB         AX,DX
    STOSW 
    MOV         AX,BP
    ADD         AX,DX
    STOSW 
    MOVSD 
    MOV         word [0xdb14],0x4
    CALL        FUN_1000_36fe
    POP         DI
    POP         ES
.LAB_LOC_1:
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0d2a:
                              ;XREF[1]:     1000:56b4(c)
    MOVZX       BX,byte [DI]
    MOV         AL,byte [BX + CSD_DAT_keys_571e]
    MOVZX       BX,byte [DI + 0x1]
    MOV         AH,byte [BX + CSD_DAT_keys_571e]
    MOV         BX,word [SI + 0xc]
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
    MOV         word [SI + 0xc],BX
    MOVZX       BX,byte [DI + 0x2]
    MOV         AL,byte [BX + CSD_DAT_keys_571e]
    MOVZX       BX,byte [DI + 0x3]
    MOV         AH,byte [BX + CSD_DAT_keys_571e]
    MOV         BX,word [SI + 0xa]
    MOV         ECX,dword [SI + 0x42]
    ADD         ECX,dword [SI + 0x46]
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
    MOV         word [SI + 0xa],BX
    MOV         AX, 0
    MOVZX       BX,byte [DI + 0x4]
    TEST        byte [BX + CSD_DAT_keys_571e],0x80
    JNZ         .LAB_LOC_14
    OR          AX,0x1
.LAB_LOC_14:
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
    MOV         EAX, 0
    MOV         EBX, 0
    MOV         ECX, 0
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
    MOV         EDX,dword [SI + 0x42]
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
    MOV         EDX,dword [SI + 0x46]
    RET
.LAB_LOC_5:
    TEST        word [CSD_WORD_1000_0e67],0x2
    JNZ         .LAB_LOC_6
    PUSH        SI
    ADD         SI,word [SI]
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
    MOV         EDX,dword [SI + 0x4a]
    RET
.LAB_LOC_7:
    TEST        word [CSD_WORD_1000_0e67],0x2
    JNZ         .LAB_LOC_8
    PUSH        SI
    ADD         SI,word [SI]
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
    MOV         EDX,dword [SI + 0x4e]
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_0f67:
                              ;XREF[1]:     1000:4bd5(c)
    MOV         CX,word [SI + 0x8]
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
    MOV         EAX,dword [SI + 0x42]
    SUB         EAX,EBX
    SAR         EAX,0x2
    ADD         EAX,EBX
    MOV         dword [SI + 0x42],EAX
    RET
.LAB_LOC_2:
    MOV         dword [SI + 0x42],EBX
    RET
.LAB_LOC_3:
    TEST        CX,CX
    JZ          .LAB_LOC_4
    MOV         EAX,dword [SI + 0x46]
    SUB         EAX,EBX
    SAR         EAX,0x2
    ADD         EAX,EBX
    MOV         dword [SI + 0x46],EAX
    RET
.LAB_LOC_4:
    MOV         dword [SI + 0x46],EBX
    RET
.LAB_LOC_5:
    TEST        CX,0x1
    JZ          .LAB_LOC_6
    MOV         EAX,dword [SI + 0x4a]
    SUB         EAX,EBX
    SAR         EAX,0x2
    ADD         EAX,EBX
    MOV         dword [SI + 0x4a],EAX
    RET
.LAB_LOC_6:
    MOV         dword [SI + 0x4a],EBX
    RET
.LAB_LOC_7:
    TEST        CX,0x1
    JZ          .LAB_LOC_8
    MOV         EAX,dword [SI + 0x4e]
    SUB         EAX,EBX
    SAR         EAX,0x2
    ADD         EAX,EBX
    MOV         dword [SI + 0x4e],EAX
    RET
.LAB_LOC_8:
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
.LAB_LOC_1:
    MOV         EAX,dword [BX + SI + 0x42]
    SAR         EAX,0x7
    SUB         dword [BX + SI + 0x42],EAX
    ADD         BX,0x4
    LOOP        .LAB_LOC_1
    TEST        word [SI + 0xe],0x1
    JZ          .LAB_LOC_3
    MOV         CX,0x10
    MOV         BX,0x0
.LAB_LOC_2:
    MOV         EAX,dword [BX + SI + 0x42]
    SAR         EAX,0x2
    SUB         dword [BX + SI + 0x42],EAX
    ADD         BX,0x4
    LOOP        .LAB_LOC_2
.LAB_LOC_3:
    MOV         AX,word [SI + 0x18]
    CWD
    MOV         CX,0x4000
    IMUL        CX
    MOVSX       EAX,DX
    MOV         BX,word [SI + 0x8]
    TEST        BX,BX
    JZ          .LAB_LOC_4
    DEC         BX
    JZ          .LAB_LOC_5
    ROL         EAX,0x3
    ADD         dword [SI + 0x42],EAX
    ADD         dword [SI + 0x46],EAX
    ADD         dword [SI + 0x4a],EAX
    ADD         dword [SI + 0x4e],EAX
    RET
.LAB_LOC_4:
    ROL         EAX,0x4
    ADD         dword [SI + 0x4a],EAX
    ADD         dword [SI + 0x4e],EAX
    RET
.LAB_LOC_5:
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
    MOV         [CSD_DWORD_1000_12b3],EAX
    MOV         dword [CSD_DWORD_1000_12b7],EBX
    MOV         dword [CSD_DWORD_1000_12bb],ECX
    CALL        FUN_1000_10b6
    MOV         [CSD_DWORD_1000_12bf],EAX
    MOV         dword [CSD_DWORD_1000_12c3],EBX
    MOV         dword [CSD_DWORD_1000_12c7],ECX
    POP         SI
    MOV         BX,word [SI + 0x16]
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
FUN_1000_11f0:
                              ;XREF[1]:     1000:138f(c)
    PUSH        SI
    ADD         SI,word [SI]
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
    MOV         BX,word [SI + 0x16]
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
    MOV         AX,word [SI + 0x1e]
    TEST        AX,AX
    JNZ         .LAB_LOC_1
    MOV         AX, [v_memblock_c]
.LAB_LOC_1:
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
.LAB_LOC_1:
    PUSH        CX
    MOV         EAX,dword [SI]
    MOV         EBX,dword [SI + 0x4]
    MOV         ECX,dword [SI + 0x8]
    CALL        FUN_1000_13cc
    MOV         EAX,dword [SI]
    MOV         EBX,dword [SI + 0x4]
    PUSH        EAX
    PUSH        EBX
    shr  EAX, 0x10
    shr  EBX, 0x10
    CALL        FUN_1000_25c5
    MOV         CX,AX
    POP         EBX
    POP         EAX
    SHL         ECX,0x10
    CALL        FUN_1000_13cc
    ADD         SI,0x1c
    POP         CX
    LOOP        .LAB_LOC_1
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
    JC          .LAB_LOC_1
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
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
    LODSB 
    MOVZX       BX,AL
    SHL         BX, 1
    AND BX, 63
    JMP         [CS:BX + .JMP_TABLE_1413]
.JMP_TABLE_1413:
    ;addr[21]
         dw  .LAB_LOC_1
         dw  .LAB_LOC_6
         dw  .LAB_LOC_7
         dw  .LAB_LOC_8
         dw  .LAB_LOC_9
         dw  .LAB_LOC_11
         dw  .LAB_LOC_12
         dw  .LAB_LOC_14
         dw  .LAB_LOC_16
         dw  .LAB_LOC_18
         dw  .LAB_LOC_20
         dw  .LAB_LOC_1
         dw  .LAB_LOC_1
         dw  .LAB_LOC_1
         dw  .LAB_LOC_1
         dw  .LAB_LOC_1
         dw  .LAB_LOC_24
         dw  .LAB_LOC_2
         dw  .LAB_LOC_3
         dw  .LAB_LOC_4
         dw  .LAB_LOC_5

         times 11 dw .LAB_RUIM

.LAB_RUIM:
    ud2

.LAB_LOC_1:
                              ;             1000:142f(*),1000:1431(*)
    RET
.LAB_LOC_2:
    LODSW 
    ADD         SI,AX
    JMP         FUN_1000_1408
.LAB_LOC_3:
    LODSW 
    PUSH        SI
    ADD         SI,AX
    CALL        FUN_1000_1408
    POP         SI
    JMP         FUN_1000_1408
.LAB_LOC_4:
    MOV         AL,[0x5ee]
    SAHF
    LODSW 
    JS          FUN_1000_1408
    ADD         SI,AX
    JMP         FUN_1000_1408
.LAB_LOC_5:
    MOV         AL,[0x5ee]
    SAHF
    LODSW 
    JNS         FUN_1000_1408
    ADD         SI,AX
    JMP         FUN_1000_1408
.LAB_LOC_6:
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    MOV         AX,[0x120]
    CMP         word [DI + 0x2],AX
    LODSW 
    MOV         CL,AL
    JL          FUN_1000_1408
    MOV         AX,word [DI + 0x6]
    MOV         BX,word [DI + 0x8]
    CALL        FUN_1000_3f98
    JMP         FUN_1000_1408
.LAB_LOC_7:
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    MOV         BX,word [DI + 0x128]
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    MOV         AX,word [DI + 0x128]
    LODSW 
    CMP         BX,AX
    LAHF
    MOV         [0x5ee],AL
    JMP         FUN_1000_1408
.LAB_LOC_8:
    MOV         BX, 0
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    LODSW 
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
.LAB_LOC_9:
    LODSB 
    MOVZX       CX,AL
    MOV         BX, 0
    LODSW 
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
    LODSW 
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
    LOOP        .LAB_LOC_10
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    XCHG        DI,SI
    CALL        FUN_1000_47ec
    XCHG        DI,SI
    MOV         BL,AL
    LODSW 
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
.LAB_LOC_11:
    JMP         FUN_1000_1408
.LAB_LOC_12:
    LODSB 
    MOVZX       CX,AL
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSW 
    MOV         BX,AX
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    DEC         CX
.LAB_LOC_13:
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSW 
    MOV         BX,AX
    PUSH        CX
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    POP         CX
    LOOP        .LAB_LOC_13
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSW 
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
.LAB_LOC_14:
    LODSB 
    MOVZX       CX,AL
    LODSW 
    MOV         [0xdb12],AX
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSW 
    MOV         BX,AX
    MOV         BX,word [BX + 0x50e]
    ADD         BX,word [0xdb12]
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    DEC         CX
.LAB_LOC_15:
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSW 
    MOV         BX,AX
    MOV         BX,word [BX + 0x50e]
    ADD         BX,word [0xdb12]
    PUSH        CX
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    POP         CX
    LOOP        .LAB_LOC_15
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSW 
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
.LAB_LOC_16:
    LODSB 
    MOVZX       CX,AL
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSD 
    MOV         EBX,EAX
    XCHG        DI,SI
    CALL        FUN_1000_46a0
    XCHG        DI,SI
    DEC         CX
.LAB_LOC_17:
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSD 
    MOV         EBX,EAX
    PUSH        CX
    XCHG        DI,SI
    CALL        FUN_1000_46d3
    XCHG        DI,SI
    POP         CX
    LOOP        .LAB_LOC_17
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    LODSD 
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
.LAB_LOC_18:
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    ADD         DI,0x126
    MOV         CX,word [DI + 0x2]
    CMP         CX,word [0x120]
    JL          .LAB_LOC_19
    MOV         BX,word [DI + 0x6]
    MOV         BP,word [DI + 0x8]
    LODSW 
    CWD
    IDIV        CX
    MOV         DX,AX
    PUSH        ES
    MOV         AX,DS
    MOV         ES,AX
    MOV         DI,0xdb16
    MOV         AX,BX
    SUB         AX,DX
    STOSW 
    MOV         AX,BP
    SUB         AX,DX
    STOSW 
    MOVSD 
    MOV         AX,BX
    ADD         AX,DX
    STOSW 
    MOV         AX,BP
    SUB         AX,DX
    STOSW 
    MOVSD 
    MOV         AX,BX
    ADD         AX,DX
    STOSW 
    MOV         AX,BP
    ADD         AX,DX
    STOSW 
    MOVSD 
    MOV         AX,BX
    SUB         AX,DX
    STOSW 
    MOV         AX,BP
    ADD         AX,DX
    STOSW 
    MOVSD 
    POP         ES
    MOV         word [0xdb14],0x4
    CALL        FUN_1000_36fe
    JMP         FUN_1000_1408
.LAB_LOC_19:
    ADD         SI,0x12
    JMP         FUN_1000_1408
.LAB_LOC_20:
    PUSH        SI
    LODSW 
    SHL         AX,0x1
    MOV         BX,AX
    SHL         AX,0x2
    ADD         BX,AX
    MOV         AX,word [BX + 0x128]
    CMP         AX,word [0x120]
    JL          .LAB_LOC_23
    LODSW 
    SHL         AX,0x1
    MOV         DI,AX
    SHL         AX,0x2
    ADD         DI,AX
    LODSW 
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
.LAB_LOC_21:
    CMP         AX,word [BX]
    JL          .LAB_LOC_22
    ADD         BX,0x2
    LOOP        .LAB_LOC_21
.LAB_LOC_22:
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
    STOSW 
    MOV         AX,BP
    ADD         AX,word [0x5d6]
    SUB         AX,word [0x5dc]
    STOSW 
    MOVSD 
    MOV         AX,BX
    SUB         AX,word [0x5d8]
    ADD         AX,word [0x5da]
    STOSW 
    MOV         AX,BP
    ADD         AX,word [0x5d6]
    ADD         AX,word [0x5dc]
    STOSW 
    MOVSD 
    MOV         AX,BX
    ADD         AX,word [0x5d8]
    ADD         AX,word [0x5da]
    STOSW 
    MOV         AX,BP
    SUB         AX,word [0x5d6]
    ADD         AX,word [0x5dc]
    STOSW 
    MOVSD 
    MOV         AX,BX
    ADD         AX,word [0x5d8]
    SUB         AX,word [0x5da]
    STOSW 
    MOV         AX,BP
    SUB         AX,word [0x5d6]
    SUB         AX,word [0x5dc]
    STOSW 
    MOVSD 
    POP         ES
    MOV         word [0xdb14],0x4
    CALL        FUN_1000_36fe
.LAB_LOC_23:
    POP         SI
    ADD         SI,0xba
    JMP         FUN_1000_1408
.LAB_LOC_24:
    MOV         AL,[0x5ee]
    SAHF
    JS          .LAB_LOC_25
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
.LAB_LOC_25:
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
    MOV         CX, word [v_num_loaded_cars]
.LAB_LOC_1:
    MOV         SI,word [DI]
    CMP         DX,word [SI + 0x1a]
    JNZ         .LAB_LOC_2
    CALL        FUN_1000_1323
.LAB_LOC_2:
    ADD         DI,0x2
    LOOP        .LAB_LOC_1
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
    JNP         .LAB_LOC_24
    MOV         byte [0x5fb],0x0
    CALL        FUN_1000_3fd0

    push_args 2, 0
    CALL        FUN_1000_40c8
    add sp,4
    MOV         AX,[0xc6]
    TEST        AH,0xa0
    JNP         .LAB_LOC_12
    MOV         DI,0x5bbc
    MOV         CX, word [v_num_loaded_cars]
.LAB_LOC_1:
    PUSH        CX
    MOV         SI,word [DI]
    CALL        FUN_1000_22f0
    ADD         DI,0x2
    POP         CX
    LOOP        .LAB_LOC_1
    MOV         SI,0xe590
    MOV         AX,[0xe58c]
    MOV         BH,AL
    SHL         AX,0x2
    ADD         SI,AX
.LAB_LOC_2:
    PUSH        BX
    MOV         BL,byte [SI]
    MOVZX       DX,BL
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
.LAB_LOC_3:
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX + 0xfeff]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    MOV         AL, 0
    MOV         BL, 0
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
    JL          .LAB_LOC_4
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
.LAB_LOC_4:
    MOV         DX,word [0x5fd]
    CMP         DH,byte [0xe58c]
    JZ          .LAB_LOC_5
    CMP         DL,byte [SI]
    JZ          .LAB_LOC_5
    CMP         DL,byte [SI + -0x4]
    JBE         .LAB_LOC_5
    CMP         DL,byte [SI + -0x2]
    JA          .LAB_LOC_5
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
.LAB_LOC_5:
    POP         BX
    CMP         BL,byte [0xad]
    JNC         .LAB_LOC_6
    INC         BL
    ADD         DI,0xa
    JMP         .LAB_LOC_3
.LAB_LOC_6:
    MOV         BL,byte [SI + 0x2]
    MOVZX       DX,BL
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
.LAB_LOC_7:
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX + 0xff00]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    MOV         AL, 0
    MOV         BL, 0
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
    JL          .LAB_LOC_8
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
.LAB_LOC_8:
    MOV         DX,word [0x5fd]
    CMP         DH,byte [0xe58c]
    JZ          .LAB_LOC_9
    CMP         DL,byte [SI + 0x2]
    JZ          .LAB_LOC_9
    CMP         DL,byte [SI + -0x4]
    JC          .LAB_LOC_9
    CMP         DL,byte [SI + -0x2]
    JNC         .LAB_LOC_9
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
.LAB_LOC_9:
    POP         BX
    CMP         BL,byte [0xad]
    JBE         .LAB_LOC_10
    DEC         BL
    SUB         DI,0xa
    JMP         .LAB_LOC_7
.LAB_LOC_10:
    POP         BX
    CMP         BH,byte [0xe58e]
    JNC         .LAB_LOC_11
    INC         BH
    ADD         SI,0x4
    XOR         word [0x19ff],0xa00
    XOR         word [0x1a01],0xa00
    JMP         .LAB_LOC_2
.LAB_LOC_11:
    RET
.LAB_LOC_12:
    MOV         DI,0x5bbc
    MOV         CX, word [v_num_loaded_cars]
.LAB_LOC_13:
    PUSH        CX
    MOV         SI,word [DI]
    CALL        FUN_1000_233b
    ADD         DI,0x2
    POP         CX
    LOOP        .LAB_LOC_13
    MOV         SI,0xe590
    MOV         AX,[0xe58e]
    MOV         BH,AL
    SHL         AX,0x2
    ADD         SI,AX
.LAB_LOC_14:
    PUSH        BX
    MOV         BL,byte [SI]
    MOVZX       DX,BL
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
.LAB_LOC_15:
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX + -0x1]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    MOV         AL, 0
    MOV         BL, 0
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
    JL          .LAB_LOC_16
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
.LAB_LOC_16:
    MOV         DX,word [0x5fd]
    CMP         DH,byte [0xe58e]
    JZ          .LAB_LOC_17
    CMP         DL,byte [SI]
    JZ          .LAB_LOC_17
    CMP         DL,byte [SI + 0x4]
    JBE         .LAB_LOC_17
    CMP         DL,byte [SI + 0x6]
    JA          .LAB_LOC_17
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
.LAB_LOC_17:
    POP         BX
    CMP         BL,byte [0xad]
    JNC         .LAB_LOC_18
    INC         BL
    ADD         DI,0xa
    JMP         .LAB_LOC_15
.LAB_LOC_18:
    MOV         BL,byte [SI + 0x2]
    MOVZX       DX,BL
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
.LAB_LOC_19:
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    MOV         AL, 0
    MOV         BL, 0
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
    JL          .LAB_LOC_20
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
.LAB_LOC_20:
    MOV         DX,word [0x5fd]
    CMP         DH,byte [0xe58e]
    JZ          .LAB_LOC_21
    CMP         DL,byte [SI + 0x2]
    JZ          .LAB_LOC_21
    CMP         DL,byte [SI + 0x4]
    JC          .LAB_LOC_21
    CMP         DL,byte [SI + 0x6]
    JNC         .LAB_LOC_21
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
.LAB_LOC_21:
    POP         BX
    CMP         BL,byte [0xad]
    JBE         .LAB_LOC_22
    DEC         BL
    SUB         DI,0xa
    JMP         .LAB_LOC_19
.LAB_LOC_22:
    POP         BX
    CMP         BH,byte [0xe58c]
    JBE         .LAB_LOC_23
    DEC         BH
    SUB         SI,0x4
    XOR         word [0x19ff],0xa00
    XOR         word [0x1a01],0xa00
    JMP         .LAB_LOC_14
.LAB_LOC_23:
    RET
;this was 2 functions below, its here now for the local labels to work
.LAB_LOC_24:
    MOV         byte [0x5fb],0x1
    CALL        FUN_1000_41b2

    push_args 0, 2
    CALL        FUN_1000_40c8
    add sp,4
    MOV         AX,[0xc6]
    TEST        AH,0xc0
    JNS         .LAB_LOC_36
    MOV         DI,0x5bbc
    MOV         CX, word [v_num_loaded_cars]
.LAB_LOC_25:
    PUSH        CX
    MOV         SI,word [DI]
    CALL        FUN_1000_2384
    ADD         DI,0x2
    POP         CX
    LOOP        .LAB_LOC_25
    MOV         SI,0xe590
    MOV         AX,[0xe58c]
    MOV         BL,AL
    SHL         AX,0x2
    ADD         SI,AX
.LAB_LOC_26:
    PUSH        BX
    MOV         BH,byte [SI]
    MOVZX       DX,BH
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
.LAB_LOC_27:
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX + 0xfeff]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    MOV         AL, 0
    MOV         BL, 0
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
    JL          .LAB_LOC_28
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
.LAB_LOC_28:
    MOV         DX,word [0x5fd]
    CMP         DL,byte [0xe58c]
    JZ          .LAB_LOC_29
    CMP         DH,byte [SI]
    JZ          .LAB_LOC_29
    CMP         DH,byte [SI + -0x4]
    JBE         .LAB_LOC_29
    CMP         DH,byte [SI + -0x2]
    JA          .LAB_LOC_29
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
.LAB_LOC_29:
    POP         BX
    CMP         BH,byte [0xb1]
    JNC         .LAB_LOC_30
    INC         BH
    ADD         DI,0xa
    JMP         .LAB_LOC_27
.LAB_LOC_30:
    MOV         BH,byte [SI + 0x2]
    MOVZX       DX,BH
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
.LAB_LOC_31:
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX + -0x1]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    MOV         AL, 0
    MOV         BL, 0
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
    JL          .LAB_LOC_32
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
.LAB_LOC_32:
    MOV         DX,word [0x5fd]
    CMP         DL,byte [0xe58c]
    JZ          .LAB_LOC_33
    CMP         DH,byte [SI + 0x2]
    JZ          .LAB_LOC_33
    CMP         DH,byte [SI + -0x4]
    JC          .LAB_LOC_33
    CMP         DH,byte [SI + -0x2]
    JNC         .LAB_LOC_33
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
.LAB_LOC_33:
    POP         BX
    CMP         BH,byte [0xb1]
    JBE         .LAB_LOC_34
    DEC         BH
    SUB         DI,0xa
    JMP         .LAB_LOC_31
.LAB_LOC_34:
    POP         BX
    CMP         BL,byte [0xe58e]
    JNC         .LAB_LOC_35
    INC         BL
    ADD         SI,0x4
    XOR         word [0x19ff],0xa00
    XOR         word [0x1a01],0xa00
    JMP         .LAB_LOC_26
.LAB_LOC_35:
    RET
.LAB_LOC_36:
    MOV         DI,0x5bbc
    MOV         CX, word [v_num_loaded_cars]
.LAB_LOC_37:
    PUSH        CX
    MOV         SI,word [DI]
    CALL        FUN_1000_23cf
    ADD         DI,0x2
    POP         CX
    LOOP        .LAB_LOC_37
    MOV         SI,0xe590
    MOV         AX,[0xe58e]
    MOV         BL,AL
    SHL         AX,0x2
    ADD         SI,AX
.LAB_LOC_38:
    PUSH        BX
    MOV         BH,byte [SI]
    MOVZX       DX,BH
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
.LAB_LOC_39:
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX + 0xff00]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    MOV         AL, 0
    MOV         BL, 0
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
    JL          .LAB_LOC_40
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
.LAB_LOC_40:
    MOV         DX,word [0x5fd]
    CMP         DL,byte [0xe58e]
    JZ          .LAB_LOC_41
    CMP         DH,byte [SI]
    JZ          .LAB_LOC_41
    CMP         DH,byte [SI + 0x4]
    JBE         .LAB_LOC_41
    CMP         DH,byte [SI + 0x6]
    JA          .LAB_LOC_41
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
.LAB_LOC_41:
    POP         BX
    CMP         BH,byte [0xb1]
    JNC         .LAB_LOC_42
    INC         BH
    ADD         DI,0xa
    JMP         .LAB_LOC_39
.LAB_LOC_42:
    MOV         BH,byte [SI + 0x2]
    MOVZX       DX,BH
    SHL         DX,0x1
    MOV         DI,DX
    SHL         DI,0x2
    ADD         DI,DX
    ADD         DI,0x5ff
    ADD         DI,word [0x19ff]
.LAB_LOC_43:
    MOV         word [0x5fd],BX
    PUSH        BX
    MOV         AL,byte FS:[BX]
    MOV         [0x5fc],AL
    MOVZX       CX,byte GS:[BX]
    SHL         CX,0x4
    MOV         AH,BL
    MOV         AL, 0
    MOV         BL, 0
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
    JL          .LAB_LOC_44
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
    MOV         word [DI + 0x6],AX
    MOV         word [DI + 0x8],BX
.LAB_LOC_44:
    MOV         DX,word [0x5fd]
    CMP         DL,byte [0xe58e]
    JZ          .LAB_LOC_45
    CMP         DH,byte [SI + 0x2]
    JZ          .LAB_LOC_45
    CMP         DH,byte [SI + 0x4]
    JC          .LAB_LOC_45
    CMP         DH,byte [SI + 0x6]
    JNC         .LAB_LOC_45
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
.LAB_LOC_45:
    POP         BX
    CMP         BH,byte [0xb1]
    JBE         .LAB_LOC_46
    DEC         BH
    SUB         DI,0xa
    JMP         .LAB_LOC_43
.LAB_LOC_46:
    POP         BX
    CMP         BL,byte [0xe58c]
    JBE         .LAB_LOC_47
    DEC         BL
    SUB         SI,0x4
    XOR         word [0x19ff],0xa00
    XOR         word [0x1a01],0xa00
    JMP         .LAB_LOC_38
.LAB_LOC_47:
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
    JL          .LAB_LOC_4
    ADD         BH,CH
    XLAT      
    MOV         AH,AL
    MOV         [0xdb12],AX
    PUSH        SI
    LEA         SI,[DI + 0xa]
    MOV         EBX, 0
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
    MOV         EBX, 0
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
    MOV         AX,[0xdb12]
    TEST        AL,0xf
    JZ          .LAB_LOC_2
    SUB         word [0xdb12],0x101
.LAB_LOC_2:
    CALL        FUN_1000_2bec
.LAB_LOC_3:
    RET
.LAB_LOC_4:
    PUSH        FS
    MOV         FS, word [v_memblock_d]
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
    JL          .LAB_LOC_5
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JNS         .LAB_LOC_5
    CALL        FUN_1000_36fe
.LAB_LOC_5:
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
    JL          .LAB_LOC_6
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JNS         .LAB_LOC_6
    CALL        FUN_1000_36fe
.LAB_LOC_6:
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
    JL          .LAB_LOC_4
    ADD         BH,CH
    XLAT     
    MOV         AH,AL
    MOV         [0xdb12],AX
    PUSH        SI
    LEA         SI,[DI + 0xa]
    MOV         EBX, 0
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
    MOV         AX,[0xdb12]
    TEST        AL,0xf
    JZ          .LAB_LOC_2
    SUB         word [0xdb12],0x101
.LAB_LOC_2:
    CALL        FUN_1000_2bec
.LAB_LOC_3:
    RET
.LAB_LOC_4:
    PUSH        FS
    MOV         FS, word [v_memblock_d]
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
    JL          .LAB_LOC_5
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JS          .LAB_LOC_5
    CALL        FUN_1000_36fe
.LAB_LOC_5:
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
    JL          .LAB_LOC_6
    MOV         SI,0xdb16
    CALL        FUN_1000_2662
    JS          .LAB_LOC_6
    CALL        FUN_1000_36fe
.LAB_LOC_6:
    POP         FS
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
.LAB_LOC_1:
    MOV         AH,byte [SI + 0x7]
    MOV         AL,byte [SI + 0x3]
    MOV         DX,AX
    SUB         AH,byte [0xb1]
    SUB         AL,byte [0xad]
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
    DEC         BP
    JNZ         .LAB_LOC_1
    POP         SI
    MOV         word [SI + 0x1a],BX
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
    ADD         SI,word [SI]
    MOV         BP,word [SI]
    ADD         SI,0x2
    MOV         BX,0x0
    MOV         CX,0x7f7f
.LAB_LOC_1:
    MOV         AH,byte [SI + 0x7]
    MOV         AL,byte [SI + 0x3]
    MOV         DX,AX
    SUB         AH,byte [0xb1]
    SUB         AL,byte [0xad]
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
    DEC         BP
    JNZ         .LAB_LOC_1
    POP         SI
    MOV         word [SI + 0x1a],BX
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
    ADD         SI,word [SI]
    MOV         BP,word [SI]
    ADD         SI,0x2
    MOV         BX,0x0
    MOV         CX,0x7f7f
.LAB_LOC_1:
    MOV         AH,byte [SI + 0x7]
    MOV         AL,byte [SI + 0x3]
    MOV         DX,AX
    SUB         AH,byte [0xb1]
    SUB         AL,byte [0xad]
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
    DEC         BP
    JNZ         .LAB_LOC_1
    POP         SI
    MOV         word [SI + 0x1a],BX
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
    ADD         SI,word [SI]
    MOV         BP,word [SI]
    ADD         SI,0x2
    MOV         BX,0x0
    MOV         CX,0x7f7f
.LAB_LOC_1:
    MOV         AH,byte [SI + 0x7]
    MOV         AL,byte [SI + 0x3]
    MOV         DX,AX
    SUB         AH,byte [0xb1]
    SUB         AL,byte [0xad]
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
    DEC         BP
    JNZ         .LAB_LOC_1
    POP         SI
    MOV         word [SI + 0x1a],BX
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
    CMP         BX,word [0x120]
    JL          .LAB_LOC_1
    CALL        FUN_1000_2760
    ADD         AX,word [0xdbb8]
    NEG         BX
    ADD         BX,word [0xdbba]
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
    MOV         CX,word [SI]
    INC         CX
    INC         CX
    MOV         word [SI + 0x20],CX
    MOV         DI,SI
    ADD         DI,CX
    MOV         CX,word [DI]
.LAB_LOC_1:
    CMP         word [DI + 0x1a],-0x1
    JZ          .LAB_LOC_2
    ADD         DI,0x1c
    LOOP        .LAB_LOC_1
    RET
.LAB_LOC_2:
    SUB         DI,SI
    MOV         word [SI + 0x20],DI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2454:
                              ;XREF[1]:     1000:01a9(c)

    PUSH        AX
    PUSH        BX
    PUSH        ES
    PUSH        DI
    PUSH        DS
    POP         ES
    MOV         CX,0x82
    MOV         AL, 0
    CLD
    REP STOSB 
    POP         DI
    POP         ES
    MOV         DX,DX
    MOV         AL,0x0
    MOV         AH,0x3d
    call far DOS3Call
    MOV         BX,AX
    JC          .LAB_LOC_2
    MOV         DX,DI
    MOV         CX,0x2710
    MOV         AH,0x3f
    call far DOS3Call
    MOV         BP,AX
    MOV         AH,0x3e
    call far DOS3Call
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
.LAB_LOC_1:
    ADD         dword [SI],EAX
    ADD         dword [SI + 0x4],EBX
    ADD         dword [SI + 0x8],EDX
    ADD         SI,0x1c
    LOOP        .LAB_LOC_1
    MOV         AX,BP

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
    PUSH        ES
    MOV         DX,0x1a03
    MOV         ES, word [v_memblock_a]
    MOV         DI, 0
    CALL        FUN_1000_5a60
    JC          .LAB_LOC_1
    MOV         DX,0x1a20
    MOV         ES, word [v_memblock_d]
    MOV         DI, 0
    CALL        FUN_1000_5a60
    JC          .LAB_LOC_1
    MOV         DX,0x1a0b
    MOV         AL,0x0
    MOV         AH,0x3d
    call far DOS3Call
    MOV         BX,AX
    CALL        FUN_1000_5a95
    JC          .LAB_LOC_1
    MOV         CX,0xffff
    MOV         DX,0xfd00
    MOV         AX,0x4202
    call far DOS3Call
    JC          .LAB_LOC_1
    MOV         DX, v_palette
    MOV         CX,0x300
    MOV         AH,0x3f
    call far DOS3Call
    MOV         CX,0x0
    MOV         DX,0x80
    MOV         AX,0x4200
    call far DOS3Call
    MOV         ES, word [v_memblock_b]
    MOV         DI, 0
    CALL        FUN_1000_5acf
    JC          .LAB_LOC_1
    MOV         AH,0x3e
    call far DOS3Call
    MOV         DX,0x1a2b
    MOV         AL,0x0
    MOV         AH,0x3d
    call far DOS3Call
    MOV         BX,AX
    MOV         DX,0x1d51
    MOV         CX,0x1100
    MOV         AH,0x3f
    call far DOS3Call
    MOV         AH,0x3e
    call far DOS3Call
    MOV         DX,0x1a33
    MOV         AL,0x0
    MOV         AH,0x3d
    call far DOS3Call
    MOV         BX,AX
    MOV         DX,0x2e51
    MOV         CX,0x1000
    MOV         AH,0x3f
    call far DOS3Call
    MOV         AH,0x3e
    call far DOS3Call
.LAB_LOC_1:
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
    MOV         ES, word [v_memblock_c]
    MOV         DI, 0
    CALL        FUN_1000_5a60
    POP         ES
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_256b:
    prologo 3
                              ;XREF[2]:     1000:261a(c),1000:265b(c)
    MOV         AX,[0x5ac1]
    IMUL        word [0x5ac9]
    MOV         [local_a],AX
    MOV         AX,[0x5ac3]
    IMUL        word [0x5ac7]
    SUB         word [local_a],AX
    MOV         AX,[0x5acd]
    IMUL        word [0x5ac9]
    MOV         [local_b],AX
    MOV         AX,[0x5acf]
    IMUL        word [0x5ac7]
    SUB         word [local_b],AX
    MOV         AX,[0x5acf]
    IMUL        word [0x5ac1]
    MOV         [local_c],AX
    MOV         AX,[0x5acd]
    IMUL        word [0x5ac3]
    SUB         word [local_c],AX
    MOV         AX,[0x5ac5]
    IMUL        word [local_b]
    MOV         BX,AX
    MOV         CX,DX
    MOV         AX,[0x5acb]
    IMUL        word [local_c]
    ADD         AX,BX
    ADC         DX,CX
    IDIV        word [local_a]

    epilogo
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
    JA          .LAB_LOC_1
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
    JMP         .LAB_LOC_2
.LAB_LOC_1:
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
    JP          .LAB_LOC_1
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
.LAB_LOC_1:
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
    MOV         AL, 0
    IDIV        BX
    XCHG        AX,CX
    MOV         DX,AX
    MOV         AL,DH
    CBW
    XCHG        AX,DX
    MOV         AH,AL
    MOV         AL, 0
    IDIV        BX
    XCHG        CX,BX
    XCHG        AX,BX
    RET

 ; 1000:277d [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;ANALYSIS: seems to be related to camera rotation and maybe position, if I nop it the camera stops rotating and following the car
;MODIFICATIONS: before ES and BP was used as temporary storage, this broke protected mode (the writing to ES part), modified to use the stack
FUN_1000_277e:
                              ;XREF[10]:    1000:0b88(c),1000:13ea(c),1000:19ee(c),1000:1aa6(c),
                              ;             1000:1b99(c),1000:1c4e(c),1000:2001(c),1000:20b8(c),
                              ;             1000:21ab(c),1000:2260(c)
    prologo 2

    XCHG        AX,BX
    XCHG        AX,CX
    PUSH        DI
    MOV         DI,DX
    MOV         [local_a],AX
    MOV         AX,BX
    IMUL        word [DI]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         [local_b],DX
    MOV         AX,CX
    IMUL        word [DI + 0x6]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         [local_b],DX
    MOV         AX, [local_a]
    IMUL        word [DI + 0xc]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         [local_b],DX
    PUSH        [local_b]
    MOV         AX,BX
    IMUL        word [DI + 0x2]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         [local_b],DX
    MOV         AX,CX
    IMUL        word [DI + 0x8]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         [local_b],DX
    MOV         AX,[local_a]
    IMUL        word [DI + 0xe]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         [local_b],DX
    PUSH        [local_b]
    MOV         AX,BX
    IMUL        word [DI + 0x4]
    SHL         AX,0x1
    RCL         DX,0x1
    MOV         [local_b],DX
    MOV         AX,CX
    IMUL        word [DI + 0xa]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         [local_b],DX
    MOV         AX,[local_a]
    IMUL        word [DI + 0x10]
    SHL         AX,0x1
    RCL         DX,0x1
    ADD         [local_b],DX
    MOV         CX,[local_b]
    POP         BX
    POP         AX
    POP         DI

    epilogo

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
    JNZ         .LAB_LOC_1
    INC         DX
.LAB_LOC_1:
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
    JNZ         .LAB_LOC_2
    INC         DX
.LAB_LOC_2:
    NEG         DX
    MOV         word [DI + 0x2],DX
    MOV         AX,[0xd100]
    IMUL        word [0xd106]
    SHL         AX,0x1
    RCL         DX,0x1
    CMP         DX,0x8000
    JNZ         .LAB_LOC_3
    INC         DX
.LAB_LOC_3:
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
    JNZ         .LAB_LOC_4
    INC         DX
.LAB_LOC_4:
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
    JNZ         .LAB_LOC_5
    INC         DX
.LAB_LOC_5:
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
    MOV         AX,word [BX + 0xd10c]
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
    MOV         AX,word [BX + 0xd10c]
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
    MOV         AX, 0
    DIV         BX
    MOV         BL,AH
    MOV         BH, 0
    SHL         BX,0x1
    MOV         AX,word [BX + 0xd90e]
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
    call far DOS3Call
    JC          .LAB_LOC_1
    MOV         [v_image_segment],AX
.LAB_LOC_1:
    RET

 ; 1000:2b97 [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;ANALYSIS: this clears the framebuffer
FUN_1000_2b98:
                              ;XREF[2]:     1000:02c6(c),1000:0392(c)
    PUSH        ES
    PUSH        DI
    MOV         ES, word [v_image_segment]
    MOV         DI, 0
    MOV         CX,0x3e80
    CLD
    REP STOSD 
    POP         DI
    POP         ES
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
    JC          .LAB_LOC_2
    MOV         AX,[0xdbbe]
    MOV         [0xdbc4],AX
    MOV         AX,[0xdbbc]
    MOV         [0xdbc6],AX
    PUSH        SI
    DEC         CX
.LAB_LOC_1:
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
    LOOP        .LAB_LOC_1
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    POP         SI
    MOV         CX,word [SI]
    MOV         DX,word [SI + 0x2]
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
    CMP         BX,word [0xdbc4]
    JGE         .LAB_LOC_1
    MOV         word [0xdbc4],BX
.LAB_LOC_1:
    CMP         CX,word [0xdbc6]
    JLE         .LAB_LOC_2
    MOV         word [0xdbc6],CX
.LAB_LOC_2:
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0xdbca
    JMP         .LAB_LOC_6
.LAB_LOC_3:
    CMP         BX,word [0xdbc4]
    JGE         .LAB_LOC_4
    MOV         word [0xdbc4],BX
.LAB_LOC_4:
    CMP         CX,word [0xdbc6]
    JLE         .LAB_LOC_5
    MOV         word [0xdbc6],CX
.LAB_LOC_5:
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,0xdbc8
.LAB_LOC_6:
    JCXZ        .LAB_LOC_8
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
    movup       word [BX],EAX
    ADD         BX,0x4
    ADD         EAX,EDX
    LOOP        .LAB_LOC_7
    ROR         EAX,0x10
    MOV         word [BX],AX
.LAB_LOC_8:
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
    JZ          .LAB_LOC_4
    INC         DX
    SHL         BX,0x2
    PUSH        ES
    MOV         ES, word [v_image_segment]
    MOV         SI,BX
    CMP         word [0xdb12],0xf0f0
    JNC         .LAB_LOC_5
.LAB_LOC_1:
    MOV         DI,SI
    SHL         DI,0x2
    ADD         DI,SI
    SHL         DI,0x4
    MOV         AX,word [SI + 0xdbc8]
    MOV         CX,word [SI + 0xdbca]
    SUB         CX,AX
    JNS         .LAB_LOC_2
    ADD         AX,CX
    NEG         CX
.LAB_LOC_2:
    INC         CX
    ADD         DI,AX
    CLD
    MOV         AX,[0xdb12]
    SHR         CX,0x1
    REP STOSW 
    JNC         .LAB_LOC_3
    STOSB 
.LAB_LOC_3:
    ADD         SI,0x4
    DEC         DX
    JNZ         .LAB_LOC_1
    POP         ES
.LAB_LOC_4:
    RET
.LAB_LOC_5:
    MOV         BX,word [0xdb12]
    SUB         BH,0xf0
.LAB_LOC_6:
    MOV         DI,SI
    SHL         DI,0x2
    ADD         DI,SI
    SHL         DI,0x4
    MOV         AX,word [SI + 0xdbc8]
    MOV         CX,word [SI + 0xdbca]
    SUB         CX,AX
    JNS         .LAB_LOC_7
    ADD         AX,CX
    NEG         CX
.LAB_LOC_7:
    INC         CX
    ADD         DI,AX
    CLD
.LAB_LOC_8:
    MOV         BL,byte ES:[DI]
    MOV         AL,byte [BX + 0x2e51]
    STOSB 
    LOOP        .LAB_LOC_8
    ADD         SI,0x4
    DEC         DX
    JNZ         .LAB_LOC_6
    POP         ES
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_2df2:
                              ;XREF[1]:     1000:2bf4(c)
    PUSH        SI
    PUSH        DI
    MOV         BP, 0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JL          .LAB_LOC_6
.LAB_LOC_1:
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
    JL          .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    SUB         CX,word [0xdbc0]
    JZ          .LAB_LOC_4
    SUB         AX,word [0xdbc0]
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    MOV         AX,[0xdbc0]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
.LAB_LOC_4:
    POP         BX
    POP         AX
    POP         CX
    LOOP        .LAB_LOC_6
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_5:
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
    LOOP        .LAB_LOC_1
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_6:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x8
    CMP         AX,word [0xdbc0]
    JGE         .LAB_LOC_5
    POP         CX
    LOOP        .LAB_LOC_6
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
    MOV         BP, 0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JG          .LAB_LOC_6
.LAB_LOC_1:
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
    JG          .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    SUB         CX,word [0xdbc2]
    JZ          .LAB_LOC_4
    SUB         AX,word [0xdbc2]
    CALL        FUN_1000_3f7a
    MOV         BX,AX
    MOV         AX,[0xdbc2]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
.LAB_LOC_4:
    POP         BX
    POP         AX
    POP         CX
    LOOP        .LAB_LOC_6
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_5:
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
    LOOP        .LAB_LOC_1
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_6:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x8
    CMP         AX,word [0xdbc2]
    JLE         .LAB_LOC_5
    POP         CX
    LOOP        .LAB_LOC_6
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
    MOV         BP, 0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JL          .LAB_LOC_6
.LAB_LOC_1:
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
    JL          .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [0xdbbc]
    JZ          .LAB_LOC_4
    SUB         AX,word [0xdbbc]
    CALL        FUN_1000_3f7a
    MOV         BX,word [0xdbbc]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
.LAB_LOC_4:
    POP         BX
    POP         AX
    POP         CX
    LOOP        .LAB_LOC_6
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_5:
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
    LOOP        .LAB_LOC_1
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_6:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x8
    CMP         BX,word [0xdbbc]
    JGE         .LAB_LOC_5
    POP         CX
    LOOP        .LAB_LOC_6
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
    MOV         BP, 0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JG          .LAB_LOC_6
.LAB_LOC_1:
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
    JG          .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    XCHG        AX,CX
    XCHG        DX,BX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [0xdbbe]
    JZ          .LAB_LOC_4
    SUB         AX,word [0xdbbe]
    CALL        FUN_1000_3f7a
    MOV         BX,word [0xdbbe]
    MOV         word [DI],AX
    MOV         word [DI + 0x2],BX
    ADD         DI,0x8
    INC         BP
.LAB_LOC_4:
    POP         BX
    POP         AX
    POP         CX
    LOOP        .LAB_LOC_6
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_5:
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
    LOOP        .LAB_LOC_1
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_6:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x8
    CMP         BX,word [0xdbbe]
    JLE         .LAB_LOC_5
    POP         CX
    LOOP        .LAB_LOC_6
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
    JC          .LAB_LOC_3
    MOV         AX,[0xdbbe]
    MOV         [0xdbc4],AX
    MOV         AX,[0xdbbc]
    MOV         [0xdbc6],AX
    PUSH        SI
    DEC         CX
.LAB_LOC_1:
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
    LOOP        .LAB_LOC_1
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
.LAB_LOC_2:
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
    LOOP        .LAB_LOC_2
    MOV         AX,word [SI + 0x4]
    MOV         BX,word [SI + 0x2]
    POP         SI
    MOV         CX,word [SI + 0x4]
    MOV         DX,word [SI + 0x2]
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
    JCXZ        .LAB_LOC_4
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
    MOV         word [BX],AX
    ADD         BX,0x4
    ROL         EAX,0x10
    ADD         EAX,EDX
    LOOP        .LAB_LOC_3
    ROR         EAX,0x10
    MOV         word [BX],AX
.LAB_LOC_4:
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_31d1:
                              ;XREF[1]:     1000:3177(c)
    MOV         BX,word [0xdbc4]
    MOV         DX,word [0xdbc6]
    SUB         DX,BX
    JZ          .LAB_LOC_4
    INC         DX
    SHL         BX,0x2
    PUSH        ES
    MOV         ES, word [v_image_segment]
.LAB_LOC_1:
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
    JNS         .LAB_LOC_2
    ADD         AX,CX
    NEG         CX
    ADD         BP,DX
    NEG         DX
.LAB_LOC_2:
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
.LAB_LOC_3:
    ROR         EAX,0x10
    STOSB 
    ROL         EAX,0x10
    ADD         EAX,EBX
    LOOP        .LAB_LOC_3
    POP         DX
    POP         BX
    ADD         BX,0x4
    DEC         DX
    JNZ         .LAB_LOC_1
    POP         ES
.LAB_LOC_4:
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
    JCXZ        .LAB_LOC_2
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
    JL          .LAB_LOC_6
.LAB_LOC_1:
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
    JL          .LAB_LOC_4
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
.LAB_LOC_3:
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
    LOOP        .LAB_LOC_1
    JMP         .LAB_LOC_2
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        BP
    movup    CX, EAX
    movup    DX, EBX
    SUB         CX,word [0xdbc0]
    JZ          .LAB_LOC_5
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
.LAB_LOC_5:
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    ADD         SI,0x8
    CMP         AX,word [0xdbc0]
    JGE         .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3376:
                              ;XREF[1]:     1000:30fb(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JG          .LAB_LOC_6
.LAB_LOC_1:
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
    JG          .LAB_LOC_4
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    PUSH        BP
    movup    CX, EAX
    movup    DX, EBX
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
    JZ          .LAB_LOC_2
    JMP         .LAB_LOC_1
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        BP
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         CX,word [0xdbc2]
    JZ          .LAB_LOC_5
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
.LAB_LOC_5:
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    ADD         SI,0x8
    CMP         AX,word [0xdbc2]
    JLE         .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_34a2:
                              ;XREF[1]:     1000:3100(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JL          .LAB_LOC_6
.LAB_LOC_1:
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
    JL          .LAB_LOC_4
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
.LAB_LOC_3:
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
    LOOP        .LAB_LOC_1
    JMP         .LAB_LOC_2
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        BP
    movup    CX, EAX
    movup    DX, EBX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [0xdbbc]
    JZ          .LAB_LOC_5
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
.LAB_LOC_5:
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    ADD         SI,0x8
    CMP         BX,word [0xdbbc]
    JGE         .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_35cf:
                              ;XREF[1]:     1000:3105(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JG          .LAB_LOC_6
.LAB_LOC_1:
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
    JG          .LAB_LOC_4
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    PUSH        BP
    movup    CX, EAX
    movup    DX, EBX
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
    JZ          .LAB_LOC_2
    JMP         .LAB_LOC_1
.LAB_LOC_4:
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
    JZ          .LAB_LOC_5
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
.LAB_LOC_5:
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
    PUSH        CX
    SHL         EAX,0x10
    SHL         EBX,0x10
    SHL         EBP,0x10
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         BP,word [SI + 0x4]
    ADD         SI,0x8
    CMP         BX,word [0xdbbe]
    JLE         .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
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
    JC          .LAB_LOC_3
    MOV         AX,[0xdbbe]
    MOV         [0xdbc4],AX
    MOV         AX,[0xdbbc]
    MOV         [0xdbc6],AX
    PUSH        SI
    DEC         CX
.LAB_LOC_1:
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
    LOOP        .LAB_LOC_1
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
.LAB_LOC_2:
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
    LOOP        .LAB_LOC_2
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
    movup       word [SI],EAX
    movup       word [SI + 0x320],EBX
    ADD         SI,0x4
    ADD         EAX,EDI
    ADD         EBX,EDX
    LOOP        .LAB_LOC_3
    movup       word [SI],EAX
    movup       word [SI + 0x320],EBX
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
    MOV         SI,word [0xdbc4]
    MOV         DI,word [0xdbc6]
    SUB         DI,SI
    JZ          .LAB_LOC_5
    INC         DI
    SHL         SI,0x2
    PUSH        ES
    MOV         ES, word [v_image_segment]
.LAB_LOC_1:
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
    JNS         .LAB_LOC_2
    ADD         AX,CX
    NEG         CX
    ADD         BX,DX
    NEG         DX
    ADD         BP,SI
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
    MOVZX       EBP,BP
    SHL         EBX,0x8
    SHL         EBP,0x8
    CLD
.LAB_LOC_3:
    ROR         EBX,0x10
    ROR         EBP,0x10
    ROR         ESI,0x10
    MOV         SI,BP
    SHL         SI,0x8
    MOV         AL,byte FS:[BX + SI]
    CMP         AL,0xff
    JZ          .LAB_LOC_4
    CMP         AL,0xf0
    JNC         .LAB_LOC_6
    MOV         byte ES:[DI],AL
.LAB_LOC_4:
    INC         DI
    ROL         ESI,0x10
    ROL         EBX,0x10
    ROL         EBP,0x10
    ADD         EBX,ECX
    ADD         EBP,EDX
    DEC         SI
    JNZ         .LAB_LOC_3
    POP         SI
    POP         DI
    ADD         SI,0x4
    DEC         DI
    JNZ         .LAB_LOC_1
    POP         ES
.LAB_LOC_5:
    RET
.LAB_LOC_6:
    SUB         AL,0xf0
    MOV         AH,AL
    MOV         AL,byte ES:[DI]
    XCHG        AX,BX
    MOV         BL,byte [BX + 0x2e51]
    XCHG        AX,BX
    MOV         byte ES:[DI],AL
    JMP         .LAB_LOC_4
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;ANALYSIS: seems to also be related to rendering textured polygons
FUN_1000_390a:
                              ;XREF[1]:     1000:3706(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JL          .LAB_LOC_6
.LAB_LOC_1:
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
    JL          .LAB_LOC_4
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
.LAB_LOC_3:
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
    JNZ         .LAB_LOC_1
    JMP         .LAB_LOC_2
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    movup    CX, EAX
    movup    DX, EBX
    SUB         CX,word [0xdbc0]
    JZ          .LAB_LOC_5
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
.LAB_LOC_5:
    POP         DI
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
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
    JGE         .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3aa3:
                              ;XREF[1]:     1000:370b(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JG          .LAB_LOC_6
.LAB_LOC_1:
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
    JG          .LAB_LOC_4
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    movup    CX, EAX
    movup    DX, EBX
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
    JNZ         .LAB_LOC_1
    JMP         .LAB_LOC_2
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    MOV         CX,AX
    MOV         DX,BX
    ROR         EAX,0x10
    ROR         EBX,0x10
    SUB         CX,word [0xdbc2]
    JZ          .LAB_LOC_5
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
.LAB_LOC_5:
    POP         DI
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
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
    JLE         .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3c3c:
                              ;XREF[1]:     1000:3710(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JL          .LAB_LOC_6
.LAB_LOC_1:
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
    JL          .LAB_LOC_4
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
.LAB_LOC_3:
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
    JNZ         .LAB_LOC_1
    JMP         .LAB_LOC_2
.LAB_LOC_4:
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    movup    CX, EAX
    movup    DX, EBX
    XCHG        AX,BX
    XCHG        DX,CX
    SUB         CX,word [0xdbbc]
    JZ          .LAB_LOC_5
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
.LAB_LOC_5:
    POP         DI
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
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
    JGE         .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_3ddb:
                              ;XREF[1]:     1000:3715(c)
    PUSH        SI
    PUSH        DI
    MOV         word [0xe528],0x0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JG          .LAB_LOC_6
.LAB_LOC_1:
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
    JG          .LAB_LOC_4
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         AX,[0xe528]
    MOV         word [DI + -0x2],AX
    RET
.LAB_LOC_3:
    PUSH        AX
    PUSH        BX
    PUSH        BP
    PUSH        DI
    movup    CX, EAX
    movup    DX, EBX
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
    JNZ         .LAB_LOC_1
    JMP         .LAB_LOC_2
.LAB_LOC_4:
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
    JZ          .LAB_LOC_5
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
.LAB_LOC_5:
    POP         DI
    POP         BP
    POP         BX
    POP         AX
    POP         CX
    LOOP        .LAB_LOC_6
    JMP         .LAB_LOC_2
.LAB_LOC_6:
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
    JLE         .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_6
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
    CMP         AX,word [0xdbc0]
    JL          .LAB_LOC_1
    CMP         AX,word [0xdbc2]
    JG          .LAB_LOC_1
    CMP         BX,word [0xdbbc]
    JL          .LAB_LOC_1
    CMP         BX,word [0xdbbe]
    JG          .LAB_LOC_1
    PUSH        ES
    MOV         BH,BL
    MOV         BL, 0
    ADD         AX,BX
    SHR         BX,0x1
    SHR         BX,0x1
    ADD         BX,AX
    MOV         ES, word [v_image_segment]
    MOV         byte ES:[BX],CL
    POP         ES
.LAB_LOC_1:
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
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_40c8:
    prologo 0
                              ;XREF[1]:     1000:40c4(c)
    MOV         SI,0xe532
    MOV         DI,0xe55c
    push ebp ;the functions below use ebp for other things, TODO fix it inside them!
    CALL        FUN_1000_4394
    XCHG        DI,SI
    CALL        FUN_1000_444d
    XCHG        DI,SI
    CALL        FUN_1000_4506
    XCHG        DI,SI
    CALL        FUN_1000_45c3
    pop ebp
    MOV         SI,DI
    MOV         CX,word [SI + -0x2]
    CMP         CX,0x3
    JC          .LAB_LOC_2
    MOV         AX,[0xe586]
    MOV         [0xe58c],AX
    MOV         AX,[0xe584]
    MOV         [0xe58e],AX
    PUSH        SI
    DEC         CX
.LAB_LOC_1:
    PUSH        CX
    PUSH        SI
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    MOV         CX,word [SI + 0x4]
    MOV         DX,word [SI + 0x6]

    push_args [param_aw], [param_bw]
    CALL        FUN_1000_4120
    add sp,4
    POP         SI
    POP         CX
    ADD         SI,0x4
    LOOP        .LAB_LOC_1
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    POP         SI
    MOV         CX,word [SI]
    MOV         DX,word [SI + 0x2]

    push_args [param_aw], [param_bw]
    CALL        FUN_1000_4120
    add sp,4
.LAB_LOC_2:

    epilogo
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4120:
                              ;XREF[2]:     1000:4107(c),1000:411c(c)
    prologo 0

    XCHG        DX,CX
    CMP         BX,CX
    JLE         .LAB_LOC_3
    XCHG        AX,DX
    XCHG        CX,BX
    CMP         BX,word [0xe58c]
    JGE         .LAB_LOC_1
    MOV         word [0xe58c],BX
.LAB_LOC_1:
    CMP         CX,word [0xe58e]
    JLE         .LAB_LOC_2
    MOV         word [0xe58e],CX
.LAB_LOC_2:
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,[param_aw]
    JMP         .LAB_LOC_6
.LAB_LOC_3:
    CMP         BX,word [0xe58c]
    JGE         .LAB_LOC_4
    MOV         word [0xe58c],BX
.LAB_LOC_4:
    CMP         CX,word [0xe58e]
    JLE         .LAB_LOC_5
    MOV         word [0xe58e],CX
.LAB_LOC_5:
    SUB         CX,BX
    SHL         BX,0x2
    ADD         BX,[param_bw]
.LAB_LOC_6:
    JCXZ        .LAB_LOC_14
    PUSH        DX
    SUB         DX,AX
    JS          .LAB_LOC_10
    MOV         DI, 0
    MOV         SI,CX
.LAB_LOC_7:
    MOV         word [BX + 0xe590],AX
    ADD         BX,0x4
    SUB         DI,DX
    JNS         .LAB_LOC_9
.LAB_LOC_8:
    INC         AX
    ADD         DI,SI
    JS          .LAB_LOC_8
.LAB_LOC_9:
    LOOP        .LAB_LOC_7
    POP         AX
    MOV         word [BX + 0xe590],AX

    epilogo
    RET
.LAB_LOC_10:
    NEG         DX
    MOV         DI, 0
    MOV         SI,CX
.LAB_LOC_11:
    MOV         word [BX + 0xe590],AX
    ADD         BX,0x4
    SUB         DI,DX
    JNS         .LAB_LOC_13
.LAB_LOC_12:
    DEC         AX
    ADD         DI,SI
    JS          .LAB_LOC_12
.LAB_LOC_13:
    LOOP        .LAB_LOC_11
    POP         AX
    MOV         word [BX + 0xe590],AX

    epilogo
    RET
.LAB_LOC_14:

    epilogo
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_41b2:
    call FUN_1000_3fd0 ; very similar but exchanges the vector axes...
    ;Super ineficiente, mas deixa o Ryzen trabalhar!
    xchg_m2m [0xe53c], [0xe53a]
    xchg_m2m [0xe536], [0xe538]
    xchg_m2m [0xe534], [0xe532]

    xchg_m2m [0xe53e], [0xe540]
    xchg_m2m [0xe546], [0xe548]
    xchg_m2m [0xe544], [0xe542]

    ret

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_4394:
                              ;XREF[2]:     1000:40ce(c),1000:42b0(c)
    PUSH        SI
    PUSH        DI
    MOV         BP, 0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JL          .LAB_LOC_5
.LAB_LOC_1:
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
    JL          .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_3:
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
    LOOP        .LAB_LOC_5
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_4:
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
    LOOP        .LAB_LOC_1
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_5:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x4
    CMP         AX,word [0xe588]
    JGE         .LAB_LOC_4
    POP         CX
    LOOP        .LAB_LOC_5
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
    MOV         BP, 0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JG          .LAB_LOC_5
.LAB_LOC_1:
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
    JG          .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_3:
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
    LOOP        .LAB_LOC_5
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_4:
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
    LOOP        .LAB_LOC_1
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_5:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x4
    CMP         AX,word [0xe58a]
    JLE         .LAB_LOC_4
    POP         CX
    LOOP        .LAB_LOC_5
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
    MOV         BP, 0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JL          .LAB_LOC_5
.LAB_LOC_1:
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
    JL          .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_3:
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
    LOOP        .LAB_LOC_5
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_4:
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
    LOOP        .LAB_LOC_1
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_5:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x4
    CMP         BX,word [0xe584]
    JGE         .LAB_LOC_4
    POP         CX
    LOOP        .LAB_LOC_5
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
    MOV         BP, 0
    MOV         CX,word [SI + -0x2]
    JCXZ        .LAB_LOC_2
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
    JG          .LAB_LOC_5
.LAB_LOC_1:
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
    JG          .LAB_LOC_3
    POP         CX
    LOOP        .LAB_LOC_1
.LAB_LOC_2:
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_3:
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
    LOOP        .LAB_LOC_5
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_4:
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
    LOOP        .LAB_LOC_1
    POP         DI
    POP         SI
    MOV         word [DI + -0x2],BP
    RET
.LAB_LOC_5:
    PUSH        CX
    MOV         CX,AX
    MOV         DX,BX
    MOV         AX,word [SI]
    MOV         BX,word [SI + 0x2]
    ADD         SI,0x4
    CMP         BX,word [0xe586]
    JLE         .LAB_LOC_4
    POP         CX
    LOOP        .LAB_LOC_5
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
    MOV         DI, 0
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [0x120]
    MOV         [0xe992],AX
    JL          .LAB_LOC_1
    MOV         EAX,dword [SI + 0x6]
    MOV         dword [DI + 0xdb16],EAX
    MOV         dword [DI + 0xdb1a],EBX
    ADD         DI,0x8
.LAB_LOC_1:
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
    JL          .LAB_LOC_3
    PUSH        DI
    MOV         DI,word [0xe996]
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [0x120]
    JL          .LAB_LOC_1
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
.LAB_LOC_1:
    PUSH        AX
    JCXZ        .LAB_LOC_2
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
.LAB_LOC_2:
    POP         word [0xe992]
    MOV         word [0xe996],DI
    POP         DI
    MOV         AX,word [SI]
    MOV         [0xe990],AX
    MOV         AX,word [SI + 0x4]
    MOV         [0xe994],AX
    RET
.LAB_LOC_3:
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [0x120]
    JGE         .LAB_LOC_4
    MOV         [0xe992],AX
    MOV         AX,word [SI]
    MOV         [0xe990],AX
    MOV         AX,word [SI + 0x4]
    MOV         [0xe994],AX
    RET
.LAB_LOC_4:
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
    JL          .LAB_LOC_3
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [0x120]
    JL          .LAB_LOC_1
    MOV         AX,[0xe996]
    SHR         AX,0x3
    MOV         [0xdb14],AX
    RET
.LAB_LOC_1:
    JCXZ        .LAB_LOC_2
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
.LAB_LOC_2:
    MOV         AX,[0xe996]
    SHR         AX,0x3
    MOV         [0xdb14],AX
    RET
.LAB_LOC_3:
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [0x120]
    JGE         .LAB_LOC_4
    MOV         AX,[0xe996]
    SHR         AX,0x3
    MOV         [0xdb14],AX
    RET
.LAB_LOC_4:
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
.LAB_LOC_1:
    MOV         EAX, [v_gravity]
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
    JNS         .LAB_LOC_11
.LAB_LOC_2:
    MOV         AX,word [DI + 0x2]
    SUB         AX,word [DI + 0x18]
    CMP         AX,0x80
    JC          .LAB_LOC_7
.LAB_LOC_3:
    MOV         AX,word [DI + 0x6]
    SUB         AX,word [DI + 0x18]
    CMP         AX,0x80
    JC          .LAB_LOC_8
.LAB_LOC_4:
    MOV         AX,word [DI + 0x2]
    ADD         AX,word [DI + 0x18]
    CMP         AX,0xfe80
    JA          .LAB_LOC_9
.LAB_LOC_5:
    MOV         AX,word [DI + 0x6]
    ADD         AX,word [DI + 0x18]
    CMP         AX,0xfe80
    JA          .LAB_LOC_10
.LAB_LOC_6:
    MOV         EAX,dword [DI + 0xc]
    MOV         EBX,dword [DI + 0x10]
    MOV         ECX,dword [DI + 0x14]
    ADD         dword [DI],EAX
    ADD         dword [DI + 0x4],EBX
    ADD         dword [DI + 0x8],ECX
    ADD         DI,0x1c
    INC         word [0xe9d6]
    DEC         word [0xe9d4]
    JNZ         .LAB_LOC_1
    CALL        FUN_1000_1003
    RET
.LAB_LOC_7:
    MOV         word [0xe9a2],0x8000
    MOV         word [0xe9a6],0x0
    MOV         word [0xe9aa],0x0
    MOV         word [0xe9ae],0x7f00
    MOV         byte [0xea28],0x0
    CALL        FUN_1000_4a71
    JMP         .LAB_LOC_3
.LAB_LOC_8:
    MOV         word [0xe9a2],0x0
    MOV         word [0xe9a6],0x7fff
    MOV         word [0xe9aa],0x8000
    MOV         word [0xe9ae],0x0
    MOV         byte [0xea28],0x0
    CALL        FUN_1000_4a71
    JMP         .LAB_LOC_4
.LAB_LOC_9:
    MOV         word [0xe9a2],0x7fff
    MOV         word [0xe9a6],0x0
    MOV         word [0xe9aa],0x0
    MOV         word [0xe9ae],0x7fff
    MOV         byte [0xea28],0x0
    CALL        FUN_1000_4a71
    JMP         .LAB_LOC_5
.LAB_LOC_10:
    MOV         word [0xe9a2],0x0
    MOV         word [0xe9a6],0x7fff
    MOV         word [0xe9aa],0x7fff
    MOV         word [0xe9ae],0x0
    MOV         byte [0xea28],0x0
    CALL        FUN_1000_4a71
    JMP         .LAB_LOC_6
.LAB_LOC_11:
    MOVZX       BX,byte [0xea28]
    SHR         BX,0x4
    MOVZX       CX,byte [BX + 0xea49]
    JCXZ        .LAB_LOC_12
    MOV         EAX,dword [DI + 0xc]
    SAR         EAX,CL
    SUB         dword [DI + 0xc],EAX
    MOV         EAX,dword [DI + 0x10]
    SAR         EAX,CL
    SUB         dword [DI + 0x10],EAX
    MOV         EAX,dword [DI + 0x14]
    SAR         EAX,CL
    SUB         dword [DI + 0x14],EAX
.LAB_LOC_12:
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
    JMP         .LAB_LOC_2
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
    JNS         .LAB_LOC_3
    MOV         dword [0xe9c8],EBX
    CMP         EBX,0xfffa0000
    JG          .LAB_LOC_1
    MOV         AX, 0
    CALL        FUN_1000_5864
.LAB_LOC_1:
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
    JZ          .LAB_LOC_5
    CMP         AX,0xffff
    JZ          .LAB_LOC_4
    JMP         .LAB_LOC_2

 ; 1000:4b25 [UNDEFINED BYTES REMOVED]

.LAB_LOC_2:
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
.LAB_LOC_3:
    RET
.LAB_LOC_4:
    JMP         .LAB_LOC_5

 ; 1000:4bdb [UNDEFINED BYTES REMOVED]

.LAB_LOC_5:
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
    JGE         .LAB_LOC_1
    NEG         EAX
.LAB_LOC_1:
    AND         EBX,EBX
    JGE         .LAB_LOC_2
    NEG         EBX
.LAB_LOC_2:
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
    MOV         EAX,[0xe9d0]
    CDQ
    IDIV        ECX
    MOV         EBX,EAX
    MOV         EAX,[0xe9cc]
    CDQ
    IDIV        ECX
    JMP         .LAB_LOC_2
.LAB_LOC_1:
    MOV         EAX,[0xe9cc]
    MOV         EBX,dword [0xe9d0]
.LAB_LOC_2:
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
    JG          .LAB_LOC_1
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
.LAB_LOC_1:
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
    JNC         .LAB_LOC_1
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
.LAB_LOC_1:
    POP         SI
    RET
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;MODIFICATIONS: use SSE to calculate the vector length (the math kind of vector, and yeah you can use SSE in 16bit code, shocking!)
; began using stack for local var storage, stoped using EBP as a GPR and BX is now a base like god intended
FUN_1000_4e0a:
                              ;XREF[1]:     1000:48d1(c)

    prologo 8

    MOV         AX,SI
    ADD         AX,word [SI]
    ADD         AX,0x2
    MOV         [local_f],AX
    ADD         SI,word [SI + 0x2]
    MOV         AX,word [SI]
    MOV         [local_g],AX
    ADD         SI,0x2
.LAB_LOC_1:
    MOV         BX,SI
    MOV         DI,word [SI + 0x2]
    MOV         AX,DI
    SHL         DI,0x3
    SUB         DI,AX
    SHL         DI,0x2
    ADD         DI,word [local_f]
    MOV         SI,word [SI]
    MOV         AX,SI
    SHL         SI,0x3
    SUB         SI,AX
    SHL         SI,0x2
    ADD         SI,word [local_f]
    MOV         EAX,dword [SI]
    SUB         EAX,dword [DI]
    MOV         ECX,dword [SI + 0xc]
    SUB         ECX,dword [DI + 0xc]
    MOV         dword [local_c],EAX
    ADD         EAX,ECX
    xorps    xmm0, xmm0
    cvtsi2ss xmm0, eax
    mulss    xmm0, xmm0

    MOV         EAX,dword [SI + 0x4]
    SUB         EAX,dword [DI + 0x4]
    MOV         ECX,dword [SI + 0x10]
    SUB         ECX,dword [DI + 0x10]
    MOV         dword [local_d],EAX
    ADD         EAX,ECX
    xorps    xmm1, xmm1
    cvtsi2ss xmm1, eax
    mulss    xmm1, xmm1

    MOV         EAX,dword [SI + 0x8]
    SUB         EAX,dword [DI + 0x8]
    MOV         ECX,dword [SI + 0x14]
    SUB         ECX,dword [DI + 0x14]
    MOV         dword [local_e],EAX
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

    MOVSX       ECX,word [BX + 0x4]
    mov         dword [local_b], ECX
    TEST        dword [local_b], 0x80000000
    JS          .LAB_LOC_10
    MOVZX       ECX,word [BX + 0x8]
    MOV         word [local_h],CX
    AND         CX,0xff
    JZ          .LAB_LOC_5
    JS          .LAB_LOC_3
    CMP         CX,0x1
    JG          .LAB_LOC_6
    MOV         ECX,dword [local_b]
    SUB         ECX,EAX
    JZ          .LAB_LOC_3
    CMP         CX,word [0xe9e2] ;not local, set up on init function
    JG          .LAB_LOC_8
    CMP         CX,word [0xe9e4] ;not local, set up on init function
    JL          .LAB_LOC_9
    MOV         dword [local_b],EAX
.LAB_LOC_2:
    SHL         ECX,0x6
    SHL         dword [local_b],0x6
    
    MOV         dword [local_a],ECX
    MOV         CL,byte [local_h + 1]
    INC         CL
    MOV         EAX, dword [local_c]
    IMUL        dword [local_a]
    IDIV        dword [local_b]
    MOV         EDX,EAX
    SAR         EAX,CL
    SUB         EDX,EAX
    ADD         dword [SI + 0xc],EAX
    SUB         dword [DI + 0xc],EDX
    MOV         EAX, dword [local_d]
    IMUL        dword [local_a]
    IDIV        dword [local_b]
    MOV         EDX,EAX
    SAR         EAX,CL
    SUB         EDX,EAX
    ADD         dword [SI + 0x10],EAX
    SUB         dword [DI + 0x10],EDX
    MOV         EAX, dword [local_e]
    IMUL        dword [local_a]
    IDIV        dword [local_b]
    MOV         EDX,EAX
    SAR         EAX,CL
    SUB         EDX,EAX
    ADD         dword [SI + 0x14],EAX
    SUB         dword [DI + 0x14],EDX
    
.LAB_LOC_3:
                              ;             1000:4ffd(j)
    MOV         SI,BX
.LAB_LOC_4:
    ADD         SI,0xe
    DEC         word [local_g]
    JNZ         .LAB_LOC_1
    epilogo
    RET
.LAB_LOC_5:
    MOVZX       EDX,word [BX + 0xc]
    CMP         EAX,EDX
    JG          .LAB_LOC_7
    MOVZX       EDX,word [BX + 0xa]
    CMP         EAX,EDX
    JL          .LAB_LOC_7
    JMP         .LAB_LOC_3
.LAB_LOC_6:
    MOVZX       EDX,word [BX + 0xc]
    CMP         EAX,EDX
    JG          .LAB_LOC_7
    MOVZX       EDX,word [BX + 0xa]
    CMP         EAX,EDX
    JL          .LAB_LOC_7
    XCHG        EAX,dword [local_b]
    SUB         EAX,dword [local_b]
    CDQ
    SHR         ECX,0x1
    IDIV        ECX
    MOV         ECX,EAX
    MOVZX       EAX,word [BX + 0x6]
    SUB         EAX,dword [local_b]
    SAR         EAX,0x1
    ADD         ECX,EAX
    mov_m2m  word [BX + 0x6], word [local_b]
    JMP         .LAB_LOC_2
.LAB_LOC_7:
    MOV         ECX,EDX
    SUB         ECX,EAX
    SAR         ECX,0x1
    JZ          .LAB_LOC_3
    MOV         dword [local_b],EAX
    mov_m2m  word [BX + 0x6], word [local_b]
    JMP         .LAB_LOC_2
.LAB_LOC_8:
    SAR         ECX,0x4
    XCHG        EAX,dword [local_b]
    SUB         EAX,ECX
    MOV         word [BX + 0x4],AX
    MOV         word [BX + 0x6],AX
    JMP         .LAB_LOC_2
.LAB_LOC_9:
    OR          word [BX + 0x8],0x80
    JMP         .LAB_LOC_3
.LAB_LOC_10:
    MOV         SI,BX
    MOV         word [SI + 0x4],AX
    MOV         word [SI + 0x6],AX
    JMP         .LAB_LOC_4
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_500b:
                              ;XREF[1]:     1000:56c8(c)
    MOV         byte [0xea28],0x0
    MOV         DI,0x5bbc
    MOV         CX, word [v_num_loaded_cars]
.LAB_LOC_1:
    PUSH        CX
    PUSH        DI
    MOV         SI,word [DI]
    CALL        FUN_1000_5091
    MOV         DI,0x5bbc
    MOV         CX, word [v_num_loaded_cars]
.LAB_LOC_2:
    PUSH        CX
    PUSH        DI
    MOV         DI,word [DI]
    CMP         DI,SI
    JZ          .LAB_LOC_4
    PUSH        SI
    PUSH        DI
    ADD         SI,word [SI]
    ADD         SI,0x2
    ADD         DI,word [DI]
    ADD         DI,0x2
    MOV         AX,word [SI + 0x2]
    SUB         AX,word [DI + 0x2]
    CMP         AX,0x200
    JG          .LAB_LOC_3
    CMP         AX,0xfe00
    JL          .LAB_LOC_3
    MOV         AX,word [SI + 0x6]
    SUB         AX,word [DI + 0x6]
    CMP         AX,0x200
    JG          .LAB_LOC_3
    CMP         AX,0xfe00
    JL          .LAB_LOC_3
    MOV         AX,word [SI + 0xa]
    SUB         AX,word [DI + 0xa]
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
    LOOP        .LAB_LOC_2
    POP         DI
    POP         CX
    ADD         DI,0x2
    LOOP        .LAB_LOC_1
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
    LODSW 
    MOV         CX,AX
    MOV         word [0xea99],0x0
.LAB_LOC_1:
    PUSH        CX
    LODSW 
    MOV         BX,AX
    SHL         BX,0x3
    SUB         BX,AX
    SHL         BX,0x2
    ADD         BX,DX
    LODSW 
    MOV         BP,AX
    SHL         BP,0x3
    SUB         BP,AX
    SHL         BP,0x2
    ADD         BP,DX
    LODSW 
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
    ADD         DI,word [DI]
    MOV         CX,word [DI]
    ADD         DI,0x2
.LAB_LOC_1:
    PUSH        CX
    MOV         SI, 0
    MOV         BX,SI
    MOV         ECX,0x80000000
.LAB_LOC_2:
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
    JNS         .LAB_LOC_9
    CMP         EDX,ECX
    JG          .LAB_LOC_10
.LAB_LOC_3:
    ADD         SI,0xc
    CMP         SI,word [0xea99]
    JC          .LAB_LOC_2
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
.LAB_LOC_4:
    MOV         AX,word [SI + 0x2]
    AND         AX,AX
    JGE         .LAB_LOC_5
    NEG         AX
.LAB_LOC_5:
    MOV         BX,AX
    MOV         AX,word [SI + 0x6]
    AND         AX,AX
    JGE         .LAB_LOC_6
    NEG         AX
.LAB_LOC_6:
    ADD         BX,AX
    MOV         AX,word [SI + 0xa]
    AND         AX,AX
    JGE         .LAB_LOC_7
    NEG         AX
.LAB_LOC_7:
    ADD         BX,AX
    CMP         BX,DX
    JL          .LAB_LOC_11
.LAB_LOC_8:
    ADD         SI,0x1c
    LOOP        .LAB_LOC_4
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
    MOV         BP,SI
    JMP         .LAB_LOC_8
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_1000_52d4:
                              ;XREF[2]:     1000:5393(c),1000:53e4(c)
    prologo 3

    MOV         AX,[0xea0c]
    IMUL        word [0xea14]
    MOV         [local_a],AX
    MOV         AX,[0xea0e]
    IMUL        word [0xea12]
    SUB         word [local_a],AX
    MOV         AX,[0xea18]
    IMUL        word [0xea14]
    MOV         [local_b],AX
    MOV         AX,[0xea1a]
    IMUL        word [0xea12]
    SUB         word [local_b],AX
    MOV         AX,[0xea1a]
    IMUL        word [0xea0c]
    MOV         [local_c],AX
    MOV         AX,[0xea18]
    IMUL        word [0xea0e]
    SUB         word [local_c],AX
    MOV         AX,[0xea10]
    IMUL        word [local_b]
    MOV         BX,AX
    MOV         CX,DX
    MOV         AX,[0xea16]
    IMUL        word [local_c]
    ADD         AX,BX
    ADC         DX,CX
    IDIV        word [local_a]

    epilogo
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
    JA          .LAB_LOC_1
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
    JMP         .LAB_LOC_2
.LAB_LOC_1:
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
.LAB_LOC_2:
    RET



;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
FUN_timer_5680:
    PUSHAD
    PUSH        DS
    PUSH        ES
    PUSH        FS
    PUSH        GS
    MOV         AX, _DATA2
    MOV         DS,AX
    MOV         ES,AX
    CMP         byte [0x6e],0x1
    JNZ         .LAB_LOC_2
    MOV         FS, word [v_memblock_b]
    MOV         GS, word [v_memblock_a]
    MOV         DI,0x5bbc
    MOV         CX, word [v_num_loaded_cars]      ;= 0001h
    MOV         BP,0x5ad9
.LAB_LOC_1:
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
    LOOP        .LAB_LOC_1
    CALL        FUN_1000_500b
    CALL        FUN_1000_0bb5
    CALL        FUN_1000_0a3b
.LAB_LOC_2:
    POP         GS
    POP         FS
    POP         ES
    POP         DS
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
    MOV         byte [BX + CSD_DAT_keys_571e],0xff
    MOV         byte [CSD_DAT_keys_571e],0x0
    ret

.LAB_LOC_1:
    AND         byte [BX + CSD_DAT_keys_571e],0x7f
    MOV         byte [CSD_DAT_keys_571e],BL
    ret


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
    ADD         AH,byte [BX + CSD_DAT_unk_592c]
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
    LODSB 
    MOV         AH,0xa8
    CALL        FUN_1000_58fc
    LODSB 
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
    MOV         BL,byte [BX + CSD_DAT_unk_592c]
    MOV         AH,0x20
    ADD         AH,BL
    LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x40
    ADD         AH,BL
    LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x60
    ADD         AH,BL
    LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x80
    ADD         AH,BL
    LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0xe0
    ADD         AH,BL
    LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x23
    ADD         AH,BL
    LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x43
    ADD         AH,BL
    LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x63
    ADD         AH,BL
    LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0x83
    ADD         AH,BL
    LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0xe3
    ADD         AH,BL
    LODSB 
    CALL        FUN_1000_58fc
    MOV         AH,0xc0
    ADD         AH,BL
    LODSB 
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
FUN_1000_5940:
                              ;XREF[2]:     1000:04e6(c),1000:04f4(c)
    MOV         byte [CSD_BYTE_1000_59c1],CL         ;= Fh
    MOV         CX,AX
    CLD
.LAB_LOC_1:
    LODSB 
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
    LODSB 
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
    ADD         SI,word [BX + 0xed17]
    ADD         SI,0x100
    POP         BX
    MOV         AX,CX
.LAB_LOC_7:
    PUSH        BX
    MOV         DL,byte [SI]
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
    call far DOS3Call
    MOV         BX,AX
    JC          .LAB_LOC_1
    CALL        FUN_1000_5a95
    JC          .LAB_LOC_1
    MOV         CX,0x0
    MOV         DX,0x80
    MOV         AX,0x4200
    call far DOS3Call
    JC          .LAB_LOC_1
    CALL        FUN_1000_5acf
    JC          .LAB_LOC_1
    MOV         AH,0x3e
    call far DOS3Call
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
    call far DOS3Call
    JC          .LAB_LOC_1
    MOV         AX,[0xef90]
    SUB         AX,word [0xef8c]
    INC         AX
    MOV         [0xef80],AX
    MOV         CX,word [0xef92]
    SUB         CX,word [0xef8e]
    INC         CX
    MOV         word [0xef82],CX
    CMP         byte [0xef8b],0x8
    JNZ         .LAB_LOC_1
    CMP         byte [0xefc9],0x1
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
    MOV         CX,word [0xef82]
    CMP         CX,0x100
    JLE         .LAB_LOC_1
    MOV         CX,0x100
.LAB_LOC_1:
    PUSH        CX
    MOV         CX, 0
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
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
.WHY_1000_5b01: ; this is never called as a function, but it was labeled as one
                              ;XREF[3]:     1000:0327(c),1000:03f3(c),1000:04b3(c)
    MOV         AH,0x0
    JNZ         .LAB_LOC_4
    MOV         AH,AL
    AND         AH,0x3f
    CALL        FUN_1000_5b26
    DEC         AH
.LAB_LOC_4:
    CMP         CX,0x100
    JNC         .LAB_LOC_5
    STOSB 
.LAB_LOC_5:
    INC         CX
    CMP         CX,word [0xef80]
    JC          .LAB_LOC_2
    POP         CX
    LOOP        .LAB_LOC_1
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
    call far DOS3Call
    POP         CX
    POP         AX
    MOV         SI,0xf008
.LAB_LOC_1:
    LODSB 
    RET

 ; 1000:5cce [UNDEFINED BYTES REMOVED]

;FIM:
