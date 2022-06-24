import scipy.integrate
import numpy as np
import math
def exp(x):
    return np.exp(-1*x**2)


def func2(x):
    return(x**2 * np.log10(x + math.sqrt(x**2 +1)))


print(scipy.integrate.quad(exp,-np.inf,np.inf))

print(scipy.integrate.quad(func2,0,2))