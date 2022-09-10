#include <assert.h>    /* assert()...                        */
#include <stdlib.h>    /* calloc()...                        */
#include <string.h>    /* strlen(), strncat, strcopy()...    */
#include "strextra.h"  /* Interfaz                           */

char * strmerge(char *s1, char *s2) {
    assert(s1 != NULL && s2 != NULL);
    char *merge=NULL;
    size_t len_s1 = strlen(s1);
    size_t len_s2 = strlen(s2);
    assert(s1 != NULL && s2 != NULL);
    merge = calloc(len_s1 + len_s2 + 1, sizeof(char));
    strncpy(merge, s1, len_s1);
    merge = strncat(merge, s2, len_s2);
    assert(merge != NULL && strlen(merge) == strlen(s1) + strlen(s2));
    return merge;
}
char * merge_with_free(char * s1, char * s2){
    char * new = strmerge(s1,s2);
    free(s1);
    return new;
}
