
%define CSD_DAT_keys_571e 0xF400

;TODO needs to be set up
%define CSD_DAT_unk_592c  0xF500

%define var_offset(x)  0xF600 + x*4

;=====================================================


%define CSD_WORD_1000_0e67  var_offset(1)

;----------------

%define CSD_DWORD_1000_129f  var_offset(2)

;TODO needs to be set to 7FFF0000h
%define CSD_DWORD_1000_12a3  var_offset(3)

%define CSD_DWORD_1000_12a7  var_offset(4)

%define CSD_DWORD_1000_12ab  var_offset(5)

%define CSD_DWORD_1000_12af  var_offset(6)

%define CSD_DWORD_1000_12b3  var_offset(7)

%define CSD_DWORD_1000_12b7  var_offset(8)

%define CSD_DWORD_1000_12bb  var_offset(9)

%define CSD_DWORD_1000_12bf  var_offset(10)

%define CSD_DWORD_1000_12c3  var_offset(11)

%define CSD_DWORD_1000_12c7  var_offset(12)

;----------------

%define CSD_BYTE_1000_553e  var_offset(13)

%define CSD_BYTE_1000_59c1  var_offset(14)


%define giracor  var_offset(15)

%define pseudolocal_a  var_offset(16)

%define pseudolocal_b  var_offset(17)

%define nova_linha  0xF700

;TODO ver se esse eh o codigo do segmento mesmo
%define _DATA2 0x17