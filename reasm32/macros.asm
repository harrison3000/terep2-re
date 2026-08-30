
;macro to allow loop to go longer (by default only allows -128..127)
%macro L_LOOP 1   
    a16 LOOP %%trampoline
    jmp %%continue

%%trampoline:
    jmp %1

%%continue:
%endmacro

;same, but for jcxz, fun fact: the encoding for the loop{,e,ne} variants and jcxz only differ by 2 bits, the more you know!
%macro L_JCXZ 1   
    JCXZ %%trampoline
    jmp %%continue

%%trampoline:
    jmp %1

%%continue:
%endmacro

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