#!/bin/bash

mkdir -p build

echo "It has begun!!!"

OPTIMIZATIONS="-Oz"

if [ "$1" = "-debug" ]; then
    echo "Debug symbols will be kept"
    OPTIMIZATIONS="-Og -g"
fi

rm -f build/terep2re*.exe

compile(){ 
  echo "Building $1 executable"

  rm -f build/w_*.o

  echo "Building components"

  CFLAGS="${OPTIMIZATIONS} -mcrtdll=msvcrt-os -D__USE_MINGW_ANSI_STDIO=0 -fno-asynchronous-unwind-tables -fno-unwind-tables -fno-math-errno -ffinite-math-only -fno-signed-zeros"

  $1-w64-mingw32-gcc ${CFLAGS} -DOPL_WF_TABLE_RUNTIME -c 3rd-party/Nuked-OPL3/opl3.c -o build/w_opl3.o &

  $1-w64-mingw32-windres win32/menu.rc -o build/w_menu.o &

  sources=("terep2re" "graphics" "sound" "blinken")

  for item in "${sources[@]}"; do
    $1-w64-mingw32-gcc ${CFLAGS} --std=gnu23 -c \
        -I./3rd-party/Nuked-OPL3 \
        win32/${item}.c          \
        -o build/w_${item}.o &
  done

  $1-w64-mingw32-gcc ${CFLAGS} -c lifted/maincode.c -o build/w_maincode.o &

  wait
  echo "Linking everything"

  $1-w64-mingw32-gcc         \
    ${CFLAGS}                \
    -mwindows -static-libgcc \
    build/w_*.o              \
    insulator/insulator.c    \
    lifted/othathings.c      \
    -lole32 -lwinmm  -flto   \
    -o build/terep2re$2.exe

  if [ "$?" != 0 ]; then
    exit 1
  fi

  if [ "${OPTIMIZATIONS}" = "-Oz" ]; then
    $1-w64-mingw32-strip build/terep2re$2.exe
  fi
}

compile i686 32
compile x86_64 64

echo "Done... probably"
