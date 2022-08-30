#include <stdio.h>
#include <stdlib.h>

#include "data.h"

void print_data(data_t d) {
    printf("NOMBRE: %s\n"
           "EDAD  : %d años\n"
           "ALTURA: %d cm\n\n",
           d.name, d.age, d.height);
}

void set_name(name_t new_name, data_t *d) {
    /* COMPLETAR */
    for (size_t i = 0; i < NAME_SIZE; i++)
    {
        d->name[i] = new_name[i];
    }
    
}

int main(void) {

    data_t messi = {"Leo Messi",  34, 169};
    print_data(messi);
    data_t *d = NULL;
    d = &messi;
    name_t messi_full_name = "Lionel Messi";
    set_name(messi_full_name,d);
    print_data(messi);
        
    return EXIT_SUCCESS;
}

