import numpy as np
import matplotlib.pyplot as plt
fp = "./datos/datos1a.dat"
data = np.loadtxt(fp,float)
def coef_linear_dot(x,y):
    unos = np.ones(len(x))
    x_cuad = np.dot(x,x)
    x_sum = np.dot(x,unos)
    y_sum = np.dot(y,unos)
    xy = np.dot(x,y)
    m = len(x)
    a0 = ((x_cuad*y_sum) - (xy*x_sum)) / ((m*x_cuad)-x_sum**2)
    a1 = ((m*xy)-(x_sum*y_sum)) / ((m*x_cuad)-x_sum**2)
    return a0,a1

def calculate(x,a0,a1):
    graph = []
    for i in x:
        graph.append(i*a1+a0)
    return graph



x_plot = data[:,0]
y_plot = data[:,1]

a0,a1 = coef_linear_dot(x_plot,y_plot)
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

