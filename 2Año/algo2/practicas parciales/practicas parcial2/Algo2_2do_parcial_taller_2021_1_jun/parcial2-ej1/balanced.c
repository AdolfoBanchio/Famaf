#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>

#include "stack.h"

static bool is_left_delimiter(char c) {
    return (c == '(' || c == '[' || c == '{' || c == '<');
}

static bool is_right_delimiter(char c) {
    return (c == ')' || c == ']' || c == '}' || c == '>');
}

static char match(char c) {
    char m;
    if (c == '(') {
        m = ')';
    } else if (c == '[') {
        m = ']';
    } else if (c == '{') {
        m = '}';
    } else if (c == '<') {
        m = '>';
    }
    return (m);
}

static size_t count_delimeters(char *expression) {
    size_t count=0, i=0;
    assert(expression!=NULL);
    while (expression[i] != '\0') {
        count += is_left_delimiter(expression[i]) || is_right_delimiter(expression[i]);
        i++;
    }
    return count;
}


static char *take_delimeters(char *expression, size_t *count) {
    assert(count!=NULL && expression != NULL);
    size_t i=0,n_count = 0;
    size_t n_delimeters=0;
    char *only_delimeters=NULL;
    n_delimeters = count_delimeters(expression);
    char aux;
    only_delimeters = calloc(n_delimeters +1,sizeof(char));
    while (expression[i] != '\0') {
        if (is_left_delimiter(expression[i]) || is_right_delimiter(expression[i]))
        {
            aux = expression[i];
            only_delimeters= strncat(only_delimeters,&aux,1);
            n_count ++; 
        }
        i++;
    }
    *count = strlen(only_delimeters);
    return only_delimeters;
}

static void print_help(char *program_name) {
    /* Print the usage help of this program. */
    printf("Usage: %s <expression-to-check>\n\n"
           "Check if the expression has balanced delimeters (parenthesis, brackets, braces and <>).\n",
           program_name);
}

static char* parse_expression(int argc, char *argv[]) {
    /* Parse the expression given by command line argument. */
    char *result=NULL;
    /* Program takes exactly one argument */
    if (argc != 2) {
        print_help(argv[0]);
        exit(EXIT_FAILURE);
    }
    /* Use the first argument ass the expression */
    result = argv[1];
    /* return expression */
    return result;
}

int main(int argc, char *argv[]) {
    stack s;
    bool balanced = true;
    char *expression=NULL, *delimeters=NULL;
    size_t delim_count,i=0;

    // Parse arguments and get the expression to be analysed
    expression=parse_expression(argc, argv);

    s = stack_empty();
    delimeters = take_delimeters(expression, &delim_count);
    i=0;
    while (i < delim_count && balanced) {
        char delim;
        delim = delimeters[i];
        if (is_left_delimiter(delim)) {
            s = stack_push(s, match(delim));
        } else {
            assert(is_right_delimiter(delim));
            if (!stack_is_empty(s) && delim == stack_top(s)) {
                s = stack_pop(s);
            } else {
                balanced = false;
            }
        }
        i++;
    }
    balanced = balanced && stack_is_empty(s);
    printf(balanced ? "la expresión está balanceada\n":"la expresión NO está balanceada\n");
    s = stack_destroy(s);
    free(delimeters);

    return 0;
}

