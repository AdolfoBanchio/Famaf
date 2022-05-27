import numpy as np
import matplotlib.pyplot as plt

def coef_linear(x,y):
    x_cuad = 0
    x_sum = sum(x)
    y_sum = sum(y)
    xy=0
    for i in range(len(x)):
        xy = xy + (x[i]*y[i])
        x_cuad = x_cuad + x[i]**2
    m = len(x)
    a0 = ((x_cuad*y_sum) - (xy*x_sum)) / ((m*x_cuad)-x_sum**2)
    a1 = ((m*xy)-(x_sum*y_sum)) / ((m*x_cuad)-x_sum**2)
    return a0,a1
def calculate(x,a0,a1):
    graph = []
    for i in x:
        graph.append(i*a1+a0)
    return graph

fp = "./datos/datos1a.dat"

data = np.loadtxt(fp,float)

x_plot = data[:,0]
y_plot = data[:,1]

a0,a1 = coef_linear(x_plot,y_plot)
lineargraph = calculate(x_plot,a0,a1)


for i in range(len(x_plot)):
    plt.plot(x_plot[i],y_plot[i], marker='o')
"""
grafico la nube de puntos
calculo la aprox mediante cuadrados minimos usando un modelo lineal
"""    
plt.plot(x_plot,lineargraph,'r')
plt.grid()
plt.show()
