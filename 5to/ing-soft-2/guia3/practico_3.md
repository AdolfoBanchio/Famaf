![](/imgs/Pasted%20image%2020250401115312.png)

$$
\begin{align}
\text{Sean P y Q prop de safety ver que:} \\
\sigma \notin P \cap Q &\rightarrow \exists i \geq 0 :\forall \beta : \sigma [..i]\beta \notin P \cap Q \\
\sigma \notin P \cap Q &\rightarrow \sigma \notin P \lor \sigma \notin Q \\
\\
\text{caso } \sigma \notin P \\
&\rightarrow \exists i \geq 0 :\forall \beta : \sigma [..i]\beta \notin P \\
&\rightarrow \exists i \geq 0 :\forall \beta : \sigma [..i]\beta \notin P \cap Q \\
\end{align}
$$

Por lo que se satisface cuando $\sigma \notin P$ cuando $\sigma \notin Q$ es análogo.


![](/imgs/Pasted%20image%2020250401120547.png)

Definicion liveness, sea P una propiedad de liveness

$$
\forall \alpha \in \Sigma^* : \exists \beta \in \Sigma^{\omega}: \alpha \beta \in P
$$

Dados $P \cap Q$    :

$$
\alpha \in P \cap Q \rightarrow \exists \beta \in \Sigma^{\omega}: \alpha \beta \in P \cap Q \\
$$

#### Ejercicio 5: encuentre una propiedad que sea de safety y de liveness

**Safety**: Si una traza tiene un prefijo que viola una propiedad de safety, es irremediable.

**Liveness**: No importa como este formada mi palabra, siempre existirá una forma de completarla para que cumpla la propiedad.


La propiedad que contiene todas las trazas posibles es de safety y de liveness. Ya que siempe no importa que prefijo tenga seguira siendo de liveness. Y no existe prefijo que viole la propiedad de safety.

#### Ejercicio 6: con referencia al ej anterior, demuestre que esa propiedad es unica.

Sean P y Q dos propiedades tales que son de safety y de liveness simultaneamente y supongamos $P \neq Q$.

Sea $\sigma \notin Q$, entonces como Q es de safety, significa que existe un prefijo $\beta$ tal que es "malo". Entonces tenemos que cualquier extension de $\beta$ tampoco satisface Q. 

Pero como Q tambien es de liveness, deberia tener una forma de completar $\beta$ tal que satisfaga la propiedad. Pero ya dijimos que cualquier extension de $\beta$ no cumple Q. 

Entonces lo que tenemos es que Q debe contener todas las trazas posibles. 

Analogamente para P, por lo que obtenemos que si existen dos propiedades que sean de safety y de liveness. Entonces son iguales.

#### Demuestre o refute lo sig:

```
El complemento de una propiedad de safety es necesariamente una propiedad de liveness
```
Complemento de una propiedad safety P:

$$
\bar{P} = \{ \sigma : \exists i \geq 0 : \forall \beta : \sigma [..i] \beta \notin P \}
$$

Esto me dice que para toda traza, existe una forma de dar un sufijo malo y que no pertenezca a P (osea que pertenezca al complemento).

De la misma forma, sea Q = $\bar{P}$ , entonces siempre existe alguna forma de completar mi traza para que pertenezca a Q. (es la def de una propiedad de liveness).

#### Ejercicio 8: para cada propiedad, decir si son de safety, liveness, ambas o ninguna. $\Sigma = \{a,b\}$

1. $a^* b^{\omega}$ : es de safety, pues cualquier prefijo diferente 

