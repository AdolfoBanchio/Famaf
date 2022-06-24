from ejercicio4 import rsteffensen
from ejercicio1 import serie_seno
import matplotlib.pyplot as plt

#calculo la primera raiz positiva con x0 = 3 en el metodo steffensen
hx1,hf1 = rsteffensen(serie_seno,3,1e-5,100)
print("primera raiz positiva = ",hx1[-1])
print("cantidad de iteraciones necesarias =",len(hx1))

hx2,hf2 = rsteffensen(serie_seno,6,1e-5,100)
print("segunda raiz positiva = ",hx2[-1])
print("cantidad de iteraciones necesarias =",len(hx2))

#caso especial para x0 = 4.5
hx3,hf3 = rsteffensen(serie_seno,4.5,1e-5,100)
print("aproximacion en el caso x0 =  4.5 = ",hx3[-1])
print("valor de serie_seno en la aproximacion obtenida = ",hf3[-1])
print("cantidad de iteraciones necesarias =",len(hx3))

#grafico la funcion y las aproximaciones obtenidas por rsteffensen para analizar cada caso 
Tf = []
Tx = []
for i in range(0,640):
    Tf.append(serie_seno(i*0.01))
    Tx.append(i*0.01)
#en una lista calculo todos los x entre [0,6.40] separados por una diferencia de 0.01
#en la otra lista (Tf) calculo  los valores de la serie para cada uno de esos x

#grafico la serie y las raices para poder verlas y compararlas con lo obtenido en el metodo de biseccion
plt.plot(Tx,Tf,label="Serie de Taylor")
plt.xlabel("eje x")
plt.ylabel("eje y")
#grafico ambas raices
plt.plot(hx1[-1],hf1[-1],"red",marker="o",label="raiz 1")
plt.plot(hx2[-1],hf2[-1],"green",marker="o",label="raiz 2",)
#plt.plot(4.5,serie_seno(4.5),"green",marker="o",label="raiz 2",)
#plt.plot(hx3[-1],hf3[-1],"blue",marker="o",label="caso especial",)
plt.legend()
plt.grid()
plt.show()

'''
Noto que las raices que se obtienen aproximmando en 3 y 6  son exactas a las obtenidas con biseccion,
tambien se nota que es mucho mas rapido el metodo de steffensen que el metodo de biseccion.

pero en el caso de x0 = 4.5 el resultado obtenido es bastante lejano a ser una raiz, el metodo usa todas las iteraciones
y no converge en una raiz. no lo grafico
'''
