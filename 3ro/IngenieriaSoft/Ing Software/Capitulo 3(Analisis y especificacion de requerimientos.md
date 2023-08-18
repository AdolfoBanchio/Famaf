
### Analisis y especificacion de requerimientos

(SRS software requirements analysis and specification)

An SRS establishes the basis for agreement between the client and the supplier on what the software product will do.

La idea es poder hacer un analisis del problema y hacer una especificacion de los requerimientos para solucionar el problema en cuestion. 

Proceso de SRS

- ********Identificar y especificar******** los requisitos involucra interaccion
- No puede ser automatizado

La SRS establece las bases para el acuerdo entre el cliente/usuario y quien suministrará el software

- Hay 3 partes involucradas:
    - necesidades del cliente
    - consideraciones del usuario

Ambos debe comunicarse al desarrollador. Al existir una brecha comunicacional entre las partes, la SRS es el medio para reconciliar las diferencias y especificar las necesidades del cliente/usuario de manera que todos entiendan.

Requerimientos (IEEE):

- Una condicion o capacidad necesaria de un usario para solucionar un problema o alcanzar los objetivos
- Una condicion o capacidad necesaria que debe poseer o cumplir un sistema.

poder discernir los requerimientos de un sistemas no es fácil ya que habría que poder visualizar el sistema futuro es difícil, las capacidades del sistema futuro no están claras y los requerimientos cambian con el tiempo. 

Es necesario realizar apropiadamente el análisis y especificación de los requerimientos. Es decir en una SRS solo se escribe el ******que****** no el como. 

### **¿Porque es necesaria una SRS?**

**************Ayuda************** al usuario a comprender las necesidades, ya que no siempre saben lo que quieren o necesitan, es por eso que se debe analizar y comprender el potencial. 

El proceso de requerimientos ayuda a aclarar las necesidades. 

La SRS provee una referencia para la ********************validación******************** del producto final. Es decir una vez que el sistema esta hecho, para corroborar que esta “bien” hecho, debe cumplir todo lo que la SRS indica. 

Una SRS con ********************calidad******************** es esencial para un software de ****************calidad****************

- Una SRS con errores trasladara esos errores al software.
- satisfacer objetivos de calidad, se debe comenzar con una SRS de calidad.

El costo de solucionar un error aumenta a medida en que cambiamos de fase. 

![Untitled](Capitulo%203(Analisis%20y%20especificacion%20de%20requerimie%2031e7b7a1b1564c2f92feb5f6d3e5d481/Untitled.png)

### Proceso de requerimientos

Es una secuencia de pasos que se necesita realizar para convertir las necesidades del usuario en la SRS. 

El proceso tiene que recolectar las necesidades y los requerimientos y especificarlos claramente.

Las actividades basicas:

1) Analisis del problema o requerimientos

2) Especificacion de los requerimientos

3) Validacion

El proceso no es lineal, es iterativo y en paralelo. Existe una superposicion entre las fases: algunas partes pueden estar siendo especificadas mientras otras estan en analisis.  

La especificacion misma puede ayudar al analisis. La validacion puede encontrar errores que traen mas analisis y especificacion. 

![Untitled](Capitulo%203(Analisis%20y%20especificacion%20de%20requerimientos/Untitled%201.png)

El analisis se enfoca en la compresion del sistema deseado y sus requerimientos. 

La estrategia basica para hacer el analisis y encontrar los requerimientos es **Dividir y conquistar,** es decir descomponemos el problema en pequeñas partes; comprendemos cada una de estas partes y las relaciones entre ellas. 

Durante todo este proceso se genera una gran cantidad de informacion, que hay que saber analizarla y organizarla, usando diagramas de flujo de datos, objetos, etc. 

Una vez logrado el analisis, hay que pasar a la especificacion. 

•La especificación se enfoca en el comportamiento externo.
• Objetivo del análisis: comprender la estructura del problema y su
dominio (componentes, entrada, salida).
• Se recolecta más información (o distinta) de la necesaria para la
especificación.
El uso del análisis y las estructuras que se construyen puede ser
indirecto, ayudando a comprender en lugar de asistir a la especificación.
- Los métodos de análisis son similares a los de diseño, pero con
objetivos y alcances distintos.
- El análisis trata con el dominio del problema mientras que el diseño
trata con el dominio de la solución.

### Análisis del problema

Objetivo: lograr una buena compresión de las necesidades, requerimientos, y restricciones del software.

El análisis incluye:
• entrevistas con el cliente y usuarios,
• lectura de manuales,
• estudio del sistema actual,
• ayudar al cliente/usuario a comprender nuevas posibilidades.

El analista debe comprender el funcionamiento de la organizacion, cliente y los usuarios. 

Principio básico: particionar el problema.
Luego comprender cada subproblema y la relación entre ellos,
pero... ¿con respecto a qué?
• Funciones (análisis estructural)
• Objetos (análisis OO)
• Eventos del sistema (particionado de eventos)
Proyección: obtener distintas vistas (desde distintos puntos de
vistas).

**************************************Modelado de flujo de datos**************************************

- Se enfoca en las funciones realizadas en el sistema
- ve al sistema como una red de trnasformadores de datos sobre la cual fluye la informacion, para el modelado se utilizan diagramas de flujo de datos (DFD) y descomposicion funcional.

Un DFD es una representación grafica del flujo de datos a través del sistema. 

- se ve al sistema como una transformacino de entradas y salidas. Mediante procesos/transformadores

![Untitled](Capitulo%203(Analisis%20y%20especificacion%20de%20requerimientos/Untitled%202.png)

Los transofmradores  son los circulos y tienen un nombre que indica que es lo **que** hace

Las flechas representan el flujo de datos y que datos se estan moviendo

Los rectángulos reprsentan una fuente o un sumidero, algo que genera/consume datos. 

En general ****NO**** hay loops, razonamiento condicional.

Un DFD ******NO****** es un diagrama de control, no debería existir diseño ni pensamiento algorítmico. 

En algunos casos se hace el DFD en niveles cuando el sistema es muy grande. 

- Comenzar con un DFD de nivel superior abstracto conteniendo pocas
burbujas.
- Luego dibujar un DFD por cada burbuja.
- Al “explotar” una burbuja, preservar la E/S original con el fin de
preservar consistencia.
- Para obtener el DFD en niveles se realiza un proceso de refinamiento
top-down. Esto permite modelar sistemas grandes y complejos.

Un DFD requiere de un ******************************************diccionario de datos:****************************************** define con mayor precisión los datos que aparecen como etiquetas en un DFD. Se pueden utilizar expresiones regulares para representar alguna estructura de datos.

![Untitled](Capitulo%203(Analisis%20y%20especificacion%20de%20requerimientos/Untitled%203.png)

********Metodo de análisis estructurado:********

Pasos principales:

1) Dibujar el diagrama de contexto

Ve al sistema completo como un transformador e identifica el contexto, es un DFD con un único transformador, entradas, salidas, fuentes y sumideros del sistema identificado. 

![Untitled](Capitulo%203(Analisis%20y%20especificacion%20de%20requerimientos/Untitled%204.png)

2) DFD del sistema existente:

Se refina el diagrama del contexto y se lo modela tal como es con un DFD para comprender el funcionamiento. Se suelen usar DFD en niveles jerárquicos.

Cada burbuja representa una transformacion logica de algunos datos. 

Debe ser validado junto a los usuarios.

![Untitled](Capitulo%203(Analisis%20y%20especificacion%20de%20requerimientos/Untitled%205.png)

3) Modelado del sistema propuesto:

No existen las reglas generales para dibujar el DFD del futuro sistema ⇒ hay que ser creativo. 

El DFD debe modelar el sistema propuesto completo: ya sean procesos automatizados o manuales. Y tambien debe ser validado con el usuario. 

![Untitled](Capitulo%203(Analisis%20y%20especificacion%20de%20requerimientos/Untitled%206.png)

********************************************************Modelado orientado a objetos********************************************************

- Más fácil de construir y de mantener
- es mas resistente/adaptable a cambios. Pq los objetos son mas estables que las funciones.

El sistema es visto como un conjunto de objetos interactuando entre sí. A través de servicios que cada objeto provee. 

Objetivo:

- Identificar los objetos(las clases) en el dominio del problema.
- definir las clases identificando cuál es la información del estado que ésta encapsula(los atributos)
- identificar las relaciones entre los objetos de las distintas clases. En jerarquía o llamadas a métodos.

El sistema consta de objetos.
• Cada objeto tiene atributos que juntos definen al objeto. Definen el
estado del objeto.
• Los objetos de tipos similares se agrupan en clases (de objetos).
• Un objeto provee servicios o realiza operaciones.
• Estos servicios son los únicos medios que permiten ver o modificar el estado de un objeto.
• Los servicios se acceden a través de mensajes que se envían a los objetos.

Se realizan diagramas de clase: representa gráficamente la estructura del problema. 

![Untitled](Capitulo%203(Analisis%20y%20especificacion%20de%20requerimientos/Untitled%207.png)

![Untitled](Capitulo%203(Analisis%20y%20especificacion%20de%20requerimientos/Untitled%208.png)

Los pasos más significativos para realizar el análisis orientado a
objetos son:

- Identificar objetos y clases
    
    Observar el espacio del problema - Obtener breve resumen - Identificar sustantivos - Aislar candidatos como potenciales objetos del sistema - Posteriormente podrían descartarse.
    
- Identificar estructuras
    
    Considerar clases previamente
    identificadas - Considerar si
    alguna generaliza/especializa a
    otra (¡que sea significativa!) -
    Considerar si algún objeto es
    parte de otro para definir
    agregación.
    
- Identificar atributos
    
    Los atributos representan las
    características que definen los
    objetos - Considerarlos cuidadosamente dentro del dominio del problema - No agregar atributos innecesarios - Ubicarlos apropiadamente en la jerarquía de clases.
    
- Identificar asociaciones
    
    Una asociación captura la relación entre instancias de varias clases - Usualmente se derivan directamente del dominio del problema - Pueden tener sus propios atributos (no forzar estos atributos en los objetos).
    
- Definir servicios
    
    Los servicios proveen el elemento activo en el modelado OO - Para identificar los servicios, definir los estados del sistema y por cada estado listar los eventos externos y respuestas requeridas - Asociar estas actividades con las clases
    

### Prototipado

Se construye un sistema parcial prototipico. Formado por clientes, usuarios y desarrolladores para comprender mejor el problema y las necesidades (cubiertas o por cubrir) 

Ayuda a visualizar el sistema final. Para ello el prototipo puede descartarse luego de terminar la fase de requerimientos o puede evolucionar hacia el sistema final. 

![Untitled](Capitulo%203(Analisis%20y%20especificacion%20de%20requerimientos/Untitled%209.png)

### Especificación de los requerimientos

La salida final de esta etapa **es la SRS**.

Los modelos DFD o DC o prototipos no son SRS, porque estos muestran la estructura del problema y la SRS se enfoca en el comportamiento externo del sistema, tratamiento de errores, requerimientos en el desempeño, restricciones en el diseño, conformidad de estándares, recuperación, etc. 

La transición del modelo a la SRS no es directa, ya que no es una formalización del mismo. 

Lo unico que se transporta el análisis a la especificación es el **conocimiento adquirido** sobre el sistema. 

- Caracteristias de SRS
    - correcta: cada requerimiento representa alguna caracteristica deseada por el cliente.
    - completa: toda caracteristica desdeada por el cliente esta descripta.
    - no ambigüedad: cada requerimiento tiene exactamente un significado.
    - Consistente: ningún requerimiento contradice a otro
    - Verificable: si cada requerimiento es verificable, es decir se puede comprobar que el software final cumple un requerimiento.
    - Rastreable: se debe poder determinar el origen de cada requerimiento y como este se relaciona a los elementos del software. Hacia adelante y hacia atras.
    - Modificable: si la estructura y estilo de la SRS es tal que permite incorporar cambios fácilmente preservando completitud y consistencia. (Tener redundancia en el desarrollo trae problemas a esto)
    - Ordenada en aspectos de importancia y estabilidad