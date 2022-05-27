    .data
    y: .dword 0x2

    .text
    mov x3, 180 // 170 (x)
	mov x4, 0x5a  // 90  (y) esquina izquierda del cuadrado 
	mov x6, 150 // radio  
	mul x6,x6,x6 //radio al cuadrado	
	sub x14,x3,320 //x-320
	sub x15,x4,240 //y-240
	madd x14,x14,x14,xzr //(x-320)^2
	madd x15,x15,x15,xzr
	sub x16,x14,x15 // (x- 320)^2 + (y - 240 )^2
	cmp x16,x6 // (x- 320)^2 + (y - 240 )^2 <= r^2
	B.LE infloop //si pertenece al circulo pintamos
    mov x0,0
    
infloop: 
    B infloop
