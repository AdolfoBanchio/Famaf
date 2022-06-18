#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>
#include "pqueue.h"

struct s_pqueue {
    struct s_node ** cola;
    unsigned int size;
    priority_t min_priority;
};

struct s_node {
    pqueue_elem elem;
    struct s_node *next;
};


/*Funciones auxiliares para los nodos (y cada cola de cada prioridad)*/
static struct s_node * create_node(pqueue_elem e) {
    struct s_node* new_node = NULL;
    new_node = malloc(sizeof(struct s_node));
    assert(new_node!=NULL);
    new_node->elem = e;
    new_node->next = NULL;
    return new_node;
}

static struct s_node * destroy_node(struct s_node *node) {
    node->next = NULL;
    free(node);
    node = NULL;
    return node;
}

static struct s_node * add_to_node(struct s_node * node,pqueue_elem e){
    struct s_node *aux,*new_elem ;
    new_elem = create_node(e);
    aux = node;
    if(node == NULL){
        node = new_elem;
    }else{//como cada nodo representara una cola de cada prioridad, voy a agregar los elementos nuevos (de la misma prioridad) al final de esta cola de prioridad i
        while (aux->next != NULL)
        {
            aux = aux->next;
        }
        aux->next = new_elem;
    }
    return node; //devuelvo el la lista de prioridad i con el nuevo elemento de prioridad i
}


static struct s_node * remove_from_node(struct s_node * node){
    struct s_node * aux;
    aux = node;
    node = node->next;
    aux->next = NULL;
    aux = destroy_node(aux);
    return node;
}

static bool node_is_empty(struct s_node * node){ //me creo una funcion para saber si la cola de prioridad i esta vacia o no
    return node == NULL;
}

static unsigned int qnode_length(struct s_node * node){
    unsigned int p = 0;
    struct s_node *aux = node;
    while (aux != NULL) 
    {
        p++;
        aux = aux->next;
    }
    return p;
}

/*-----------------------------------------------------------------------------------------*/
/*INVARIANTE DE REPRESENTACION*/

static bool invrep(pqueue q) {
    bool inv;
    unsigned int invsize = 0;
    for (unsigned int i = 0; i <= q->min_priority; i++)
    {
        invsize = invsize + qnode_length(q->cola[i]);//sumo la cantidad de elementos que hay con cada prioridad
    }
    inv = q != NULL && invsize == q->size; //una cola nunca puede ser NULL y el q->size debe coincidir con la cantidad de elementos que hay en todas las listas 
    return inv;
}

/*Funciones de pqueue*/

pqueue pqueue_empty(priority_t min_priority) {
    pqueue q;
    q = malloc(sizeof(struct s_pqueue));
    q->cola = calloc(min_priority+1,sizeof(struct s_node *)); /*el arreglo contendra punteros a nodos 
                                                            (donde cada nodo es el comienzo de la cola de prioridad i) desde 0 hasta min priority inclusive.*/
    for (unsigned int r = 0; r <= min_priority; r++)
    {
        q->cola[r] = NULL; //todas las listas de prioridad quedaran vacias 
    }
    q->size = 0;
    q->min_priority = min_priority;
    assert(invrep(q) && pqueue_is_empty(q));
    return q;
}


pqueue pqueue_enqueue(pqueue q, pqueue_elem e, priority_t priority) {
    assert(invrep(q));
    q->cola[priority] = add_to_node(q->cola[priority],e);
    q->size = q->size + 1;
    assert(invrep(q) && !pqueue_is_empty(q));
    return q;
}


bool pqueue_is_empty(pqueue q) {
    assert(invrep(q));
    return q->size == 0;
}

pqueue_elem pqueue_peek(pqueue q) {
    assert(invrep(q) && !pqueue_is_empty(q));
    pqueue_elem a = 0;
    unsigned int i =0; //creo un indicie para recorrer las colas de prioridades
    while (node_is_empty(q->cola[i]) && i<=q->min_priority)
    {
        i++; //si la cola de prioridad i esta vacia, me fijo en la cola de prioridad i+1, hasta encontrar la primer cola de prioridad con algun elemento
    }
    if (i <= q->min_priority)//si logre encontrar algun elemento entonces en la cola de prioridad i tiene el actual elemento con mayor prioridad
    {
        a = q->cola[i]->elem;
    }
    return a;
}

priority_t pqueue_peek_priority(pqueue q) {
    assert(invrep(q) && !pqueue_is_empty(q));
    unsigned int t =0; //creo un indicie para recorrer las colas de prioridades
    while (node_is_empty(q->cola[t]) && t<=q->min_priority)
    {
        t++; //si la cola de prioridad i esta vacia, me fijo en la cola de prioridad i+1, hasta encontrar la primer cola de prioridad con algun elemento
    }
    return t;
}

size_t pqueue_size(pqueue q) {
    assert(invrep(q));
    return q->size;
}

pqueue pqueue_dequeue(pqueue q) {
    assert(invrep(q) && !pqueue_is_empty(q));
    //voy a recorrer el arreglo de colas hasta encontrar la primer cola no vacia(osea la cola con mayor prioridad que tiene elementos)
    unsigned int a =0; //creo un indicie para recorrer las colas de prioridades
    while (node_is_empty(q->cola[a]) && a<=q->min_priority)
    {
        a++;
    }
    //ahora la cola de prioridad i(indice i del arreglo) es la cola con mayor prioridad que tiene algun elemento
    q->cola[a] = remove_from_node(q->cola[a]);
    q->size = q->size -1;
    assert(invrep(q));
    return q;
}

pqueue pqueue_destroy(pqueue q) {
    assert(invrep(q));
    struct s_node * aux;
    for (unsigned int i = 0; i <= q->min_priority; i++)
    {
        while (q->cola[i] != NULL )
        {
            aux = q->cola[i];
            q->cola[i] = q->cola[i]->next;
            aux = destroy_node(aux);
        }        
    }
    free(q->cola); 
    free(q);
    q = NULL;
    return q;
}

