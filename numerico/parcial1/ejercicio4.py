
def rsteffensen (fun,x0,err,mit):
    hx = []
    hf = []
    im_x0= fun(x0) 
    if abs(im_x0)<err:
        hx.append(x0)
        hf.append(im_x0)
        return (hx,hf)
    for k in range (mit):
        xn = x0 - (im_x0**2/(fun(x0 + im_x0)- im_x0)) #modifico la iteracion con la dada en la consigna
        im_x0 = fun(xn)
        hx.append(xn)
        hf.append(im_x0)        
        if abs(im_x0)<err:
            return (hx,hf)
        
        x0 = xn
    return (hx,hf)

