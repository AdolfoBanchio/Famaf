#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include "array_helpers.h"

unsigned int array_from_file(int a[], unsigned int max_size,const char *filepath){
    FILE *fp;
    unsigned int i,valor;
    valor = 2;
    i = 0;

    fp = fopen(filepath,"r");

  //busco el primer entero en el archivo y lo guardo en valor
    fscanf (fp,"%ud\n",&valor);

  //se que los eneteros restantes son los elementos asi que busco y guardo uno por uno
    for(i=0;i<valor && i<max_size;i++){
    fscanf(fp,"%d",&a[i]);
  };
  return valor;
}

void array_dump(int a[], unsigned int length){
    printf("[");
    unsigned int i=0;
    for(i=0;i<length;i++){
        printf("%d ",a[i]);
    };
    printf("]\n");
}
