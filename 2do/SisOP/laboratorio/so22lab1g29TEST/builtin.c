#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include "tests/syscall_mock.h"

#include "builtin.h"
#include "command.h"


/*
 * Indica si el comando alojado en `cmd` es un comando interno.
 */
bool builtin_is_internal(scommand cmd) {
    assert(cmd != NULL);
    /* Guargamos los nombres de los comandos implementados en un arreglo. */
    const char *list_of_bi_cmds[] = {"cd", "help", "pwd","exit"};
    bool is_internal = false;
    char *cmd_name = scommand_front(cmd);
    for (unsigned int i = 0; i < BUILTIN_AMOUNT && !is_internal; ++i) {
        if (!strcmp(list_of_bi_cmds[i], cmd_name)) {
            is_internal = true;
        }
    }
    return is_internal;
}


/*
 * Indica si el comando alojado en `cmd` es el comando 'exit'.
 */
bool builtin_is_exit(scommand cmd) {
    assert(cmd != NULL);
    char *cmd_name = scommand_front(cmd);
    bool is_exit = !strcmp("exit", cmd_name);
    return is_exit;
}


/*
 * Indica si el pipeline tiene un solo elemento y si este corresponde
 * a un comando interno.
 */
bool builtin_alone(pipeline p) {
    assert(p != NULL);
    return pipeline_length(p) == 1 && builtin_is_internal(pipeline_front(p));
}


/*
 * Cambia el directorio en el que trabaja el proceso de la terminal.
 */
static void change_dir(char *dir) {
    if (dir == NULL) {
        /* Caso 'cd' sin argumentos -> cambia a HOME */
        char *home = getenv("HOME");
        chdir(home);
    } else {
        chdir(dir);
    }
}


/*
 * Imprime un mensaje con información sobre la terminal.
 */
static void print_help(void) {
    const char *msg = 
        "MyBash -- Implemented by \033[0;38;5;45m'La Miñoneta'\033[0m\n"
        "-> Banchio, Adolfo\n"
        "-> Gimenez, Julieta\n"
        "-> Viglianco, Agustín\n\n"
        "You can use the following internal commands:\n"
        "> cd <new_dir>: change current directory.\n"
        "> exit: exit the terminal.\n"
        "> help: print information about the shell and its usage.\n"
        "> pwd: print current working directory.\n";
    printf("%s\n", msg);
    fflush(stdout);
}


/*
 * Imprime el directorio en el que trabaja la terminal.
 */
static void print_working_dir(void) {
    char cwd[MAX_PATH];
    if (getcwd(cwd, sizeof(cwd)) != NULL) {
        printf("%s\n", cwd);
    } else {
        printf("Couldn't find current working directory.\n");
    }
    fflush(stdout);
}


/*
 * Ejecuta un comando interno.
 */
void builtin_run(scommand cmd) {
    assert(builtin_is_internal(cmd));
    
    char *command = strdup(scommand_front(cmd));
    scommand_pop_front(cmd);

    /* Ejecutamos la función correspondiente al comando especificado */
    if (!strcmp(command, "cd")) {
        if (scommand_is_empty(cmd)) {
            /* Caso 'cd' sin argumentos */
            change_dir(NULL);
        } else {
            char *dir = strdup(scommand_front(cmd));
            scommand_pop_front(cmd);
            change_dir(dir);
            free(dir);
            dir = NULL;
        }
    } else if (!strcmp(command, "help")) {
        print_help();
    } else if (!strcmp(command, "pwd")) {
        print_working_dir();
    }
    free(command);
    command = NULL;
}