#include "string.h"
#include <stdio.h>
int main(){
    string str1 = string_create("uno");
    string str2 = string_create("dos");

    bool menor, igual;
    menor = string_less(str1,str2);
    igual = string_eq(str1,str2);

    if(menor){
        printf("str1 es menor que str2\n");
    }else{
        printf("str2 es mayor que str1\n");
    }

    if (igual)
    {
        printf("str1 es igual a str2\n");
    }else{
        printf("las strings son diferentes\n");
    }

    str1 = string_destroy(str1);
    str2 = string_destroy(str2);
    return 0;
}