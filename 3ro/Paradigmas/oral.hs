data ArbolBin a = UnNodo a
                | Nodo (ArbolBin a) a (ArbolBin a)
                deriving(Eq, Show)

mapArbolBin :: (a -> b) -> ArbolBin a -> ArbolBin b 
mapArbolBin f (UnNodo a) = UnNodo (f a) 
mapArbolBin f (Nodo izq a der) = Nodo (mapArbolBin f izq) (f a) (mapArbolBin f der)