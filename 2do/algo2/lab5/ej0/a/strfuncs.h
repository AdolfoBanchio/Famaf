
#ifndef _STRFUNCs_H
#define _STRFUNCs_H
#include <stdio.h>
/**
* @brief calcula la longitud de la cadena apuntada por STR 
* @param[in] str - palabrita
*/
size_t string_length(const char *str);

/**
* @brief Devuelve unanueva cadena en moemoria dinamica que se obtiene
tomando los caracteres de STR que son distintos de 'c'
*/
char *string_filter(const char *str,char c);

#endif