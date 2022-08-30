#include <stdio.h>
#include <stdlib.h>
#include "stack.h"

int main(){
    stack s,p,q;
    q = stack_empty();
    s = stack_empty();
    p = stack_empty();
    for (unsigned int i = 0; i < 5; i++)
    {
        s = stack_push(s,i);
    }
    printf("\nlargo de la stack s %u \n",stack_size(s));
    p = stack_push(p,1);
    p = stack_pop(p);
    printf("\nlargo de la stack p %u \n",stack_size(p));
    p = stack_push(p,1);
    printf("\nlargo de la stack p %u \n",stack_size(p));


    stack_elem *a = stack_to_array(q);
    printf("funciona stack_to_array para pila vacia?\n");
    if (a==NULL)
    {
        printf("zi\n");
    }else{
        printf("no\n");
    }
    
    stack_elem* b = stack_to_array(s);
    for (unsigned int i = 0; i < stack_size(s); i++)
    {
        printf(" %d ",b[i]);
    }
    printf("\n");
    q = stack_destroy(q);
    s = stack_destroy(s);
    p = stack_destroy(p);
    free(a);
    free(b);
    return 0;
}

/*
no errores valgrind
*/