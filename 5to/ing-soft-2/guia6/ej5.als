/*
Ejercicio 5. Modele relaciones binarias en Alloy. Utilizando predicados, especifique que una relaci´on
es:
(a) un preorden,
(b) un orden parcial,
(c) un orden total,
(d) un orden estricto,
(e) que tiene primer elemento,
(f) que tiene ´ultimo elemento.
Escriba aserciones para las siguientes propiedades:
todo orden parcial es total;
todo orden parcial tiene primer elemento;
todo orden total con primer elemento x y ultimo elemento y satisface x != y;
la union de ordenes estrictos es un orden estricto;
la composicion de ordenes estrictos es un orden estricto.
*/

sig Elems {}

sig BinRel {
	R: Elems -> Elems
}

// Propiedades
pred is_reflex[r: BinRel]{
	all e: Elems |
	e->e in r.R 
}

pred is_transitive[r: BinRel]{
	all a,b,c: Elems |
	a->b in r.R and b->c in r.R implies a->c in r.R
}

pred is_antisimetric[r: BinRel]{
	all a,b: Elems |
	a->b in r.R and b->a in r.R implies a = b
}

pred is_total[r: BinRel]{
	all a,b: Elems |
	(a->b in r.R) or (b->a in r.R)
}

pred has_first_elem[r: BinRel, m: Elems]{
	one a: Elems | a->Elems in ^(r.R) 
	some a: Elems | a->Elems in ^(r.R) and a = m
}

pred has_last_elem[r: BinRel, M: Elems]{
	one a: Elems | Elems->a in ^(r.R) 
	some a: Elems | Elems->a in ^(r.R) and a = M
}

// Tipos de orden
pred is_preOrder[r: BinRel]{
	 is_transitive[r] and is_reflex[r]
}

pred is_partialOrder[r: BinRel]{
	 is_preOrder[r] and is_antisimetric[r]
}

pred is_totalOrder[r: BinRel]{
	is_partialOrder[r] and is_total[r]
}

/*
Orden estricto
	no reflexivo
	transitivo
	asimetrico
*/
pred is_strictOrder[r: BinRel]{
	is_transitive[r] and 
	all a,b: Elems | a->b in r.R implies b->a not in r.R
}

// Encontrar ejemplos de cada orden
run is_preOrder for 3 but 1 BinRel

run is_partialOrder for 3 but 1 BinRel

run is_totalOrder for 3 but 1 BinRel

run is_strictOrder for 4 but 1 BinRel

run has_first_elem for 4 but 1 BinRel

run has_last_elem for 4 but 1 BinRel

// Aserciones
assert partial_is_total{
	// Falso
	all r: BinRel | is_partialOrder[r] implies is_totalOrder[r]
}

check partial_is_total for 4

assert partial_has_first{
	// false
	all r: BinRel | some c: Elems | is_partialOrder[r] implies has_first_elem[r, c]
}

check partial_has_first for 4

//todo orden total con primer elemento x y ultimo elemento y satisface x != y;
assert total_diff_min_max{
	all r:BinRel | some m,M: Elems | 
	(is_totalOrder[r] and has_first_elem[r,m] and has_last_elem[r,M]) implies m != M
	
}

check total_diff_min_max for 4

/*
la union de ordenes estrictos es un orden estricto;
*/

assert union_strict_is_strict {
	all r,g: BinRel | (is_strictOrder[r] and is_strictOrder[g]) implies is_strictOrder[r + g ]
}

check union_strict_is_strict 

//la composicion de ordenes estrictos es un orden estricto.

assert comp_strict_is_strict {
	all r,g: BinRel | (is_strictOrder[r] and is_strictOrder[g]) 
	implies (some c: BinRel | c.R = (r.R).(g.R) and is_strictOrder[c])
}

check comp_strict_is_strict
