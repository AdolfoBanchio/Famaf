#include <assert.h>
#include <glib.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#include "command.h"
#include "strextra.h"

/* scommand: comando simple. */
struct scommand_s{
    GQueue *args;
    char *input;
    char *output;
};

scommand scommand_new(void) {
    scommand newcmd = malloc(sizeof(struct scommand_s));
    assert(newcmd != NULL);
    newcmd->args = g_queue_new();
    newcmd->input = NULL;
    newcmd->output = NULL;
    assert(newcmd != NULL 
           && scommand_is_empty(newcmd) 
           && scommand_get_redir_in(newcmd)==NULL 
           && scommand_get_redir_out(newcmd)==NULL);
    return newcmd;
}

scommand scommand_destroy(scommand self) {
    assert(self != NULL);
    if (g_queue_is_empty(self->args)) {
        g_queue_free(self->args);
    } else {
        g_queue_free_full(self->args,free);
    }
    free(self->input);
    free(self->output);
    self->args = NULL;
    self->input = NULL;
    self->output = NULL;
    free(self);
    self = NULL;
    assert(self==NULL);
    return self;
}

/* Modificadores */

void scommand_push_back(scommand self, char * argument) {
    assert(self != NULL && argument != NULL);
    g_queue_push_tail(self->args, argument);
}

void scommand_pop_front(scommand self) {
    assert(self != NULL && !scommand_is_empty(self));
    char *to_destroy = g_queue_pop_head(self->args);
    free(to_destroy);
    to_destroy = NULL;
}

void scommand_set_redir_in(scommand self, char * filename) {
    assert(self != NULL);
    if (self->input != NULL) {
        free(self->input);
        self->input = NULL; 
    }   
    self->input = filename;
}


void scommand_set_redir_out(scommand self, char * filename) {
    assert(self != NULL);
    if (self->output != NULL) {
        free(self->output);
        self->output = NULL;   
    }
    self->output = filename;
}

/* Proyectores */

bool scommand_is_empty(const scommand self) {
    assert(self != NULL);
    return g_queue_is_empty(self->args);
}

unsigned int scommand_length(const scommand self) {
    assert(self != NULL);
    guint length = g_queue_get_length(self->args);
    return length;
}

char * scommand_front(const scommand self) {
    assert(self != NULL && !scommand_is_empty(self));
    char *front = g_queue_peek_head(self->args);
    assert(front != NULL);
    return front;
}

char * scommand_get_redir_in(const scommand self) {
    assert(self != NULL);
    return self->input;
}

char * scommand_get_redir_out(const scommand self) {
    assert(self != NULL);
    return self->output;
}


char * scommand_to_string(const scommand self){
    assert(self != NULL);
    char *str = NULL;
    unsigned int index = 1;
    if (!scommand_is_empty(self)) {
            str = strmerge(g_queue_peek_head(self->args),"");
        while (g_queue_get_length(self->args) > index && str != NULL) {
            str = merge_with_free(str," ");
            str = merge_with_free(str, g_queue_peek_nth(self->args,index));
            index ++;
        }
        if (self->output != NULL) {
            str = merge_with_free(str," > ");
            str = merge_with_free(str, self->output);
        }
        if (self->input != NULL) {
            str = merge_with_free(str," < ");
            str = merge_with_free(str, self->input);
        }
    } else {
        str = strdup("");
    }
    assert(scommand_is_empty(self) || scommand_get_redir_in(self) == NULL 
           || scommand_get_redir_out(self) == NULL || strlen(str) > 0);
    return str;
}


/* pipeline: tubería de comandos. */
struct pipeline_s {
    GQueue *commands;
    bool wait;
};

pipeline pipeline_new(void) {
    pipeline newpipe;
    newpipe = malloc(sizeof(struct pipeline_s));
    newpipe->commands = g_queue_new();
    newpipe->wait = true;
    return newpipe;
}

pipeline pipeline_destroy(pipeline self) {
    assert(self!=NULL);
    scommand cmd;
    while (!g_queue_is_empty(self->commands)) {
        cmd = g_queue_pop_head(self->commands);
        cmd = scommand_destroy(cmd);
    }
    g_queue_free(self->commands);
    free(self);
    self = NULL;
    assert(self == NULL);
    return self;
}

/* Modificadores */

void pipeline_push_back(pipeline self, scommand sc) {
    assert(self != NULL && sc != NULL);
    g_queue_push_tail(self->commands,sc);
    assert(!pipeline_is_empty(self));
}

void pipeline_pop_front(pipeline self) {
    assert(self != NULL && !pipeline_is_empty(self));
    scommand to_destroy = g_queue_pop_head(self->commands);
    scommand_destroy(to_destroy);
}

void pipeline_set_wait(pipeline self, const bool w) {
    assert(self != NULL);
    self->wait = w;
}

/* Proyectores */

bool pipeline_is_empty(const pipeline self) {
    assert(self != NULL);
    return g_queue_is_empty(self->commands);
}

unsigned int pipeline_length(const pipeline self) {
    assert(self != NULL);
    guint length = g_queue_get_length(self->commands);
    return length;
}

scommand pipeline_front(const pipeline self) {
    assert(self != NULL && !pipeline_is_empty(self));
    scommand front = g_queue_peek_head(self->commands);
    assert(front != NULL);
    return front;
}

bool pipeline_get_wait(const pipeline self) {
    assert(self != NULL);
    return self->wait;
}

char * pipeline_to_string(const pipeline self) {
    assert(self != NULL);
    char * str = NULL;
    char * aux;
    unsigned int index = 1;
    if (!pipeline_is_empty(self)) {
        str = scommand_to_string(g_queue_peek_head(self->commands));
        while (g_queue_get_length(self->commands) > index) {
            str = merge_with_free(str," | ");
            aux = scommand_to_string(g_queue_peek_nth(self->commands,index));
            str = merge_with_free(str, aux);
            free(aux);
            index ++;
        }
        if (self->wait == false) {
            str = merge_with_free(str, " &");
        }
    } else {
        str = strdup("");
    }
    assert(pipeline_is_empty(self) || pipeline_get_wait(self) || strlen(str)>0);
    return str;
}