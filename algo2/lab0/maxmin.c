#include <stdio.h>

typedef struct{
int max_value;
int min_value;
unsigned int max_position;
unsigned int min_position;
}max_min_result;

max_min_result compute_max_min(int array[], unsigned int length){
int i,auxmin,auxmax,auxposmin,auxposmax;
int largo = length ;
max_min_result resultado;
    auxmin = array[0];
    auxmax = array[0];
for ( i = 0; i < largo; i++){
    if (array[i]<auxmin){
        auxmin = array[i];
        auxposmin = i ;
    };
    if (array[i]>auxmax){
        auxmax = array[i];
        auxposmax = i ;
    };
    resultado.max_value = auxmax;
    resultado.min_value = auxmin ;
    resultado.max_position = auxposmax;
    resultado.min_position = auxposmin ;
};
    return(resultado);
}

int main (void){
    int tamano;
    max_min_result result ;
    printf("ingresa el tamaño del arreglo\n");
    scanf("%d",&tamano);
    int arreglo[tamano],i=0;
    while (i< tamano){
        printf("ingresa el elemento %d del arreglo:\n",i);
        scanf("%d",&arreglo[i]);
        i= i+1;
    }
    result = compute_max_min(arreglo,tamano);
    printf("%d\n", result.max_value);
    printf("%d\n", result.min_value);
    printf("%u\n", result.max_position);
    printf("%u\n", result.min_position);
    return(0);
    //es un comentario de prueba 
}
