parent('Rashid', 'Hasib').
parent('Hasib', 'Rehana'). parent('Hasib', 'Rakib'). parent('Hasib', 'Hasina').
parent('Rakib', 'Sohel'). parent('Rakib', 'Rebeka').
parent('Hasina', 'Rasel'). parent('Hasina', 'Mujib').

male('Rashid').
male('Hasib').
male('Rakib').
male('Sohel').
male('Rasel').
male('Mujib').

grandparent(X,Z) :- parent(X,Y), parent(Y,Z).
grandchildren(X,Z) :- parent(Z,Y), parent(Y,X).
brother(Y,Z) :- parent(X,Y), parent(X,Z), male(Y), not(Y=Z).
sister(Y,Z) :- parent(X,Y), parent(X,Z), not(male(Y)), not(Y=Z).
uncle(Y,Z) :-  parent(X,Z), brother(Y,X).
aunt(Y,Z) :-  parent(X,Z), sister(Y,X).

findGc :- write(' Grandparent: '), read(X), write('Grandchildren: '),
		grandparent(X, Gc), write(Gc), tab(5), fail.
findGc.

findGp :- write(' Grandchildren: '), read(X), write('Grandparent: '),
                grandchildren(X, Gp), write(Gp), tab(5), fail.
findGp.

findBrother :- write(' Sibling: '), read(X), write('Brother: '),
                brother(Bro, X), write(Bro), tab(5), fail.
findBrother.

findSister :- write(' Sibling: '), read(X), write('Sister: '),
                sister(Sis, X), write(Sis), tab(5), fail.
findSister.

findUncle :- write(' Nephew or Niece: '), read(X), write('Uncle: '),
                uncle(Unc, X), write(Unc), tab(5), fail.
findUncle.

findAunt :- write(' Nephew or Niece: '), read(X), write('Aunt: '),
                aunt(A, X), write(A), tab(5), fail.
findAunt.





