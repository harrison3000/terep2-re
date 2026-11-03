calculate_and_pray:
    FINIT
    FILD       dword [0xe9ec]
    FMUL       ST0
    FILD       dword [0xe9f0]
    FMUL       ST0
    FILD       dword [0xe9f4]
    FMUL       ST0
    FADDP
    FADDP
    FSQRT
    FISTP      dword [0xe9e8]
    MOV        EAX,[0xe9e8]
    SAR        EAX,0xa

    ret
