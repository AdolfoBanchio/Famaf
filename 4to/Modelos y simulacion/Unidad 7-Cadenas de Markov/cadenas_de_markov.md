# Cadenas de Markov

Un proceso de Markov con un conjunto discreto de estados S es una **cadena de Markov**. Y la propiedad de Markov se escribe como:
$$
P(X_{n+1} = j | X_n = x_n, X_{n-1} = x_{n-1}, \ldots, X_0 = x_0) = P(X_{n+1} = j | X_n = x_n)
$$

Dada una cadena de Markowv con conjunto de estados $S = \{0,1,2,\cdots\}$ las probabilidades de transición son los numeros:
$$
p_{ij} = P(X_{n+1} = j | X_n = i) \quad \text{para } i,j \in S
$$

$p_{ij}$ es la probabilidad de transición de i a j en un paso. Para representar todas las probabilidades de transición de una cadena de Markov, se utiliza una matriz de probabilidades de transición $Q$.
$$
Q = (p_{ij}) = \begin{bmatrix}
                p_{00} & p_{01} & p_{02} & \cdots \\
                p_{10} & p_{11} & p_{12} & \cdots \\
                p_{20} & p_{21} & p_{22} & \cdots \\
                \vdots & \vdots & \vdots & \ddots
                \end{bmatrix}
$$

Donde $p_{ij} \geq 0$ y $\sum_{j} p_{ij} = 1$ (Cada fila suma 1).

La **distribución incial** de la cadena es la funcion:
$$
\pi(j) = P(X_0 = j) \quad \text{para } j \in S
$$

Donde $\pi(j) \geq 0$ y $\sum_{j} \pi(j) = 1$. Por lo que teniendo la distribución inicial y la matriz de probabilidades. Podemos calcular la distribucion conjunta de $X_0, \cdots, X_n$: 
$$
P(X_0 = x_0, X_1 = x_1, \cdots, X_n = x_n) = \pi(x_0) p_{x_0 x_1} p_{x_1 x_2} \cdots p_{x_{n-1} x_n}
$$

**Ecuaciones de Chapman Kolmogorov**. Sea $Q=(p_{ij})$ la matriz de transición, entonces la matriz $Q^n$ contiene las probabilidades de transición en n etapas. 
$$
(Q^n)_{ij} = P(X_n = j | X_0 = i)
$$

Dos estados i y j se **comnican** si j es accesible desde i e i es accesible desde j.

Una **clase comunicante** es un subconjunto de estados donde todos los estados se comunican entre si.

Un subconjunto $C$ no vacío de estados se dice **cerrado** sii para todo $i \in C$ y $j \notin C$ se tiene que $j$ no es alcanzable desde $i$.

Un subconjunto $C$ se dice **irreducible** si y solo si no contiene ningun subconjunto propio cerrado. Una cadena se dice irreducible si su espacio de estados es irreducible (no tiene subconjuntos cerrados).

## Clasificación de estados

$v_{ij}$ es la probabilidad de que la cadena que comienza en $i$ llegue al estado $j$ en un tiempo positivo. 
$$
v_{ij} = P(X_n = j, n \geq 1 | X_0 = i)
$$

- $j$ es **recurrente** si $v_{jj} = 1$. Es decir, que siempre que parta de $j$ todos los caminos posibles llevan a $j$.
- $j$ es **transitorio** si no es recurrente.
- $j$ es **absorbente** si $p_{jj} = 1$.

**Proposición**: si $i$ es recurrente y existe un camino de $i$ a $j$ entonces $j$ es recurrente.

Si la cadena de Markov es finita, no pueden ser todos los estados transitorios, al menos hay uno recurrente.

Si la cadena es finita e irreducible, todos sus estados son recurrentes. Y a cadena se dice recurrente.

**Estados periodicos**:

Si un estado $i$ es recurrente, entonces hay algun n positivo tal que la probabilidad de llegar a $i$ en el paso n partiendo desde $i$ es mayor que 0. En particular el **periodo** del estado $i$ es:
$$
k = MCD\{n \gt 0 : P(X_n = i | X_0 = i) > 0\}
$$
Si $k=1$ el estado es **aperiódico**. Si $k>1$ el estado es **periódico** con periodo $k$.

Si la cadena es irreducible, entonces todos tienen el mismo período o todos son aperiódicos. Se dice que la cadena es **periodica** o **aperiódica**.

## Tiempos de alcance

El tiempo minimo de alcance de un subconjunto de A de S es $H^A$:
$$
H^A = \inf{\{n \geq 0 : X_n \in A\}}
$$
Donde la **probabilidad de alcance** a A desde el estado $i$ es:
$$
h_i^A = P(H^A \lt \infty | X_0 = i)
$$

Luego si A = $\{j\}$, entonces es la suma de las probabilidades de que en el n-esimo paso alcance j.
$$
h_i^{\{j\}} = \sum_{n \geq 0} P(H^A = n | X_0 = i) \\

\text{O tambien, la solucion mínima no negativa del sistema de ecuaciones:} \\

\begin{cases}
h_i^{A} = 1 & \text{si } i \in A \\
h_i^{A} = \sum_{j \in S} p_{ij} h_j^{A} & \text{si } i \notin A
\end{cases}
$$

El **tiempo medio de alcance** del conjunto A desde el estado $i$ es la esperanza condicional $k_i^A = E[H^A | X_0 = i]$. Y se calcula como
$$
\begin{cases}
k_i^{A} = 0 & \text{si } i \in A \\
k_i^{A} = 1 + \sum_{j \in S} p_{ij} k_j^{A} & \text{si } i \notin A
\end{cases}
$$

El **tiempo medio de retorno** se define como el valor esperado del tiempo de alcance del estado $j$ sobre todos los caminos de almenos un paso. Tambien puede determinarse a partir de las probabilidades de alcance desde cada uno de los estados. El tiempo medio de retorno al estado j es:
$$
r_j = 1 + \sum_{i \in S} p_{ji} k_i^{(j)}
$$
