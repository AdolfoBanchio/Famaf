#include <stdlib.h>
#include <stdio.h>

void absolute(int x, int *y) {
    // Completar aqui
    if (x<0){
        *y = -x;
    }
}

int main(void) {
    int a,*res;
    a=-98;
    res = &a;
    absolute(a,res);
    printf("%d \n",*res);
    return EXIT_SUCCESS;
}

