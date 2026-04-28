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

    POP EBP
    POP DS
    retf

render_:
    PUSH DS
    PUSH EBP

    MOV AX, _DATA2
    MOV DS, AX

    CALL FUN_main_render

    POP EBP
    POP DS
    retf

getMem16_:
    PUSH DS 
    MOV AX, _DATA2
    MOV DS, AX

    MOV AX, [BX]

    POP DS
    retf

    %include "reasm/maincode.asm"


segment _DATA2 class=DATA align=16
    incbin "memdumps/data.bin"

    db "SEPARATOR", 0

    %include "reasm/cs_data.asm"
