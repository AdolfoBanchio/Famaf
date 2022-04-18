import math
from ej3rnewton import rnewton
def raiz3dea (a):
    fun = lambda  x:(x**3-a,3*(x**2))
    hx,hf = rnewton(fun,a,1e-6,100)
    return (hx,hf)
hx,hf = raiz3dea(27.0)
print(f"la raiz3 de a = {hx[-1]}")
