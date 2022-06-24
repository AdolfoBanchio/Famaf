from click import style
from scipy.interpolate import interp1d
import numpy as np
import matplotlib.pyplot as plt
import math

fp = "../datos/datos_aeroCBA.dat"

data = np.loadtxt(fp,usecols=(0,1))
x_int =[]
y_int =[]
for i in range(len(data)):
    if not(math.isnan(data[i][1])):
        x_int.append(data[i][0])
        y_int.append(data[i][1])


f = interp1d(x_int,y_int,kind='cubic',bounds_error=False,fill_value="extrapolate")

x_plot = [i for i in range(1957,2018)]
f_plot = [f(i) for i in x_plot]

plt.plot(x_plot,f_plot,'g')
plt.title("Temperatura media entre 1957-2017")
plt.grid(color = "black" ,linestyle="-",linewidth=1)
for i in range(len(x_plot)):
    plt.plot(x_plot[i],f_plot[i],marker='o')
plt.legend()
plt.show()