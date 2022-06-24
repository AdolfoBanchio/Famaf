#include <stdlib.h>
#include "truco.h"
#include <stdio.h>

int main(){
    truco_card a = truco_card_new(3,'o');
    truco_card b = truco_card_new(3,'e');
    truco_card c = truco_card_new(1,'o');
    truco_card d = truco_card_new(7,'o');
    truco_card_dump(a);
    bool ab = truco_card_tie(a,b);
    bool cd = truco_card_win(d,c);
    printf("a igual a b? = %d \n",ab);
    printf("c gana a d? = %d \n",cd);
    a = truco_card_destroy(a);
    b = truco_card_destroy(b);
    c = truco_card_destroy(c);
    d = truco_card_destroy(d);
    return 0;
}