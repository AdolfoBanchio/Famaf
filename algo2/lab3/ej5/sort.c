/*
  @file sort.c
  @brief sort functions implementation
*/

#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include "helpers.h"
#include "sort.h"
#include "player.h"

bool goes_before(player_t x, player_t y){
    if(x->rank > y->rank){
        return false;
    }else{
        return true;
    }
    
}

void player_swap (player_t a[], unsigned int i, unsigned int j){
    player_t aux;
    aux = a[i];
    a[i] = a[j];
    a[j] = aux;
}
bool array_is_sorted(player_t atp[], unsigned int length) {
    unsigned int i = 1u;
    while (i < length && goes_before(atp[i - 1u], atp[i])) {
        i++;
    }
    return (i == length);
}
unsigned int partition(player_t a[], unsigned int izq, unsigned int der) {
    unsigned int ppiv,i,j;
    ppiv = izq;
    i = izq+1;
    j = der;
    while (i<=j){
      if(goes_before(a[i],a[ppiv])){
        i=i+1;
      }else if(goes_before(a[ppiv],a[j])){
        j=j-1;
      }else if(goes_before(a[ppiv],a[i]) && goes_before(a[j],a[ppiv])){
        player_swap(a,i,j);
      }
    }
    player_swap(a,j,ppiv);
    ppiv = j;
    return ppiv ;
}

void quick_sort_rec(player_t a[], unsigned int izq, unsigned int der) {
    /* copiá acá la implementación que hiciste en el ejercicio 3 */
    unsigned int ppiv;
    if (der > izq){
      ppiv = partition(a,izq,der);
      quick_sort_rec(a,izq,(ppiv == 0u) ? 0u : ppiv-1);
      quick_sort_rec(a,(ppiv==der) ? der : ppiv+1u,der);
    }
}

void quick_sort(player_t a[], unsigned int length) {
    quick_sort_rec(a,0,(length == 0u) ? 0u : length-1u);
}