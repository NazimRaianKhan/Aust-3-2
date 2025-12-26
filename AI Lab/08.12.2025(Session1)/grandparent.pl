parent('Hasib' , 'Rakib'). parent('Rakib' , 'Sohel'). parent('Rakib' , 'Rebeka').
parent('Rashid' , 'Hasib'). grandparent(X, Z) :- parent(X, Y), parent(Y, Z).

/* [Built-in KB is enhanced with the 4 facts and 1 rule; two 2-place predicates;   3 variables;   full stop
      (.) as the end marker of a clause/ sentence / statement;   :- as ‘if’;  comma (,) as logical AND. ] */

/* Procedure to find the grandchildren of X */

findGc :- write(' Grandparent: '), read(X), write('Grandchildren: '),
		grandparent(X, Gc), write(Gc), tab(5), fail.
findGc.
