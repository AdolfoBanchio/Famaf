from cProfile import label
import sys
from turtle import dot
import numpy as np
import math
import matplotlib.pyplot as plt
"""
algoritmo que calcula una integral con el metodo de 
simpson
"""
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

def funcion(y):
    r = 1/y
    return r
"""
evalua la integral en el intervalo [1,x] para la funcion anterior
usando metodo de simpson
"""
def integral_simpson(x):
    return simpson(funcion,1,x,100)

"""
creo una funcion que tenga una raiz en 1, y dependa de x
tal que pueda encontrar una aproximacion del numero e que para el cual 
integral_simspon vale 1
"""

def fun_raiz(x):
    g =integral_simpson(x)-1
    return g

"""
para poder encontrar esta aproximacion de e, voy a usar el metodo
metodo de la biseccion para encontrar la raiz.

Porque como al desarrollar la integral entre [-1,x] de 1/y
veo que termina siendo el ln(x) y se en que intervalos se encuentra el valor que hace
al ln(x) = 1 , entonces se entre que intervalos se encuentra la raiz de 
g(x) = 1-integral_simpson(x) y lo uso para el metodo de la biseccion.

Uso biseccion ya que es un metodo que pide pocas hipotesis:
    -la funcion debe ser continua y tener una raiz en el intervalo inicial.

"""
def rbisec(fun,i,err,mit):
    u = fun(i[0])
    v = fun(i[1])
    e = i[1]-i[0]
    hx = list()
    hf = list()
    if np.sign(u)==np.sign(v):
        sys.exit("los extremos tienen el mismo signo")
    for k in range (1,mit):
        e = e/2
        c = i[0] + e
        w = fun(c)
        hx.append(c)
        hf.append(w)
        if abs(fun(c))<err or k >= mit:
            break
        if np.sign(w)!= np.sign(u):
            i[1]=c
            v = w
        else:
            i[0]=c
            u = w
    return (hx,hf)


"""
rbisec devuelve una lista con todas las aproximaciones y una con todos los 
valores de f en esas aproximaciones, 

La aproximacion a e esta dada por:
"""
fun_x_plot ,fun_y_plot =rbisec(fun_raiz,[2.2,2.8],1e-6,100) 
"""
fun_x_plot contiene las aproximaciones de e
fun y_plot contiene los valores de integral_simpson(x)-1 en dichas aproximaciones
"""
eaprox = fun_x_plot[-1]
print(f"Valor de la aproximacion {eaprox}")

"""
y el error absoluto entre una aproximacion y el valor real esta dado por

error = |x*-x| donde x* es el valor real

luego en este caso es:
"""
print(f"Valor de la constante math.e = {math.e}")
print(f"error absoluto {abs(math.e - eaprox)}")

"""
creo una gran cantidad de puntos entre 1 y 8 para evaluar integral_simpson y que
el grafico se vea suave
"""
x_plot = np.linspace(1,8,200)
"""
evaluo integral_simpson(x) y integral_simpson(X)-1 
para graficarlas 
"""
simp_y_plot = [integral_simpson(i) for i in x_plot]
g_y_plot = [fun_raiz(i) for i in x_plot]
"""
calculo integral simpson(e) con las aproximaciones
obtenidas en el metodo de la biseccion

"""
simp_e_aprox = [integral_simpson(i) for i in fun_x_plot]

"""grafico todo junto"""
plt.plot(x_plot,simp_y_plot,"red",label="f(x) = integral_simpson(x)")
plt.plot(fun_x_plot,fun_y_plot,"o",label="aprox de e")#aprox de e con del metodo de biseccion y la funcion usada

plt.plot(x_plot,g_y_plot,label="g(x) = integral_simpson(x)-1")#grafico de la funcion g(x) = integral_simpson(x)-1

plt.plot(fun_x_plot,simp_e_aprox,"o",label="aprox de integral_simpson(e)")


plt.plot(eaprox,integral_simpson(eaprox),"o",label="integral_simpson(e)")
plt.plot(math.e,0,"*",label="constante math.e")
plt.legend()
plt.grid()
plt.show()

"""
dos graficos por separado
fig,ax = plt.subplots(2)
ax[0].plot(x_plot,y_plot,"red",label="integral_simpson")
ax[1].plot(fun_x_plot,fun_y_plot,"ob",label="aproximaciones")
#plt.plot(x_plot,g_y_plot)#grafico de la funcion para obtener la aproximacion de e g = integral_simpson(x)-1
ax[0].plot(math.e,integral_simpson(math.e),"o",label="integral_simpson(e)")
ax[1].plot(math.e,0,"*",label="constante math.e")
ax[0].legend()
ax[1].legend()
ax[0].grid()
ax[1].grid()
fig.show()
plt.show()
"""