# TeREp2-re - Reverse engineering the terep2 demo

**Disassembly/Recompilation of the Terep2 demo to run on modern systems**

The original ASM has been cleaned up a bit and converted to a C file, each instruction implemented as a macro, the innermost loops of the rendering functions have been rewritten in normal C to speed things up a bit, on a modern Ryzen this uses less than 2% of one core (even when rendering at higher resolutions) but who knows? somebody might want to run this in retro systems

The primary target is Win32 (both 32 and 64 bit), surprisingly it runs even on win98 (tested on qemu).
It also runs on Linux on a SDL window but this is mostly for testing

Some bugs in the renderer have been fixed, but the physics was barely touched and should be identical to the original (except for those pesky floating point LSB differences, these could occur even in different families of CPUs I think), theres a verifyer to run and verify replays recorded in a very old version with more pristine code 


## AI/LLM usage

Limited AI usage, for things like generating boilerplate or doing small corrections to the GUI is acceptable, but touching the ASM code or other critical parts using AI is a big no-no, we dont do that here

AI has been used as a research tool and answering question about old Win32 APIs and odd x86 behaviors

The parallel `terep2vb` project has been consulted for things like discovering specific addresses and to discover what each function is meant to do, but I took care to not look directly at the code, only the comments, for the high resolution development I only asked the AI to give a brief overview of the rasterization process and implemented the code myself, I even did some things not done in the `terep2vb` like supporting different aspect ratios!

## Project history

This project started in 2019 (remember back then? everything was so different somehow), I didn't actually unpack the Guardian Angel obfuscation, I just dumped the memory using the Dosbox debugger after the game was already running instead, I managed to make a unpacked exe that ran and discovered the structure of some of the code using ghidra but quickly lost interest, fast forward 6 years later and I discovered there's a whole community of Terep fans


## Early progress

*Very early build running on win16 mode, no palette, no sound, no physics, nothing... just a very crude proof of concept*

![](https://github.com/user-attachments/assets/d4b37fef-2f56-480c-87b1-b15e4a9e8ec5)


*After a bunch of fixes, playable, but no sound yet*

![](https://github.com/user-attachments/assets/5c3be341-af07-4a9e-9e34-23a75b006979)

