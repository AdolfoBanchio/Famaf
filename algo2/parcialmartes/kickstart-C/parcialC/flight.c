/*
  @file layover.c
  @brief Implements flight structure and methods
*/
#include <stdlib.h>
#include "flight.h"

static const int AMOUNT_OF_FLIGHT_VARS = 2;

Flight flight_from_file(FILE* file, char code, unsigned int arrival_hour)
{
    Flight flight;
    int readed ;
    flight.code = code;
    flight.hour = arrival_hour;
    readed = fscanf(file," %u %u \n",&flight.type,&flight.items_amount); 
    //leo y guardo los datos de el tipo de entrega y la cantidad de items
    if (readed != AMOUNT_OF_FLIGHT_VARS)
    {
      printf("Invalid file");
      exit(EXIT_FAILURE);
    }
    /* chequeo si recibi la cantidad de datos correcta (tipo y cantidad)*/
    
    return flight;
}
