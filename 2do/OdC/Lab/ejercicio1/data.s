/* Bustos Delprato, Franco Nicolás - Banchio, Adolfo - Viglianco, Agustín - OdC 2022 */

.ifndef data_s
.equ data_s, 0

/*
    Este archivo contiene toda la información relacionada con valores 
    que se utilizan en diversos puntos a lo largo del programa
*/

.data
// Arreglos de posiciones
/*
    Las naves estarán asociadas a un arreglo de posiciones.
    Estos se organizan de la siguiente forma:
    ship_player <ejex>,<ejey>
    ship_enemyX <ejex>,<ejey>
*/
ship_player: .word  240,400
ship_enemy1: .word 135,120
ship_enemy2: .word 270,80
ship_enemy3: .word 405,80
ship_enemy4: .word 540,120

// Balas
/*
    Tenemos un arreglo para cada bala. 
    La estructura se organiza de la siguiente forma:
    bullet_X: <ejex>,<ejey>
*/
bullet_1:  .word 270,340
bullet_2:  .word 540,180
bullet_3:  .word 405,260

// Colores
dark_blue: .word    0x001933
blue: .word         0x0000FF
green: .word        0x66CC00
grey: .word         0x808080
light_blue: .word   0x3B83BD
light_green: .word  0x3C9103
orange: .word       0xFFA500
purple: .word       0x990099
red: .word          0xFF0000
red_light: .word    0xFF4040
white: .word        0xFFFFFF
yellow: .word       0xFFFF00

// Pantalla 
/*
    Algunas constantes relacionadas con el tamaño de los píxeles y la pantalla.
*/
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.equ BYTES_PER_PIXEL,    4

.endif
