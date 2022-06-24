#include <stdbool.h>
#include <stdio.h>
#ifndef ARRAY_HELPERS
#define ARRAY_HELPERS

unsigned int array_from_file(int a[], unsigned int max_size,const char *filepath);
void array_dump(int a[], unsigned int length);
bool array_is_sorted(int a[], unsigned int length);

//#include "array_helpers.c"
#endif
