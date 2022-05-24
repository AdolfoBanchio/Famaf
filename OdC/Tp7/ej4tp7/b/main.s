    .data
    y: .dword 0xa

    .text
    LDR X1, y
    MOV X0, 0x0
loop: 
    SUBs X1,X1,0
    B.le infloop
    SUB X1, X1,1
    ADD X0, X0,2
    B loop
infloop: 
    B infloop
