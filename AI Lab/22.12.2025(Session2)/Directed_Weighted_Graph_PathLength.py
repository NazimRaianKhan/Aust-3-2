graph = {
    'i': [('a', 35), ('b', 45)],
    'a': [('c', 22), ('d', 32)],
    'b': [('d', 28), ('e', 36), ('f', 27)],
    'c': [('d', 31), ('g', 47)],
    'd': [('g', 30)],
    'e': [('g', 26)],
    'f': [],
    'g': []
}

def path_length(start, end):
    
    for neighbor, weight in graph.get(start, []):
        if neighbor == end:
            return weight
    
    for neighbor, weight in graph.get(start, []):
        sub_length = path_length(neighbor, end)
        if sub_length is not None:
            return weight + sub_length
    return None

L = path_length('i', 'g')
print("Path length :", L)
