# Memoria

Principio de localidad dice que los programas acceden a relaitivamente pqueñas porciones de memoria del _Adress Space_ de los programas en cualquier instante. 2 tipos de localidad

## Localidad Temporal

    Si un item es referenciado, es probable que sea referenciado nuevamente en un futuro cercano.

## Localidad Espacial

    Si un item es referenciado, es probable que items cercanos sean referenciados en un futuro cercano.

![Alt text](image.png)

Para poder aprovechar los principios de localidad se implementa una jerarquia de memoria. Que es una estructura que usa multiples niveles de memorias, tal que a medida que la distancia al procesador aumenta, aumenta el tamaño de la memoria y el tiempo de acceso a la misma. 

Mientras mas rapido sean las memorias mas caras por bit son.

La informacion esta siempre guardada en el nivel mas bajo, y la informacion contenida en los niveles mas altos son subconjuntos de la informacion contenida en el nivel mas bajo.

## Cache

La cache es el bloque de memoria mas rapido mas cercano al procesador. La cache es un buffer de memoria que almacena temporalmente los datos que son usados frecuentemente. 

En la cache un **Bloque** (o linea) es la unidad minima de informacion que puede estar presente en el cache. 

Si una informacion que requiere el procesador la encuentra en la cache, se considera un _hit_. Si no se encuentra en la cache, se considera un _miss_, y en este caso se accede a los niveles mas bajos de memoria para obtener la informacion deseada. 

**Hit rate** es la fraccion de accesos a la cache que resultan en un hit.

**Miss rate** es la fraccion de accesos a la cache que resultan en un miss.(1 - Hit rate o Misses / Accesses)


**Hit time** es el tiempo requerido para acceder a la cache y determinar si el acceso es un hit o un miss.

**Miss penalty** es el tiempo requerido para remplazar un bloque de la cache con el bloque deseado de la memoria principal + el tiempo de enviarlo al procesador.

Como el cache es memoria mas rapida, el hit time es mucho mas rapido que el tiempo de acceder a la memoria principal.

![Alt text](image-1.png)

SRAM es la memoria utilizada en la cache, tiene un solo puerto de acceso que provee un _read_ o un _write_. Tiene un tiempo de acceso fijo a cualquier direccion de memoria.

### Cache Mapping

La cache esta basada en una estructura _direct-mapped cache_ que es una estructura donde cada direccion de memoria tiene un unico lugar en la cache donde puede ser almacenado. Para poder encontrar la ubicacion de la cache de una direccion de memoria se hace:

    (Direccion de memoria) modulo (Numero de bloques en la cache)

Por ejemplo si una cache tiene 8 bloques, entonces solamente utiliza los ultimos 3 bits de la direccion de memoria para encontrar la ubicacion del bloque en la cache.

