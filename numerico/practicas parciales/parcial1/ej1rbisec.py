from math import tan
import math
import sys
import numpy

#ejercicio 1 
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

