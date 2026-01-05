def sum_ap(a, d, n):
    if n == 0:
        return 0
    
    return sum_ap(a, d, n-1) + (a + (n-1) * d)

print(sum_ap(2, 3, 4))
