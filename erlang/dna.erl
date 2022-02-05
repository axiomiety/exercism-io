-module(dna).
-export([hamming_distance/2]).

hamming_distance(A,B) -> hamming_distance(A,B,0).

hamming_distance([], [], Sum) -> Sum;
hamming_distance([H|T1],[H|T2], Sum) -> hamming_distance(T1, T2, Sum);
hamming_distance([_H1|T1],[_H2|T2], Sum) -> hamming_distance(T1, T2, Sum+1).
