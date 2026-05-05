%define v_image_segment 0xdb10
%define v_gravity 0x6a

%define v_palette 0x1a4d

%define v_memblock_a 0x1a45
%define v_memblock_b 0x1a47
%define v_memblock_c 0x1a49
%define v_memblock_d 0x1a4b

%define v_num_loaded_cars 0x5bba

;0x5bbc seemd to point to car data, but I am not sure, needs more research

;0x5af7 array of pointers to the strings with the file names for each carx.dat
;0x5b2e same, but for carx.pcx
;0x5a53 another table of pointers, but I have no idea for what
;0x120 seems to be near clipping plane
;0x5f5 seems to be the textured draw distance
