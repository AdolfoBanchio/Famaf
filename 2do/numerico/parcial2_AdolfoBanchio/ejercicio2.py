from cProfile import label
import matplotlib.pyplot as plt
xi = [0,1.5,2,2.9,4,5.6,6,7.1,8.05,9.2,10,11.3,12]
fxi = [0.1,0.2,1,0.56,1.5,2.0,2.3,1.3,0.8,0.6,0.4,0.3,0.2]
plt.plot(xi,fxi,'o')
plt.grid()
plt.show()
"""
Instrucciones de ejecucion:
    -ejecutar por terminal el archivo
    e imprimira por pantalla la respuesta al inciso c.

trapecio realiza la regla simple del trapecio dados dos puntos a b y f(a) y f(b)

y en trapecio adaptativo lo que hago es llamar la regla simple por cada
subintervalo en los datos de la tabla (13 datos 12 subintervalos), 
porque trapecio compuesto utiliza una separacion igual para cada subintervalo,
en este caso tengo una distancia diferente en cada subintervalo. 
por lo que es mas exacto usar la simple para cada intervalo dado.
"""
def trapecio(a,b,fa,fb):
    return ((b-a)/2)*(fa+fb)

def trapecio_adapt(xi,yi):
    res = 0
    for i in range(len(xi)-1):
        res = res + trapecio(xi[i],xi[i+1],yi[i],yi[i+1])
    return res
""" 
    En el resultado esta el valor de la cantidad de metros cuadrados
de tierra que hay en la "cara" del terreno, lo que representan los datos 
en el grafico de la consigna. 
    Luego para dejar el terreno en 0 mts debo sacar toda la tierra del area.  

    Entonces al saber cuantos metros cuadrados de tierra hay en la "cara"(resultado
    de la integral en (0,12) ),
debo multiplicar por la profundidad el resultado y esa sera la cantidad de tierra a sacar

"""
print(f"La cantidad de metros cubicos a ser remmovidos son : {trapecio_adapt(xi,fxi)*10}")