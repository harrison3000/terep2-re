#!/bin/bash
rm -f build/terep2sx.exe
pushd msdos
  nasm -f obj theThing.asm
  /opt/watcom/binl64/wlink  @link.lnk
popd
mv msdos/terep2sx.exe build/