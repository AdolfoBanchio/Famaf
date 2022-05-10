from inewton import inewton
from ilagrange import ilagrange
import matplotlib.pyplot as plt
import math 
from numpy import linspace

def funej4 (x):
    f = 1/(1+25*(x**2))
    return f
def puntosq(i,n):
    x =((2*i +1)/(2*n + 2)) *math.pi
    return x


wpng = []
wqng = []
"""
creo listas para guardar ahi los diferentes xi que voy a usar 
para hacer cada grafico tanto para el polinomio de newton y de lagrange
"""
z = linspace(-1,1,200)
yf = [funej4(x) for x in z]
"""
calculo f(x) en los 200 puntos igualmente espaciados entre 
1 y -1 para el grafico

"""
fig = plt.figure()
axs = []
for n in range (1,16):
    xpn = [ (2*(i-1)/n)-1 for i in range (1,n+2)]
    xqn = [math.cos(puntosq(i,n)) for i in range (0,n)]
    
    ypn = [funej4(x) for x in xpn]
    yqn = [funej4(x) for x in xqn]
    """
    calculo los pares (xi,yi)i=1..n con sus respectivas formulas
    para el polin de newton y lagrange
    """
    wpn = (inewton(xpn,ypn,z))
    wqn = (inewton(xqn,yqn,z))
    """
    calculo el polinomio de newton que interpolan a los pares (xi,yi)i=1..n
    y en wpn y wqn guardo los resultados al ser evaluados en los 200 puntos 
    igualmente espaciados entre 1 y -1 
    """
    wpng.append(wpn)
    wqng.append(wqn)
    axs.append(fig.add_subplot(5,3,n))
    axs[-1].plot(z,wpn,label="p_n")
    axs[-1].plot(z,wqn,label="q_n")    
    axs[-1].plot(z,yf,label="f(x)")
    axs[-1].legend()
    axs[-1].grid(color = "black" ,linestyle="-",linewidth=1)
        
   
"""
fig, ax = plt.subplots(5,3)
l=0
for idx in range(5):
    for idy in range(3):
        ax[idx][idy].plot(z,wpng[idy+l],label="p_n")
        ax[idx][idy].plot(z,wqng[idy+l],label="q_n")    
        ax[idx][idy].plot(z,yf,label="f(x)")
        ax[idx][idy].legend()
        ax[idx][idy].grid(color = "black" ,linestyle="-",linewidth=1)
        
    l = l+3
"""     
fig.show()
plt.show()