#!/bin/bash

mkdir -p build

echo "It has begun!!!"

compile(){ 

  rm -f build/w_*.o

  $1-w64-mingw32-gcc -O1 -g -c 3rd-party/Nuked-OPL3/opl3.c -o build/w_opl3.o

  $1-w64-mingw32-windres win32/menu.rc -o build/w_menu.o

  sources=("terep2re" "graphics" "sound" "blinken")

  for item in "${sources[@]}"; do
    $1-w64-mingw32-gcc -O1 -g --std=gnu23 -c \
        -I./3rd-party/Nuked-OPL3 \
        win32/${item}.c          \
        -o build/w_${item}.o

    echo "$item"
  done


  $1-w64-mingw32-g++ -O1 -g  \
    -mwindows -static        \
    build/w_*.o              \
    insulator/insulator.cpp  \
    lifted/maincode.cpp      \
    lifted/othathings.cpp    \
    -lole32 -lwinmm -o build/terep2re$2.exe

}

compile i686 32
compile x86_64 64
