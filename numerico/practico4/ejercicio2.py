import numpy as np
import math
import matplotlib.pyplot as plt 
xa = np.linspace(0,1,50)
xb = np.linspace(0,4*math.pi,50)

yarcsen = [math.asin(i) for i in xa]
ycos = [math.cos(i) for i in xb]

for i in range(1,6):
    arcsen = np.polyfit(xa,yarcsen,i) #crea una interpolacion de grado i 
    a_plot = np.polyval(arcsen,xa)
    plt.plot(xa,a_plot,label=f"arcsen grado {i}")
    
plt.grid()
plt.legend()
plt.show()

for i in range(1,6):
    cos = np.polyfit(xb,ycos,i)
    b_plot = np.polyval(cos,xb)
    plt.plot(xb,b_plot,label=f"cos grado {i}")
plt.grid()
plt.legend()
plt.show()
