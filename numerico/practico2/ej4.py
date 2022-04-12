import math
import sys
from tracemalloc import stop
from numerico.practico2.ej3rnewton import rnewton
a = int(input("ingrese el radicando:"))

def raiz3dea (x): 
    f = x**3-a
    fp = 3*(x**2)
    return (f,fp)
x0 =float(input("ingrese la primera aproximacion de la raiz:"))
hx,hf = rnewton(raiz3dea,x0,1e-6,100)

print(f"la raiz3 de {a} = {hx[len(hx)-1]}")