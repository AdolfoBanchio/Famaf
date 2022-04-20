#include <stdlib.h>
#include <stdio.h>

void absolute(int x, int y) {
    if (x>=0){
        y = x;
    }else{
        y=-x;
    }
}

int main(void) {
    // Completar aqui
    int a,res;
    res = 0;
    a = -98;
    absolute(a,res);
    printf("%d \n",res);
    return EXIT_SUCCESS;
}

