sum_ap(_, _, 0, 0).

sum_ap(A, D, N, Sum) :-
    N > 0,
    N1 is N - 1,
    sum_ap(A, D, N1, PrevSum),
    Term is A + N1 * D,
    Sum is PrevSum + Term.
