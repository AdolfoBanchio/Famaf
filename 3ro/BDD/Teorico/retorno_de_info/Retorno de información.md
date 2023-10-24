El **Retorno de informacion** es el proceso de retornar documentos a partir de una coleccion de documentos en respuesta a una consulta. 
- Los documentos suelen estar en lenguaje natural no estructurado 
	- No tiene un modelo formal bien definido
	- Se basa en la comprension del lenguaje natural
	- Se almacena en una variedad amplia de formatos estandares.

Los sistemas de retorno de informacion **SRI** permiten *expresiones de consulta* formadas usando palabras clave y conectivos proposicionales.
* Algunos lenguajes de consulta pueden ser:
	* Consultas usando frases: una frase es secuencia de palabras
	* Consultas de palabras clave: se escribe texto de palabras clave y se asume and entre esas palabras
	* Consultas booleanas: las expresiones involucran terminos y conectivos booleanos
	* Consultas basadas en regex: busqueda basada en patrones
	* Consultas de proximidad: se expresa que tan cerca deben estar ciertos terminos entre si. 
	* Consulta lenguaje natural: requiere entender la estructura y su significado, puede ser pregunta o narrativa.

Los **resultados de una busqueda** pueden ser una lista de identificadores de documentes y tambien algunas piezas de texto. Ademas los doc se ordenan segun algun puntaje de relevancia. 
- Esta se mide en factores como
	- Frecuencia de términos de una consulta en un doc
	- Frecuencia inversa de documentos, si ocurre en menos documentos se le da mas importancia a la palabra
	- Enlaces de documentos, si hay mas enlaces a un doc, entonces es mas importante
	- Las palabras que ocurren en el título, lista de autores, títulos se les da más importancia.
	- Las palabras cuya primera ocurrencia es tarde en el documento se les da poca importancia.
	- Proximidad: si las palabras de una consulta aparecen cerca entre sí en el documento, el documento tiene más importancia que si las palabras ocurren bien lejos unas de otra.

No es eficiente acceder a todo un doc, por lo que para cada uno se construye una estructura que resume su contenido. En un **enfoque estadístico** los doc son analizados y descompuestos en piezas (palabras,frases,n-gramas). Luego dada una consulta se comparan sus términos con las piezas del doc para determinar la correspondencia y relevancia. Existen diferentes modelos estadísticos para establecer los resultados.





### Modelo Booleano
- Los documentos se representan como un conj de términos
- Se usan consultas booleanas
- El retorno es una correspondencia exacta (sirve o no sirve)
- No existe relevancia

### Modelo de espacio vectorial

^9b60cd

- Cada documento se representa con un vector de valores de dimension n. Dondecada termino es una dimension. 
- En cada dimension hay un numero que puede representar 
	- valor booleano representando presencia en el doc
	- frecuencia del termino en el doc
	- peso (usando TF-IDF)
- Una consulta se representa como un vector de terminos, luego el vector de una consulta es comparado(funcion de similitud) con los vectores de los documentos para establecer una medida de relevancia (similitud/relevancia)
	- Los terminos tienen peso en los vectores. Este puede ser la frecuencia de cada termino en el doc/consulta o usando **TF-IDF**.
- Las respuestas se ordenan por relevancia

##### TF-IDF (frecuencia de termino-frecuencia inversa de doc)
Un termino que captura la esencia de un documento aparece frecuentemente. Pero para poder discriminar documentos a partir de un termino, debe ocurrir en pocos docs de la colección. 
![[Pasted image 20231023213341.png|649]]
![[Pasted image 20231023213445.png|654]]
![[Pasted image 20231023213505.png|646]]


___


### Como crear la representación de un doc?
Es necesario procesarlo para encontrar sus terminos relevantes. Pero no todos son relevantes.
- **stop word** : palabras que se espera que ocurran en el 80% o mas del doc
	- ej: el,la,lo,de, un, etc.
	- No contribuyen a la relevancia -> se ignoran (en la representacion de doc y en consultas)
- Para un termino que aparece de multiples formas (un verbo y sus conjugaciones) existe el **algoritmo de Martin Porter** para utilizar una sola forma del termino en la representacion
	- P.ej: usar ‘comput’ para computer, computing, computable, and computation.
- Para los **sinonimos de un termino** , se puede utilizar un termino por concepto. 
	- No es tan simple pues una palabra puede significar diferentes cosas segun su contexto.
			![[Pasted image 20231023214444.png]]

Cuando tenemos una coleccion de documentos, queremos poder buscar las ocurrencias de un termino en cada documento. La solucion mas "sencilla" es por cada documento tener un listado de los terminos que contiene (cada uno con alguna propiedad como su frecuencia,peso, etc.) 

 Documento | terminos
	-- | --
	identificador | lista de terminos 

Esto resulta en que un termino puede aparecer multiples veces en la tabla, ya que puede estar contenido en n documentos.

#### ==Indice invertido==
En un indice invertido almacena para **cada termnio** los identificadores de los documentos donde aparece el termino y alguna informacion adicional (posicion donde aparece para relevancia basada en proximidad, frecuencia, peso, etc.)

Termino | apariciones
-- | -- 
nombre | [(idDoc, info extra)]

La lista de un termino puede requerir varios bloques de disco. Para la eficiencia de acceso, se puede tener esa lista en un conjunto consecutivo de bloques. E incluso tener un arbol B+ de indice para mapear cada termino a su lista invertida asociada. 
	![[Pasted image 20231023220347.png|489]]
	![[Pasted image 20231023220629.png|639]]

___

#### Busqueda de doc a partir de una consulta
1) Busqueda de vocabulario: cada termino de la consulta se busca en el vocabulario, los terminos se pueden ordenar lexicograficamente
2) Retorno de la informacion de documentos: se retorna la info del doc para cada termino
3) Manipulacion/tratamiento de la informacion retornada: la informacion de cada doc es procesada para incorporar las distintas formas de logica de consulta.
![[Pasted image 20231023221815.png]]

___
#### Medición de la eficacia (relevancia) de los resultados
![[Pasted image 20231023222031.png|639]]
Existen métricas relevantes para medir el desempeño
- Precision: proporcion de los documentos relevantes retornados en el total de documentos retornados por la consulta. 
- Cobertura: proporcion de los documentos relevantes retornados en el total de documentos relevantes en la BD (retornados y no retornados)
	+cobertura -> -precision
	Poder definir que documentos son realmente relevantes implica comprender el lenguaje natural y comprender el proposito de una consulta. Se termina creando consultas y etiquetando manualmente documentos como relevantes e irrelevantes.
![[Pasted image 20231023222855.png]]

   ___
   
### Lucene
Es una maquina de busqueda e indexado popular en la industria y academia
- Los documentos no estructurados pasan por un proceso de indexado previo a estar disponibles para consultas.
- Un documento de Lucene se forma de **campos** que tienen un **tipo** (binario,numerico,texto)
	- texto puede ser no tokenizado o un stream de simbolos
- Posee una **API de consultas** 
	- Las consultas retornan una lista ordenada de docs por rango, usando variante de [[#TF-IDF (frecuencia de termino-frecuencia inversa de doc)| TF-IDF]] para dar valor a los docs.
	- La API de consultas es configurable, se puede crear consultas por expr booleanas, regex o proximidad.
- Usa [[Retorno de información#^9b60cd |modelo de espacio vectorial]]

