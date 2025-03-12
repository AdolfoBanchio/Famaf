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

struct linked_list {
	struct node *head;
	struct node *tail;
};


void linked_list_insert(struct linked_list * const pll, const int data) {
	assert(pll);

	struct node *newnode = calloc(1, sizeof(struct node));
	assert(newnode);
	newnode->data = data;
	newnode->next = NULL;

	int nn = (NULL==pll->head) + (NULL==pll->tail);
	assert(2==nn || 0==nn);

	if (NULL==pll->head)
		pll->head = newnode;
	if (NULL!=pll->tail)
		pll->tail->next = newnode;
	pll->tail = newnode;
}

int main(void)
{
	struct linked_list ll = {NULL, NULL};

	for(size_t i=0; i<N; ++i) {
		linked_list_insert(&ll, (int)i);
	}

	return 0;
}
