
# Generacion de variables aleatorias discretas

Existen 2 formas de generar variables aleatorias discretas:

- metodo de la transformada inversa
- metodo de aceptacion y rechazo.

## Metodo de la transformada inversa

---

## Metodo de aceptacion y rechazo

El metodo de aceptacion y rechazo para generar una variable aleatoria X supone que podemos generar una variable aleatoria Y que cumpla lo siguiente:

- Si $P(X = x_j)$ entonces $P(Y = x_j) > 0$, para todo $x_j$ en el rango de X.
- Existe una constante c > 0, tal que 
$$\frac{P(X = x_j)}{P(Y = x_j)}\leq c$$
