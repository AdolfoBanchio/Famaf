from numpy import linspace
from ejercicio1 import intenumcomp
import matplotlib.pyplot as plt
import numpy as np
"""
la cantidad de n intervalos debe ser escogida de forma que la long 
del intervalo sea <= a 0,1
"""
def senint(x):
    y = []
    for i in x:
        n = int(np.ceil(10*i))
        y.append(intenumcomp(np.cos,0,i,n,"trapecio"))
    return y

x_plot = np.arange(0,2*np.pi,0.5)
y_senint = senint(x_plot)
sen_plot = np.sin(x_plot) 

plt.plot(x_plot,y_senint,label="Senint(x)")
plt.plot(x_plot,sen_plot,label="sen(x)")
plt.grid()
plt.legend()
plt.show()