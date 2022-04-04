#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#include "array_helpers.h"
#include "sort_helpers.h"
#include "sort.h"

/* Permutes elements of a[izq..der] and returns pivot such that:
 - izq <= pivot <= der
 - elements in a[izq,pivot) all 'go_before' (according to function goes_before) a[pivot]
 - a[pivot] 'goes_before' all the elements in a(pivot,der]
*/
static unsigned int partition(int a[], unsigned int izq, unsigned int der) {
    unsigned int ppiv,i,j;
    ppiv = izq;
    i = izq+1;
    j = der;
    while (i<=j){
      if(goes_before(a[i],a[ppiv])){
        i=i+1;
      }else if(goes_before(a[ppiv],a[j])){
        j=j-1;
      }else if(goes_before(a[j],a[ppiv])){
        swap(a,i,j);
        i=i+1;
        j=j-1;
      }
    }
    swap(a,j,ppiv);
    ppiv = j;
    return ppiv ;
}

static void quick_sort_rec(int a[], unsigned int izq, unsigned int der) {
    /* copiá acá la implementación que hiciste en el ejercicio 3 */
    unsigned int ppiv;
    if (der > izq){
      ppiv = partition(a,izq,der);
      quick_sort_rec(a,izq,(ppiv == 0u) ? 0u : ppiv-1);
      quick_sort_rec(a,(ppiv==der) ? der : ppiv+1u,der);
    }
}

void quick_sort(int a[], unsigned int length) {
    quick_sort_rec(a,0,(length == 0u) ? 0u : length-1u);
}
