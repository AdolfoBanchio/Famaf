from ej5pfijo import puntofijo
def fun_lab2ej6 (x):
    f = 2**(x-1)
    return f
x0 = float(input("ingrese un x0 <2 = "))
hx = puntofijo(fun_lab2ej6,x0,1e-5,100)
print("punto fijo con x0<2 \n",hx)
"""
para los x0 tal que x0-1<1 el metodo de PF
converge a el punto fijo 1, para los x0 tq x0-1>= 1 
el metodo no converge
""" 
hx = puntofijo(fun_lab2ej6,2,1e-5,100)
print("punto fijo con x0=2 \n",hx)