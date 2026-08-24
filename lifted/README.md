Mechanically translated asm to C, done with a simple Go program I wrote(using a antlr4 generetad parser and all that jazz), maybe I will clean it up and publish it, maybe I wont

### Todo
 - [X] Proof of concept translator
 - [ ] Implement jumps
 - [ ] Things like push/pop need to know the size of the operand
 - [ ] Avoid direct SP manipulations (2 places)

### Ideas
 - use cpp references in the macros
 - some flags can be calculated on-the-fly, with a fake register called "last_res" (lazy flags)

