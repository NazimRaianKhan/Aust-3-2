gtp(1,1,1). gtp(2,1,2). gtp(3,1,3). gtp(4,2,3). gtp(5,3,3). gtp(6,3,2). gtp(7,3,1). gtp(8,2,1). gblnk(2,2).
tp(1,1,2). tp(2,1,3). tp(3,2,1). tp(4,2,3). tp(5,3,3). tp(6,2,2). tp(7,3,2).
tp(8,1,1). blnk(3,1).

go:- calcTH(1,0,H), write('Heuristic: '), write(H).

calcTH(9,X,X):-!.
calcTH(T,X,Y):- checkT(T,V), X1 is X+V, T1 is T+1, calcTH(T1,X1,Y).

checkT(T,V):- gtp(T,A,B), tp(T,C,D), A=C, B=D, V is 0,!.
checkT(_,1):-!.
