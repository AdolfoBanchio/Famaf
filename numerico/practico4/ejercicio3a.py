import numpy as np
import matplotlib.pyplot as plt 
fp = "./datos/datos3a.dat"

data = np.loadtxt(fp,float)

"""
modelo a ajustar y=C.x^A --> ln(y) = ln(c)+A.ln(y) 
a mis valores x e y aplico el logaritmos y hago el ajuste lineal
"""

x = data[0]
y = data[1]

x_log = np.log(x)
y_log = np.log(y)

coefs_log = np.polyfit(x_log,y_log,1)

coefs_log[1] = np.exp(coefs_log[1])

ajuste = np.polyval(coefs_log,x)

print(coefs_log)