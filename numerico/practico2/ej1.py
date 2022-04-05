from cmath import tan
import math
import sys
import numpy

#ejercicios 1 y 2

def fun_ej2a(x):
    f = tan(x)-(2*x)
    return f
def fun_ej2b (x):
    f = x**3 - 5
    return f

def rbisec(fun,i,err,mit):
    u = fun(i[0])
    v = fun(i[1])
    e = i[1]-i[0]
    hx = list()
    hf = list()
    if numpy.sign(u)==numpy.sign(v):
        sys.exit("los extremos tienen el mismo signo")
    for k in range (1,mit):
        e = e/2
        c = i[0] + e
        w = fun(c)
        hx.append(c)
        hf.append(w)
        if abs(fun(c))<err or k >= mit:
            break
        if numpy.sign(w)!= numpy.sign(u):
            i[1]=c
            v = w
        else:
            i[0]=c
            u = w
    return (hx,hf)

hx , hf = rbisec(fun_ej2a,[0.8,1.4],1e-5,100)
print(f"es la raiz para f(x)= tan(x)-2x \n es x={hx[len(hx)-1]}")
print(f"\nf({hx[len(hx)-1]}) = {hf[len(hf)-1]}")

hx2 , hf2 = rbisec(fun_ej2b,[-105000,130000],1e-5,30)
print(f"es la raiz para f(x)= x^3 - 5 \n es x={hx2[len(hx2)-1]}")
print(f"\nf({hx2[len(hx2)-1]}) = {hf2[len(hf2)-1]}")
