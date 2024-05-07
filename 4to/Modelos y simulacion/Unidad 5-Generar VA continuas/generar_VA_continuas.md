# Generación de variables aleatorias continuas

## Metodo de la transformada inversa

Este metodo requiere de conocer la funcion de distribución acomulada de la variable X a simular. Si X es absolutamente continua y _f_ es su función de densidad, entonces su función de distribución acumulada es:
$$ \int_{-\inf}^{x} f(t)dt $$

Vamos trabajar sobre las variables X tal que su f.d.m sea monótona creciente sobre el conjunto
$F^{-1}(0,1) ={x| 0 \lt F(X) \lt 1}$. De esta forma nos aseguramos que F(x) sea invertible en el (0,1).

![proposicion](image.png)

Con esta proposicion podemos dar un algoritmo basico de como funciona el metodo de la transformada inversa:

```python
def Tinversa():
    u = random()
    return G(U) # G = F^-1
```

Eso no siempre es posible ya que puede ser que $F^{-1}$ involucre funciones costosas o que no se pueda calcular explicitamente. En estos casos se busca expresar F como:

- distribucion del minimo o del maximo de VA indep
- suma de variables indep
- distribuciones condicionales, etc.

### Simulacion de variable Exponencial

TODO

### Simulacion de variable Poisson

TODO

### Simulacion de variable Gamma(n, $\lambda^{-1}$)

TODO

---

## Metodo de aceptacion y rechazo

Supongamos que queremos generar X que tiene funcion de densidad _f_:
$$F(x) = P(X \leq x) = \int_{-\inf}^{x} f(t)dt$$

Y que tengo un método para generar otra Y con denssidad _g_ tq:
$$\frac{f(y)}{g(y)} \leq c \quad\text{ para todo } y \in \R : f(y) \not ={0}$$

Entonces el algoritmo de aceptacion y rechazo es:

```python
def AceptacionRechazo():
    while True:
        y = G()
        u = random()
        if u < f(y) / (c*g(y)):
            return y
```

Al igual que en las variables aleatorias discretas, este metodo tiene densidad _f_ y el numero de iteraciones es una variable geometrica con media _c_.

Para poder generar X rechazando contra una variable Y debemos poder acotar $\frac{f(x)}{g(x)}$ con una constante c. Por lo que vamos a tener que considerar la funcion:
$$
h(x) = \frac{f(x)}{g(x)}, \quad \text{para } x \in \R : f(x) \not = 0
$$

Para esto vamos a:

- encontrar los puntos criticos de h(x) (donde h'(x) = 0 o h(x) no esta definida)
- ver cuales corresponden a máximos locales
- Luego tomamos ese maximo como _**c**_

## Simulacion de variables aleatorias normales

### Por composicion usando |Z|

TODO

### Metodo polar

TODO

### Transformaciones de Box-Muller

TODO

### Método de razón entre uniformes

TODO

## Generación de un proceso de Poisson

TODO
