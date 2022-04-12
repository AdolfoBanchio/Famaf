#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#define MAX_SIZE 1000

char *parse_filepath(int argc, char *argv[]) {
    /* Parse the filepath given by command line argument. */
    char *result = NULL;
    // Program takes exactly two arguments
    // (the program's name itself and the input-filepath)
    bool valid_args_count = (argc == 2);

    if (!valid_args_count) {
        exit(EXIT_FAILURE);
    }

    result = argv[1];

    return result;
}
unsigned int data_from_file(const char *path,unsigned int indexes[],
char letters[],unsigned int max_size){
    FILE *fp;
    unsigned int i;
    i = 0u;
    fp = fopen(path,"r");
    while (!feof(fp) && i<max_size){
        fscanf(fp,"%u '%c'\n",&indexes[i],&letters[i]);
        i++;
    };
    return i;
}

static void dump(char a[], unsigned int length) {
    printf("\"");
    for (unsigned int j=0u; j < length; j++) {
        printf("%c", a[j]);
    }
    printf("\"");
    printf("\n\n");
}

static merge_word (char sorted[],char letters[],unsigned int indexes[], unsigned int length){
    for (unsigned int i = 0; i < length; i++){
        sorted[indexes[i]] = letters[i];
    }
}

int main(int argc, char *argv[]) {
    char *file = NULL;
    file = parse_filepath(argc,argv);
    unsigned int indexes[MAX_SIZE];
    char letters[MAX_SIZE];
    char sorted[MAX_SIZE];
    unsigned int length=0; 
    length = data_from_file(file,indexes,letters,MAX_SIZE);
    merge_word(sorted,letters,indexes,length);
    dump(sorted, length);

    return EXIT_SUCCESS;
}

