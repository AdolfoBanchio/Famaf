#include <stdio.h>
#include <assert.h>
#include <stdlib.h>

#ifndef N
#define N (1<<16)
#endif

struct node {
	int data;
	struct node *next;
};

void simple_list_insert(struct node ** const plist, const int data) {
	assert(plist);

	struct node *newnode = calloc(1, sizeof(struct node));
	assert(newnode);
	newnode->data = data;
	newnode->next = NULL;

	struct node *list = *plist;
	while (list && list->next) {
		list = list->next;
	}

	if (NULL==list) {
		*plist = newnode;
	} else {
		list->next = newnode;
	}
}

int main(void)
{
	struct node *list = NULL;
	for(size_t i=0; i<N; ++i) {
		simple_list_insert(&list, (int)i);
	}

	//getchar();
	return 0;
}
