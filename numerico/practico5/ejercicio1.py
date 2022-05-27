import sys
import numpy as np
def simpson(fun,a,b,n):
    h =(b-a)/(2*n)
    sx0 = fun(a) + fun(b)
    sx1 = 0
    sx2 = 0 
    xi = np.linspace(a,b,2*n +1)
    for j in range(1,2*n):
        if j%2 == 0 :
            sx2 = sx2 + fun(xi[j])
        else:
            sx1 = sx1 + fun(xi[j])
    sx = (sx0 + 2*sx2 + 4*sx1)*(h/3)
    return sx



def trapecio(fun,a,b,n):
    h = (b-a)/n
    sxi = 0
    sx = 0
    xi = 0
    for i in range(1,n):
        xi = a + i*h
        sxi = sxi + fun(xi)
    sx = (fun(a) + 2*sxi + fun(b)) *h/2
    return sx


def ptomedio(fun,a,b,n):
    h = (b-a)/(n)
    sxi = 0 #suma de los f(xi) impares
    xi = np.linspace(a,b,n+1)
    sx = 0
    for i in range(0,len(xi)):
        if i%2 != 0:
            sxi = sxi + fun(xi[i])
    sx = 2*h*sxi 
    return sx



def intenumcomp(fun,a,b,N,regla):
    if N == 0:
        return 0
    else:
        if regla == "trapecio":
            return trapecio(fun,a,b,N)
        elif regla == "pm":
            return ptomedio(fun,a,b,N)
        elif regla == "simpson":
            return simpson(fun,a,b,N)
        else:
            print("entrada incorrecta, debe ser 'trapecio' 'pm' 'simpson' ")
            sys.exit()

def cuadrado(x):
    return x**2
"""
print(intenumcomp(cuadrado,0,3,10,"simpson"))
print(intenumcomp(cuadrado,0,3,10,"trapecio"))
print(intenumcomp(cuadrado,0,3,1000,"pm"))
"""