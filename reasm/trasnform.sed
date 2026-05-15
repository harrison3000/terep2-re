s#EBP#R8D#
s#BP#R8W#

s#MOV\s+([EFG]S),#load_\1    #
s#(PUSH|POP)\s+([EFG]S)#\1_\2    #

s#call far#call  #