

%macro airlock_prologue 0
    PUSHAD
%endmacro

%macro airlock_epilogue 0
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

%macro ld_seg 2
    MOVZX EBP, %2
    PUSH dword [EBP*4 + all_segments]
    POP  dword %1
%endmacro
