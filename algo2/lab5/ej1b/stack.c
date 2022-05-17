#include <stdlib.h>
#include <assert.h>
#include "stack.h"
 
struct _s_stack
{
    stack_elem elem;
    struct _s_stack *next;
    unsigned int stack_len;
};

/*
invariante:
cada elemento del stack, en el campo stack_len, tendra
la cantidad de elementos que hay desde el mismo hacia el final.
*/
stack stack_empty(){
    stack s = malloc(sizeof(struct _s_stack));
    s->stack_len = 0;
    return s;
}


stack stack_push(stack s, stack_elem e){
    if (s->stack_len == 0)
    {
        s->elem = e;
        s->next = NULL;
        s->stack_len++;
    }else{
        stack aux = malloc(sizeof(struct _s_stack));
        aux->elem = e;
        aux->next = s;
        aux->stack_len = s->stack_len;
        /*
        guardo en aux la distancia que habia entre el primer elemento y el final
        ANTES de sumar este nuevo elemento.
        */
        s = aux ;
        s->stack_len++;
        /*
        le sumo 1 al largo total de la lista(nodo inicial).
        tq el nodo inicial tiene la nueva distancia hacia el fin de la lista.
        */
    } 
    return s;
}


stack stack_pop(stack s){
     stack p;
     p = s;
     s = s->next;
     p->next = NULL;
     stack_destroy(p);
     return s;
}

unsigned int stack_size(stack s){
    return s->stack_len;
}

bool stack_is_empty(stack s){
    return (s->stack_len == 0);
}

stack_elem stack_top (stack s){
    assert(s->stack_len != 0);
    stack_elem e ;
    e = s->elem;
    return e ;
}

stack_elem *stack_to_array(stack s){
    stack_elem * array;
    if (s->stack_len != 0)
    {
        return NULL;
    }
    array = calloc(stack_size(s),sizeof(stack_elem));
    stack p = s;
    for (unsigned int i = 0; i < stack_size(s); i++)
    {
        array[(stack_size(s)-1)-i] = stack_top(p);
        p = p->next;
    }
    return array;
}


stack stack_destroy(stack s){
    stack p;
    while (s != NULL)
    {
        p = s;
        s = s->next;
        p->next = NULL;
        free(p);
    }
    free(s);
    return s;
}

