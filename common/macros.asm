
%macro mov_m2m 2
    ;mov memory to memory using the stack, yeah, not efficient, who cares?
	push %2
	pop  %1
%endmacro

%macro xchg_m2m 2
	push %2
	push %1
	pop  %2
	pop  %1
%endmacro

%macro movzx_m2m 2
	;movzx 16 to 32, mem to mem
	push  eax
	movzx eax, word %2
	mov   %1, eax
	pop   eax
%endmacro

%macro movsx_m2m 2
	;movsx 16 to 32, mem to mem
	push eax
	movsx eax, word %2
	mov %1, eax
	pop eax
%endmacro

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