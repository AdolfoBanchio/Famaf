
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.equ square_width,     	300
.equ square_heigh,     	300

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	
	movz x10, 0xC8, lsl 16
	movk x10, 0x9900, lsl 00

	movz x11, 0x0F, lsl 16
	movk x11, 0xF5ee, lsl 00 //color celeste

	mov x9, 640 //guardo 640 en hex para poder usarlo para calcular
				// posiciones en el frame
/* 
	mov x2, SCREEN_HEIGH         // Y Size 
loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	stur w10,[x0]	   // Set color of pixel N
	add x0,x0,4	   // Next pixel
	sub x1,x1,1	   // decrement X counter
	cbnz x1,loop0	   // If not end row jump
	sub x2,x2,1	   // Decrement Y counter
	cbnz x2,loop1	   // if not last row, jump
*/
//cuadrado 

    mov x3, 0xaa //170
	mov x4,0x5a  // 90
	
	mov x2, square_heigh //300
square:
	mov x0,x20 //guardo en x0 la direccion base del frame
	madd x5,x4,x9,x3 //x5 = x9 +(x12*x13) calculo el inicio de la linea del cuadrado
	lsl x5,x5,2 //multiplico por 4
	add x0,x20,x5 //x0 = direc.base.frame + 4*(x+(y*640)) inicio demi nueva linea
	mov x1, square_width //300
loop4:
	stur w11,[x0]
	add x0,x0,4  //next pixel
	sub x1,x1,1
	cbnz x1,loop4
	sub x2,x2,1
	add x4,x4,1 //aumento mi'y' para calcular la base de la linea de abajo
	cbnz x2,square

//------------------------------------------------------------------------------------------




//guardo los (x,y) del frame donde voy a querer arrancar a dibujar
		mov x3, 170 // 170 (x)
		mov x4, 90  // 90  (y) esquina izquierda del cuadrado 
		
		mov x6, 150 // radio  
		mul x6,x6,x6 //radio al cuadrado
		mov x2, 300
		mov x1, 300
		b loop_c
movy:
		add x4,x4,1 //aumento el y
		mov x3, 170 //170 (x) vuelvo a setear x
		sub x2,x2,1 //le quito uno a mi contador de eje y
		mov x1, 300 //300
		cbz x2, InfLoop
		b loop_c
circle: 
		madd x5,x4,x9,x3 //x5 = x3 +(x4*x9) = x +(y*640) calculo el inicio de la linea del cuadrado
		lsl x5,x5,2 //multiplico por 4
		add x0,x20,x5 //x0 = direc.base.frame + 4*(x+(y*640)) inicio demi nueva linea
		stur w10,[x0]
		add x3,x3,1 //me muevo al sig x
		sub x1,x1,1
		cbz x1, movy // si me pase de linea, reseteo a 300 de vuelta y aumento mi 'y' y vuelvo a setear x en el inicio de la linea
loop_c:
		sub x14,x3,320 //x-320
		sub x15,x4,240 //y-240
		madd x14,x14,x14,xzr //(x-320)^2
		madd x15,x15,x15,xzr //(y-240)^2
		add x16,x14,x15 // (x- 320)^2 + (y - 240 )^2
		cmp x16,x6 // (x- 320)^2 + (y - 240 )^2 <= r^2
		B.LE circle //si pertenece al circulo pintamos
		sub x1,x1,1
		add x3,x3,1
		cbnz x1,loop_c
		cbz x1, movy



	/*
	mi centro es (320,240) quiero un circulo de radio 150, por lo que todos los puntos pertenecientes al circulo seran los (x,y)
	tal que  (320 - x)^2 + (240 - y)^2 <= r^2
	r^2= 22500 = 0x57E4
	320 = 0x140
	240 = 0xF0

	 */
	
	
	//---------------------------------------------------------------
	// Infinite Loop 
InfLoop: 
	b InfLoop
