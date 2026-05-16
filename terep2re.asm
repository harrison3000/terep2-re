bits 64

extern DOS3Call

global initgame_
global getMem16_
global render_
global physics_
global handlekey_

%include "reasm/macros.asm"

section .text

initgame_:
    PUSH DS
    PUSH EBP

    MOV AX, _DATA2
    MOV DS, AX

    CALL f_init

    POP EBP
    POP DS
    ret

render_:
    PUSH DS
    PUSH ES
    PUSH FS
    PUSH GS
    PUSH EBP

    MOV AX, _DATA2
    MOV DS, AX

    CALL FUN_main_render

    POP EBP
    POP GS
    POP FS
    POP ES
    POP DS
    ret

getMem16_:
    PUSH DS 
    MOV AX, _DATA2
    MOV DS, AX

    MOV AX, [BX]

    POP DS
    ret

physics_:
    ;the inner function already push registers and sets the DS correctly
    call FUN_timer_5680
    ret


handlekey_:
    call FUN_keyboard_56df
    ret

    %include "reasm/maincode.asm"


section .data
    %include "reasm/dataseg.asm"

    db "SEPARATOR", 0

    %include "reasm/cs_data.asm"

nova_linha:
    db "GAMBIARRA FOREVER!", 0
giracor:
    db 0


;padding
;numbers higher than this probably encode some special values, this is the max
times (65534 - ($ - $$)) db 'P'
