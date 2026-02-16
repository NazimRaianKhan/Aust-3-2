:-use_module(eval_state).
:-use_module(mdl_list).
:-use_module(write_list).
:-dynamic(state/4). /* id,type,state,h_value*/
:-dynamic(id1/1).
:-dynamic(max_val/1).
:-dynamic(threshold/1).
:-dynamic(fitness/1).
:-dynamic(itrn_cntr/1).
:-dynamic(intl_sts/1).

/* Organizing a Menu */
start:- repeat,
	write('\n1. Clear database'),
	write('\n2. Load initial population'),
	write('\n3. Execute gntic_alg'),
	write('\n4. Display states'),
	write('\n5. Save states'),
	write('\n6. Exit'),
	write('\n\nEnter your choice: '),
	read(N), N >0, N < 7,
	do(N), N=6,!.

do(1):- retractall(state(_,_,_,_)),retractall(id1(_)), retractall(max_val(_)),
	retractall(threshold(_)), retractall(fitness(_)),
	retractall(itrn_cntr(_)), retractall(intl_sts(_)).
do(2):- consult('intl_states.pl'),!.
do(3):- go_galg.
do(4):- listing(state).
do(5):- write('Enter a new file name:'), read(Flnm),
	tell(Flnm),listing(state),told.
do(6):- abort.

/* Beginning of search */
go_galg:- gen_i_sts, write('\nEnter Fitness value:'), read(F),
	  assert(fitness(F)), write('\nEnter threshold value:'),
	  read(V),assert(threshold(V)), assert(itrn_cntr(0)), go_srch.

/* Generating initial states */
gen_i_sts:- assert(id1(0)), lst_sts, retract(id1(_)).

lst_sts:-intl_sts(S), get_index(N),getdigits(S,D1,D2,D3,D4,D5,D6,D7,D8),
	L=[D1,D2,D3,D4,D5,D6,D7,D8], assert(state(N,'n',L,50)), fail.
lst_sts:- !.

get_index(N):- incr_id1, id1(N),!.

incr_id1:- id1(V), V1 is V+1, retract(id1(_)),
	assert(id1(V1)).

/*  Evaluation and selection */
go_srch:- eval_all, check.

eval_all:- state(I,T,L,_), eval(L,V),retract(state(I,_,_,_)),
	assert(state(I,T,L,V)), fail.
eval_all:-!.

check:- best1(I1,V1), fitness(V2), V1 >= V2, dsply(I1),!.
check:- best1(I,V), write_list(['\nIteration max: ',V,' Id: ',I ]),
	restrt.

restrt:- itrn_cntr(V), V>2,write('\n\nNot found! Ending.\n\n'),
	 retract(itrn_cntr(_)),!.
restrt:- write('\n\nTrying again!\n\n'), go_anew.

/* Determining and displaying the best state */
best1(I,Max):- state(_,_,_,Val), assert(max_val(Val)),
	updt_max, max_val(Max), state(I,_,_,Max), retract(max_val(_)),!.

updt_max:- state(_,_,_,V2),  max_val(V1), V2>V1,
	retract(max_val(_)), assert(max_val(V2)), fail.
updt_max:-!.

dsply(I):-state(I,T,L,V),
	write_list(['\n\nFound! Id:',I,'  ',T,'	 ', L,'	 ','Value:',V,'\n']),!.

/* New cycle, incomplete */
go_anew:- incr_i_c, mk_p_gen, reindex, crs_over, mutn, retype, go_srch.

incr_i_c:- itrn_cntr(V), V1 is V+1, retract(itrn_cntr(_)),
	assert(itrn_cntr(V1)).

mk_p_gen:- state(I,_,_,V), threshold(V1), V<V1, retract(state(I,_,_,_)), fail.
mk_p_gen:-!.

reindex:- assert(id1(0)),change_ind, retract(id1(_)).

change_ind:- state(I,'n',L,V), retract(state(I,'n',L,V)), get_index(N),
	assert(state(N,'p',L,V)),fail.
change_ind:-!.

/* Performing Crossover */
crs_over:- count_sts(_,N),N>1, N1 is N div 2,
	write_list(['\n',N1,' crossovers possible!']), cross(N,N1), !.
crs_over:- write('\nCrossover not possible!'),!.

cross(_,0):-!.
cross(N,N1):- N2 is N-1, X is random(N2)+1, Y is random(N2)+1,
	CP is random(7)+1, go_cross(X,Y,CP), chk_cont(N1,N3), cross(N,N3).

go_cross(X,Y,CP):- state(X,'p',L1,_), state(Y,'p',L2,_),CP1 is 8-CP,
	del_1st_n_el(L1,CP,L12),del_last_n_el(L1,CP1,L11),
	del_1st_n_el(L2,CP,L22),del_last_n_el(L2,CP1,L21),
	append(L11,L22,LO1),append(L21,L12,LO2), count_sts(_,N),
	N1 is N+1, N2 is N+2,
	assert(state(N1,'o',LO1,50)), assert(state(N2,'o',LO2,50)),
	write('\nOne crossover executed!'),!.

chk_cont(N1,N3):- write('\nContinue?(y/n) :'),
	read(X), X='y', N3 is N1-1, !.
chk_cont(_,N3):- N3 is 0,!.

/* Mutation */
mutn:- cont_mutn(N), N>0, do_mutn,!.
mutn:-!.

cont_mutn(N):- write('\nExecute a mutation?(y/n) :'),
	read(X), X='y', N is 1, !.
cont_mutn(N):- N is 0,!.

do_mutn:- count_sts('o',N), N1 is random(N)+1,
	assert(id1(0)),get_offspr(N1,I,T,L,V), retract(id1(_)),
	N2 is random(8)+1, N3 is random(8)+1, rplc_nthel(N2,N3,L,L1),
	retract(state(I,T,L,V)), assert(state(I,T,L1,50)),
	write_list(['\nMutated:',I,T,L,V]),
	write_list(['\nNew:',L1,N]),!.

get_offspr(N1,I,'o',L,V):- state(I,'o',L,V),incr_id1, id1(N), N1=N,!.


/* Making new population */
retype:- state(I,_,L,V), retract(state(I,_,L,V)),
	assert(state(I,'n',L,V)), fail.
retype:-!.

/* Counting  states */
count_sts(T,N):- assert(id1(0)),set_n_o_s(T), id1(N),retract(id1(N)).

set_n_o_s(T):- state(_,T,_,_), incr_id1, fail.
set_n_o_s(_):-!.





