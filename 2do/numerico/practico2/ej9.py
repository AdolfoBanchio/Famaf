from math import sqrt
import math
import sys
from ej3rnewton import rnewton

def energia (x): 
    f = 0.01328*(x**2)*(6.66667**3) - 500
    fp = 0.01328*(2*x)*(6.66667**3)
    return (f,fp)


hx,hf = rnewton(energia,25,1e-6,100)

print(hx)
print(hf)