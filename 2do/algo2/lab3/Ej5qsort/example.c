#include <stdio.h>
#include <stdlib.h>

static const unsigned int length = 5u;
int a[5] = {7,4,3,2,8};


int goes_before(const void * x, const void* y)
{
    int x1 = *(int*)x;
    int x2 = *(int*)y;
    return x1 - x2;
}


int main (void)
{
    qsort(a, length, sizeof(int), goes_before);
    for(unsigned int i = 0u; i<length; ++i)
    {
        printf("Array[%u]=%d\n", i, a[i]);
    }
    return 0;
}