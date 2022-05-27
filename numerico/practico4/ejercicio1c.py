from cProfile import label
import matplotlib.pyplot as plt
from numpy import disp, linspace, polyfit
import numpy as np

pares = linspace(0,10,20)
p_y = 0.75 *pares - 0.5
dispersion = np.random.randn(20)
pares_con_ruido = p_y + dispersion

ajuste_l = np.polyfit(pares,pares_con_ruido,1)
recta_ajustada = np.polyval(ajuste_l,pares)
plt.plot(pares,p_y,'o',label="puntos entre [0,10] sin ruido")
plt.plot(pares,pares_con_ruido,'*',label="pares con ruido")
plt.plot(pares,recta_ajustada,'g',label="Recta por cuadrados minimos")
plt.legend()
plt.grid()
plt.show()