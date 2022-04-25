from rbisec import rbisec
import matplotlib.pyplot as plt
from ejercicio1 import serie_seno
'''
importo el metodo de biseccion que implemente en otro archivo

analizando el grafico de la serie de Taylor del seno centrada en 0
veo que sus raices positivas se encuentran entre 
x0 = [3,3.5]
x1 = [4.7,5.1]

usare el metodo de biseccion en cada uno de esos intervalos 
para obtener aproximaciones a dichas raices

'''

hx1,hf1 = rbisec(serie_seno,[3,3.5],1e-5,100) 
#calculo la raiz de la serie de Taylor del seno en el int [3,3.5] usando biseccion
print("aproximacion de la raiz entre [3,3.5] = ",hx1[-1])


hx2,hf2 = rbisec(serie_seno,[4.7,5.1],1e-5,100)
print("aproximacion de la raiz entre [3,3.5] = ",hx2[-1])
#calculo la raiz de la serie de Taylor del seno en el int [4.7,5.1] usando biseccion

Tf = []
Tx = []
for i in range(0,640):
    Tf.append(serie_seno(i*0.01))
    Tx.append(i*0.01)
#en una lista calculo todos los x entre [0,6.40] separados por una diferencia de 0.01
#en la otra lista (Tf) calculo  los valores de la serie para cada uno de esos x

plt.plot(Tx,Tf,label="Serie de Taylor")
plt.xlabel("eje x")
plt.ylabel("eje y")
#grafico ambas raices
plt.plot(hx1[-1],hf1[-1],"red",marker="o",label="raiz 1")
plt.plot(hx2[-1],hf2[-1],"green",marker="o",label="raiz 2",)
plt.legend()
plt.grid()
plt.show()

# grafico los puntos para ver donde se encuentran las raices en la funcion serie_seno