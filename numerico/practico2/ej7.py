from numpy import linspace
from ej1rbisec import rbisec
from ej3rnewton import rnewton
from ej5pfijo import puntofijo
from math import exp
import matplotlib.pyplot as plt

def funej7bisec (x):
    fun = lambda y:(y - exp(-(1-x*y)**2))
    hx,hf = rbisec(fun,[0.0,2.0],1e-8,100)
    return (hx,hf)
    
aprox = []
for x in linspace(0.0,1.5,20):
    hx,hf = funej7bisec(x)
    aprox.append(hx[-1])

plt.plot(linspace(0.0,1.5,20),aprox)
plt.show()
print(aprox)