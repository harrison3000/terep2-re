

%macro airlock_prologue 0
    PUSHAD
    PUSH FS
    PUSH GS
    PUSH DS
    PUSH ES

    MOV AX, _DATA2
    MOV DS, AX
%endmacro

%macro airlock_epilogue 0
    POP ES
    POP DS
    POP GS
    POP FS
    POPAD
%endmacro