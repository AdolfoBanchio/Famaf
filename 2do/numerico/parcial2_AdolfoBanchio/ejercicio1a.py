import numpy as np
import matplotlib.pyplot as plt
"""
instrucciones de ejecucion:
    -ejecutar el archivo e imprimira los graficos correspondientes a
    (longitud,latitud) del archivo irma.csv
"""
data = np.loadtxt("irma.csv",delimiter=',')
horas = data[:,0]
longitud_plot = data[:,1]  
latitud_plot = data[:,2]
"""
extraigo separo los datos de latitud y longitud de la matriz
formada por np.loaftxt()
"""
plt.plot(longitud_plot,latitud_plot,'o')
plt.grid()
plt.show()