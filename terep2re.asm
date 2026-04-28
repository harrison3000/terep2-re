bits 16

extern DOS3Call

global initgame_
global getMem16_
global render_
global physics_
global handlekey_

segment _CODE2 class=CODE align=16



initgame_:
    PUSH DS
    PUSH EBP

    MOV AX, _DATA2
    MOV DS, AX

    CALL t_init

    PUSH AX
    
    MOV AX, ES
    MOV [my_es_save], ax
    
    MOV AX, FS
    MOV [my_fs_save], ax

    MOV AX, GS
    MOV [my_gs_save], ax    

    POP AX

    POP EBP
    POP DS
    retf

render_:
    PUSH DS
    PUSH ES
    PUSH FS
    PUSH GS
    PUSH EBP

    MOV AX, _DATA2
    MOV DS, AX

    MOV AX, [my_es_save]
    MOV ES, AX

    MOV AX, [my_fs_save]
    MOV FS, AX

    MOV AX, [my_gs_save]
    MOV GS, AX

    CALL FUN_main_render

    POP EBP
    POP GS
    POP FS
    POP ES
    POP DS
    retf

getMem16_:
    PUSH DS 
    MOV AX, _DATA2
    MOV DS, AX

    MOV AX, [BX]

    POP DS
    retf

physics_:
    ;the function already push registers and sets the DS correctly
    CALL iFUN_timer_5680
    retf

    %include "reasm/maincode.asm"


segment _DATA2 class=DATA align=16
    incbin "memdumps/data.bin"

    db "SEPARATOR", 0

    ;the render function expects the registers to be the way the init left them.... oh well
    my_es_save dw 0
    my_fs_save dw 0
    my_gs_save dw 0

    %include "reasm/cs_data.asm"
