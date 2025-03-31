# Propiedades de los sistemas concurrentes

Debido a que los sistemas concurrentes son reactivos a diferentes eventos, tienen diferentes características y por lo tanto comportamientos que suelen no ser los esperados.

Para ello se buscan que satisfagan ciertas propiedades para su correcto funcionamiento. Estas tienen las sig categorías:
1. **Alcanzabilidad**: es posible que el sistema llegue a algún estado de un conjunto dado (en particular conjunto de estado de ERROR). Buscamos en general que la propiedad de interés para nuestro sistema sea la negación de la alcanzabilidad.
2. **Seguridad**: "Nunca va a pasar nada malo". Garantizar estas propiedades me asegura que el sistema preserva un invariante dado, exclusion mutua, etc. La negación de una propiedad de seguridad es una prop de alcanzabilidad
3. **Vitalidad**: "siempre es posible que algo bueno ocurra". Es posible alcanzar algún estado de estabilidad.
4. **Equidad**: "siempre ocurrirá algo de manera frecuente".

Dentro de la semántica de procesos podemos definir el conjunto de todas las ejecuciones. Donde cada ejecución es una sucesión de eventos del proceso.

De esta forma podemos definir las **propiedades** como un **conjunto de trazas** posibles de mi sistema.

```
Las propiedades tienen una semántica dada en términos de conjuntos de trazas. Una propiedad P se dientifica con todas las sucesiones de eventos atómicos que exhiben la propiedad P
```

#### Lenguajes $\omega - regulares$ 

![[Pasted image 20250325102655.png]]

Dentro de L tendré palabras de la forma

$$
e_1 \cdot f_1^{\omega} + \cdots + e_n \cdot f_n^{\omega}
$$
Donde cada palabra tiene una parte finita y una parte infinita.

Buscaremos representar propiedades con expresiones $\omega -regulares$ . De modo que luego podemos formalizar las propiedades de las diferentes características utilizando estos lenguajes.

##### Propiedades safety
- Si una traza tiene un prefijo que viola una propiedad de safety, es irremediable. Y esta traza (sin importar como continua) nunca dejara de violar la propiedad.

![](/imgs/Pasted%20image%2020250325104718.png)

##### Propiedades liveness
"Siempre es posible que algo bueno ocurra". No importa como este formada mi palabra, siempre existirá una forma de completarla que cumplirá la propiedad.

![[Pasted image 20250325105826.png]]

```
Teorema [Alpern & Schneider 85] 

Toda propiedad puede escribirse como la intersección de una propiedad de safety y una de liveness
```

FSP me permite caracterizar las propiedades que debe cumplir cierto proceso. De modo que al momento de construirlo verifica cuando un proceso NO satisface dicha propiedad y lo traduce agregando los estados de error necesarios para representar correctamente dichos casos.

