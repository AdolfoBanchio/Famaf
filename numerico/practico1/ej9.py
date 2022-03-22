def horn (coefs,x):
    p = 0
    for i in range (len(coefs)-1,-1,-1):
        p = x*p + coefs[i]
    return p 

coefs = [10,8,-6,2,-5,4,2]
x = 1
print("p(",x,") = ",horn(coefs,x))