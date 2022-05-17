#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LENGTH 20

int main(void) {
    char user_input[MAX_LENGTH];
    char aux[MAX_LENGTH];

    printf("Ingrese su nombre y apellido: ");
    /*scanf("%s", user_input);
    no logra guardar la segunda palabra, el apellido*/
    fgets(aux,MAX_LENGTH,stdin);
    strncpy(user_input,aux,strlen(aux)-1);
    printf("Te damos la bienvenida %s a este maravilloso programa!\n", user_input);

    return EXIT_SUCCESS;
}

/*
conditional jump or move depends on unitialised values
*/