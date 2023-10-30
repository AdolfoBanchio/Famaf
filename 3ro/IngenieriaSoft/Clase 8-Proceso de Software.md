Un proceso adecuado ayuda a lograr los objetivos del proyecto con alta C&P.
Un **proyecto exitoso** es el que satisface las expectativas en costo, tiempo y calidad. Al planear y ejecutar un proyecto de sw, las decisiones se toman con el fin de reducir costos y tiempos e incrementar la calidad. Es el proceso el que guía un proyecto, e influye significativamente el resultado esperado del proyecto.

Las componentes del **proceso de software** son :
- El proceso de **desarrollo**, que se enfoca en las actividades para el desarrollo y garantizar la calidad necesarias para la ingeniería del sw.
- **Administración del proyecto**: se enfoca en el planeamiento y control del proceso de desarrollo con el fin de cumplir sus objetivos.

El proceso de desarrollo es el corazon del proceso de software, los otros giran al rededor de el.
**Componentes del proceso de software**
- Proceso de la ingeniería del producto
	0) proceso de desarrollo
	1) Proceso de administración del proyecto
	2) Proceso de inspección 
	3) Proceso de administración de configuración
	4) Proceso de administración de cambios
5) Proceso de administración del proceso
##### Especificación del proceso
El proceso generalmente es un conjunto de fases donde cada fase realiza una tarea bien definida y produce una salida. Tal salida intermedia se llama **producto de trabajo**.
Cada producto de trabajo es una entidad **formal** y **tangible**, capaz de ser **verificada**. Cada fase se puede llevar a cabo utilizando diferentes metodologias
### Enfoque "ETVX"
Cada fase sigue el enfoque ETVX (Entry-Task-Verification-Exit) donde el criterio de entrada es consistente con la salida de la fase anterior.
- Criterio de entrada: que condiciones deben cumplirse para iniciar la fase
- Tarea: lo que debe realizar la fase
- Verificación: las inspecciones/controles que deben realizarse a la salida de la fase
- Criterio de salida: cuando puede considerarse que la fase fue realizada exitosamente.
Cada fase produce info para la admin del proceso.
___
### Características deseadas del proceso
Debe proveer alta C&P. El proceso debe:
- producir sw testeable: es la tarea más cara durante el proceso de desarrollo
- producir sw mantenible: es lo más caro en la vida del sw.
- Debe poder eliminar defectos en etapas tempranas
	- El costo de eliminar un error que perdura en el proceso es mayor.
	- Deben ser encontrados en la etapa en que se introdujeron (La "V" en ETVX). Para ello se hace **control de calidad**, su proposito es identificar y eliminar errores.
- El proceso ademas debe poder prevenir defectos.
- Ser predecible y repetible. Es decir conseguir el mismo desempeño o similar cuando se utilizan en distintos proyectos. (por eso predecible)
	- Permite estimar calida, costos y esfuerzos.
	- Para ello debe estar bajo control estadistico.
- Soportar cambios y producir sw que se adapte a cambios
	- Debe esperar los cambios en requerimientos y durante el desarrollo del sw.
___
### Proceso de desarrollo de software
**Objetivo**: construir sistemas de sw dentro de los costos y el tiempo planeado, cronograma y que posea la calidad apropiada, satisfaciendo al cliente, alta C&P. -> se necesita un proceso adecuado para alcanzar los objetivos. Es especificado durante el pleaneamiento.
- Es un conjunto de fases y cada fase es una secuencia de pasos que definan la metodología de la fase
	- Analisis de requerimientos y especificación
		- Salida: SRS
	- Arquitectura y diseño
		- Involucra Arquitectura, diseño de alto nivel y diseño detallado
		- Salida: doc correspondientes
	- Codificacion
		- Salida: codigo (simple y facil de comprender)
	- Testing
		- Salida: plan de test con los resultados y codigo final testeado
	- Entrega e instalación.
- Cada modelo de proceso diferente las realizan de diferente manera. 
Cada fase del proceso de desarrollo toma una entrada y produce una salida(producto de trabajo) para que la siguiente fase lo utilice. 
___
### Proceso para la administración del proyecto
3 fases
- Planeamiento
	- Se realiza antes de comenzar el proyecto
- Seguimiento y control
	- Acompaña el proceso de desarrollo. Busca seguir y observar parametros claves:
		- Costo, tiempos, riesgo y factores que los afectan.
		- Utiliza métricas para proveer información del proceso de desarrollo necesarias para el seguimiento
- Análisis de terminación
	- Se realiza al final del proceso de desarrollo. Su propósito es analizar el desempeño del proceso e identificar lecciones aprendidas.
	- Cuando el proceso es iterativo, se realiza al final de cada iteración.
	- ![[Clase 8-Proceso de Software-20231030180125141.webp]]
___
### Proceso de inspección
**Objetivo**: detectar los defectos en los productos de trabajo (salidas de cada fase).
- Mejora tanto la calidad como la productividad. 
- Los defectos pueden introducirse en el SW en cualquier etapa -> deben eliminarse en cada etapa.
Es realizado por personal técnico para personal técnico, es un proceso estructurado con roles bien definidos para cada participante. La info recolectada es registrada y utilizada para monitorear la efectividad de la solución. **Encuentra problemas no los resuelve**
**Roles y responsabilidades:**
- Moderador: tiene la responsabilidad general
- Autor: quien realizo el producto de trabajo
- Revisor: quien identifica los defectos
- Lector: lee línea a línea el producto de trabajo para enfocar el progreso de la reunión
- Escriba: registra las observaciones indicadas.
Tiene las siguientes etapas
1) Planeamiento
	- Entrada: producto de trabajo a revisar
	- Salida: equipo de revision y cronograma.
		- Paquete para la distribución:
			- producto de trabajo a revisar con sus especificaciones
			- Lista de control con items relevantes
			- estándares
2) Preparación y repaso
	- Toma el paquete del planeamiento
	- Cada miembro identifica potenciales defectos en el producto de trabajo en una planila de revisión individual
	- ![[Clase 8-Proceso de Software-20231030181503655.webp|363]]
3) Reunión de revisión grupal
	- A partir de las revisiones individuales, se vuelve a revisar el producto de trabajo y se identifican los defectos y el escriba los registra
	- Al finalizar se analiza la lista de defectos/observaciones, si son pocos se acepta el producto, sino se pude requerir otra revision.
	- NO PROPONE SOLUCIONES
	- El moderador esta a cargo y asegura que el foco permanezca en identificar defectos. Analiza la efectividad de la revisión
4) Corrección y seguimiento
	- Una vez corregidos los defectos por el autor. Obtiene un visto bueno por el moderador o se somete a una nueva revisión.
	- Cuando los defectos son satisfactoriamente procesados, la revisión finaliza.
![[Clase 8-Proceso de Software-20231030182021434.webp|573]]
![[Clase 8-Proceso de Software-20231030182035940.webp|578]]
___
### Proceso de administración de configuración
Controla sistematicamente los cambios producidos. Se enfoca en los cambios durante la evolución: los cambios de requerimientos se manejan aparte.
Requiere de disciplina como de herramientas.
SCM es usualmente independiente del proceso de desarrollo, estos miran el gran esquema pero no los cambios individuales de items/archivos.
- A medida que los ítems se producen, se introducen en la SCM
- SCM controla solo los productos del proceso de desarrollo. Y durante ese proceso los items/archivos van cambiando y generando diferentes versiones.
- La admin de config se asegura que las distintas versiones se combinen apropiadamente sin pérdidas.
###### Funcionalidades necesarias
- Recolectar las fuentes, documentos y otra info del sistema actual.
- Evitar cambios desautorizados
- Deshacer cambios o revertir a una versión especificada
- Hacer disponible la ultima versión del programa.
###### Mecanismos principales
- Control de acceso, versiones
- Identificación de la configuración
###### Items de configuración
- Cada item es una unidad de modificación y se modifican intensamente, sus cambios deben ser seguidos.
- Las diferentes versiones de los mismos deben ser correctamente combinadas
- **baseline**: arreglo apropiado de items de configuración. Establece puntos de referencia a lo largo del desarrollo del sistema. Captura el estado lógico del mismos y forma la base de los cambios posteriores. 
El proceso en si consta de:
- Definir las actividades que requieren control de cambio
- Planeamiento: identificar los items, definir la estructura del repositorio, definir control de acceso, puntos de referencia, definir procedimiento de publicación.
- Ejecución: realizar los procedimientos según lo establecido en planeamiento
- Auditoria: para verificar que no se cometieron errores.
___
### Proceso de administración de cambios de requisitos
Los **requerimientos** pueden cambiar en cualquier momento durante el desarrollo y pueden producir impactos en los productos de trabajo y en los distintos items de configuración.
- Los cambios no controlados puede impactar adversamente en el proyecto, tanto en costo como en tiempo.
Consta de:
- Registrar los cambios
	- Se inician a traves de un **requerimiento de cambio**
	- Existe un registro de requerimientos de cambio
- Realizar análisis de impacto sobre los productos de trabajo y los ítems
	- El analisis de impacto incluye identificar los cambios necesarios en los distintos items y naturaleza del cambio
- Estimar el impacto en esfuerzo y en cronograma
- Analizar el impacto con las personas involucradas
	- El impacto del cambio en el proyecto es analizado para decidir si hacerlo efecitvo o no
- Reprocesar los productos de trabajo y los items
___
### Proceso de administración de procesos
Se enfoca en la evaluación y mejora del proceso. Para eso la organizacion debe comprender el proceso actual:
- Requiere que el mismo esta bien documentado y apropiadamente ejecutado en los proyectos.
- Para eso se recolecta datos de los proyectos para comprender el desempeño del proceso en los proyectos
##### CMM
Tiene 5 niveles par el proceso de software. En cada nivel el proceso tiene ciertas capacidades y establece las bases para pasar al siguiente nivel. Para moverse de un nivel a otro CMM especifica las áreas en las que enfocarse.
1) Ad-hoc
2) Repetible:
	 - Admin de requerimientos
	 - Admin de configuración
	 - Planeamiento del proyecto
	 - Control y monitoreo
3) Definido:
	- Organización en definición del proceso.
	- Programa de entrenamiento
	- Revisión de pares
	- Admin integrada del SW
4) Administrado
	- Admin de la calidad del SW
	- Admin cuantitativa del proceso
5) Optimizado
	- Admin del cambio del proceso
	- Admin del cambio de tecnología
	- Prevención de defectos