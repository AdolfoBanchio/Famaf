delay: .dword 0xfffff
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

//-------------------------delay test
//generate_delay:
	//mov x22, 5
crearDelay:
        ldr x21, delay
    loop_crearDelay:
        subs x21, x21, 1
        b.ne loop_crearDelay
        ldr x21, delay
    loop_crearDelay2:
        subs x21, x21, 1
        b.ne loop_crearDelay2
		ldr x21, delay
    loop_crearDelay3:
        subs x21, x21, 1
        b.ne loop_crearDelay3
//-------------------------	/
	mov x3, 0xaa //170
	mov x4,0x5a  // 90
	
	mov x2, square_heigh //300
square2:
	mov x0,x20 //guardo en x0 la direccion base del frame
	madd x5,x4,x9,x3 //x5 = x9 +(x12*x13) calculo el inicio de la linea del cuadrado
	lsl x5,x5,2 //multiplico por 4
	add x0,x20,x5 //x0 = direc.base.frame + 4*(x+(y*640)) inicio demi nueva linea
	mov x1, 250 //300
loop7:
	stur w10,[x0]
	add x0,x0,4  //next pixel
	sub x1,x1,1
	cbnz x1,loop7
	sub x2,x2,1
	add x4,x4,1 //aumento mi'y' para calcular la base de la linea de abajo
	cbnz x2,square2

	
	//---------------------------------------------------------------
	// Infinite Loop 
InfLoop: 
	b InfLoop
