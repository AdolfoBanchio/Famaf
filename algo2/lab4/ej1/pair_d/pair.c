#include <stdlib.h>
#include "pair.h"
struct s_pair_t {
    elem fst;
    elem snd;
};

pair_t pair_new(elem x, elem y){
    pair_t newp=NULL;
    newp = malloc(sizeof(pair_t));
    newp->fst = x;
    newp->snd = y;
    return newp;
}

elem pair_first(pair_t p){
    assert(p != NULL);
    return p->fst;
}

elem pair_second(pair_t p){
    assert(p != NULL);
    return p->snd;
}
pair_t pair_swapped(pair_t p){
    assert(p != NULL);
    pair_t q=NULL;
    q = malloc(sizeof(pair_t));
    q->fst = p->snd;
    q->snd = p->fst;
    return q;
}

pair_t pair_destroy(pair_t p){
    free(p);
    return p;
}
