#include <pwd.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

#include "prompt.h"


void show_prompt(void) {
    char host[WORD_MAX];
    struct passwd* pass;
    pass = getpwuid(getuid());

    printf(USER_COLOR);
    printf("%s", pass->pw_name);
    printf(CLOSE_COLOR);
    printf("@");
    printf(HOST_COLOR);
    gethostname(host, WORD_MAX);
    printf("%s", host);
    printf(CLOSE_COLOR);
    printf("> ");

    fflush(stdout);
}