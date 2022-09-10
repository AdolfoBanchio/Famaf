/* Bustos Delprato, Franco Nicolás - Banchio, Adolfo - Viglianco, Agustín - OdC 2022 */

.ifndef data_s
.equ data_s, 0

/*
    Este archivo contiene toda la información relacionada con valores 
    que se utilizan en diversos puntos a lo largo del programa
*/

.data
/*
    ".skip" crea un arreglo de la cantidad de bytes indicada e inicializa
    todos los elementos en 0. 
    
    La idea es crear un buffer secundario del mismo tamaño del principal, donde en cada
    cuadro pintamos la imagen y luego la copiamos en el principal.
 */
secondary_buffer: .skip BYTES_FRAMEBUFFER
/*
    Esta constante regula la ejecución de los delay_loops que generan el retardo entre frames.
    Puede modificarse a gusto para regular la velocidad de ejecución de la animación.
*/
delay_time: .dword 0x8fffff

// Arreglos de posiciones
/*
    Las naves estarán asociadas a un arreglo de posiciones.
    Estos se organizan de la siguiente forma:
    ship_player <ejex>,<ejey>,<state>
    ship_enemyX <ejex>,<ejey>,<dead>

    "dead" se inicializa en 0 e indica si hay que pintar o no la correspondiente nave.
    Cuando el campo <dead> > 0, la nave no se pintará más y se usará para el radio
    de la explosión.
 */
ship_player: .word  320,438,0
ship_enemy1: .word 135,40,0
ship_enemy2: .word 270,40,0
ship_enemy3: .word 405,40,0
ship_enemy4: .word 540,40,0

// Balas
/*
    Tenemos un arreglo para cada bala. 
    La estructura se organiza de la siguiente forma:
    bullet_X: <ejex>,<ejey>,<dibujar>,<disparada>

    Al coincidir el eje x de ship_player con el eje x de 
    cualquier ship_enemyX, se disparara la correspondiente bullet_X.
    En ese caso, se marca que hay que dibujarla y que esta disparada (para no dispararla dos veces).
 */
bullet_1:  .word 0,0,0,0
bullet_2:  .word 0,0,0,0
bullet_3:  .word 0,0,0,0
bullet_4:  .word 0,0,0,0

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

// Limite de la explosión
explosion_limit: .word 40

// Pantalla 
/*
    Algunas constantes relacionadas con el tamaño de los píxeles y la pantalla.
*/
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.equ BYTES_PER_PIXEL,    4   
.equ SCREEN_PIXELS,     SCREEN_HEIGH*SCREEN_WIDTH
.equ BYTES_FRAMEBUFFER,  SCREEN_PIXELS * BYTES_PER_PIXEL

.endif
