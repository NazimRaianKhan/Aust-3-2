def rebuild_path(tree, node_index):
    path = []

    while node_index is not None:
        node, parent = tree[node_index]
        path.insert(0, node)
        node_index = parent

    return path
