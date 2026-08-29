Mechanically translated asm to C, done with a simple Go program I wrote(using a antlr4 generetad parser and all that jazz), maybe I will clean it up and publish it, maybe I wont

### Todo
 - [X] Proof of concept translator
 - [ ] Implement jumps
 - [X] Things like push/pop need to know the size of the operand
 - [X] Avoid direct SP manipulations (2 places)
 - [ ] See whats the deal with the flags returned by FUN_1000_2662, the sometimes are stored into [0x5ee] (can probably store BH into this var)

### Ideas
 - use cpp references in the macros
 - some flags can be calculated on-the-fly, with a fake register called "last_res" (lazy flags)

