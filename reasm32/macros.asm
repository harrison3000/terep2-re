

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

%macro mk_addr 2
    LEA %1, %2
    LEA %1, [%1 + base_mem]
%endmacro

%macro mk_addr_seg 3
    %ifidni %1, eax
        %error "Dest cant be eax"
    %endif
    
    PUSH EAX
    MOV  EAX, dword [%2]
    LEA  %1, %3
    LEA  %1, [%1 + EAX]
    POP  EAX
%endmacro