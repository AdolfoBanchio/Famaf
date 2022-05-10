/*
@file array_helpers.c
@brief Array Helpers method implementation
*/
#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "array_helpers.h"

/**
* @brief returns true when reach last entry in flight table
* @return True when is the last entre of the flight table, False otherwise
*/
static bool is_last_line(unsigned int hour, unsigned int type) {
  return  hour == HOURS - 1u && type == TYPE - 1u;
}

void array_dump(DeliveryTable a) {
  for (unsigned int type = 0u; type < TYPE; ++type) {
    for (unsigned int hour = 0u; hour < HOURS; ++hour) {
      Flight f = a[type][hour];
      fprintf(stdout, "%c: flight with %u %s arrived at %u:00", f.code, f.items_amount, f.type == 0 ? "boxes" : "letters", f.hour - 1);
      if (!is_last_line(hour, type))
      {
        fprintf(stdout, "\n");
      }
    }
  }
}

unsigned int extra_space_fee_cost (DeliveryTable a, unsigned int h) {
  unsigned int savedbox,savedletters,boxfee,letterfee;
  savedbox = 0;
  savedletters = 0;
  boxfee = 0;
  letterfee = 0 ;
    for (unsigned int j = 0; j < h; j++)
    {
      savedbox = savedbox + a[0][j].items_amount;
      savedletters = savedletters + a[1][j].items_amount;
    }
    //calculo la cantidad de cartas y cajas que hubo hasta las 20 hs
    if(savedbox > MAX_ALLOWED_BOXES){
      boxfee = (savedbox-MAX_ALLOWED_BOXES) * BOX_PENALTY ;
    }
    if (savedletters > MAX_ALLOWED_LETTERS)
    {
      letterfee = (savedletters-MAX_ALLOWED_LETTERS) * LETTER_PENALTY;
    }
    //calculo el impuesto por cada caja y carta extra que se almaceno y lo sumo
  return (boxfee+letterfee);
}


void array_from_file(DeliveryTable array, const char *filepath) {
  FILE *file = NULL;

  file = fopen(filepath, "r");
  if (file == NULL) {
    fprintf(stderr, "File does not exist.\n");
    exit(EXIT_FAILURE);
  }

  char code;
  unsigned int arrival_hour;
  int i = 0;
  while (!feof(file) && i<HOURS){ //chequeo que no trate de pasarse de lugares del arreglo
    int res = fscanf(file,"\n_%c_ ",&code);
    if (res != 1) {
      fprintf(stderr, "Invalid file.\n");
      exit(EXIT_FAILURE);
    }
    int readed = fscanf(file," %u ",&arrival_hour);
    if (readed != 1) {
      fprintf(stderr, "Invalid file.\n");
      exit(EXIT_FAILURE);
    }
    if (arrival_hour > 24) //chequeo que el formato de hora este bien en el archivo
    {
      fprintf(stderr,"invalid file");
      exit(EXIT_FAILURE);
    }
    
    /* COMPLETAR: Generar y guardar ambos Flight en el array multidimensional */
    Flight flight_boxes = flight_from_file(file,code,arrival_hour);
    Flight flight_letters = flight_from_file(file,code,arrival_hour);
    array[flight_boxes.type][flight_boxes.hour -1 ]=flight_boxes;
    array[flight_letters.type][flight_letters.hour -1]=flight_letters;
  }
}
