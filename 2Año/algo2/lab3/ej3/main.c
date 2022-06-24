/*
  @file main.c
  @brief Main program function implementation
*/
#include <stdio.h>

/** @brief structure which represent a person */
typedef struct _person {
    int age;
    char name_initial;
} person_t;

/**
 * @brief Main program function
 *
 * @return EXIT_SUCCESS when programs executes correctly, EXIT_FAILURE otherwise
 */
int main(void) {

    int x = 1;
    person_t m = {90, 'M'};
    int a[] = {0, 1, 2, 3};
    /* resolucion usando dos punteros 
    int *puntero1 = NULL;
    person_t *puntero2 = NULL;
    puntero1 = &x;
    *puntero1 = 9;

    puntero2 = &m ;
    puntero2->age = 100;
    puntero2->name_initial = 'F';

    puntero1 = &a[1];
    *puntero1 = 42;

    esta implementacion funciona
    */


   /* resolucion usaando void pointers 

   void *ptr = NULL;
   ptr = &x ;
   *(int *)ptr = 9;
   ptr = &m.age;
   *(int *)ptr = 100 ;
   ptr = &m.name_initial; 
   *(char *)ptr = 'F';

   ptr = &a[1];
   *(int *)ptr = 42;
   
   esta implementacion tambien funciona

  
  void *ptr = NULL;
  ptr = &x ;
  *(int *)ptr = 9;
  ptr = &m ;
  person_t g = {100, 'F'};
  *(person_t *)ptr = g;

  ptr = &a[1];
   *(int *)ptr = 42;
  */
  void *ptr = NULL;
  ptr = &x ;
  *(int *)ptr = 9;
  ptr = &m ;
  ((person_t *)ptr)->age = 100;
  ((person_t *)ptr)->name_initial = 'F';
  ptr = &a;
  ((int *)ptr)[1] = 42;

    /* Completar aquí:
       Al finalizar la ejecución las variables deben tener los siguientes valores
       x = 9
       m = (100, F)
       a[1] = 42

       Las restricciones son:
       - No usar las variables 'x', 'm' y 'a' en la parte izquierda de alguna asignación.
       - Se pueden agregar líneas de código, pero no modificar las que ya existen.
       - Se pueden declarar hasta 2 punteros.
       AYUDA: podes usar GDB para consultares valores de variables y la dirección de memoria donde estan alojadas.
    */

    printf("x = %d\n", x);
    printf("m = (%d, %c)\n", m.age, m.name_initial);
    printf("a[1] = %d\n", a[1]);
}
