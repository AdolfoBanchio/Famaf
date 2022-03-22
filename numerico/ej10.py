import random

def sonrecipro(x,y):
    if x*y == 1:
        res = True
    else:
        res = False

    return res
d = sonrecipro(2.0,0.5)
print(d)
for _  in range(100):
    x = 1 + random.random()
    y = 1/x
    if not sonrecipro(x,y):
        print(x)
