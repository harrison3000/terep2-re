#!/bin/bash

mkdir -p build

echo "It has begun!!!"

#TODO add a debug option that does not strip the exe and adds the -g

compile(){ 
  echo "Building $1 executable"

  rm -f build/w_*.o

  echo "Building GUI components"

  $1-w64-mingw32-gcc -O2 -c 3rd-party/Nuked-OPL3/opl3.c -o build/w_opl3.o &

  $1-w64-mingw32-windres win32/menu.rc -o build/w_menu.o &

  sources=("terep2re" "graphics" "sound" "blinken")

  for item in "${sources[@]}"; do
    $1-w64-mingw32-gcc -O2 --std=gnu23 -c \
        -I./3rd-party/Nuked-OPL3 \
        win32/${item}.c          \
        -o build/w_${item}.o &
  done

  $1-w64-mingw32-g++ -O2 -c lifted/maincode.cpp -o build/w_maincode.o &

  wait
  echo "Linking everything"

  $1-w64-mingw32-g++ -O2     \
    -mwindows -static        \
    build/w_*.o              \
    insulator/insulator.cpp  \
    lifted/othathings.cpp    \
    -lole32 -lwinmm          \
    -o build/terep2re$2.exe

  $1-w64-mingw32-strip build/terep2re$2.exe

  echo "Done... maybe"
}

compile i686 32
compile x86_64 64
