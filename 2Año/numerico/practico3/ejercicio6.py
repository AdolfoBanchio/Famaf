from cProfile import label
from click import style
from scipy.interpolate import interp1d
import numpy as np
import matplotlib.pyplot as plt
import math
from ilagrange import ilagrange
from inewton import inewton

x = [i for i in range(-3,4)]
y = [1,2,5,10,5,2,1]
z = np.linspace(-3,3,101)
y_plot_n = inewton(x,y,z)
y_plot_l = ilagrange(x,y,z)

f_spline_c = interp1d(x,y,kind='cubic',bounds_error=False,fill_value="extrapolate")
f_plot_c = [f_spline_c(i) for i in z]

f_spline_q = interp1d(x,y,kind='quadratic',bounds_error=False,fill_value="extrapolate")
f_plot_q = [f_spline_q(i) for i in z]
plt.plot(z,y_plot_n,color='green',label='newton')
plt.plot(z,y_plot_l,color='black',label='lagrange',linestyle='dotted')
plt.plot(z,f_plot_c,color='blue',label='spline cubico')
plt.plot(z,f_plot_q,color='red',label='spline cuadratico')
plt.grid()
plt.legend()
plt.show()