## Defecto y desperfecto
- **Desperfecto**: un desperfecto de software ocurre si el comportamiento de este es distinto del esperado/especificado.
- **Defecto:** es lo que genera el desperfecto. = bug.
	- Un desperfecto implica la presencia del defecto
	- la existencia del defecto no implica la ocurrencia del desperfecto. Pero igual el defecto tiene el potencial para causar el desperfecto
	- Lo que se considere un desperfecto depende del proyecto.
- La idea del testing es poder identificar los defectos del sw para garantizar calidad.
	- Durante el testing, el programa se lo ejecuta en un conjunto de casos de test. Buscando causar desperfectos para así detectar la presencia de defectos. Luego para identificar el defecto real, se debe debuggear.


## Oráculos de tests
Un oraculo es una entidad que conoce el resultado esperado de los casos de test. Su funcion es poder verificar la ocurrencia de un desperfecto en la ejecucion de un caso de test.
![[Pasted image 20231028125221.png|331]]

	El oraculo puede ser generado automaticamente a partir de la especificacion. (y en pocos casos es humano). Lo ideal es que sea algo generado automaticamente.


### Casos de test y criterios de seleccion
A la hora de realizar el testing, deseamos poder construir un conjunto de test tal que la ejecucion satisfactoria de todos ellos imploque la ausencia de defectos. Como testear es costoso, se busca que sea un conjunto reducido.

A la hora de elegirlos se usa algun **criterio de seleccion de tests**

	El criterio de seleccion especifica las condiciones que el conjunto de casos de test debe satisfacer con respecto al programa y/o a la especificacion.


## Testing de caja negra
Se basa en que el software a testear se trata como una **caja negra**:
- Donde la especificacion esta dada
- Para diseñar los casos de test, se utiliza el comportamiento esperad del sistema. Es decir, los casos de test se seleccionan sólo a partir de la especificación
- No se utiliza la estructura interna del código.

La **premisa** es que el comportamiento esperado está especificado. Luego solo se definen test para el comportamiento esperado especificado.
- En el testing de módulos: la especificación producida por en el diseño define el comportamiento esperado.
- Para el testing del sistema: la SRS define el comportamiento esperado

El testing **exhaustivo** es el mas minucioso. Ya que un sw esta diseñado para trabajar sobre un espacio de entrada -> Se testea el sw con todos los elementos del espacio de entrada. Esto es algo claramente muy costoso e inviable.

#### Clases de equivalencia
Se divide el espacio de entrada en clases de equivalencias
- De modo que si el software funciona para un caso de test en una clase, muy probablemente funcione de la misma manera para todos los elementos de la misma clase.
	- obtener un particionado ideal es imposible. Pero se aproxima identificando las clases para las cuales se especifican dsitintos comportamientos
- La especificacion requiere el mismo comportamiento en todos los elementos de una misma clase. Si falla para uno, falla para todos. 

Cada condicion especificada como entrada es una clase de equivalencia. Por ello para lograr robustez, se deben armar clases de equivalencias para entradas inválidas.
![[Clase 9-Testing-20231028132343498.webp|560]]

Ademas se deben considerar las clases de equivalencia de los datos de salida y generar los casos de test para estas clases eligiendo apropiadamente las entradas. Una vez elegidas las clases de equivalencia, se deben seleccionar los casos de test:
1) Seleccionar cada caso de test cubriendo tantas clases como sea posible
2) Dar un caso de tes que cubra a lo sumo una clase válida por cada entrada.
- Ademas de los casos de test separados por cada clase inválida.

##### Análisis de valores limites
Los programas generalmente fallan sobre valores especiales. Estos valores suelen estar en los limites de las clases de equivalencia. (también llamados casos extremos).

Un caso de test de valores límites es un conjunto de datos de entrada que se encuentra en el  borde de las clases de equivalencias de la entrada o la salida.  Los casos de test de valores limites tienen alto rendimiento.

- Primero se determinan los valores a utilizar para cada variable. Si la entrada tiene un rango definido hay 6 valores del limite (2 afura, 2 adentro, 2 del limite) mas el caso normal.
- Si tenemos multiples entradas hay dos alternativas
	1) ejecutar todas lass combinaciones posibles de las variables $7^n$ casos de test.
	2) Seleccionar los casos limites para una varaible y mantener las demas en casos normales. mas el caso de todo normal. $6n +1$ casos de test.
![[Clase 9-Testing-20231028133744934.webp]]

#### Grafo causa efecto
Los analisis de clase de equivalencia y valores limites consideran cada entrada separadamente. Para manipular las entradas, distintas combinaciones de las clases de equivalencia deben ser ejecutadas. Si hay n condiciones en la entrada que puden ser validas o invalidas hay $2^n$ clases de eq.

El grafo causa-efecto ayuda a seleccionar las combinaciones como condiciones de entrada
- **Causa**: distintas condiciones en la entrada que pueden ser V o F
- **Efecto**: distintas condiciones de salidas (V o F)
Se busca identificar cuales causas pueden producir que efectos; las causas se pueden combinar.

Las causas y efectos son nodos en el grafo, y las aristas determinan dependancia (positivas o negativas) tambien hay nodos and y or para combinar causalidad. 

El grafo sirve para poder crear **tabla de decision**. Que esta se usa para armar distintos casos de test.

#### Testing de a pares
El comportamiento del sistema suele estar determinado por muchos parametros. Estos puden ser entradas o seteos y toman distintos valores o rango de valores. 

- Tipos de defectos
	- De modo simple: involucran solo una condicion. Los defectos de modo simple pueden detectarse verifiando distintos valores de los distintos parametros. Si hay n parametros con m tipos de valores c/u. Podemos testear cada valor distinto en cada test por cada parametro. **m** casos de test en total
	- Los defectos de modo multiple se revelan con casos de test que contemplen las combinaciones apropiadas. Para esto surge el test de a pares
Hacer test combinatorio (osea testear cada combinacion posible de parametros) no es factible ya que demora mucho tiempo. Y como la mayoria de defectos se revelan con interaccion de apares. Se testea en cada par posible.

Todos los pares de valores deben ser ejercitados. Si tenemos n parametros  con m valores. Para cada par de parametros tenemos m * m pares. Luego el total de test que habra por hacer sera  $m^2 *n *(n-1)/2$. Y en el mejor caso un test cubre $n*(n-1)/2$ pares. Luego en el mejor caso total, tendremos $m^2$ casos de test distintos que proveen cobertura completa.



