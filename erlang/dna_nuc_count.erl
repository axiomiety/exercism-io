-module(dna).
-export([count/2, nucleotide_counts/1]).

count(Strand, "A") -> length(lists:filter(fun(X) -> X == $A end, Strand));
count(Strand, "C") -> length(lists:filter(fun(X) -> X == $C end, Strand));
count(Strand, "G") -> length(lists:filter(fun(X) -> X == $G end, Strand));
count(Strand, "T") -> length(lists:filter(fun(X) -> X == $T end, Strand));
count(_, _) -> erlang:error("Invalid nucleotide").

nucleotide_counts(Strand) ->
  Nucleotides = ["A","T","C","G"],
  lists:zip(Nucleotides, [dna:count(Strand, N) || N <- Nucleotides]).
