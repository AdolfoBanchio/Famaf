#include <assert.h>
#include <stdlib.h>
#include "dict.h"
#include "key_value.h"

struct _node_t {
    dict_t left;
    dict_t right;
    key_t key;
    value_t value;
};
/*
static bool invrep(dict_t d) {
    return true;
}
*/
dict_t dict_empty(void) {
    dict_t dict = NULL;
    return dict;
}

dict_t dict_add(dict_t dict, key_t word, value_t def) {
    //assert(invrep(tree));
    if (dict == NULL)
    {
        dict_t newe;
        newe = malloc(sizeof(struct _node_t));
        newe->key = word;
        newe->value = def;
        newe->right = NULL;
        newe->left = NULL;
        dict = newe;
        return dict;
    }
    else if (key_eq(dict->key,word))
    {
        dict->value = def;
    }else if (key_less(dict->key,word))
    {
        dict->right = dict_add(dict->right,word,def);
    }else
    {
        dict->left = dict_add(dict->left,word,def);
    }

    //assert(invrep(tree));
    return dict;
}

value_t dict_search(dict_t dict, key_t word) {
    key_t def=NULL;
    if(dict_exists(dict,word))
    {
        if (key_eq(dict->key,word))
        {
            def = dict->value;
        }else if (key_less(dict->key,word))
        {
            def = dict_search(dict->right,word);
            //si la llave a busar es mayor que en la que estoy, voy a la derecha
        }else
        {
            def = dict_search(dict->left,word);
        }
    }
    return def;
}

bool dict_exists(dict_t dict, key_t word) {
    bool exists = false;
    if (dict != NULL) //si el diccionario no es vacio nos fijamos si esta
    {
        if (key_eq(dict->key,word))
        {
            exists = true;
        }else if (key_less(dict->key,word))
        {
            exists = dict_exists(dict->right,word);
        }else
        {
            exists = dict_exists(dict->left,word);
        }
    }
    return exists;
}

unsigned int dict_length(dict_t dict) {
    unsigned int length = 0u;
    if (dict != NULL)
    {
        length = 1 + dict_length(dict->left) + dict_length(dict->right);
    }
    return length;
}


static dict_t minValueNode(dict_t dict){
    dict_t current = dict ;
    while (current != NULL && current->left !=NULL)
    {
        current = current->left;
    }
    return current;
}

dict_t dict_remove(dict_t dict, key_t word) {
    if (dict_exists(dict,word) || dict != NULL)
    {
        if (key_eq(dict->key,word))
        {
            if (dict->left == NULL)
            {
                dict_t temp = dict;
                dict = dict->right;
                free(temp);
            }else if (dict->right == NULL)
            {
                dict_t temp = dict;
                dict = dict->left;
                temp->key = key_destroy(temp->key);
                temp->value = value_destroy(temp->value);
                free(temp);
            }else{
                dict_t temp = minValueNode(dict->right);
                dict->key = temp->key;
                dict->value = temp->value;
                dict->right = dict_remove(dict->right,temp->key);
            }
        }else
        {
            if (key_less(dict->key,word))
            {
                dict->right = dict_remove(dict->right,word);
            }else
            {
                dict->left = dict_remove(dict->left,word);
            } 
            
        }
    }
    return dict;
}

dict_t dict_remove_all(dict_t dict) {
    dict = dict_destroy(dict);
    dict = dict_empty();
    return dict;
}

void dict_dump(dict_t dict, FILE *file) {
    if(dict != NULL)
    {
        dict_dump(dict->left,file);
        key_dump(dict->key,file);
        fprintf(file," : ");
        value_dump(dict->value,file);
        fprintf(file,"\n");
        dict_dump(dict->right,file);
    }
}

dict_t dict_destroy(dict_t dict) {
    //assert(invrep(dict));
    if(dict != NULL)
    {
        dict->right = dict_destroy(dict->right);
        dict->left = dict_destroy(dict->left);
        dict->key = key_destroy(dict->key);
        dict->value = value_destroy(dict->value);
        free(dict);
        dict = NULL;
    }else
    {
        free(dict);
        dict = NULL;
    }
    return dict;
}

