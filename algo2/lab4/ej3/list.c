#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <assert.h>
#include "list.h"

struct node{
    list_elem elem;
    struct node * next;
};

list empty(void){
    list l = NULL;
    return l;
}

list addl(list_elem e,list l){
    list aux = malloc(sizeof(list_elem));
    aux->elem = e;
    aux->next = l ;
    l = aux ;
    return l ;
}
bool is_empty(list l){
    return (l==NULL);
}
/**devuelve true si la lista es vacia */

list_elem head(list l){
    //assert(!is_empty(l));
    return l->elem;
}
/*devuelve el primer elemento de la lista
pre not is_empty(l)*/

list tail(list l){
    list aux;
    aux = l;
    l = l->next;
    free(aux);
    return l;
}
/*elimina el primer elemento de la lista*/

list addr(list l, list_elem e){
    list aux,newe;
    newe = malloc(sizeof(struct node));
    aux = l;
    if(aux != NULL){
        while (aux->next != NULL)
        {
            aux = aux->next;
        }
        newe->elem = e;
        newe->next = NULL;
        aux->next = newe;
    }else{
        newe->elem = e;
        newe->next = NULL;
        l = newe;
    }
    return l;
}
/*agrega el elemento e al final de la lista*/

unsigned int length(list l){
    list aux = l;
    unsigned int i=0;
    while (aux !=NULL)
    {
        aux= aux->next;
        ++i;
    }
    return i;
}
/*devielve la cantidad de elementos de la lista l*/

list concat(list l,list l2){
    list aux,cpl2;
    aux = l;
    cpl2 = copy_list(l2);
    if(aux != NULL){
        while (aux->next != NULL )
        {
            aux = aux->next;
        }
        aux->next = cpl2;
    }else{
        l = cpl2;
    }
    return l;
}
/*agrega al final de l todos los elementos de l2*/

list_elem index(list l,unsigned int n){
    assert(length(l)>n);
    list aux = l;
    for (unsigned int i = 0; i < n; i++)
    {
        aux = aux->next;
    }
    return aux->elem;
}
/*devuelve el n-esimo elemento de la lista l
el primer elemento es de indice 0
pre: length(l)>n*/

list take(list l,unsigned int n){
    list aux,aux1;
    unsigned int i = 0;
    aux = l;
    if (n == 0){
        l = NULL;
        destroy_list(aux);
    }else if (l!= NULL){
        while (aux->next != NULL && i < n-1)
        {
            aux = aux->next;
            ++i;
        }
        aux1= aux->next;
        aux->next=NULL;
        destroy_list(aux1);
    }
    return l;
}
/*deeja en l solo los primeros n elementos, eliminando el resto*/

list drop(list l, unsigned int n){
    unsigned int i = 0;
    while (l!= NULL && i < n)
    {
        l = tail(l);
        ++i;
    }
    return l;
}
/*elimina los primeros n elementos de l*/

list copy_list(list l){
    list aux,copy;
    aux = l;
    copy = empty();
    while (aux != NULL){
        copy = addr(copy,aux->elem);
        aux = aux->next;
    }
    return copy;
}
/*copia todos los elementos de l en una nueva lista l2*/

void destroy_list(list l){
    while(l!=NULL){
        l = tail(l);
    }
    //free(l);
}
/*libera memoria de ser necesario*/



