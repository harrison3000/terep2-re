@echo off

set WATCOM=C:\watcom
set NASM=C:\nasm

set PATH=%WATCOM%\binnt64;%NASM%;%PATH%
set INCLUDE=%WATCOM%\h;%WATCOM%\h\nt
set LIB=%WATCOM%\lib386;%WATCOM%\lib386\nt

if not exist "build" mkdir build

cd reasm32
nasm -f win32 -DWIN32 the_thing.asm
cd ..
REM wrc -r -bt=nt -DDEBUGMENU win32/menu.rc
wrc -r -bt=nt win32/menu.rc
wcl386 -6 -os -zastd=c99 -bt=nt -l=nt_win reasm32/the_thing.obj win32/terep2re.c win32/menu.res shell32.lib user32.lib ole32.lib -fe=build/terep2re32.exe
