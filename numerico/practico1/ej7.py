def potencian (num,pot):
    aux = 1
    for i in range (1,pot+1):
        aux = aux*num
        print(aux)

print("ingrese un numero")
x = int(input())
potencian(x,5)