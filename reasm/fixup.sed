s/^000:/ ; 1000:/
s/ \+$//
s/CODE_1:DAT_15cd_/0x/
s/^;undefined \(\w\+\)()/\1:/
s/\(byte\|word\) ptr /\1 /