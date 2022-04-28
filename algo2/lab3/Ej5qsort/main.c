/*
  @file main.c
  @brief Main program function implementation
*/
/* First, the standard lib includes, alphabetically ordered */
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>


/* Then, this project's includes, alphabetically ordered */
#include "helpers.h"
#include "sort.h"
#include "player.h"

#define MAX_PLAYERS 5000

/**
 * @brief print usage help
 * @param[in] program_name Executable name
 */
void print_help(char *program_name) {
    /* Print the usage help of this program. */
    printf("Usage: %s <input file path>\n\n"
           "Sort an array given in a file in disk.\n"
           "\n"
           "The input file must have the following format:\n"
           " * Each line must contain the name of a player"
           " without spaces followed by a three-letter country"
           " code, the rank of the player, his age, his atp points"
           " and the number of tournaments played during the year.\n"
           " * Values must be separated by one or more spaces.\n"
           " * Numeric values must be natural numbers.\n\n",
           program_name);
}

/**
 * @brief reads file path from command line
 *
 * @param[in] argc amount of command line arguments
 * @param[in] argv command line arguments
 *
 * @return An string containing read filepath
 */
char *parse_filepath(int argc, char *argv[]) {
    /* Parse the filepath given by command line argument. */
    char *result = NULL;

    if (argc < 2) {
        print_help(argv[0]);
        exit(EXIT_FAILURE);
    }

    result = argv[1];

    return (result);
}

/**
 * @brief Main program function
 *
 * @param[in] argc amount of command line arguments
 * @param[in] argv command line arguments
 *
 * @return EXIT_SUCCESS when programs executes correctly, EXIT_FAILURE otherwise
 */


 
int main(int argc, char *argv[]) {
    char *filepath = NULL;
    player_t atp[MAX_PLAYERS];

    /* parse the filepath given in command line arguments */
    filepath = parse_filepath(argc, argv);

    /* parse the file to load de players */
    unsigned int length = process_file(filepath, atp);

    /* create a copy of the array, to do some checks later */
    player_t copy[MAX_PLAYERS];
    array_copy(copy, atp, length);
    size_t nelems = length;
    /*calculo el tamaño del arreglo segun el tamaño de sus elementos y el tamaño del tipo de elementos
    esto sirve para poder calcular el tamaño de un arreglo de manera generica sin necesidad de saber 
    que cosas tiene adentro*/
    /* enable statistics for cpu utilization */
    {
        clock_t start, end;

        start = clock();

        /* do the actual sorting */
        //quick_sort(atp, length); en vez de ordenar usando el algoritmo que cree, 
        //ordeno usando void pointers con la funcion quicksort nativa de C, y creo mi 
        //funcion de comparacion goes_before_ptr paraa pasar como parametro

        qsort((void *)atp,nelems,sizeof(player_t),goes_before_ptrs);
        
         /*me di cuenta que si en el 3er argumento (tamaño de los elementos que contiene el arreglo) 
        paasaba como argumento sizeof(struct _players_t) el programa daba segmentation fault, 
        en cambio pasando sizeof(player_t como argumento no sucede
        
        lo que me hace pensar, porque cuando calculo la cantidad de elementos del arreglo (nelems)
        si uso el tamaño de struct _players_t para dividir y funciona, y si lo cambio por
        size of player_t (sin cambiar el 3er argumento de qsort) tambien se rompe el programa
        
        la pregunta es 
        poorque para calcular el tamaño del arreglo uso el tamaño de la estructura como si el arreglo tuviera 		
        adentro elementos de esa estructura, cuando en realidad tiene punteros. y porque en qsort debo pasar el 		
        temaño del puntero en vez de la estructura completa*/
        end = clock();

        /* cpu_time used to sort the array */
        double used_cpu_time = ((double) (end - start)) / CLOCKS_PER_SEC;

        /* show the ordered array in the screen */
        atp_dump(atp, length);

        /* show the cpu time in seconds used to sort the array */
        printf("\ncpu time used to sort the array: %f seconds.\n", used_cpu_time);
    }

    /* check if it is sorted */
    //assert(array_is_sorted(atp, length));

    /* check if it is a permutation of original */
    assert(array_is_permutation_of(copy, atp, length));
    destroy(atp, length);
    return (EXIT_SUCCESS);
}


/*
el tiempo que demora en ordenar un arreglo formado por punteros a 
estructuras _player_t es significativamente menor(no se porque)

se llama a destroy antes del luego de ordenar todo para eliminar todos
los lugares de memoria dinamica que se usaron  ya que el fin del programa era
dejar en un archivo todos los jugadores ordenados (¿?)
*/