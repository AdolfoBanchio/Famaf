#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include "tests/syscall_mock.h"
#include "builtin.h"
#include "command.h"
#include "execute.h"
#include "strextra.h"

static char **set_args(scommand cmd, unsigned int length) {
    char **args = calloc(length,sizeof(char *));
    args[0] = strdup(scommand_front(cmd));
    scommand_pop_front(cmd);
    for (unsigned int i = 1; i < length-1;i++) {
        args[i] = strdup(scommand_front(cmd));
        scommand_pop_front(cmd);
    }
    return args;
}

static char **free_args(char **args, unsigned int length) {
    for (unsigned int i = 0; i < length; i++) {
        free(args[i]);
        args[i] = NULL;
    }
    free(args);
    args = NULL;
    return args;
}

static void setup_redir_in(scommand cmd) {
    int in_fd = open(scommand_get_redir_in(cmd), O_RDONLY, 0);
    if (in_fd < 0) {
        fprintf(stderr, "Open failed: file or directory not found.");
    }
    dup2(in_fd, STDIN_FILENO);
    close(in_fd);
}

static void setup_redir_out(scommand cmd) {
    int out_fd = open(scommand_get_redir_out(cmd), 
                  O_CREAT | /* Crea el archivo si no existe */
                  O_WRONLY | /* Permite solo lectura */
                  O_TRUNC, /* Si existe, sobreescribe */
                  S_IRWXU /* Permiso de edición y ejecución */
                  | 0);
    if (out_fd < 0) {
        fprintf(stderr, "Open failed: file or directory not found.");
    }
    dup2(out_fd, STDOUT_FILENO);
    close(out_fd);
}

static void execute_scommand(scommand cmd) {
    unsigned int init_length = scommand_length(cmd)+1;
    char **args = set_args(cmd, init_length);
    if (scommand_get_redir_in(cmd)!=NULL) {
        setup_redir_in(cmd);
    }
    if (scommand_get_redir_out(cmd)!= NULL) {
        setup_redir_out(cmd);
    }
    if (execvp(args[0],args)<0) {
        printf("Invalid command.\n");
        /* Salimos del proceso hijo y liberamos la memoria */
        args = free_args(args, init_length);    
        exit(EXIT_FAILURE);
    }
    args = free_args(args, init_length);
}


void execute_pipeline(pipeline apipe) {
    assert(apipe != NULL);
    scommand cmd;
    if (builtin_alone(apipe)) {
        builtin_run(pipeline_front(apipe));
    } else {
        if (pipeline_length(apipe)==1) {
            /* Comandos simples */
            cmd = pipeline_front(apipe);
            pid_t pid = fork();
            if (pid < 0) {
                fprintf(stderr,"Fork failed.\n");
            } else if (pid == 0) {
                execute_scommand(cmd);
            } else if (pipeline_get_wait(apipe)) {
                wait(NULL);
            }
        } else if (pipeline_length(apipe) == 2) {
            /* Pipeline con solo 2 scommands */
            int pipefd[2];
            pid_t pid1,pid2;
            pipe(pipefd);

            cmd = pipeline_front(apipe);
            pid1 = fork();
            if (pid1 < 0) {
                fprintf(stderr,"Fork failed.\n");
            } else if (pid1 == 0) {
                /* child 1 executing */
                close(pipefd[0]);
                dup2(pipefd[1],STDOUT_FILENO);
                close(pipefd[1]);
                execute_scommand(cmd);
            } else { 
                /* parent executing */
                
                pipeline_pop_front(apipe);
                cmd = pipeline_front(apipe);
                pid2 = fork();
                if (pid2 < 0) {
                    fprintf(stderr,"Fork failed.\n");
                } else if (pid2 == 0) {
                    /* child 2 executing */
                    close(pipefd[1]);
                    dup2(pipefd[0],STDIN_FILENO);
                    close(pipefd[0]);
                    execute_scommand(cmd);
                } else if (pipeline_get_wait(apipe)) {
                    close(pipefd[0]);
                    close(pipefd[1]);
                    wait(NULL);
                    wait(NULL);
                }
            }
        } else if (pipeline_length(apipe) > 2) {
            fprintf(stderr, "Pipelines longer than 2 commands are not supported.\n");
        }
    }
}
