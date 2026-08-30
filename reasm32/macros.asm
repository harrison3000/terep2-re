
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