from ejercicio1 import serie_seno
import matplotlib.pyplot as plt
#importo la funcion serie_seno del ej1

#visualizar la serie de taylor del sen(x) centrada en 0 en el intervalo [0,6.4]

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
plt.legend()
plt.grid()
plt.show()

#para poder ver el grafico solo se tiene que ejecutar el archivo