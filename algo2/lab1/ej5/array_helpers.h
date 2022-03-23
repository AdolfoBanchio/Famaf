#include "mybool.h"
#include <stdio.h>
#ifndef ARRAY_HELPERS
#define ARRAY_HELPERS
  unsigned int array_from_file(int a[], unsigned int max_size,const char *filepath);
  void array_dump(int a[], unsigned int length);
  mybool array_is_sorted(int a[], unsigned int length);
#endif
