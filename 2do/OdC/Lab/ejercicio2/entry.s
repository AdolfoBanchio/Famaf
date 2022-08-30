/* Bustos Delprato, Franco Nicolás - Banchio, Adolfo - Viglianco, Agustín - OdC 2022 */

.ifndef entry_s
.equ entry_s,0

.include "background.s"
.include "data.s"
.include "graphics.s"
.include "logic.s"

/*
	En este archivo se gestiona la animación de entrada y salida de las naves
	a la pantalla.
*/

/*
	Realiza la animación de entrada de las naves (tanto la del jugador como las enemigas).
*/
entry_ships:
	sub sp,sp,#8
	stur lr,[sp]
	mov x16,#40

	entry_ships_loop:
		bl background
		bl draw_player_ship

		ldr x9,=ship_player
		ldur w1,[x9,#4]
		sub x1,x1,#1
		stur w1,[x9,#4]

		ldr x9,=ship_enemy1
		ldr x17, =ship_enemy1
		bl draw_enemy_ship_2

		ldr x9,=ship_enemy1
		ldur w1,[x9,#4]
		add x1,x1,#1
		stur w1,[x9,#4]

		ldr x9,=ship_enemy2
		ldr x17, =ship_enemy2
		bl draw_enemy_ship_1

		ldr x9,=ship_enemy2
		ldur w1,[x9,#4]
		add x1,x1,#1
		stur w1,[x9,#4]

		ldr x9,=ship_enemy3
		ldr x17, =ship_enemy3
		bl draw_enemy_ship_1

		ldr x9,=ship_enemy3
		ldur w1,[x9,#4]
		add x1,x1,#1
		stur w1,[x9,#4]

		ldr x9,=ship_enemy4
		ldr x17,=ship_enemy4
		bl draw_enemy_ship_2

		ldr x9,=ship_enemy4
		ldur w1,[x9,#4]
		add x1,x1,#1
		stur w1,[x9,#4]

		bl frame_update
		bl delay

		sub x16,x16,#1
		cbnz x16,entry_ships_loop
	ldur lr,[sp]
	add sp,sp,8
	br lr


/*
	Realiza la animación de salida de la nave del jugador, y se resetean los parametros
*/
exit_ship:
	sub sp,sp,#8
	stur lr,[sp]
	mov x16,#380
	exit_loop:
		bl background
		bl draw_player_ship

		ldr x17,=ship_player
		ldur w1,[x17,#4]
		sub x1,x1,#2
		stur w1,[x17,#4]

		ldur w0,[x17]
		sub x0,x0,15
		add x1,x1,38
		mov x2,18
		mov x3,3
		ldr x4,yellow
		bl rectangle


		ldur w0,[x17]
		ldur w1,[x17,#4]
		add x0,x0,15
		add x1,x1,38
		mov x2,18
		mov x3,3
		bl rectangle

		ldur w0,[x17]
		ldur w1,[x17,#4]
		sub x0,x0,15
		add x1,x1,41
		mov x2,12
		mov x3,3
		bl rectangle


		ldur w0,[x17]
		ldur w1,[x17,#4]
		add x0,x0,15
		add x1,x1,41
		mov x2,12
		mov x3,3
		bl rectangle

		ldur w0,[x17]
		ldur w1,[x17,#4]
		sub x0,x0,15
		add x1,x1,45
		mov x2,6
		mov x3,4
		bl rectangle


		ldur w0,[x17]
		ldur w1,[x17,#4]
		add x0,x0,15
		add x1,x1,45
		mov x2,6
		mov x3,4
		bl rectangle


		sub x16,x16,#2
		bl frame_update
		bl delay
		cmp x16,xzr
		b.ge exit_loop

	mov w9,#438
	ldr x10,=ship_player
	stur w9,[x10,#4]
	stur wzr,[x10,#8]

	mov w9,#40
	ldr x10,=ship_enemy1
	stur w9,[x10,#4]
	stur wzr,[x10,#8]

	mov w9,#40
	ldr x10,=ship_enemy2
	stur w9,[x10,#4]
	stur wzr,[x10,#8]

	mov w9,#40
	ldr x10,=ship_enemy3
	stur w9,[x10,#4]
	stur wzr,[x10,#8]

	mov w9,#40
	ldr x10,=ship_enemy4
	stur w9,[x10,#4]
	stur wzr,[x10,#8]

	mov w9,#40
	ldr x10,=ship_enemy4
	stur w9,[x10,#4]
	stur wzr,[x10,#12]

	ldr x10,=bullet_1
	stur wzr,[x10,#12]

	ldr x10,=bullet_2
	stur wzr,[x10,#12]

	ldr x10,=bullet_3
	stur wzr,[x10,#12]

	ldr x10,=bullet_4
	stur wzr,[x10,#12]

	ldur lr,[sp]
	add sp,sp,#8
	br lr
.endif
 