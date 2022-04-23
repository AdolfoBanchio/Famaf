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
/*
bool array_is_sorted(player_t atp[], unsigned int length) {
    unsigned int i = 1u;
    while (i < length && goes_before_ptrs(atp[i - 1u], atp[i])) {
        i++;
    }
    return (i == length);
}
**/
int goes_before_ptrs(const void *x,const void *y){
    player_t i = *(player_t *)x;
    player_t j = *((player_t *)y);
    /*
    if(i->rank < j->rank){
        return -1;
    }else{
        return 1;
    }
    */
   return(i->rank - j->rank);
}