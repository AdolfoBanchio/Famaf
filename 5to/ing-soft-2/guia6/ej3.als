-- Dominio del problema

sig Addr, Data {}

-- Definicion de memoria

sig Memory {
	addrs: set Addr,
	map: addrs -> one Data
}

-- Para representar el sistema de memoria debo tener:
-- Memoria principal 
-- Cache

sig MainMemory extends Memory {}

sig Cache extends Memory {
	dirty: set addrs
}

-- defino el sistema completo

sig System {
	cache: Cache,
	main: MainMemory
}

/*
Defino lectura y escritura para las memorias
*/
pred Write [S_i,S_o: System, d: Data, a: Addr] {
	S_o.main.map = S_i.main.map ++ (a -> d)
}

pred Read [S_i: System, d_o:Data, a:Addr] {
	let d = S_i.main.map[a] | some d implies d = d_o
}

/*
operacion flushing
paso todo lo dirty a la memoria

el operador izq<:der, devuelve la relacion de la derecha
restringida al dominio de la izquierda. 
*/
pred Flushing [S_i, S_o: System] {
	S_o.main.map = S_i.main.map ++ (S_i.cache.dirty <: S_i.cache.map) 
	no S_o.cache.dirty
	S_o.cache.map = S_i.cache.map
}

/*
Operacion loading
Cargo un dato de memoria en la cache
*/
pred Loading [S_i, S_o: System, a: Addr] {
	S_o.cache.map = S_i.cache.map ++ (a -> S_i.main.map[a])
	S_o.cache.dirty = S_i.cache.dirty - a
}

/*
Chequeo consistencia de las operaciones
*/
pred Consistent [s:System] {
	s.cache.map - (s.cache.dirty -> Data) in s.main.map
}

assert CheckFlushConsistency {
	all s_1,s_2: System |
		Consistent [s_1] and Flushing[s_1,s_2] implies Consistent[s_2]
}
 
check CheckFlushConsistency for 5 
