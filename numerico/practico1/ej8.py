#resolucion de ecuaciones de segundo grado
import math
#print("ingrese los coeficientes a b c \n para resolver ax^2+bx+c=")
#print("a = ")
#a = int(input())
#print("b = ")
#b = int(input())
#print("c = ")
#c = int(input())

def mala (a ,b ,c):
    if (((b**2) -4*a*c)>= 0):
        x1 = ((-b) + math.sqrt((b**2) -4*a*c))/(2*a)
        x2 = ((-b) - math.sqrt((b**2) -4*a*c))/(2*a)
    else:
        x1 = "discriminante negativo"
        x2 = "discriminante negativo"
    return[x1 , x2]

def buena (a,b,c):
    if (((b**2) -4*a*c)>= 0):    
        if b>=0 :
            x2 = ((-b) - math.sqrt((b**2) -4*a*c))/(2*a)
            x1 = c/(x2*a)
        else:
            x1 = ((-b) + math.sqrt((b**2) -4*a*c))/(2*a)
            x2 = c/(x1*a)
    else:
        x1 = "discriminante negativo"
        x2 = "discriminante negativo"
    return[x1 , x2]
a = 1
b = 10**8
c = 1
raicesbaskhara = mala(a,b,c) 
raicesbuenas = buena(a,b,c)
print("raices baskhara",raicesbaskhara)

print("raices buenas",raicesbuenas)