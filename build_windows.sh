#!/bin/bash

mkdir -p build

echo "It has begun!!!"

OPTIMIZATIONS="-O2"

if [ "$1" = "-debug" ]; then
    echo "Debug symbols will be kept"
    OPTIMIZATIONS="-Og -g"
fi

compile(){ 
  echo "Building $1 executable"

  rm -f build/w_*.o

  echo "Building components"

  $1-w64-mingw32-gcc ${OPTIMIZATIONS} -c 3rd-party/Nuked-OPL3/opl3.c -o build/w_opl3.o &

  $1-w64-mingw32-windres win32/menu.rc -o build/w_menu.o &

  sources=("terep2re" "graphics" "sound" "blinken")

  for item in "${sources[@]}"; do
    $1-w64-mingw32-gcc ${OPTIMIZATIONS} --std=gnu23 -c \
        -I./3rd-party/Nuked-OPL3 \
        win32/${item}.c          \
        -o build/w_${item}.o &
  done

  $1-w64-mingw32-g++ ${OPTIMIZATIONS} -fno-exceptions -c lifted/maincode.cpp -o build/w_maincode.o &

  wait
  echo "Linking everything"

  $1-w64-mingw32-g++         \
    ${OPTIMIZATIONS}         \
    -mwindows                \
    -fno-exceptions  -flto   \
    -fno-rtti -nostdlib++    \
    build/w_*.o              \
    insulator/insulator.cpp  \
    lifted/othathings.cpp    \
    -lole32 -lwinmm          \
    -o build/terep2re$2.exe

  if [ "${OPTIMIZATIONS}" = "-O2" ]; then
    $1-w64-mingw32-strip build/terep2re$2.exe
  fi

  echo "Done... maybe"
}

compile i686 32
compile x86_64 64
