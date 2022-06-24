#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

#include "truco.h"

struct _s_truco_card {
        unsigned int rango;
        unsigned int num;
        char palo;
};

#define ESPADA "ESPADA"
#define BASTO  "BASTO"
#define ORO    "ORO"
#define COPA   "COPA"

static const char *suit_str(char p) {
    const char *str;
    if (p == 'e') {
        str = ESPADA;
    } else if (p=='b') {
        str = BASTO;
    } else if (p=='o') {
        str = ORO;
    } else if (p=='c') {
        str = COPA;
    }
    return str;
}

static void dump(int num, char suit) {
    printf(" ----------------\n"
           " : %2d           :\n"
           " :              :\n"
           " :              :\n"
           " :    ""%-7s""   :\n"
           " :              :\n"
           " :              :\n"
           " :              :\n"
           " :           %2d :\n"
           " ----------------\n",
           num, suit_str(suit), num);
}

static int card_rank(int num, char suit) {
    int rank=0;
    if (num==1 && suit == 'e') {  
        rank = 15;    // Ancho de espadas
    } else if (num==1 && suit=='b') {
        rank = 14; // Ancho de bastos
    } else if (num==7 && suit=='e') {
        rank = 13; // Siete de espadas
    } else if (num==7 && suit=='o') { 
        rank = 12;// Siete de oro
    }//si llegue aca significa que no es de los rangos mas importantes 
    else if (4 <= num && num <= 12) { 
        int count = 0;
        bool stop = true;
        while (count < 9 && stop)
        {
            if(num == count+4)
            {
                rank = count;
                stop = false;
            }
        } 
    } else { 
        rank = num + 8; //solo llega aca si es un ancho falso 2 o 3, y sus rangos son
                        // 9(1+8),10(2+8),11(3+8)
    }
    return rank;
}
static bool valid_num(int num){
    return (1<= num && num <= 12 && num != 8 && num != 9);
}
static bool valid_suit(char p){
    return(p=='e' || p=='o' || p=='c' || p=='b');
}
/*
static bool invrep(truco_card c) {
    bool valid_card=false;
    return valid_card;
}
*/
truco_card truco_card_new(int num, char p) {
    truco_card card;
    assert(valid_num(num) && valid_suit(p));
    card = malloc(sizeof(struct _s_truco_card));
    card->num = num;
    card->palo = p;
    card->rango = card_rank(num,p);
    return card;
}

bool truco_card_win(truco_card a, truco_card b) {
    return a->rango > b->rango;
}

bool truco_card_tie(truco_card a, truco_card b) {
    return a->rango == b->rango;
}

void truco_card_dump(truco_card c) {
    dump(c->num,c->palo);
}

truco_card truco_card_destroy(truco_card c) {
    free(c);
    return c;
}
