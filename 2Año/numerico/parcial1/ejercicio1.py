from cmath import pi
import math

def serie_seno(x):
    f = 0
    for n in range (0,5):
        f = ((((-1)**n)/math.factorial((2*n)+1))*(x**((2*n)+1))) + f 
    return f


'''
la funcion serie_seno toma un valor x y aproxima el valor del
sen(x), al ser una serie centrada en 0 sera mas exacta en valores 
cercanos al 0, por eso su grafico en valores grandes > 3, su grafico
no es similar al grafico del sen, pero si cerca del 0
print(serie_seno(1)) ejemplo de ejecucion de la funcion serie_seno evaluada en 1,



dejo comentadas las aproximaciones porque al utilizar la funcion serie_seno en otros ejercicios 
estas aproximaciones tambien se imprimen. para poder ver estas aproximaciones remover los "#"  de las lineas 28 y 30 y ejecutar el archivo
luego volver a colocarlos para poder ejecutar los demas ejercicios 
si no se comentan no cambiara nada en la ejecucion de los otros ejercicios, solo que estas tambien se imprimiran y pueden estorbar.
'''

#print(serie_seno(pi))
#aproximacion del sen de pi
#print(serie_seno(1))
#aproximacion del sen 1