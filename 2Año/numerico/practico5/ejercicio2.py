from ejercicio1 import intenumcomp
import numpy as np
def exp(x):
    return np.exp(-x)

int_exp = 1 - 1/np.exp(1)

N = [4,10,20]
for n in N :
    int_simp = intenumcomp(exp,0,1,n,"simpson")
    int_pm = intenumcomp(exp,0,1,n,"pm")
    int_trap = intenumcomp(exp,0,1,n,"trapecio")

    print(f"error absoluto de simpson con {n} intervalos = {abs(int_exp - int_simp)}")
    print(f"error absoluto de pm con {n} intervalos = {abs(int_exp - int_pm)}")
    print(f"error absoluto de trapecio con {n} intervalos = {abs(int_exp - int_trap)}")
    print("\n")