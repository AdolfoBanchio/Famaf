![[Pasted image 20250401115312.png]]
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


![[Pasted image 20250401120547.png]]

Definicion liveness, sea P una propiedad de liveness
$$
\forall \alpha \in \Sigma^* : \exists \beta \in \Sigma^{\omega}: \alpha \beta \in P
$$
Dados $P \cap Q$    :
$$
\alpha \in P \cap Q \rightarrow \exists \beta \in \Sigma^{\omega}: \alpha \beta \in P \cap Q \\

$$