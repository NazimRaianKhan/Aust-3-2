gtp=[(1,1,1), (2,1,2), (3,1,3), (4,2,3), (5,3,3), (6,3,2), (7,3,1), (8,2,1)]
gblnk = (2,1)
tp=[(1,1,2), (2,1,3), (3,2,1), (4,2,3), (5,3,3), (6,2,2), (7,3,2), (8,1,1)]
blnk = (3,1)

def calcH():
    L = []
    t = 0
    while(t<len(gtp)):
        distance = abs(gtp[t][1] - tp[t][1]) + abs(gtp[t][2] - tp[t][2])
        L.append(distance)
        t+=1
    return L

def sumList(L):
    
    if L == []:
        return 0
    
    H = L[0]      
    T = L[1:]     
    V1 = sumList(T)
    return V1 + H

def go():
    L = calcH()
    V = sumList(L)
    print("Heuristics:", V)

# Main
go()
