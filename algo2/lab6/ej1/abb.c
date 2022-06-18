#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include "abb.h"

struct _s_abb {
    abb_elem elem;
    struct _s_abb *left;
    struct _s_abb *right;
};

static bool elem_eq(abb_elem a, abb_elem b) {
    return a == b;
}

static bool elem_less(abb_elem a, abb_elem b) {
    return a < b;
}


static bool is_abb(abb tree){
    if(tree == NULL){
        return true;
    }else if(tree->right == NULL && tree->left==NULL)
    {
        return true;
    }else if (tree->right == NULL && tree->left!= NULL)
    {
        return is_abb(tree->left);
    }else if (tree->right != NULL && tree->left== NULL)
    {
        return is_abb(tree->right);
    }else
    {
        bool is_more = !elem_less(tree->right->elem,tree->elem);
        bool is_less = elem_less(tree->left->elem,tree->elem);
        bool der = is_abb(tree->right);
        bool izq = is_abb(tree->left);
        return(is_less && is_more && der && izq);
    }
}

static bool invrep(abb tree) {
    return is_abb(tree);
}

abb abb_empty(void) {
    abb tree;
    tree =NULL;
    assert(invrep(tree) && abb_is_empty(tree));
    return tree;
}

abb abb_add(abb tree, abb_elem e) {
    assert(invrep(tree));
    if (abb_exists(tree,e)){
        return tree;
    }
    if (tree == NULL){
        abb newe;
        newe = malloc(sizeof(struct _s_abb));
        newe->elem = e;
        newe->right = NULL;
        newe->left = NULL;
        tree = newe;
        return tree;
    }
    if (elem_less(tree->elem,e))
    {
        tree->right = abb_add(tree->right,e);
    }else{
        tree->left = abb_add(tree->left,e);
    }

    assert(invrep(tree));
    return tree;
}

bool abb_is_empty(abb tree) {
    bool is_empty=false;
    assert(invrep(tree));
    is_empty = tree == NULL;
    return is_empty;
}

bool abb_exists(abb tree, abb_elem e) {
    bool exists=false;
    assert(invrep(tree));
    if (abb_is_empty(tree))
    {
        exists = false;
    }
    else if (elem_eq(tree->elem,e))
    {
        exists = true;
    }
    else if (elem_less(tree->elem,e))
    {
        exists = abb_exists(tree->right,e);
    }else
    {
        exists = abb_exists(tree->left,e);
    }
    assert(invrep(tree));
    return exists;
}

unsigned int abb_length(abb tree) {
    unsigned int length=0;
    assert(invrep(tree));
    if(abb_is_empty(tree))
    {
        return length;
    }
    length = 1 + abb_length(tree->right) + abb_length(tree->left);
    assert(invrep(tree) && (abb_is_empty(tree) || length > 0));
    return length;
}

//devuelve el nodo con el valor minimo de un arbol binario
static abb minValueNode(abb tree){
    abb current = tree ;
    while (!abb_is_empty(current) && !abb_is_empty(current->left))
    {
        current = current->left;
    }
    return current;
}

abb abb_remove(abb tree, abb_elem e) {
    assert(invrep(tree));
    if (!abb_exists(tree,e) || abb_is_empty(tree)){
        return tree;
    }
    else if (elem_less(e,tree->elem))
    {
        tree->left = abb_remove(tree->left,e);       
    }else if (elem_less(tree->elem,e)){
        tree->right = abb_remove(tree->right,e);
    }else{
        if(abb_is_empty(tree->left)){
            abb temp = tree->right;
            free(tree);
            return temp;
        }else if(abb_is_empty(tree->right)){
            abb temp = tree->left;
            free(tree);
            return temp;
        }

        abb temp = minValueNode(tree->right);
        tree->elem=temp->elem;
        tree->right = abb_remove(tree->right,temp->elem);
    }
    assert(invrep(tree) && !abb_exists(tree, e));
    return tree;
}


abb_elem abb_root(abb tree) {
    abb_elem root;
    assert(invrep(tree) && !abb_is_empty(tree));
    root = tree->elem;
    assert(abb_exists(tree, root));
    return root;
}

abb_elem abb_max(abb tree) {
    abb_elem max_e;
    assert(invrep(tree) && !abb_is_empty(tree));
    if (abb_is_empty(tree->right))
    {
        max_e = abb_root(tree);
        return max_e;
    }
    max_e = abb_max(tree->right);
    assert(invrep(tree) && abb_exists(tree, max_e));
    return max_e;
}

abb_elem abb_min(abb tree) {
    abb_elem min_e;
    assert(invrep(tree) && !abb_is_empty(tree));
    if (abb_is_empty(tree->left))
    {
        min_e = abb_root(tree);
    }else{
        min_e = abb_min(tree->left);
    }
    assert(invrep(tree) && abb_exists(tree, min_e));
    return min_e;
}

void abb_dump(abb tree) {
    assert(invrep(tree));
    if (tree != NULL) {
        abb_dump(tree->left);
        printf("%d ", tree->elem);
        abb_dump(tree->right);
    }
}

abb abb_destroy(abb tree) {
    assert(invrep(tree));
    if (abb_is_empty(tree))
    {
        free(tree);
        tree = NULL;
        return tree;
    }
    tree->right = abb_destroy(tree->right);
    tree->left = abb_destroy(tree->left);
    free(tree);
    tree = NULL;
    assert(tree == NULL);
    return tree;
}
