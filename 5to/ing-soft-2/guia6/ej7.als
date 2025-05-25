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
}
