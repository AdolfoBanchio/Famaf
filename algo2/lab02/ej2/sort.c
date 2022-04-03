#include <assert.h>
#include <stdbool.h>
#include <stdio.h>

#include "array_helpers.h"
#include "sort_helpers.h"
#include "sort.h"


/*static*/ void quick_sort_rec(int a[], unsigned int izq, unsigned int der){
 /* needs implementation */
    unsigned int ppiv;
    //ppiv = 0;
    if (der > izq){
      ppiv = partition(a,izq,der);
      //printf("%u\n",ppiv );
      quick_sort_rec(a,izq,ppiv);
      quick_sort_rec(a,ppiv+1,der);
    }
}

void quick_sort(int a[], unsigned int length) {
    quick_sort_rec(a,0,length-1);
}
