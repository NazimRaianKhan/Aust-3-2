from input_graph import graph, heuristic
from utils import rebuild_path

def a_star(start):
    tree = {0: (start, None)}
    priority_queue = [(start, 0, None, heuristic[start])]
    index_counter = 1

    while priority_queue:
        priority_queue.sort(key=lambda x: x[3])
        node, index, parent, f_val = priority_queue.pop(0)

        if heuristic[node] == 0:
            path = rebuild_path(tree, index)
            return path, f_val

        for (child, cost) in graph[node]:
            g_old = f_val - heuristic[node]
            g_new = g_old + cost
            f_new = g_new + heuristic[child]

            tree[index_counter] = (child, index)
            priority_queue.append(
                (child, index_counter, index, f_new)
            )
            index_counter += 1
