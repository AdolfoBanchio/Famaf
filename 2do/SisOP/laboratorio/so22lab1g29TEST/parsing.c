#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "command.h"
#include "parser.h"
#include "parsing.h"

/* Parsea un comando simple. */
static scommand parse_scommand(Parser p) {
    assert(!parser_at_eof(p));
    scommand cmd = scommand_new();
    bool is_pipe = false;
    arg_kind_t type;
    char *arg = NULL;
    
    while (!is_pipe && !parser_at_eof(p)){
        arg = parser_next_argument(p, &type);
        if (type == ARG_NORMAL && arg != NULL) {
            scommand_push_back(cmd, arg);   
        } else if (type == ARG_INPUT && arg != NULL) {
            scommand_set_redir_in(cmd, arg);
        } else if (type == ARG_OUTPUT && arg != NULL) {
            scommand_set_redir_out(cmd, arg);
        } else {
            is_pipe = true;
        }
        parser_skip_blanks(p);
    }
    return cmd;
}

/* 
 * Parsea un pipeline completo.
 * Devuelve NULL en caso de encontrar un pipeline considerado inválido.
 */
pipeline parse_pipeline(Parser p) {
    assert(p != NULL && !parser_at_eof(p));

    pipeline result = pipeline_new();
    scommand cmd = NULL;
    bool error = false, another_pipe=true;

    cmd = parse_scommand(p);
    error = (cmd == NULL || scommand_is_empty(cmd));
    /* Parseamos el pipeline hasta que no hayas mas | o se detecte error. */
    while (another_pipe && !error) {
        pipeline_push_back(result, cmd);
        if (!parser_at_eof(p)) {
            parser_op_pipe(p, &another_pipe);
            if (another_pipe){
                parser_skip_blanks(p);
                cmd = parse_scommand(p);
                error = (cmd == NULL || scommand_is_empty(cmd));
                parser_skip_blanks(p);
            }
        } else {
            another_pipe=false;
        }
    }

    /* Revisamos los casos donde hay un & y/o basura al final del comando. */
    bool wait = false;
    bool garbage = false;
    if (!parser_at_eof(p)) {        
        parser_op_background(p, &wait);
        parser_garbage(p, &garbage);
        pipeline_set_wait(result, !wait);
    }

    /* Si hubo error, hacemos cleanup */
    if (error) {
        if (!pipeline_is_empty(result)) {
            printf("Invalid command.\n");
        }
        result = pipeline_destroy(result);
        if(cmd != NULL) {
            cmd = scommand_destroy(cmd);
            cmd = NULL;
        }
        result = NULL;   
    }

    /* Consideramos inválido el caso <comando> &<gabage>. */
    if(garbage) {
        if(wait) {
            result = pipeline_destroy(result);
            result = NULL;
            printf("Invalid command.\n");
        }
    }
    return result;
}

