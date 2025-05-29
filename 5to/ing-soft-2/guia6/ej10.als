/*
Modelar el problema de las torres de hanoi

Tendre una signatura que represente el disco.
cada disco tiene un indice de la pila en donde esta
y un tamaño
*/

open util/ordering[Towers]

abstract sig Tower{}

one sig T1,T2,T3 extends Tower {}

sig Disk {
	ix: Int,
	size: Int,
	tower: one Tower
}

sig Towers {
	disks: set Disk,
}{
	// Todos los discos tienen tamaños distintos
	all d1: disks | all d2: disks - d1 | d1.size != d2.size

	// Si un disco esta debajo de otro, entonces tiene mayor tamaño
	// Para cada torre
	all d1: disks | all d2: disks - d1 |
	d1.tower = d2.tower implies (
							d1.ix != d2.ix 
							and 
							(d1.ix < d2.ix implies d1.size > d2.size))
}

// Todos los discos comienzan en la primera torre
fact initial_tower {
	
	let t0 = first[] | all d: t0.disks | d.tower = T1
}

