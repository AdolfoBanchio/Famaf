#include <stdlib.h>
#include "pair.h"
struct s_pair_t {
    int fst;
    int snd;
};

pair_t pair_new(int x, int y){
    pair_t newp=NULL;
    newp = malloc(sizeof(pair_t));
    newp->fst = x;
    newp->snd = y;
    return newp;
}

int pair_first(pair_t p){
    assert(p != NULL);
    return p->fst;;
}

int pair_second(pair_t p){
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
