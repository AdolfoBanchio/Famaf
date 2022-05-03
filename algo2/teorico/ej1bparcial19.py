def p (a,e):
    ppiv = 0
    i = 0
    j = len(a)-1
    while i <= j:
        if a[i]< e:
            i = i+1
        else:
            if a[j]> e:
                j = j-1
            else:
                if a[i]> e and a[j] < e:
                    aux = a[i]
                    a[i] = a[j]
                    a[j] = aux
    return i

a=[1,4,5,23,6,8]

p(a,0)
