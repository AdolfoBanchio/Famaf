##### Ejercicio 5
![[Pasted image 20231024233102.png|693]]
x0 = i , x1 = j, Para las primeras iteraciones el salto en 0x14 NO se tomara cada 3 saltos. Es decir se toma 3 veces luego no se toma. Y el salto en 0x20 se tomara siempre excepto en la iteracion 100

###### a) 
Iteracion | valor | condicion | GR(4 bits shift) | PC(4 bits) | Resultado | PHT(predictor)
:--: | :--: |:--: |:--: |:--: |:--: | :--:
1(j) | 1 | j<3 | 0000 | 0100 | Taken | 00 (miss)
2(j) | 2 | j<3 | 0001 | 0100 | Taken | 00 (miss)
3(j) | 3 | j<3 | 0011 | 0100 | Not Taken | 00 (hit)
1(i) | 0 | i<100 | 0110 | 0000 | Taken | 00 (miss)
4(j) | 1 | j<3 | 1101 | 0100 | Taken | 00 (miss)
6(j) | 2 | j<3 | 1011 | 0100 | Taken | 00 (miss)
7(j) | 3 | j<3 | 0111 | 0100 | Not Taken | 00 (hit)
2(i) | 1 | i<100 | 1110 | 0000 | Taken | 00 (miss)
8(j) | 1 | j<3 | 1101 | 0100 | Taken | 01 (miss)
9(j) | 2 | j<3 | 1011 | 0100 | Taken | 01 (miss)
10(j) | 3 | j<3 | 0111 | 0100 | Not Taken | 00 (hit)
3(i) | 2 | i<100 | 1110 | 0000 | Taken | 01 (miss)
11(j) | 1 | j<3 | 1101 | 0100 | Taken | 10 (hit)
12(j) | 2 | j<3 | 1011 | 0100 | Taken | 10 (hit)
13(j) | 3 | j<3 | 0111 | 0100 | Not Taken | 00 (hit)
4(i) | 3 | i<100 | 1110 | 0000 | Taken | 10 (hit)
___ | ___ |___ |___ |___ |___ | ___ 
14(j) | 1 | j<3 | 1101 | 0100 | Taken | 11 (hit)
15(j) | 2 | j<3 | 1011 | 0100 | Taken | 11 (hit)
16(j) | 3 | j<3 | 0111 | 0100 | Not Taken | 00 (hit)
5(i) | 3 | i<100 | 1110 | 0000 | Taken | 11 (hit)

###### b) 
Para el predictor de 2 bits. Por cada 4 bits de PC guardo un predictor de 2 bits.

PC | Predictor
:-- : | :--:



##### Ejercicio 6
![[Practico 6-20231025003957996.webp|722]]

	prediccion local: se puede predecir utilizando ejecuciones y resultados anteriores del mismo salto
	prediccion global: se puede predecir utilizando ejecuciones y resultados anteriores de otros saltos en el programa
###### a)
Como el valor guardado en `val` sera un numero aleatorio, el resultado de los saltos previos de B1,B2 y B3 no nos sera util ya que no existira relacion entre dichos valores -> no pueden ser predichos localmentre (usando resultados previos del mismo salto).

Sin embargo el salto B1 si es un salto local ya que se beneficia de ejecuciones anteriores de ese salto. 

b) Si, la condicion para que B4 se tome, esta relacionada con las condiciones de B3 o B2, ya que un numero es divisible por 6 si lo es por 2 y 3. 
Luego si B2 y B3 son Taken B4 tambien lo sera. 

