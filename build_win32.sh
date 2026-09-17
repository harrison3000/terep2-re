#!/bin/bash

mkdir -p build

DEBUG_DEF=""
BLINKEN_SRC=""

if [ "$1" = "-debug" ]; then
    echo "Debug menu enabled"
    DEBUG_DEF="-DDEBUGMENU" 
    BLINKEN_SRC="win32/blinken.c"
else
    echo "Tip: you can pass a parameter '-debug' to this command to enable the debug menus"
fi

echo "It has begun!!!"

cd reasm32
    nasm -f win32 -DWIN32 the_thing.asm
cd ..

i686-w64-mingw32-windres ${DEBUG_DEF} win32/menu.rc -o win32/menu.o
i686-w64-mingw32-gcc \
    ${DEBUG_DEF}     \
    -O1 -g --std=gnu23 -mwindows \
    -I./3rd-party/Nuked-OPL3 \
    reasm32/the_thing.obj \
    win32/terep2re.c      \
    3rd-party/Nuked-OPL3/opl3.c \
    ${BLINKEN_SRC}        \
    win32/menu.o          \
    -lole32 -lwinmm -o build/terep2re32.exe
