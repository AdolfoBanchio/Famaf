def puntofijo(fun,x0,err,it):
    i = 1
    hx = []
    while i<= it :
        xn = fun(x0)
        hx.append(xn)
        if abs(xn-x0) < err:
            return hx
        i+=1
        x0 = xn
    return hx