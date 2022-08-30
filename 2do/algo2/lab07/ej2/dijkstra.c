#include <assert.h>
#include <stdlib.h>
#include "cost.h"
#include "graph.h"
#include "mini_set.h"
static unsigned int minimum(set vertexs,cost_t *distances,unsigned int max_vertexs){
    cost_t min;
    unsigned int ret;
    min = __INT_MAX__;
    for (unsigned int i = 0; i < max_vertexs; i++)
    {
        if (distances[i]<=min && set_member(i,vertexs))
        {
            min = distances[i];
            ret = i;
        }
    }
    return ret;
}
cost_t *dijkstra(graph_t graph, vertex_t init) {
    unsigned int c;
    set vertexs = set_empty();
    cost_t *distances = calloc(graph_max_vertexs(graph),sizeof(cost_t));
    cost_t suma;
    for (unsigned int i = 0; i < graph_max_vertexs(graph); i++)
    {
        vertexs = set_add(vertexs,i);
    }
    vertexs = set_elim(vertexs,init);
    for (unsigned int i = 0; i < graph_max_vertexs(graph); i++)
    {
        distances[i] = graph_get_cost(graph,init,i);
    }
    while (!set_is_empty(vertexs))
    {
        c = minimum(vertexs,distances,graph_max_vertexs(graph));
        vertexs = set_elim(vertexs,c);
        for (unsigned int j = 0; j < graph_max_vertexs(graph); j++)
        {
            if (set_member(j,vertexs))
            {
                suma = cost_sum(distances[c],graph_get_cost(graph,c,j));
                if (cost_le(suma,distances[j]))
                {
                    distances[j] = suma;
                }
            }
        }
    }
    return distances;
}