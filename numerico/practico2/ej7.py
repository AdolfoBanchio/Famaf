from numpy import linspace
from ej1rbisec import rbisec
from ej3rnewton import rnewton
from ej5pfijo import puntofijo
from math import exp
import matplotlib.pyplot as plt

def funej7bisec (x):
    fun = lambda y:(y - exp(-(1-x*y)**2))
    hxb,hfb = rbisec(fun,[0.0,2.0],1e-8,100)
    return (hxb,hfb)

ux1 = []
for x in linspace(0.0,1.5,20):
    hxb,hfb = funej7bisec(x)
    ux1.append(hxb[-1])

def funej7newton(x):
    fun = lambda y:(y - exp(-(1-x*y)**2),1-exp(-1+2*y*x-y**2*x**2)*(-2*x**2*y+2*x))
    hxn,hfn = rnewton(fun,1,1e-8,100)
    return (hxn,hfn)
ux2 = []

for x in linspace(0.0,1.5,20):
    hxn,hfn = funej7newton(x)
    ux2.append(hxn[-1])

#creo mi funcion g(y) iterativa para el punto fijo
def funej7pf(x):
    fun = lambda y:(exp(-(1-x*y)**2))
    hxp = puntofijo(fun,0,1e-8,100)
    return (hxp)

ux3 = []
for x in linspace(0.0,1.5,20):
    hxp = funej7pf(x)
    ux3.append(hxp[-1])

ux = [ux1,ux2,ux3]
labels = ["con biseccion","con newton","con pf"]
x = linspace(0.0,1.5,20)
"""
fig, bisec = plt.subplots()
bisec.plot(x,ux1,"blue",label="con biseccion")
plt.plot(x,ux2,"red",label="con newton")
plt.plot(x,ux3,"g",label="con pf")
plt.title("grafico u(x)=y")
plt.xlabel("eje x")
plt.ylabel("eje y")
plt.legend()
plt.grid()
plt.show()
"""
fig, ax = plt.subplots(1,3)
for idy in range (3):
    ax[idy].plot(x,ux[idy],label=labels[idy])
    ax[idy].set_title("grafico u(x)=y")
    ax[idy].legend()

fig.show()
plt.show()
