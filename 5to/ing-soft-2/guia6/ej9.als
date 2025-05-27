/*
Problema de cruzar el puente.

4 personas deben cruzar un puente colgante.
En el puente solo puede haber dos personas
Siempre se debe cruzar con una linterna
Hay una unica linterna.
El tiempo que demoran dos personas en cruzar el puente es igual al de la mas lenta

Cada aventurero sera identificado por la velocidad en la que puede cruzar el puente
Ya que para este caso son todas diferentes
5,10,20,25
*/
open util/ordering[Referee]

sig Adventurer {
	speed: Int,
}
// Como especifico que solo son 4 aventureros y que tienen unas velocidades especificas

sig Light {
	owner: one Adventurer,
}

/*
Esta signatura sera la que lleve el estado de todo el problema
indicando donde esta cada aventurero y la linterna.
Como tambien sumando el tiempo transcurrido en el cruce del puente
*/
sig  Referee {
	adventurers: set Adventurer,
	atStart: set adventurers,
	atEnd: set adventurers,
	light: Light,
	time: Int
}{
	// el dueño siempre esta en algun aventurero del problema
	light.owner in adventurers
	// Todos los aventureros del problema estan de algun lado del puente
	no (atStart & atEnd) and adventurers = atStart + atEnd
}

fact initialState {
	let s0 = first[] | no s0.atEnd and s0.time = 0 and some s0.atStart
}

//define el cruce para dos aventureros
pred cross_bridge_1 [r_in, r_out: Referee] {
	some disj a1,a2: r_in.atStart | {
		// linterna la tiene alguno de los dos
		r_in.light.owner in (a1 + a2)

		// en el sig estado, estan del lado del frente
		r_out.atEnd = r_in.atEnd + a1 + a2
		r_out.atStart = r_in.atStart - a1 - a2

		// actualizo el tiempo que llevan
		r_out.time = r_in.time + max[a1.speed + a2.speed]
	}
}

// defino el cruce de vuelta de un aventurero
pred cross_bridge_2  [r_in, r_out: Referee] {
	some a1: r_in.atEnd | {
		r_in.light.owner in a1

		r_out.atEnd = r_in.atEnd - a1
		r_out.atStart = r_in.atStart + a1
		
		r_out.time = r_in.time + a1.speed 
	}
}

fact state_transition {
	all r1: Referee, r2: next[r1] |
		// si la linterna esta en el inicio hago cross bridge 1
		(r1.light.owner in r1.atStart implies cross_bridge_1[r1,r2]) 
		&&
		// si la linterna esta en el final hago cross bridge 2
		(r1.light.owner in r1.atEnd implies cross_bridge_2[r1,r2])
}


pred solve_puzzle[] {
	last[].time < 61
}
 //Como lo verifico?

run solve_puzzle for 11 Referee, exactly 4 Adventurer, exactly 1 Light
