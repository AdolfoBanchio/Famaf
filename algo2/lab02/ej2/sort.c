#include <assert.h>
#include <stdbool.h>
#include <stdio.h>

#include "array_helpers.h"
#include "sort_helpers.h"
#include "sort.h"


static void quick_sort_rec(int a[], unsigned int izq, unsigned int der){
    unsigned int ppiv;
    if (der > izq){
      ppiv = partition(a,izq,der);
      quick_sort_rec(a,izq,(ppiv == 0u) ? 0u : ppiv-1);
      quick_sort_rec(a,(ppiv==der) ? der : ppiv+1u,der);
    }
}

void quick_sort(int a[], unsigned int length) {
    quick_sort_rec(a,0,(length == 0u) ? 0u : length - 1u);
}
