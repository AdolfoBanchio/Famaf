/* Bustos Delprato, Franco Nicolás - Banchio, Adolfo - Viglianco, Agustín - OdC 2022 */

.ifndef graphics_s
.equ graphics_s,0

.include "data.s"

/* 
    Este archivo contiene el grueso de las funciones relacionadas con
    los gráficos que se realizan en el programa.

    Algunas otras funciones gráficas (como la que dibuja el fondo) fueron modularizadas a
    otros archivos para mayor claridad.
*/

/*
    Realiza los cálculos necesarios para generar un "puntero" al pixel deseado.

    Parámetros:
        x0 = Posición deseada en x
        x1 = Posición deseada en y
    Retorno:
        x0 = Puntero al pixel en las coordenadas deseadas
*/
pixel:
	madd x0, x1, x25, x0 //fila.|Columnas| + columna
	add x0,x27,x0, lsl #2 //baseArray + (fila.|Columnas| + columna)*4
	br lr

/* 
    Dibuja un rectángulo en pantalla.

    Parámetros:
        
        x0 = Posición x del centro
        x1 = Posición y del centro
        x2 = Ancho del rectángulo
        x3 = Alto del rectángulo
        x4 = Color del rectángulo
*/
rectangle:
	sub sp,sp,#8
	stur lr,[sp]

    sub x0,x0,x2,lsr #1
	sub x1,x1,x3,lsr #1
    
	bl pixel

	mov x9,x0
	rectangle_row_loop:
		mov x10,x2
		rectangle_col_loop:
			stur w4,[x9]
			add x9,x9,4
			sub x10,x10,#1
			cbnz x10, rectangle_col_loop
			sub x9,x9,x2, lsl #2
			add x9,x9,x25, lsl #2
			sub x3,x3,#1
			cbnz x3, rectangle_row_loop
	ldur lr,[sp]
	add sp,sp,8
    br lr

/* 
    Dibuja un círculo en la pantalla.

    Parámetros:
        x0 = posicion del centro en x
        x1 = posicion del centro en y
        x2 = radio del circulo
        x3 = color del circulo
*/
circle:
            sub sp,sp,8
            stur lr,[sp]

            mov x4, x0
            mov x5, x1

            sub x9, x4,x2 
            sub x10, x5,x2

            mul x6,x2,x2
            add x7,x2,x2
            add x8,x2,x2
    circle_loop:
            sub x0,x9,x4
            sub x1,x10,x5
            madd x0,x0,x0,xzr
            madd x0,x1,x1,x0
            cmp x0,x6
            B.LE circle_loop2
            sub x7,x7,1
            add x9,x9,1
            cbnz x7,circle_loop
    circle_mov_y:
            add x10,x10,1
            sub x9,x4,x2
            sub x8,x8,1
            add x7,x2,x2
            cbnz x8, circle_loop
    circle_ret:
        ldur lr,[sp]
        add sp,sp,8
        BR LR
    
    circle_loop2: 
            mov x0,x9
            mov x1,x10
            BL pixel
            stur w3,[x0]
            add x9,x9,1
            sub x7,x7,1
            cbz x7, circle_mov_y
            b circle_loop

/* 
    Dibuja un triangulo en la pantalla.

    Parámetros:
        x0 = posicion del centro en x
        x1 = posicion del centro en y
        x2 = mitad de la altura del triangulo
        x3 = color del triangulo
*/
triangle:
    sub sp,sp,#8
    stur lr,[sp]
    
    sub x1, x1, x2
    mov x13, x0
    mov x10, x2, lsl 1
    mov x11, 1
    triangle_row_loop:
        mov x12, x11
        mov x0, x13
        bl pixel
        mov x9, x0
        triangle_col_loop:
            stur w3, [x9]
            add x9, x9, 4
            sub x12, x12, 1
            cbnz x12, triangle_col_loop
            add x11, x11, 2
            sub x10, x10, 1
            add x1, x1, 1
            sub x13, x13, 1
            cbnz x10, triangle_row_loop
    ldur lr,[sp]
    add sp,sp,8
    br lr

/*
    Pinta la nave "del jugador" usando como parámetros los datos extraidos 
    del arreglo asociado ship_player definido en el archivo data.s
 */
draw_player_ship:
    sub sp,sp,8
    stur lr,[sp]

    ldr x17,=ship_player

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,6
    mov x3,84
    ldr x4,white
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,18
    mov x3,60
    ldr x4,white
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    add w1,w1,12
    mov x2,30
    mov x3,36
    ldr x4,white
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,6
    mov x3,12
    ldr x4,red
    bl rectangle

    mov x18,1
    sub x18,xzr,x18

    player_loop:
    ldur w0,[x17]
    ldur w1,[x17,4]
    mov w9,18
    madd w0,w9,w18,w0
    add w1,w1,15
    mov x2,6
    mov x3,18
    ldr x4,white
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov w9,24
    madd w0,w9,w18,w0
    add w1,w1,12
    mov x2,6
    mov x3,36
    ldr x4,white
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov w9,30
    madd w0,w9,w18,w0
    add w1,w1,27
    mov x2,6
    mov x3,18
    ldr x4,white
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov w9,36
    madd w0,w9,w18,w0
    add w1,w1,24
    mov x2,6
    mov x3,36
    ldr x4,white
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov w9,18
    madd w0,w9,w18,w0
    add w1,w1,3
    mov x2,6
    mov x3,6
    ldr x4,blue
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov w9,24
    madd w0,w9,w18,w0
    add w1,w1,9
    mov x2,6
    mov x3,6
    ldr x4,blue
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov w9,24
    madd w0,w9,w18,w0
    sub w1,w1,9
    mov x2,6
    mov x3,18
    ldr x4,red
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov w9,36
    madd w0,w9,w18,w0
    mov x2,6
    mov x3,18
    ldr x4,red
    bl rectangle
    
    ldur w0,[x17]
    ldur w1,[x17,4]
    mov w9,12
    madd w0,w9,w18,w0
    add w1,w1,21
    mov x2,6
    mov x3,6
    ldr x4,red
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov w9,15
    madd w0,w9,w18,w0
    add w1,w1,30
    mov x2,12
    mov x3,12
    ldr x4,red
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov w9,6
    madd w0,w9,w18,w0
    add w1,w1,6
    mov x2,6
    mov x3,12
    ldr x4,red
    bl rectangle

    add x18,x18,2
    cmp x18,1
    b.eq player_loop

    ldur lr,[sp]
    add sp,sp,8
    br lr

/*
    Pintan las naves "enemigas" usando como parametros los datos 
    extraidos del arreglo ship_player definido en el arhivo data.s

    La nave se dibuja solo si no está muerta, es decir si el campo
    <dead> de su arreglo asociado es cero.
 */
draw_enemy_ship_1:
    sub sp,sp,8
    stur lr,[sp]

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,20
    mov x3,50
    ldr x4,red
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 30
    mov x3, 25
    ldr x4, yellow
    sub x1, x1, 25
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 8
    mov x3, 10
    ldr x4, yellow
    sub x1, x1, 40
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 11
    mov x3, 10
    ldr x4, red
    sub x0, x0, 10
    sub x1, x1, 32
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 11
    mov x3, 10
    ldr x4, red
    add x0, x0, 9
    sub x1, x1, 32
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 20
    mov x3, 10
    ldr x4, yellow
    add x1, x1, 15
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 6
    mov x3, 10
    ldr x4, red
    add x1, x1, 25
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 4
    mov x3, 4
    ldr x4, yellow
    sub x0, x0, 13
    sub x1, x1, 35
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 4
    mov x3, 4
    ldr x4, yellow
    add x0, x0, 13
    sub x1, x1, 35
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 11
    mov x3, 11
    ldr x4, light_blue
    sub x0, x0, 16
    sub x1, x1, 7
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 11
    mov x3, 11
    ldr x4, light_blue
    add x0, x0, 14
    sub x1, x1, 7
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 11
    mov x3, 33
    ldr x4, light_blue
    add x0, x0, 20
    add x1, x1, 10
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 11
    mov x3, 33
    ldr x4, light_blue
    sub x0, x0, 22
    add x1, x1, 10
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 7
    mov x3, 7
    ldr x4, light_blue
    sub x0, x0, 19
    sub x1, x1, 30
    bl rectangle    
    
    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 7
    mov x3, 7
    ldr x4, light_blue
    add x0, x0, 17
    sub x1, x1, 30
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 5
    mov x3, 17
    ldr x4, light_blue
    add x0, x0, 22
    sub x1, x1, 40
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2, 5
    mov x3, 17
    ldr x4, light_blue
    sub x0, x0, 24
    sub x1, x1, 40
    bl rectangle

    ldur lr,[sp]
    add sp,sp,8
    br lr

draw_enemy_ship_2:
    sub sp,sp,8
    stur lr,[sp]

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,34
    mov x3,20
    ldr x4,yellow
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,4
    mov x3,12
    ldr x4,orange
    add x0, x0, 8
    add x1, x1, 16
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,4
    mov x3,12
    ldr x4,orange
    sub x0, x0, 7
    add x1, x1, 16
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,34
    mov x3,5
    ldr x4,light_green
    sub x1, x1, 13
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,7
    mov x3,15
    ldr x4,light_green
    sub x1, x1, 13
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,9
    mov x3,12
    ldr x4,orange
    sub x0, x0, 7
    sub x1, x1, 21
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,9
    mov x3,12
    ldr x4,orange
    add x0, x0, 7
    sub x1, x1, 21
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,4
    mov x3,10
    ldr x4,light_green
    add x0, x0, 6
    sub x1, x1, 32
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,4
    mov x3,10
    ldr x4,light_green
    sub x0, x0, 5
    sub x1, x1, 32
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,12
    mov x3,22
    ldr x4,light_green
    sub x0, x0, 23
    add x1, x1, 3
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,12
    mov x3,25
    ldr x4,light_green
    sub x0, x0, 28
    add x1, x1, 10
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,5
    mov x3,7
    ldr x4,orange
    sub x0, x0, 28
    add x1, x1, 8
    bl rectangle

        ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,12
    mov x3,22
    ldr x4,light_green
    add x0, x0, 23
    add x1, x1, 3
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,12
    mov x3,25
    ldr x4,light_green
    add x0, x0, 28
    add x1, x1, 10
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,5
    mov x3,7
    ldr x4,orange
    add x0, x0, 28
    add x1, x1, 8
    bl rectangle

    ldur lr,[sp]
    add sp,sp,8
    br lr

/*
    Función que pinta a la vez las 4 naves enemigas en la posición especificada
*/
draw_all_enemy_ships:
    sub sp,sp,8
    stur lr,[sp]
    
    ldr x17,=ship_enemy1
    bl draw_enemy_ship_2
    ldr x17,=ship_enemy2
    bl draw_enemy_ship_1
    ldr x17,=ship_enemy3
    bl draw_enemy_ship_1
    ldr x17,=ship_enemy4
    bl draw_enemy_ship_2

    ldur lr,[sp]
    add sp,sp,8
    br lr

/*
    Dibuja una bala de acuerdo a la posiciones (x, y) especificadas
    como parámetros.
    
    Parámetros:
        x0 = Posición x del centro
        x1 = Posición y del centro
*/
paint_bullet:
    sub sp,sp,8
    stur lr,[sp]

    ldur w0,[x9, 0]
    ldur w1,[x9, 4]
    mov x12,x0
    mov x13,x1

    mov x2,4
    mov x3,10
    ldr x4,red
    bl rectangle

    sub x1,x13,12
    sub x0,x12,1
    mov x2,3
    mov x3,4
    ldr x4,light_blue
    bl rectangle

    sub x1,x13,8
    sub x0,x12,4
    mov x2,3
    mov x3,4
    ldr x4,light_blue
    bl rectangle
    
    sub x1,x13,8
    add x0,x12,2
    mov x2,3
    mov x3,4
    ldr x4,light_blue
    bl rectangle
    ldur lr,[sp]
    add sp,sp,8
    br lr

paint_bullets:
    sub sp,sp,8
    stur lr,[sp]

    ldr x9, =bullet_1
    bl paint_bullet
    ldr x9, =bullet_2
    bl paint_bullet
    ldr x9, =bullet_3
    bl paint_bullet

    ldur lr,[sp]
    add sp,sp,8
    br lr

.endif
