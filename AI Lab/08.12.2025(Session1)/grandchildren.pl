parent('Hasib' , 'Rakib'). parent('Rakib' , 'Sohel'). parent('Rakib' , 'Rebeka').
parent('Rashid' , 'Hasib'). grandchildren(X, Z) :- parent(Y, X), parent(Z, Y).

findGp :- write(' Grandchildren: '), read(X), write('Grandparent: '),
                grandchildren(X, Gp), write(Gp), tab(5), fail.
findGp.
