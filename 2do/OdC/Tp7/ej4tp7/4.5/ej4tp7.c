#include <stdio.h>
int main(){
    long acc = 0;
    long N;
    unsigned int counter = 0;
    scanf("%ld",&N);
    for (long i = N; 0<=i; i--)
    {
        printf("%ld\n",i);
        acc += 2;
        ++counter;
    }
    printf("acc %ld counter %u",acc,counter);
    return 0;
}