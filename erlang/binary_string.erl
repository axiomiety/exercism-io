-module(binary_string).
-export([to_decimal/1]).

to_decimal(S) ->
  to_decimal(S, 0).

to_decimal([], Acc) ->
  trunc(Acc);
to_decimal([$1|T], Acc) ->
  to_decimal(T, Acc+math:pow(2,length(T)));
to_decimal([$0|T], Acc) ->
  to_decimal(T, Acc).
