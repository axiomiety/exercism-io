-module(anagram).
-export([find/2]).

find(Word, Ln) -> find(Word, Ln, []).

find(_, [], Acc) -> lists:reverse(Acc);
find(Word, [Word|T], Acc) -> find(Word, T, Acc); % same word doesn't count
find(Word, [H|T], Acc) ->
  case isanagram(Word, H) of
    true  -> find(Word, T, [H|Acc]);
    false -> find(Word, T, Acc)
  end.

isanagram(W1, W2) ->
  (lists:sort(string:to_lower(W1)) == lists:sort(string:to_lower(W2))) and (string:to_lower(W1) /= string:to_lower(W2)).
