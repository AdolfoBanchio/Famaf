/*
	Modelar grafo dirigido
*/
sig Node {}

sig Graph {
	nodes: set Node,
	edges: nodes -> nodes
}
/*
represento las aristas como una relacion binaria entre nodos
si (n0,n1) in edges, entonces existe una arista dirigida de n0 a n1
*/

/*
Dar u predicado que especifique cada una de las siguientes propiedades
*/

/*
(a) El grafo es aciclico
clausura transitiva estricta ^ 
*/
pred no_cycles [g: Graph]{
	no ^(g.edges) & iden
}

/*
(b) El grafo es no dirigido
*/
pred undirected [g: Graph]{
	g.edges = ~(g.edges)
}

/*
(c) el grafo es fuertemente conexo,
Para todo nodo A,B. 
Existe camino de A a B y B a A
*/
pred strong_conected [g: Graph]{
	all n1, n2: g.nodes |
	n1 in *(g.edges)[n1] and n2 in *(g.edges)[n1]
}

/*
(d) el grafo es conexo
Para todo nodo A,B
existe algun camino entre A y B
*/
pred conected [g: Graph]{
	all n1, n2: g.nodes |
	n2 in ^(g.edges + ~(g.edges))[n1]
}

/*
(e) el grafo contiene una componente fuertemente conexa,
*/
pred has_SCC [g: Graph] {
	some s: set g.nodes |
	all n1,n2: s |
	n1 in *(g.edges)[n1] and n2 in *(g.edges)[n1]
}

/*
(f) el grafo contiene una componente conexa
*/
pred has_CC [g: Graph] {
	some s: set g.nodes |
	all n1,n2: s |
	n2 in *(g.edges + ~(g.edges))[n1]
}

run no_cycles for 4 but 1 Graph

run undirected for 4 but 1 Graph

run strong_conected for 4 but 1 Graph

run conected for 4 but 1 Graph

run has_SCC for 3 but 1 Graph

run has_CC for 3 but 1 Graph
