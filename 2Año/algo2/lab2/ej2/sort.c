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
      //quick_sort_rec(a,izq,ppiv);
      //quick_sort_rec(a,ppiv+1,der); no funciona para arreglos de mas de 100
      
      /*quick_sort_rec(a,izq,ppiv);
      quick_sort_rec(a,(ppiv==der) ? der : ppiv+1u,der);
      tampoco funcionan para mas de 1000 elementos*/
      quick_sort_rec(a,izq,(ppiv==0u) ? 0u : ppiv-1u);
      quick_sort_rec(a,(ppiv==der) ? der : ppiv+1u,der);
      //funciona para mas de 1000
    }
}

void quick_sort(int a[], unsigned int length) {
    quick_sort_rec(a,0,(length == 0u) ? 0u : length - 1u);
}
