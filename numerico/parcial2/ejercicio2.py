xi = [0,1.5,2,2.9,4,5.6,6,7.1,8.05,9.2,10,11.3,12]
fxi = [0.1,0.2,1,0.56,1.5,2.0,2.3,1.3,0.8,0.6,0.4,0.3,0.2]
"""
Instrucciones de ejecucion:
    -ejecutar por terminal el archivo
    e imprimira por pantalla la respuesta al inciso c.


Esta funcion recibira como argumentos los a b del intervalo a calcular la integral
(necesarios para poder calcular el h)

luego datospart es una lista que contiene los f(xi) (incluidos f(a) y f(b))
tal que los xi no son equidistantes. 

luego el n para calcular h = b-a/n , n = la cantidad de elementos de datospart, es decir
la cantidad de puntos

"""
def trapecio_adaptativo(a,b,datospart):
    h = (b-a)/len(datospart)
    sxi = 0
    sx = 0
    xi = 0
    for i in range(1,len(datospart)-1):
        sxi = sxi + datospart[i]
    sx = (datospart[0] + 2*sxi + datospart[-1]) *h/2
    return sx

""" 
    En el resultado esta el valor de la cantidad de metros cuadrados
de tierra que hay en la "cara" del terreno, lo que representan los datos 
en el grafico de la consigna. 
    Luego para dejar el terreno en 0 mts debo sacar toda la tierra del area.  

    Entonces al saber cuantos metros cuadrados de tierra hay en la "cara"(resultado
    de la integral en (0,12) ),
debo multiplicar por la profundidad el resultado y esa sera la cantidad de tierra a sacar

"""
print(f"La cantidad de metros cubicos a ser remmovidos son : {trapecio_adaptativo(0,12,fxi)*10}")