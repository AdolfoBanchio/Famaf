from random import random
from math import log

def Poisson_no_homogeneo_adelgazamiento(T, lamda, lamda_t):
    'Devuelve el n´umero de eventos NT y los tiempos en Eventos'
    'lamda_t(t): intensidad, lamda_t(t)<=lamda'
    NT = 0
    Eventos = []
    U = 1 - random()
    t = -log(U) / lamda
    while t <= T:
        V = random()
        if V < lamda_t(t) / lamda:
            NT += 1
            Eventos.append(t)
        t += -log(1 - random()) / lamda
    return NT, Eventos


def Poisson_adelgazamiento_mejorado(T, interv, lamdas, funcion):
    j = 0 
    t = -log (1 - random()) / lamdas[j]
    NT = 0
    Eventos = []
    while t <= T:
        if t <= interv[j]:
            V = random()
            if V < funcion(t) / lamdas[j]:
                NT += 1
                Eventos.append(t)
            t += -log(1 - random()) / lamdas[j]
        else: #t > interv[j]
            t = interv[j] + (t - interv[j]) * lamdas[j] / lamdas[j + 1]
            j += 1
    return NT, Eventos


su1 = 0
su2 = 0
n = 10000
for _ in range(n):
    su1 += Poisson_adelgazamiento_mejorado(3, [1, 2, 3], [7, 5, 13/3], lambda x: 3+4/(x+1))[0]
    su2 += Poisson_no_homogeneo_adelgazamiento(3, 7, lambda x: 3+4/(x+1))[0]

print(f"{su1/n} \n{su2/n}")
