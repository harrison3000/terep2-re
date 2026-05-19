%macro prologo 0
	;8 local vars ought to be enough for anybody
	;always dword because we have plenty of stack space
	enter 8*4, 0
%endmacro

%macro epilogo 0
    leave
%endmacro

%define local_a bp-4*1
%define local_b bp-4*2
%define local_c bp-4*3
%define local_d bp-4*4
%define local_e bp-4*5
%define local_f bp-4*6
%define local_g bp-4*7
%define local_h bp-4*8

%macro mov_upper 2
;mov upper word using the stack, gambiarras forever
	push %2
	add sp, 2
	pop %1
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

;bp points to "old bp", bp+2 to the return address
%define param_aw bp+4
%define param_bw bp+6
%define param_cw bp+8
%define param_dw bp+10
%define param_ew bp+12