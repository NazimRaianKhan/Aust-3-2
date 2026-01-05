def evalState(L):
    hval = 0

    for i in range(8):
        for j in range(i + 1, 8):
            if L[i] == L[j]:
                hval += 1

    for i in range(8):
        for j in range(i + 1, 8):
            if L[j] == L[i] + (j - i):
                hval += 1

    for i in range(8):
        for j in range(i + 1, 8):
            if L[j] == L[i] - (j - i):
                hval += 1

    return hval

state = [6, 1, 5, 7, 4, 3, 8, 1]
print("Heuristic value:", evalState(state))
