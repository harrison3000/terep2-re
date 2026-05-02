%macro prologo 1
	push bp
	mov bp, sp
	sub sp, %1*4
%endmacro

%macro epilogo 0
    mov sp, bp
    pop bp
%endmacro

%define local_a bp-4
%define local_b bp-8
%define local_c bp-12
%define local_d bp-16
%define local_e bp-20
%define local_f bp-24
%define local_g bp-28
%define local_h bp-32

%macro movup 2
;mov upper word using the stack, gambiarras forever
	push %2
	add sp, 2
	pop %1
%endmacro