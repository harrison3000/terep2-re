
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
	push word  0
	push word  %2
	pop  dword %1
%endmacro

%macro movsx_m2m 2
	;movsx 16 to 32, mem to mem
	push eax
	movsx eax, word %2
	mov %1, eax
	pop eax
%endmacro