-module(anagram).
-export([find/2]).

find(Word, Ln) -> lists:filter(fun(W) -> isanagram(Word, W) end, Ln).

isanagram(W1, W2) ->
  (lists:sort(string:to_lower(W1)) == lists:sort(string:to_lower(W2))) and (string:to_lower(W1) /= string:to_lower(W2)).
