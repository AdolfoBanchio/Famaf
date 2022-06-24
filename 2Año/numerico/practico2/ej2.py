from math import tan
from numerico.practico2.ej1rbisec import rbisec
#ejercicios 1 y 2

def fun_ej2a(x):
    f = tan(x)-(2*x)
    return f
def fun_ej2b (x):
    f = x**2 - 3
    return f

hx , hf = rbisec(fun_ej2a,[0.8,1.4],1e-5,100)

print(f"La raiz para f(x)= tan(x)-2x \nes x = {hx[len(hx)-1]}")
print(f"f({hx[len(hx)-1]}) = {hf[len(hf)-1]}")
print(f"luego de {len(hx)}iteraciones")

hx2 , hf2 = rbisec(fun_ej2b,[1.1,13],1e-5,30)

print(f"\nLa raiz para f(x)= x^3 - 5 \nes x = {hx2[len(hx2)-1]}")
print(f"f({hx2[len(hx2)-1]}) = {hf2[len(hf2)-1]}")
print(f"luego de {len(hx2)} iteraciones")