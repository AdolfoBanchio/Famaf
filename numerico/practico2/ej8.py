from math import sqrt
import math
import sys

def ptoscriticos (x): #funcion para calcular los puntos criticos de tan(x)/x
    f = ((x*(1/math.cos(x)))**2-(2*math.tan(x)))/x**3
    fp = ((x*(1/math.cos(x)))**2-(2*math.tan(x)))/x**4
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

hx,hf = rnewton(ptoscriticos,0.9,1e-6,100)

print(hx)
print(hf)
