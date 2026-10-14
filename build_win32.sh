#!/bin/bash

mkdir -p build

echo "It has begun!!!"

cd reasm32
    nasm -f win32 -DWIN32 the_thing.asm
cd ..

i686-w64-mingw32-windres win32/menu.rc -o win32/menu.o
i686-w64-mingw32-gcc \
    -O1 -g --std=gnu23 -mwindows \
    -I./3rd-party/Nuked-OPL3 \
    reasm32/the_thing.obj \
    3rd-party/Nuked-OPL3/opl3.c \
    win32/{terep2re,fakedoscall,graphics,sound,blinken}.c      \
    win32/menu.o          \
    -lole32 -lwinmm -o build/terep2re32.exe
