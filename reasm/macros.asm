%macro prologo 0
	;8 local vars ought to be enough for anybody
	;always dword because we have plenty of stack space
	enter 8*4, 0
%endmacro

%macro epilogo 0
    leave
%endmacro

%define local_a rbp-4*1
%define local_b rbp-4*2
%define local_c rbp-4*3
%define local_d rbp-4*4
%define local_e rbp-4*5
%define local_f rbp-4*6
%define local_g rbp-4*7
%define local_h rbp-4*8

%macro movup 2
;mov upper word using the stack, gambiarras forever
	push dword %2
	add rsp, 2
	pop word %1
%endmacro

%macro mov_m2m 2
;mov memory to memory using the stack, yeah, not efficient, who cares?
	push %2
	pop %1
%endmacro

%macro xchg_m2m 2
	push %2
	push %1
	pop %2
	pop %1
%endmacro

%macro push_args 1-*
    %rep %0
        %rotate -1
        push %1
    %endrep
%endmacro

;bp points to "old bp", bp+8 to the return address
%define param_aw rbp+8+8*1
%define param_bw rbp+8+8*2
%define param_cw rbp+8+8*3
%define param_dw rbp+8+8*4
%define param_ew rbp+8+8*5

%macro load_ES 1
	;FIXME actually implement
	nop
%endmacro

%macro load_FS 1
	;FIXME actually implement
	nop
%endmacro

%macro load_GS 1
	;FIXME actually implement
	nop
%endmacro

%macro PUSH_ES 0
	;FIXME actually implement
	nop
%endmacro

%macro PUSH_FS 0
	;FIXME actually implement
	nop
%endmacro

%macro PUSH_GS 0
	;FIXME actually implement
	nop
%endmacro

%macro POP_ES 0
	;FIXME actually implement
	nop
%endmacro

%macro POP_FS 0
	;FIXME actually implement
	nop
%endmacro

%macro POP_GS 0
	;FIXME actually implement
	nop
%endmacro

%macro setup_ES 2
	;FIXME actually implement
	nop
%endmacro

%macro setup_FS 2
	;FIXME actually implement
	nop
%endmacro

%macro setup_GS 2
	;FIXME actually implement
	nop
%endmacro

%macro setup_data 2
	;FIXME actually implement
	nop
%endmacro