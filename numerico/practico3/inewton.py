from math import prod

def diferencia_divid(x,y):
    grado = len(x)
    c = [[0 for k in range(grado)]for y in range(grado)]
    for k in range(grado):
        c[k][0] = y[k]
    for j in range(1,grado):
        for i in range(grado - j):
            c[i][j] = ((c[i+1][j-1] - c[i][j-1])/(x[i+j]-x[i]))

    return c

def productoria(m,x,z):
    p=1
    for j in range(m):
        p = p *(z - x[j])
    return p

def inewton(x,y,z):
    grado = len(x)
    w = []
    c = diferencia_divid(x,y)[:][0]
    for k in range(len(z)):
        p = 0
        for i in range(grado):
            p = p + c[i]*productoria(i,x,z[k])
        w.append(p)
    return w
"""
x = [0,2,4]
y = [1,5,17]
z = [1,3,5,0]

c = inewton(x,y,z)
print(c)
"""

