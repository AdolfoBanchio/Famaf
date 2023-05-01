data Arbol a = Vacio 
              | Nodo (Arbol a) a (Arbol a)
               deriving (Eq, Show)
{- Funcion fold sobre el arbol -}
foldArbol :: (a -> b -> b -> b) -> b -> Arbol a -> b
foldArbol f acc Vacio = acc
foldArbol f acc (Nodo izq a der) = f a (foldArbol f acc izq) (foldArbol f acc der)

mapArbol :: (a -> b)-> Arbol a -> Arbol b
mapArbol f Vacio = Vacio
mapArbol f (Nodo izq a der) = Nodo (mapArbol f izq) (f a) (mapArbol f der)
