    .data
    y: .dword 0x2

    .text
    LDR X1, y
    MOV X0, 0x0
    mov x10,0x2
    mov x11,0x3

loop:
    ADD X0, X0, 2
    SUB X1, X1, 1
    CBNZ X1, loop
    mov x1,0x3
    madd x0,x10,x11,x1
infloop: 
    B infloop
