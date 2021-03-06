from math import tan
import numpy
import matplotlib.pyplot as plt
from numerico.practico2.ej1rbisec import rbisec
#ejercicios 1 y 2

def fun_ej2a(x):
    f = tan(x)-(2*x)
    return f
def fun_ej2b (x):
    f = x**2 - 3
    return f

hx , hf = rbisec(fun_ej2a,[0.8,1.4],1e-5,100)
hx2 , hf2 = rbisec(fun_ej2a,[4.5,4.7],1e-5,100)

x = numpy.linspace(0.8,1.4,120)
plt.plot(hx,hf,"red",label="puntos medios[0.8,1.4]")
plt.plot(hx2,hf2,"blue",label="puntos medios[4,5]")
plt.plot(x,numpy.tan(x)-(2*x),"g", label="tan(x)-(2*x)")
plt.title("grafico fun ej2a")
plt.legend()
plt.grid()
plt.show()


hx3 , hf3 = rbisec(fun_ej2b,[0,3],1e-5,100)
hx4 , hf4 = rbisec(fun_ej2b,[-2,0],1e-5,100)
y = numpy.linspace(-5,5,120)
plt.plot(hx3,hf3,"red",label="puntos medios[0,3]")
plt.plot(hx4,hf4,"blue",label="puntos medios[-2,0]")
plt.plot(y,(y**2)-3,"g", label="x**2-3")
plt.title("grafico fun ej2b")
plt.legend()
plt.grid()
plt.show()
