from turtle import color
import numpy as np
from ilagrange import ilagrange
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d #funcion que hace splines

"""
Instruccion de ejecucion:
    -ejecutar el archivo por terminal e imprimira los
    graficos correspondientes.
    -los puntos de (horas,longitud), la interpolacion de lagrange y el spline juntos
    -los puntos de (horas,latitud), la interpolacion de lagrange y el spline en otro cuadro

cargo los datos con la funcion loadtxt
que los deja cargados en una matriz
"""
data = np.loadtxt("irma.csv",delimiter=',')
horas = data[:,0]
longitud = data[:,1]  
latitud = data[:,2]

"""
para interpolar las funciones 
longitud(t) y latitud(t) en funcion de las horas usando 
lagrange (funcion implementada en el practico 3)
que recibe como parametros (xi,yi) a interpolar y una lista z de
valores a evaluar, y devuelve una lista con esos z evaluados en el polinomio
interpolante de lagrange

en este caso voy a querer interpolar (horas,longitud/latitud),
y evaluarlo en un range(0,25) para evaluar el polinomio interpolante
cada 1 hora. 
"""

x_plot = range(0,25)
y_long_plot = ilagrange(horas,longitud,x_plot)

y_lat_plot = ilagrange(horas,latitud,x_plot)

spline_long = interp1d(horas,longitud,kind='cubic')
spline_lat = interp1d(horas,latitud,kind='cubic')

"""
genero los splines cubicos para cada set de datos.
La funcion interp1d me devuelve una funcion que puedo evaluar en los datos que quiera.

y los evaluo cada 1 hs, es decir de la 00 a la 24.
"""
y_lat_spline = [spline_lat(i) for i in x_plot]
y_long_spline = [spline_long(i) for i in x_plot]

"""
grafico por separado 
longitud(t)
latitud(t)
"""
fig, ax = plt.subplots(2)
ax[0].plot(x_plot,y_long_plot,label="Longitud(t) lagrange")
ax[0].plot(x_plot,y_long_spline,label="Longitud(t) spline")
ax[0].plot(horas,longitud,'o',color='b')
ax[0].grid()
ax[0].legend()

ax[1].plot(x_plot,y_lat_plot,label="Latitud(t) lagrange")
ax[1].plot(x_plot,y_lat_spline,label="Latitud(t) spline")
ax[1].plot(horas,latitud,'o')
ax[1].legend()
ax[1].grid()
fig.show()
plt.show()