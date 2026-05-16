s#EBP#R8D#
s#BP#R8W#

s#MOV\s+([EFG]S),#load_\1    #
s#(PUSH|POP)\s+([EFG]S)#\1_\2    #

s#call far#call  #

#explicit segment register references
s#(.+)([EFG]S):\[(BX|SI|DI)#    setup_\2    R10, \3\n\1[R10#

s#(.+) \[(BX|SI)#    setup_data  R11, \2\n\1 [R11#
s#(.+) \[(DI)#    setup_data  R12, \2\n\1 [R12#