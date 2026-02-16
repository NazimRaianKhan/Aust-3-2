:-use_module(symptoms).

go:- write('\nEnter the name of the patient:'),
	read(Patient), hypothesis(Patient, Disease), nl,
	write(Patient), write(' probably has '), write(Disease), write('.'),!.

go:- write('\nSorry, I think, I am not competent enough '), nl,
	write('to diagnose the disease.').


hypothesis(Patient, flu):-
	symptom(Patient, headache), symptom(Patient, fever),
	symptom(Patient, runny_nose).

hypothesis(Patient, common_cold):-
	symptom(Patient, sneezing),
	symptom(Patient, runny_nose).




