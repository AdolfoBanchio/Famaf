import numpy as np
import matplotlib.pyplot as plt 
fp = "./datos/datos3b.dat"

data = np.loadtxt(fp,float)

"""
modelo a ajustar y=x/ax+b --> 1/y = A + B *(1/x) 
a mis valores x e y aplico el logaritmos y hago el ajuste lineal
"""

x = data[0]
y = data[1]

x_inv = [1/i for i in x]
y_inv = [1/i for i in y]

coefs_log = np.polyfit(x_inv,y_inv,1)

ajuste = np.polyval(coefs_log,x)

print(f"A = {coefs_log[1]} B = {coefs_log[0]}")