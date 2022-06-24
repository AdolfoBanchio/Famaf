from algsecante import rsecante
from ej3rnewton import rnewton

def busqueda_ceros (fun,x0,x1,err,mit):
    
    hxn , hfn = rnewton(fun,x0,err,mit)
    hxs , hfs = rsecante(fun,x0,x1,err,mit)
