s#^000:# ; 1000:#
s# +$##
s#CODE_1:DAT_15cd_#0x#
s#^;undefined (\w+)\(\)#\1:#
s#(byte|word) ptr #\1 #
s# +;undefined \w+\(\)$##
s#^( +)([A-Z]+)\.REP #\1REP \2 ; #
s#(DAT_keys_571e)\[([0-9]+)\]#\1 + \2#
s#addr +(LAB_1000_)#dw  \1#
s#FIM_DO_CODIGO#;FIM#
s#^( +)ddw#\1dd#
s#^( +)ds #; ds #
s#=>#  ; =>#