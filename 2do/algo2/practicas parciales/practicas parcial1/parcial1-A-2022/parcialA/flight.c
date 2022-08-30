/*
  @file layover.c
  @brief Implements flight structure and methods
*/
#include <stdlib.h>
#include "flight.h"

static const int AMOUNT_OF_FLIGHT_VARS = 3 ;

Flight flight_from_file(FILE* file, char code)
{
    Flight flight;
    flight.code = code;
    int read = fscanf(file," %u %u %u ",&flight.type,&flight.hour,&flight.passengers_amount);
    if(read != AMOUNT_OF_FLIGHT_VARS){
      printf("invalid file");
      exit(EXIT_FAILURE);
    }

    return flight;
}
