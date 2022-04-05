import math
import sys
from tracemalloc import stop
a = int(input("ingrese el radicando:"))
def raiz3dea (x): 
    f = x**3-a
    fp = 3*(x**2)
    return (f,fp)

def raiz3(x):
    f = x**3-5
    fp = 3*(x**2)
    return (f,fp)
def rnewton (fun,x0,err,mit):
    hx = []
    hf = []
    im_x0,d_x0 = fun(x0)
    if abs(im_x0)<err:
        hx.append(x0)
        hf.append(im_x0)
        return (hx,hf)
    for k in range (mit):
        xn = x0 -(im_x0/d_x0)
        im_x0,d_x0 = fun(xn)
        hx.append(xn)
        hf.append(im_x0)        
        if abs((xn - x0)/xn)<err or abs(im_x0)<err:
            return (hx,hf)
        
        x0 = xn
    return (hx,hf)

hx,hf = rnewton(raiz3dea,1.5,1e-6,100)

print(hx)
print(hf)