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

Si X es una variable aleatoria con distribucion exponencial de parametro $\lambda = 1$ entonces su funcion de densidad es:
$$
F(x) = \begin{cases}
        1 - e^{-x} \quad \text{si  } x \gt 0 \\
        0  \quad \text{si  } x \le 0
        \end{cases}
$$

luego la inversa de F sobre (0,1) es:
$$
F^{-1}(u) = -\log(1-u) , u \in (0,1)
$$

Entonces el algoritmo de simulacion para una exponencial con $\lambda = 1$ es:

```python
def exponencial ():
    u = 1 - random()
    return -log(1-u)
```

Vemos que si Y es $\frac{1}{\lambda} X$ entonces Y distribuye exponencial con parametro $\lambda$ y el codigo es:

```python
def exponencial (lamda):
    u = 1 - random()
    return -log(1-u)/lamda
```

### Simulacion de variable Poisson

Sabemos que en un proceso de Poisson de intensidad $\lambda$ entonces N(t), es una variable aleatoria Poisson con media $\lambda . t$. Y ademas sabemos que el tiempo entre llegadas de eventos son aleatorias exponenciales con media $\frac{1}{\lambda}$.

N(1) es una variable Poisson con paramentro $\lambda$, y sabemos que los tiempos entre arribos en [0,1] son exponenciales. Entonces si simulamos _i_ variables aleatorias de modo que:
$$
X_1+X_2+..+X_n \leq 1 \text{ y } X_1+X_2+..+X_n+X_{n+1} \gt 1
$$
Entonces n es el número de arribos hasta t=1. Y tenemos

![alt text](image-1.png)

```python
def poisson_con_exp(lamda):
    X = 0
    producto = 1 - random()
    cota = exp(1-lamda)
    while producto >= cota:
        producto *= 1 - random
        x += 1
    return x
```

### Simulacion de variable Gamma(n, $\lambda^{-1}$)

Sabemos que la suma de n variables aleatorias exponenciales, independientes, con parametro $\lambda$ es una variable aleatoria con distribucion Gamma(n, $\lambda^{-1}$). Esta propiedad nos permite dar un algoritmo que a partir de exponenciales generamos una Gamma.

$$X = -\frac{1}{\lambda} \log(U_1 \cdot U_2 \cdots U_n)$$

Y el algoritmo es:

```python
def Gamma(n, lamda):
    # genera gamma con parametros n y 1/lamda
    u = 1
    for _ in range(n):
        u *= 1 - random()
    return -log(u)/lamda
```

utilizando este metodo de generacion de exponenciales para generar una gamma, entonces podemos diseñar un algoritmo para generar n variables independientes exponenciales de parametro $\lambda$

```python
def DosExp(lamda):
    V1, V2 = 1-random(), 1-random()
    t = -log(V1 * V2) / lamda
    U = random()
    X = t * U
    Y = t - X
    return X, Y
```

Para el caso general tenemos que calcular un unico logaritmo y n-1 uniformes adicioneles.

```python
def Nexponenciales(n,lamda):
    t = 1
    for _ in range(n): t *= random()
    t = -log(t)/lamda
    unif = random.uniform(0,1,n-1)
    unif.sort()
    exponenciales = [unif[0]*t]
    for i in range(n-2):
        exponenciales.append((unif[i+1]-unif[i])*t)
    
    exponenciales.append((1-unif[n-2])*t)
    return exponenciales
```

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
