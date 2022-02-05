-module(word_count).
-export([count/1]).

count(S) ->
  NewS = normalise(S),
  Tokens = tokenise(NewS),
  count_tokens(Tokens, dict:new()).

normalise(S) ->
  % we only keep alphanumeric characters, spaces and underscores
  % is it cleaner to use regex or do it manually with guards?
  Sanitised = re:replace(S, "[^A-Za-z0-9 _,]", "", [global, {return, list}]),
  string:to_lower(Sanitised).

tokenise(S) ->
  % that's almost too easy...
  string:tokens(S, " _,").

count_tokens([], Dict) ->
  Dict;
count_tokens([H|T], Dict) ->
  NewDict = dict:update(H, fun(Old) -> Old + 1 end, 1, Dict),
  count_tokens(T, NewDict).
