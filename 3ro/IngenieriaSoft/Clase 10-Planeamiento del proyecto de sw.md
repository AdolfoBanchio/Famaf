**Objetivo**: construir un sistema de sq que cumpla con los costos tiempos y calidad.
Una administracion del proyecto efectiva es clave para la ejecución exitosa del proyecto.

El proceso de software tiene 6 componentes:

0) Proceso de desarrollo
1) **Porceso de administracion del proyecto**
2) Proceso de insepccion
3) Proceso de administración de configuración 
4) Proceso de administración de cambios
5) Proceso de administración del proceso

En este caso nos enfocamos en 1) que cuenta con 3 fases:
1) Planeamiento
2) Seguimiento y control
3) Análisis de terminación

El planeamiento se realiza **antes** de comenzar con el desarrollo y toma como entradas los requerimientos y la arquitectura. Se planean todas las tareas que la administración del proyecto necesita realizar. Luego el plan es ejecutado y actualizado en la fase de seguimiento y control.
### 1) Planeamiento del proceso
![[Clase 10-Planeamiento del proyecto de sw-20231030101613506.webp]]
### 2) Estimación del esfuerzo

Dado el conjunto de requerimientos se busca saber cuanto costara en tiempo y dinero el desarrollo. En gral se mide en personas/mes.

La estimación del esfuerzo es clave para el planeamiento. Ya que de ello dependen los tiempos,costos y recursos.

Para poder estimar correctamente existen diferentes modelos que intentan determinar la estimación del esfuerzo a partir de valores de ciertos parámetros.
Esos valores dependen del proyecto -> El modelo reduce el problema de estimar el esfuerzo a estimar ciertos **parámetros claves** del proyecto. Y deben poder medirse en etapas muy tempranas del proyecto.
###### Estimación top-down
Primero determinamos el esfuerzo total y luego calculamos el esfuerzo por cada parte. 
- Primero se estima el tamaño global.
- Luego se calcula
	- esfuerzo = a * tamaño^b
- Las constantes a y b se determinan a través de un análisis sobre proyectos pasados.
###### Estimación bottom-up
1) Identificar los módulos del sistema y clasificaros com simples,medios o complejos
2) Determinar el esfuerzo promedio de codificación para cada tipo de módulo
3) Obtener el esfuerzo total de codificación en base a la clasificación anterior y al conteo de cada tipo
4) Utilizar la distribución de esfuerzos de proyectos similares para estimar el esfuerzo de cada tarea y finalmente el esfuerzo total
5) Refinar los estimadores anteriores en base a factores específicos del proyecto.
##### El modelo COCOMO 
COnstructive COst MOdel

Es un enfoque top-down que utiliza el tamaño ajustado con algunos factores. Consta de
1) Obtener el estimador inicial usando el tamaño
	- $E_i = a * tamaño^b$ esto esta dado por la sig tabla
	- ![[Clase 10-Planeamiento del proyecto de sw-20231030103519672.webp]]
2) Determinar un conjunto de 15 factores de multiplicación representando distintos atributos.
	- Para cada atributo se le asigna algun peso
		- Atributos del software
			- RELY: confiabilidad
			- DATA: tamaño de la BDD
			- CPLX: complejidad de las funciones, datos, interfaces
		- Atributos del hardware:
			- TIME: limitaciones del % de uso de CPU
			- STOR: limitaciones en el % de uso de memoria
			- VIRT: volatilidad de la maquina virtual
			- TURN: frecuencia de cambio en el modelo de explotación
		- Atributos del personal:
			- ACAP: calificación de los analistas.
			- AEXP: experiencia del personal en aplicaciones similares.
			- PCAP: calificación de los programadores.
			- VEXP: experiencia del personal en la máquina virtual.
			- LEXP: experiencia en el lenguaje de programación a usar.
		- Atributos del proyecto
			- MODP: uso de prácticas modernas de programación.
			- TOOL: uso de herramientas de desarrollo de software.
			- SCED: limitaciones en el cumplimiento de la planificación.

3) Ajustar el estimador de esfuerzo escalándolo según el factor de multiplicación final
	- Luego de tener un peso para cada categoria el esfuerzo es $$esfuerzo = E_i * \sum_{k=1}^{15} f_k$$ donde $f_k$ es el factor de ajuste segun cada categoria
4) Calcular el estimador de esfuerzo para cada fase principal.
	- Luego para calcular el esfuerzo en cada fase se reparte el esfuerzo total segun esta tabla (para sistemas orgánicos). 
	- ![[Clase 10-Planeamiento del proyecto de sw-20231030104653632.webp]]
### 3) Planificación y recursos humanos
Existen dos niveles de planificacion, global y detallada
###### Planificación global
Depende del esfuerzo estimado, y dada una estimacion existe "cierta" flexibilidad dependiendo de como se asiganan los recursos.

Una forma de estimar el tiempo en meses (M) es usando una función del esfuerzo en personas/mes. Estas funciones no son lineales y se determinan analizando datos pasados.
- COCOMO: M = 2.5 * esfuerzo*0.38
- Una "Rule of thumb" es chequear M = $\sqrt{esfuerzo}$

Ya con esta estimación y se puede determinar el tiempo de las metas parciales. La distribución de esfuerzo y la distribución de los tiempos en las fases son dos cosas distintas.
###### Planificación detallada
Busca decidir las tareas de bajo nivel y asignarlas preservando siempre la planificación de alto nivel. 

Esto es un proceso iterativo: si no se pueden acomodar todas las tareas -> revisar la planificación global. Por este mismo modo no se realiza de manera completa al comienzo sino que va evolucionando. Es un documento muy activo en la admin del proceso.

Cualquier actividad a realizarse debe quedar reflejada en la planificación detallada, cada tarea tiene asignado nombre, esfuerzo, fecha, duración, recurso, etc. La planificación detallada ademas debe ser consistente con las metas. Es decir las tareas son subactividades de las actividades a nivel de metas -> el esfuerzo individual debe sumar apropiadamente preservando la duración total.

Para poder lograr todo esto los equipos estan organizados estructuralmente, hay 3 tipos
- Organización jerárquica:
	- hay un administrador con responsabilidad global.
	- tiene programadores, testers y administrador de config para ejecutar las tareas detalladas
- Equipos democráticos:
	- Funciona en pequeños grupos donde el liderazgo es rotativo
- Alternativa:
	- Se busca reconocer 3 tareas independientes: desarrollo, teting y administracion. Cada equipo debe ser relativamente independiente y los administradores deben proveer las especificaciones y aseguran coordinacion.
	- Cada equipo tiene un líder y todos reportan a un líder general
### 4) Planeamiento de la administración de la config del sw
Se realiza cuando el proyecto a sido iniciado y ya se conoce la especificación de los requerimientos y el entorno de la operación. Se deben identificar los ítems de configuración y especificar los procedimientos a utilizar par controlar e implementar los cambios de estos items.
- algunas actividades:
	- Identificar los ítems de configuración (IC).
	-  Definir un esquema de nomenclatura para cada IC.
	- Definir la estructura de directorios necesaria.
	- Definir el procedimiento para el versionado y los métodos para rastrear los cambios en los IC.
	- Definir las restricciones de acceso.
	- Definir los procedimientos para el control de cambios.
	- Identificar y definir las responsabilidades del administración de configuración.
	- Identificar los puntos en los que se crearán las “baselines”.
	- Definir el procedimiento de backup.
	- Definir el procedimiento de “release”.
### 5) Planeamiento del control de calidad
objetivo: entragar un sw de alta calidad->baja densidad de defectos. 
La unidad de medida suele ser # defectos/KLOC

	Defecto: algo que causa que el sw se comporte de manera incosistente con respecto a los requerimientos

Como los efectos se pueden introducir en cualquier etapa, se deben eliminar constantemente. Lo mejor es mediante actividades de control de calidad como revisiones y testing luego de cada etapa.
![[Clase 10-Planeamiento del proyecto de sw-20231030111501343.webp]]

Existen diferentes enfoques para administrar las actividades de control de calidad
- Enfoque ad-hoc
	- Se hacen test y revisiones de acuerdo a cuando y como se necesiten
- Enfoque de procedimiento
	- El plan define que tares de QC(revisión y testing) se realizan y en que momentos. Provee procedimientos y lineamientos a seguir en las act. 
- Enfoque cuantitativo:
	- Analiza los datos recolectados de los defectos y estavlece juicios sobre la calidad usando métricas o densidad de defectos. 
	- Utiliza parámetros claves como las tasas de introducción y eliminación de defectos.

En todo proyecto se establece un plan de calidad que determina que actividades van a realizarse. Y su nivel depende de los modelos de predicción disponibles. Por lo menos deberá definir las tareas de QC a realizar y podría especificar los niveles esperados de defectos que cada tarea debe encontrar. 
### 6) Administración de riesgos
**Riesgo**: cualquier condición o evento de ocurrencia incierta que puede causar la falla del proyecto. 

El objetivo es minimizar el impacto de la materialización de los riesgos. 

Dentro de la administración del riesgo hay una etapa de evaluación que se realiza durante el planeamiento y una etapa de control que se realiza durante la realización del proyecto
#### Evaluación del riesgo
###### Identificación del riesgo 
Busca identificar los posibles riesgos del proyecto, es decir, aquellos eventos que podrían ocurrir y causar la falla del proyecto.
- la forma de hacerlo es mediante listas de control, brainstorming, experiencias, etc.
![[Clase 10-Planeamiento del proyecto de sw-20231030113049397.webp|491]]
###### Analisis y def de prioridades
Como la cantidad de riesgos a tener en cuenta, se les debe dar a uno una probabilidad de ocurrencia y estimar la perdida que estos causarian. para luego ordenarlos de acuerdo al "valor de exposición al riesgo" (RE):
$$RE = \mathrm{prob.ocurrencia \ indeseada} * \mathrm{impacto \ ocur.indeseada}$$
RE es el valor esperado de la pérdida debido a un riesgo. Se realizan planes para tratar los riesgos con mayor RE.

Se clasifican las probabiliades de ocurrencia como Baja, Media, Alta y se clasifican los impactos de los riesgos como Bajos, Medios, o Altos. Se busca enfocarse en los riesgos AA, AM y MA.
#### Control de riesgos
Evitar todo posible riesgo evitable, para los demás casos planear y ejecutar los pasos necesarios para mitigarlos. 
- Se deben definir las acciones a seguir de manera que si el riesgo se materializa su impacto sea mínimo.

La mitigacion de riesgos incluye los pasos a realizar, deben planificarse en el tiempo y ejecutarse. NO son los mismos que para cuando el mismo se materializa.
### 7) Planificación del seguimiento del proyecto
Es un documento que sirve como guia que debe ejecutarse para poder asegurarse que la realizacion del proyecto se realiza como estaba especulada. Para esto esta realizacion debe seguirse y controlarse. Para esto se pueden utilizar mediciones y metodos para interpretarla

El plan de seguimiento incluye:
- planificar que medir, cuando y como
- como analizar y reportar esos datos
###### Mediciones
- Tiempo(cronograma): analizar si se cumplen los plazos
- Esfuerzo: se sigue dentro del presupuesto, se puede medir a través de reportes de esfuerzo.
- Defectos: determinan la calidad
- Tamaño: mucha info se normaliza respecto al tamaño

El objetivo del **Seguimiento del proyecto** es hacer visible la ejecución del proyecto de manera que se puedan realizar acciones correctivas cuando sea necesario con el fin de asegurar el éxito del proyecto. 
Existen diferentes niveles de seguimiento
- Nivel de actividad
	- Asegura que cada act se hace bien y a tiempo.
	- Realizado por los admin del proyecto diariamente
- Reportes de estado: consta de
	- resumen de actividades completadas y pendientes
	- Cuestiones que necesitan atención
- Análisis de metas parciales:
	- Se realiza una mayor revisión con cada meta parcial
	- Análisis de esfuerzos y tiempos reales vs estimados. Si esta desviacion es grande -> se aplican medidas correctivas. 
	- Se vuelven a revisar los riesgos.
Para todos estos seguimientos necesitamos de los datos que las mediciones proveen.

