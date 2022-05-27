#include <stdio.h>
#include <stdlib.h>
#include "strfuncs.h"

size_t string_length(const char *str){
    unsigned int i = 0u;
    if (str == NULL)
    {
        return 0;
    }
    while (str[i]!= '\0')
    {
        ++i;
    }
    return i;
}

char *string_filter(const char *str,char c){
    char *filtered;
    filtered = NULL;
    unsigned int c_count,len,j;
    size_t strlen = string_length(str);
    c_count = 0u;
    len = 0u;
    for(unsigned int i = 0u; i < strlen; i++)
    {
        if (str[i]== c)
        {
            ++c_count;
        }
    }
    /*
    calculo el largo que tendra str filtrada, 
    el largo real - cantidad de caracteres que voy a excluir
    */
    len = (strlen-j);
    filtered = malloc((len+1)*sizeof(char));
    j=0;
    for(unsigned int i = 0u; i < strlen; i++)
    {
        if (str[i]!= c)
        {
            filtered[j]=str[i];
            ++j;    
        }
    }
    filtered[len] = '\0';
    return filtered;
}
/*
chequear valgrind
conditional jump or move depends on unitialised values
*/