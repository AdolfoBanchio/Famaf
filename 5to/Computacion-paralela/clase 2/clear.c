// COaD5, Fig. 2.30

#include <omp.h> // omp_get_wtime()
#include <string.h> // memset()
#include <stdio.h> // printf()

#define SIZE (1<<28) // 2**28
int a[SIZE]; // 1 GiB de memoria

void
clear1(int array[], int size)
{
	int i;
	for (i = 0; i < size; i += 1)
		array[i] = 0;
}

void
clear2(int *array, int size)
{
	int *p;
	for (p = &array[0]; p < &array[size]; p = p + 1)
		*p = 0;
}

void
clear3(int *array, int size)
{
	memset(array, '\0', size*sizeof(array[0]));
}

void
main(void)
{
	double t = omp_get_wtime();
	clear1(a, SIZE);
	printf("clear1: %lf\n", (omp_get_wtime()-t));
	t = omp_get_wtime();
	clear2(a, SIZE);
	printf("clear2: %lf\n", (omp_get_wtime()-t));
	t = omp_get_wtime();
	clear3(a, SIZE);
	printf("clear3: %lf\n", (omp_get_wtime()-t));
}
