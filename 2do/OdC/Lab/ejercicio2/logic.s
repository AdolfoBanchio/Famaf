/* Bustos Delprato, Franco Nicolás - Banchio, Adolfo - Viglianco, Agustín - OdC 2022 */

.ifndef logic_s
.equ logic_s,0

.include "data.s"
.include "graphics.s"

/*
    Actualiza la posicion de la nave en el eje x segun una variable global 
    para decidir si va hacia la derecha o hacia la izquierda.
    Esta variable tendra 3 estados:
    0: la nave se mueve hacia la derecha, hasta el que el eje x = 550
    1: la nave se mueve hacia la izquierda hasta que el eje x = 130
    2: la nave se movera hacia el eje x = 320 y se cambiara al estado 3
    3: no hay movimiento
 */
right:
    add w0,w0,1
	stur w0,[x10]
	br lr
left:
    sub w0,w0,1
	stur w0,[x10]
	br lr

update_playership:
	ldr x10,=ship_player
    ldur w3,[x10,8]
    ldur w0,[x10]
    cbnz x3,next_state
	cmp w0,555
    b.LE right
    mov x3,1
    stur w3,[x10,8]
next_state:
    cmp w3,1
    B.NE next_state2
    cmp w0,130
    B.NE left
    mov x3,2
    stur w3,[x10,8]
next_state2:
    cmp w3,2
    B.NE next_state3
    cmp w0,320
    B.NE right
    mov x3,3
    stur w3,[x10,8]
next_state3:
    br lr

/* 
    Esta funcion decide si va a disparar la bala en el proximo frame o no, 
    comparando el eje x de ship_player con ship_enemyX.

    En caso de tener que dispararla setea el campo <dibujar> de bullet_X 
    para saber que hay que pintarla y el campo <disparada> para saber que ya se 
    disparo y no es necesario hacerlo de vuelta.
*/
shoot_logic:
    ldr x17,=ship_player
    ldr x18,=ship_enemy1
    ldur w0,[x17]
    ldur w1,[x17,4]
    ldur w2,[x18]
    cmp w0,w2
    B.EQ shoot_enemy1
next_ship:
    ldr x18,=ship_enemy2
    ldur w2,[x18] 
    cmp w0,w2
    B.EQ shoot_enemy2
next_ship2:
    ldr x18,=ship_enemy3
    ldur w2,[x18] 
    cmp w0,w2
    B.EQ shoot_enemy3
next_ship3:
    ldr x18,=ship_enemy4
    ldur w2,[x18] 
    cmp w0,w2
    B.EQ shoot_enemy4
next_ship4:
    br lr

shoot_enemy1:
    ldr x16,=bullet_1
    ldur w5,[x16,12]
    cbnz x5,next_ship
    sub x3,x1,30
    stur w0,[x16]   
    stur w3,[x16,4]
    mov x4,1
    stur w4,[x16,8]
    mov x5,1
    stur w5,[x16,12]
    b next_ship
    
shoot_enemy2:
    ldr x16,=bullet_2
    ldur w5,[x16,12]
    cbnz x5,next_ship2
    sub x3,x1,30
    stur w0,[x16]   
    stur w3,[x16,4]
    mov x4,1
    stur w4,[x16,8]
    mov x5,1
    stur w5,[x16,12]
    b next_ship2

shoot_enemy3:
    ldr x16,=bullet_3
    ldur w5,[x16,12]
    cbnz x5,next_ship3
    sub x3,x1,30
    stur w0,[x16]   
    stur w3,[x16,4]
    mov x4,1
    stur w4,[x16,8]
    mov x5,1
    stur w5,[x16,12]
    b next_ship3
    
shoot_enemy4:
    ldr x16,=bullet_4
    ldur w5,[x16,12]
    cbnz x5,next_ship4
    sub x3,x1,30
    stur w0,[x16]   
    stur w3,[x16,4]
    mov x4,1
    stur w4,[x16,8] 
    mov x5,1
    stur w5,[x16,12]
    b next_ship4
// FIN SHOOT LOGIC

/*
    La funcion actualiza la posicion en el eje Y de las balas si es que estan siendo dibujadas.
 */
update_bullet:
    ldr x11,=bullet_1
    ldur w3,[x11,8]
    cbz x3,next_update 
    ldur w1,[x11,4]
    sub w1,w1,2
    stur w1,[x11,4]
next_update:
    ldr x11,=bullet_2
    ldur w3,[x11,8]
    cbz x3,next_update2 
    ldur w1,[x11,4]
    sub w1,w1,2
    stur w1,[x11,4]
next_update2:
    ldr x11,=bullet_3
    ldur w3,[x11,8]
    cbz x3,next_update3 
    ldur w1,[x11,4]
    sub w1,w1,2
    stur w1,[x11,4]
next_update3:
    ldr x11,=bullet_4
    ldur w3,[x11,8]
    cbz x3,endupdate
    ldur w1,[x11,4]
    sub w1,w1,2
    stur w1,[x11,4]
endupdate:
    br lr
// FIN UPDATE BULLET

// Funciones para el manejo de la animación
/*
    Ejecuta un delay-loop que nos permite retrasar la ejecución de los frames e
    imponerle el ritmo deseado a la animación.

    Depende de la constante delay_time, configurada en data.s
*/
delay:
        ldr x9, delay_time
    delay_loop:
        subs x9, x9, 1
        b.ne delay_loop
        br lr

/*
    Copia todo lo dibujado en el framebuffer secundario en el buffer principal.
    Eso lo hacemos para no perder calidad en la imagen al pintar y actualizar 
    la imagen muy rapidamente.
    Esta técnica nos permite eliminar el parpadeo. 
*/
frame_update:
        mov x9, SCREEN_WIDTH
        mov x10, SCREEN_HEIGH
    frame_loop:
		madd x12,x10,x25,x9 
        ldr w11, [x26,x12,lsl 2] // Copiamos el color de cada pixel del frame secundario
        str w11, [x27,x12,lsl 2] // "Pegamos" en el principal
		sub x9,x9,1
		cbnz x9, frame_loop	
		mov x9, SCREEN_WIDTH
		sub x10,x10,1
		cbnz x10,frame_loop
        br lr


/*
    Verifica si ya terminó la escena, si terminó devuelve 0, sino devuelve 1
*/
    end_animation:
        ldr w9,=ship_player
        ldur w0,[x9,8]
        subs x0,x0,3
        csinc x0,x0,xzr, eq
        
        ldr x10,explosion_limit

        ldr x9,=ship_enemy1
        ldur w9,[x9,8]
        cmp x9,x10
        csinc x0,x0,xzr, ls

        ldr w9,=ship_enemy2
        ldur w9,[x9,8]
        cmp x9,x10
        csinc x0,x0,xzr, ls

        ldr w9,=ship_enemy3
        ldur w9,[x9,8]
        cmp x9,x10
        csinc x0,x0,xzr, ls

        ldr w9,=ship_enemy4
        ldur w9,[x9,8]
        cmp x9,x10
        csinc x0,x0,xzr, ls
        

        br lr

.endif
