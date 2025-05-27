/*
Se desea modelar en Alloy la manipulacion de catalogos de musica

Los catalogos contienen canciones, interpretes y el listado de canciones.
*/

sig Interprete {}

sig Cancion {}

sig Catalogo {
	canciones: set Cancion,
	interpretes: set Interprete,
	interpretaciones: canciones -> interpretes
}{
	canciones = interpretaciones.interpretes
	interpretes = interpretaciones[canciones]
// o tambien puede expresarse como
// 	interpretaciones = canciones some -> some interpretes
}


/*
Predicado que dado un catalogo, una cancion y un interprete. Devuelva
un nuevo catalogo igua al primero pero con esa interpretacion agregada
*/
pred add_inter [c: Cancion, i: Interprete,c_in,c_out: Catalogo]{
	c_out = c_in and
	c_out.interpretaciones = c_in.interpretaciones + c->i
/*
Por como esta definido el catalogo, al agregar una nueva relaciones a la interpretaciones
agrega automaticamente los elementos a los conjuntos correspondientes
*/
}

/*
Dado un catalogo, una cacnion y un interprete.
Devuelve el mismo catalogo pero sin esa interpretacion
*/
pred del_inter [c: Cancion, i: Interprete,c_in,c_out: Catalogo]{
	c_out = c_in and
	c_out.interpretaciones = c_in.interpretaciones - c->i
}

/*
Una funcion que dado un catálogo, devuelva los pares
de interpretes que interpretan la misma cancion
*/
fun get_pairs (c: Catalogo) : set Interprete -> Interprete {
  {
    i1, i2: c.interpretes |
      i1 != i2 and some s: c.canciones |
        i1 in c.interpretaciones[s] and
        i2 in c.interpretaciones[s]
  }
}

