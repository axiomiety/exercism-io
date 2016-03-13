-module(rna_transcription).
-export([to_rna/1]).

to_rna([Nucleotide]) ->
  complement([Nucleotide]);
to_rna([Nucleotide|Tail]) ->
  complement([Nucleotide]) ++ to_rna(Tail).

complement("G") -> "C";
complement("C") -> "G";
complement("T") -> "A";
complement("A") -> "U".
