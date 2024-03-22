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


m = eventosPoisson(1, 0.5)
print(f"{m[0]} \n {m[1]}")