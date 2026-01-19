from gbfs import greedy_best_first
from astar import a_star

print("1. Greedy Best-First Search")
print("2. A* Search")

choice = int(input("Choose algorithm (1 or 2): "))
start = input("Enter start node: ")

if choice == 1:
    path, cost = greedy_best_first(start)
    print("\nGreedy Best-First Search Result")

elif choice == 2:
    path, cost = a_star(start)
    print("\nA* Search Result")

else:
    print("Invalid choice")
    exit()

print("Solution Path:", path)
print("Path Length:", cost)
