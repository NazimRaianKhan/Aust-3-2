% Including data files
:-use_module(inputGraph).

:-dynamic(treeNode/4).
:-dynamic(treeNodeIndex/1).
:-dynamic(priorityQueue/1).
:-dynamic(possiblePath/1).

startAStar:- write('Enter start node:'),read(S),h_fn(S,HV),assert(treeNodeIndex(1)),
assert(treeNode(S,0,nil,HV)),assert(priorityQueue([node(S,0,'nil',HV)])),
assert(possiblePath([])), generate, findPathLength(L), displayResult(L).

generate:-priorityQueue([H|_]),H=node(N,I,_,_),h_fn(G,0),N=G, updatePP(N,I),!.
generate:-priorityQueue([H|_]),H=node(N,I,_,_),updateWith(N,I), generate.

updateWith(N,I):-updatePQandTree(N,I), updatePP(N,I).

updatePQandTree(N,I):-priorityQueue(Lst), delFirstElement(Lst,Lst1),
	retract(priorityQueue(_)), assert(priorityQueue(Lst1)), addChildren(N,I).
delFirstElement(Lst,Lst1):-Lst = [_|Lst1].
addChildren(N,I):- neighbor(N,X,D), treeNodeIndex(I1), treeNode(_,I,_,V),
	h_fn(N,V1), h_fn(X,V2), FNV is V+D-V1+V2,
	insertToPQ(X,I1,I,FNV), assert(treeNode(X,I1,I,FNV)),
	increaseIndex, fail.
addChildren(_,_).
insertToPQ(X,I1,I,FNV):- priorityQueue(Lst),insert12PQ(node(X,I1,I,FNV),Lst,Lst1),
	retract(priorityQueue(_)),assert(priorityQueue(Lst1)).
insert12PQ(El,[], [El]):-!.
insert12PQ(El, L1, L2):-L1=[H|_], El=node(_,_,_,V1), H=node(_,_,_,V2),
	not(V1> V2), L2 = [El|L1], !.
insert12PQ(El, L1, L2):-L1=[H|T], insert12PQ(El, T, Lx), L2 = [H|Lx].
increaseIndex:- treeNodeIndex(X), Y is X+1, retract(treeNodeIndex(X)),
	assert(treeNodeIndex(Y)).

updatePP(N,I):- retract(possiblePath(_)), assert(possiblePath([])), renewPP(N,I).
renewPP(N,I):-treeNode(N,I,nil,_), possiblePath(X), append([N],X,X1),
	retract(possiblePath(_)), assert(possiblePath(X1)), !.
renewPP(N,I):- possiblePath(X), append([N],X,X1), retract(possiblePath(_)),
	assert(possiblePath(X1)),treeNode(N,I,I1,_),treeNode(N1,I1,_,_), renewPP(N1,I1).

findPathLength(L):-priorityQueue([H|_]),H=node(_,_,_,L).

% Displaying &#39;shortest&#39; path and its length
displayResult(L):- possiblePath(Lst), write('Solution:'), write(Lst),nl,
write('Length:'), write(L).
