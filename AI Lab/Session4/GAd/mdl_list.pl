:-module(mdl_list,
	  [soe/2, nthel/3, rplc_nthel/4, del_el/3,del_1st_n_el/3,
	   del_last_n_el/3]).


% A procedure to find the sum of the elements
soe([],0):-!.
soe([H|T],N):- soe(T,N1), N is N1+H.

% A procedure to find the nth element
nthel(1,[H|_],H):-!.
nthel(N,[_|T],El):- N1 is N-1, nthel(N1,T,El).

% A procedure to replace the nth element
rplc_nthel(1,X,[_|T],[X|T]):-!.
rplc_nthel(N,X,[H|T],L1):- N1 is N-1, rplc_nthel(N1,X,T,L2), L1=[H|L2].

del_el(X,[X|T],T):-!.
del_el(X,[H|T],L1):-del_el(X,T,L2),L1=[H|L2].

del_1st_n_el(L,0,L):-!.
del_1st_n_el([_|T],1,T):-!.
del_1st_n_el(L1,N,L2):- N1 is N-1, L1=[_|T], del_1st_n_el(T,N1,L2).

del_last_n_el(L,N,L1):- reverse(L,Lx),del_1st_n_el(Lx,N,Ly),reverse(Ly,L1).









