from inewton import inewton
import matplotlib.pyplot as plt
def f (x):
    f = 1/x
    return f

x,y,z = [],[],[]
for i in range(1,6):
    x.append(i)
    y.append(f(i))
fy = []
for j in range(1,102):
    yn = 24/25 + j/25
    z.append(yn)
    fy.append(f(yn))

w = inewton(x,y,z)

plt.plot(z,fy,label="1/x")
plt.plot(z,w,label="p(2)")
plt.grid()
plt.legend()
plt.show()
