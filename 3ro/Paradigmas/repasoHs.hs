--La intención de este documento y sus ejercicios es repasar brevemente algunos
--conceptos del paradigma funcional (en haskell) que sean utiles para luego
--realizar el lab1 como funciones recursivas, declaración de tipos, etc.

--Comenzamos repasando la estructura presente en la definición de una función
--recursiva:

factorial :: Int -> Int              --signatura de la función (declara cantidad
                                     --y tipo de cada input/output de la
                                     --función)
factorial 0 = 1                      --case base (pattern-matching con "0")
factorial n = n * factorial (n-1)    --caso recursivo (pattern-matching con "n")


--Repasemos funciones recursivas sobre listas.  Podemos caracterizar (al menos)
--tres tipos de funciones recursivas sobre listas: "MAP", "FILTER", "FOLD".

--Funciones recursivas del tipo "MAP":
duplica :: [Int] -> [Int]
duplica [] = []
duplica (x : xs) = (2*x) : duplica xs

--Las funciones del tipo "map" consisten en aplicar una función a cada elemento
--de la lista, en el ejemplo de "duplica", la función sería f(x) = 2*x

--Otro ejemplo de función tipo "map" es:
mas1 :: [Int] -> [Int]
mas1 [] = []
mas1 (x : xs) = (x+1) : mas1 xs

--Parece que "duplica" y "mas1" son funciones muy similares.
--Solo se diferencian en la función que aplican a cada elemento de la lista,
--mientras una aplica 2*x, la otra aplica x+1.
--Por lo tanto, surge la pregunta si podemos generalizar la funciones 
--del tipo "map", de forma tal que, "duplica" y "mas1" (e inclusive cualquier otra)
--sean un caso particular de dicha generalizacion.

--Para lograr esto utilizaremos el concepto de "ALTO ORDEN" que consiste en permitir
--que una función pueda tomar como argumento de entrada o de salida una función propiamente dicha.
--Es decir, que una función es un valor posible de nuestro lenguaje tan naturalmente como los es
--un Int, o un Float, o un String, etc. 
 
--Entonces, la función que generaliza puede ser definida tomando como argumento la 
--función que es aplicada a cada elemento de la lista. 

generalMap:: [Int] -> (Int -> Int) ->  [Int]
generalMap [] f = []
generalMap (x:xs) f = f x : generalMap xs f

--Notar que "generalMap" claramente utiliza alto orden.
--Toma una lista de enteros como primer argumento,
--una función como segundo argumento (que toma un entero y devuelve un entero) 
--y devuelve como output una lista de enteros.


--Más aún, podemos generalizar el tipo de la lista [Int]
--a traves del "POLIMORFISMO" que consiste en definir funciones que
--estén bien definidas para cualquier tipo de datos.
--Asi podemos dar una version polimórfica de la función "generalMap" de
--la siguiente manera:

polGeneralMap :: [a] -> (a -> a) -> [a]
polGeneralMap [] f = []
polGeneralMap (x:xs) f = f x : polGeneralMap xs f

--De esta manera, podemos utilizar "polGeneralMap" para realizar cualquier mapeo
--independientemente del tipo de la lista.
--De hecho, podemos dar una versión aún más polimórfica observando que el dominio y la imágen
--de la función de mapeo no necesariamente deben ser del mismo tipo. Es decir:

morePolGeneralMap :: [a] -> (a -> b) -> [b]
morePolGeneralMap [] f = []
morePolGeneralMap (x:xs) f = f x : morePolGeneralMap xs f


--Ejercicio 1: 
--a) redefinir la función "duplica" y "mas1" en términos de "generalMap" y "polGeneralMap".
--b) definir la función esPar:: [Int] -> [Bool] en términos de "morePolGeneralMap". 
--Donde la función "esPar" mapea cada elemento de la lista a un booleano que indica si el mismo es un numero par. 
--Por ejemplo, esPar [2,9,4,5] = [True, False, True,False]. 
--
--
--
--
--

--Funciones recursivas del tipo "FILTER":
soloPares :: [Int] -> [Int]
soloPares [] = []
soloPares (x:xs) | mod x 2 == 0 = x : soloPares xs
                 | mod x 2 /= 0 = soloPares xs
                 
--Las funciones del tipo "filter" consisten en filtrar los elementos que
--satisfacen una cierta condición, en este ejemplo, la condición sería "x es un
--número par".

--Ejercicio 2: 
--a) generalizar la funciones de tipo "FILTER" sobre lista de enteros.
--b) dar una versión polimorfica de la misma.
--c) redefinir la función "soloPares" en términos de dicha generalización.
--
--
--
--                 

--Funciones recursivas del tipo "FOLD":
sumatoria :: [Int] -> Int          
sumatoria [] = 0                  
sumatoria (x:xs) = x + sumatoria (xs)   
                 
--Las funciones del tipo "fold" consisten en "colapsar" los elementos de una
--lista vía una función, en este ejemplo, la función sería f(x,y) = x + y.

--Ejercicio 3: 
--a) generalizar la funciones de tipo "FOLD" sobre lista de enteros.
--b) dar una versión polimorfica de la misma.
--c) redefinir la función "sumatoria" en términos de dicha generalización.
--
--
--
--                 


--Otro concepto interesante del paradigma funcional, es que, podemos definir 
--nuestos propios tipos:

type Radio = Float   --Define un "alias de tipo" (sinónimo)
type Lado = Float

--Vamos a definir 4 figuras
data Figura = Circulo Radio        --Cada uno de estos es un _constructor_
            | Cuadrado Lado        --define el constructor de un "Cuadrado"
            | Rectangulo Lado Lado --define el constructor de un "Rectangulo"
            | Punto                --define el constructor de un "Punto"
              deriving (Eq, Show)
              
--(esta última linea permite hacer que se impriman en pantalla los constructores
--de una Figura, y que se puedan comparar.)

--Y obviamente, podemos definir funciones sobre nuestros propios tipos de datos:

perimetro :: Figura -> Float
perimetro (Circulo radio) = 2 * pi * radio
perimetro (Cuadrado lado) = 4 * lado
perimetro (Rectangulo ancho alto) = 2 * ancho + 2 * alto
perimetro (Punto) = error "no se puede calcular el perimetro del punto"

--Ejercicio 4: definir una función que devuelva la superficie de una "Figura"
--
--
--
--


--Ejercicio 5:

--a) Asi como definimos el tipo "Figura" en el ejercicio anterior, ahora definir
--un tipo "Expr" que permita representar una expresión aritmética sobre enteros
--(sin variables) con nuestros propios operadores :+:, :-:, :*: 
--Por ejemplo: (5 :*: 3) :+: 10 :-: 2 es una "Expr"
--
--

--b)Luego, definir su semántica, i.e., definir una función que evalúa (en forma
--natural) una expresión aritmética "Expr". Por ejemplo: 
--
--evaluar ((5 :*: 3) :+: 10 :-: 2) = 5*3 + 10 - 2 = 23
--
   

--Ejercicio 6:

--a) Definir un tipo "BinTree" que permita representar un arbol binario
--genérico, en cuyos nodos se almacenen valores de un tipo arbitrario.

--b) Definir una función de _folding_ que recorra los elementos del arbol en
--alguna de los tres ordenes posibles (preorder,inorder o posorder).
--Ayuda: devolver una lista con los elementos del arbol en el orden en el que 
--fueron visitados.

--c) Definir una función que devuelva la profundidad de un arbol binario. Luego,
--redefinirla en terminos de una funcion fold que opera sobre arboles binarios.
