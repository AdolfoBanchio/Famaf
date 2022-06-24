import string
import numpy as np
import matplotlib.pyplot as plt
fp = "./datos/covid_italia.csv"

data = np.loadtxt(fp,float,usecols=1,delimiter=',')

x = [i for i in range(len(data))]

"""
voy a realizar un ajuste exponencial de la forma y = a.e^bx
para hacer el ajuste lo lleveo a la forma 
ln(y) = ln(a) + b.x  
"""
y_log = np.log(data)

ajust = np.polyfit(x,y_log,1)
y_ajust = np.polyval(ajust,x)
a = np.exp(ajust[1])
b = ajust[0]

exponential = [a*np.exp(b*i) for i in x]


plt.plot(x,data,label="datos orig",marker='o')
plt.plot(x,exponential,label="exponencial")
plt.plot(x,y_ajust,label="ajuste log")
plt.legendw()
plt.grid()
plt.show()