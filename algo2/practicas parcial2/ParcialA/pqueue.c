#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>
#include "pqueue.h"

struct s_pqueue {
    struct s_node* front;
    unsigned int size;
};

struct s_node {
    pqueue_elem elem;
    unsigned int priority;
    struct s_node * next;
};

static struct s_node * create_node(pqueue_elem e, unsigned int priority) {
    struct s_node *new_node = NULL;
    new_node = malloc(sizeof(struct s_node));
    assert(new_node!=NULL);
    new_node->elem = e;
    new_node->priority = priority;
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


static bool invrep(pqueue q) {
    bool inv = false;
    if (q->front == NULL && q->size == 0)
    {
        inv = true;
    }else{
        struct s_node * p = q->front;
        if (q->size == 1)
        {
            inv = true;
        }
        else{    
            while (p->next != NULL)
            {
                inv = p->priority <= p->next->priority;
                p = p->next;
            }
        }
    }
    return inv;
}

pqueue pqueue_empty(void) {
    pqueue q=NULL;
    q = malloc(sizeof(struct s_pqueue));
    q->front = NULL;
    q->size = 0u;
    return q;
}

pqueue pqueue_enqueue(pqueue q, pqueue_elem e, unsigned int priority) {
    assert(invrep(q));
    struct s_node *new_node = create_node(e, priority);
    if (pqueue_is_empty(q))
    {
        q->front = new_node;
    }else
    {
        struct s_node*p,*n;
        p = q->front;
        n = NULL;
        if (q->front->priority > priority)
        {
            n = q->front;
            q->front = new_node;
            new_node->next = n;
        }else{
            while (p->next != NULL && p->next->priority<= priority)
            {
                p = p->next;
            }
            n = p->next;
            p->next = new_node;
            new_node->next = n;
        }
    }
    q->size = q->size +1;
    return q;
}

bool pqueue_is_empty(pqueue q) {
    return (q->size == 0 && q->front == NULL);
}

pqueue_elem pqueue_peek(pqueue q) {
    return q->front->elem;
}

unsigned int pqueue_peek_priority(pqueue q){
    return q->front->priority;
}
unsigned int pqueue_size(pqueue q) {
    //assert(invrep(q));
    return q->size;
}

pqueue pqueue_dequeue(pqueue q) {
    struct s_node*p = NULL;
    p = q->front;
    q->front = q->front->next;
    p->next = NULL;
    p = destroy_node(p);
    q->size = q->size -1;
    return q;
}

pqueue pqueue_destroy(pqueue q) {
    //assert(invrep(q));
    struct s_node *p,*r;
    p = q->front;
    r = p;
    while (p!= NULL)
    {
        r = p;
        p = p->next;
        r = destroy_node(r);
    }
    free(q);
    q = NULL;
    assert(q == NULL);
    return q;
}
