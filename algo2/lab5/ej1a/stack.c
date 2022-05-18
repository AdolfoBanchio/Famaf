#include <stdlib.h>
#include <assert.h>
#include "stack.h"
 
struct _s_stack
{
    stack_elem elem;
    struct _s_stack *next;
};


stack stack_empty(){
    return NULL;
}


stack stack_push(stack s, stack_elem e){
    stack aux = NULL;
    aux = malloc(sizeof(struct _s_stack ));
    aux->elem = e;
    aux->next = s ;
    s = aux ;
    return s;
}


stack stack_pop(stack s){
    assert(!stack_is_empty(s));
     stack p = NULL;
     p = s;
     s = s->next;
     p->next = NULL;
     stack_destroy(p);
     return s;
}

unsigned int stack_size(stack s){
    unsigned int i = 0u;
    stack p = NULL;
    p = s;
    while (p!= NULL)
    {
        p = p->next;
        ++i;
    }
    return i;
}

bool stack_is_empty(stack s){
    return (s==NULL);
}

stack_elem stack_top (stack s){
    assert(!stack_is_empty(s));
    stack_elem e = 0u;
    e = s->elem;
    return e ;
}




stack_elem *stack_to_array(stack s){
    stack_elem * array = NULL;
    if (s == NULL)
    {
        return NULL;
    }
    array = calloc(stack_size(s),sizeof(stack_elem));
    stack p = NULL;
    p = s;
    for (unsigned int i = 0; i < stack_size(s); i++)
    {
        array[(stack_size(s)-1)-i] = p->elem;
        p = p->next;
    }
    return array;
}


stack stack_destroy(stack s){
    stack p = s;
    while (!stack_is_empty(s)) {
        s = s->next;
        p->next = NULL;
        free(p);
        p = s;
    }
    return s;
}

