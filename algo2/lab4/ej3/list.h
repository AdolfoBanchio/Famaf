#ifndef _LIST_H
#define _LIST_H
#include <stdio.h>
#include <stdbool.h>

typedef struct node * list;
/*defino lista como un puntero a un nodo*/
typedef int list_elem;

list empty(void);
/*devuelve una lista vacia*/

list addl(list_elem e, list l);
/*agrega un elemento al comienzo de la lista*/

bool is_empty(list l);
/**devuelve true si la lista es vacia */

list_elem head(list l);
/*devuelve el primer elemento de la lista
pre not is_empty(l)*/

list tail(list l);
/*elimina el primer elemento de la lista*/

list addr(list l, list_elem e);
/*agrega el elemento e al final de la lista*/

unsigned int length(list l);
/*devielve la cantidad de elementos de la lista l*/

list concat(list l,list l2);
/*agrega al final de l todos los elementos de l2*/

list_elem index(list l,unsigned int i);
/*devuelve el n-esimo elemento de la lista l
el primer elemento es de indice 0
pre: length(l)>n*/

list take(list l,unsigned int n);
/*deeja en l solo los primeros n elementos, eliminando el resto*/

list drop(list l, unsigned int n);
/*elimina los primeros n elementos de l*/

list copy_list(list l);
/*copia todos los elementos de l en una nueva lista l2*/

void destroy_list(list l);
/*libera memoria de ser necesario*/

#endif