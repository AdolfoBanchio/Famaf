def ilgrange_parcial (x,y,z):
    grado = len(x)
    p = 0
    for i in range(grado):
        l = 1
        for j in range(grado):
            if i != j:
                l = l * ((z - x[j])/(x[i]-x[j]))
        p = p + y[i]*l
    
    return p

def ilagrange (x,y,z):
    w = []
    for i in range(len(z)):
        w.append(ilgrange_parcial(x,y,z[i]))
    return w 

#k = ilagrange([0,2,4],[1,5,17],[1,3])
#print(k)