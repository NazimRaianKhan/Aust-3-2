from input_graph import graph, heuristic
from utils import rebuild_path

def greedy_best_first(start):
    tree = {0: (start, None)}
    priority_queue = [(start, 0, None, heuristic[start])]
    index_counter = 1

    while priority_queue:
        priority_queue.sort(key=lambda x: x[3])
        node, index, parent, h_val = priority_queue.pop(0)

        if heuristic[node] == 0:
            path = rebuild_path(tree, index)
            
            cost = 0
            for i in range(len(path) - 1):
                current_node = path[i]
                next_node = path[i+1]
                
                for neighbor, weight in graph[current_node]:
                    if neighbor == next_node:
                        cost += weight
            
            return path, cost 

        for (child, _) in graph[node]:
            tree[index_counter] = (child, index)
            priority_queue.append(
                (child, index_counter, index, heuristic[child])
            )
            index_counter += 1
