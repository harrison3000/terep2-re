@echo off

set WATCOM=C:\watcom
set NASM=C:\nasm

set PATH=%WATCOM%\binnt64;%NASM%;%PATH%
set INCLUDE=%WATCOM%\h;%WATCOM%\h\nt
set LIB=%WATCOM%\lib386;%WATCOM%\lib386\nt

if not exist "build" mkdir build

cd reasm32
nasm -v
nasm -f win32 -w+x -DWIN32 the_thing.asm
cd ..
wrc -r -bt=nt -dDEBUGMENU win32/menu.rc
wcl386 -6 -os -wx -zastd=c99 -bt=nt -dDEBUGMENU -l=nt_win reasm32/the_thing.obj win32/blinken.c win32/terep2re.c win32/menu.res shell32.lib user32.lib ole32.lib -fe=build/terep2re32_dbg.exe
