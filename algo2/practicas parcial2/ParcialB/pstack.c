#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>
#include "pstack.h"

struct s_pstack {
    struct s_node *front;
    unsigned int size;
};

struct s_node {
    pstack_elem elem;
    priority_t priority;
    struct s_node *next;
};

static struct s_node * create_node(pstack_elem e, priority_t priority) {
    struct s_node *new_node = NULL;
    new_node = malloc(sizeof(struct s_node));
    assert(new_node!=NULL);
    new_node->elem = e;
    new_node->priority = priority;
    new_node->next = NULL;
    return new_node;
}

static struct s_node * destroy_node(struct s_node *node) {
    assert(node != NULL);
    node->next = NULL;
    free(node);
    node = NULL;
    assert(node == NULL);
    return node;
}


static bool invrep(pstack s) {
    bool inv = true;
    if (s->size == 0 && s->front == NULL)
    {
        inv = true;
    }else{
        struct s_node*p = s->front;
        while (p->next != NULL)
        {
            inv = p->priority >= p->next->priority;
            p = p->next;
        }
    }
    return inv;
}

pstack pstack_empty(void) {
    pstack s=NULL;
    s = malloc(sizeof(struct s_pstack));
    s->front = NULL;
    s->size = 0;
    return s;
}

pstack pstack_push(pstack s, pstack_elem e, priority_t priority) {
    assert(invrep(s));
    struct s_node *new_node = create_node(e, priority);
    if (pstack_is_empty(s))
    {
        s->front = new_node;
    }else{
        struct s_node *p = s->front;
        struct s_node *r = NULL;
        if (s->front->priority <= priority)
        {
            p = s->front;
            s->front = new_node;
            new_node->next = p;
        }else{  
            while (p->next != NULL && p->next->priority >= priority)
            {
                p = p->next;
            }//avanzo hasta el nodo que tenga 
            r = p;
            p = new_node;
            new_node->next = r;
        }
    }
    s->size = s->size +1;
    return s;
}

bool pstack_is_empty(pstack s) {
    assert(invrep(s));
    return (s->size == 0 && s->front == NULL);
}

pstack_elem pstack_top(pstack s) {
    assert(invrep(s));
    return s->front->elem;
}

priority_t pstack_top_priority(pstack s) {
    assert(invrep(s));
    return s->front->priority;
}

unsigned int pstack_size(pstack s) {
    assert(invrep(s));
    return s->size;
}

pstack pstack_pop(pstack s) {
    assert(invrep(s));
    struct s_node * p = s->front;
    s->front = s->front->next;
    p->next = NULL;
    p = destroy_node(p);
    s->size = s->size-1;
    return s;
}

pstack pstack_destroy(pstack s) {
    assert(invrep(s));
    struct s_node *p = s->front;
    struct s_node *n = NULL;
    while (p!= NULL)
    {
        n = p;
        p = p->next;
        n = destroy_node(n);
    }
    free(s);
    s = NULL;
    return s;
}

