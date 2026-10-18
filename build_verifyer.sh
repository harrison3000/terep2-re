#!/bin/bash


g++ -Og -g -lSDL3 \
    verifyer/main.cpp \
    lifted/maincode.cpp \
    lifted/othathings.cpp \
    insulator/insulator.cpp \
    -o build/terep2_verifyer