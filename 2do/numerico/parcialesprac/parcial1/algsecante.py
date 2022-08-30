import math
def raiz2(x):
    f = ((x*(1/math.cos(x)))**2-(2*math.tan(x)))/x**3
    return f

def rsecante (fun,x0,x1,err,mit):
    im_x0 = fun(x0)
    im_x1 = fun(x1)
    hx,hf = [],[]
    for _ in range (2,mit):
        if abs(im_x0) < abs(im_x1):
            x0,x1 = x1,x0
            im_x0,im_x1 = im_x1,im_x0

        sec = (x1 - x0)/(im_x1-im_x0)
        x1 = x0
        im_x1 = im_x0
        x0 = x0 - im_x0*sec
        im_x0 = fun(x0)
        hx.append(x0)
        hf.append(im_x0)
        if abs(im_x0)<err:
            return(hx,hf)
    return(hx,hf)
hx,hf = rsecante(raiz2,0.1,0.5,1e-6,1000)
print("mejor aproximación \n",hx[-1])
print("cantida de aproximaciones \n",len(hx))
