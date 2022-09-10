#ifndef PROMPT_H_
#define PROMPT_H_

#define WORD_MAX 256
#define USER_COLOR "\033[0;38;5;45m"
#define HOST_COLOR "\033[0;38;5;70m"
#define CLOSE_COLOR "\033[0m"

void show_prompt(void);
/*
 * Imprime un prompt con información relevante y colores.
 * 
 * El nuevo prompt tiene el formato:
 *    <user>@<host>
 * 
 */


#endif