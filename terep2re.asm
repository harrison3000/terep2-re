bits 16

extern DOS3Call

global initgame_
global render_
global physics_
global handlekey_

segment _CODE2 class=CODE align=16



initgame_:
    PUSH DS 
    MOV AX, _DATA2
    MOV DS, AX

    CALL t_init
    ;FIXME if I run in a fake directory it gives a fake ok return, if I run in a actual track directory it hangs
    ;use winedbg to find out why, probably registers being clobbered

    POP DS
    retf

    %include "reasm/maincode.asm"


segment _DATA2 class=DATA align=16
    incbin "memdumps/data.bin"
