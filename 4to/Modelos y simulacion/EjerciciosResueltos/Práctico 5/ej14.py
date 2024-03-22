from random import random
from math import log

def eventosPoisson(lamda,T):
    t = 0
    NT = 0
    Eventos = []
    while t < T:
        U = 1 - random()
        t += - log(U) / lamda
        if t <= T:
            NT += 1
            Eventos.append(t)
    return NT, Eventos


def Capacidad_cole():
    return 40 - int(random() * 21)

def simulacion(lamda, T):
    Autobuses = eventosPoisson(lamda, T)[0]
    hinchas = 0

    for _ in range(Autobuses):
        hinchas += Capacidad_cole() 

    return hinchas

n = 10000
espert = 0
for _ in range(n):
    espert += simulacion(5,1)

print(espert/n)
