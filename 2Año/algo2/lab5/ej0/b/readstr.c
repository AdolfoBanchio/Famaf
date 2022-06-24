#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LENGTH 20

int main(void) {
    char user_input[MAX_LENGTH];

    printf("Ingrese su nombre y apellido: ");
    /*scanf("%s", user_input);
    no logra guardar la segunda palabra, el apellido*/
    fgets(user_input,MAX_LENGTH,stdin);

    //strncpy(user_input,aux,strlen(aux)-1);
    user_input[strcspn(user_input,"\n")] = '\0';
    printf("Te damos la bienvenida %s a este maravilloso programa!\n", user_input);

    return EXIT_SUCCESS;
}

/*
conditional jump or move depends on unitialised values
*/