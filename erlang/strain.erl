-module(strain).
-export([keep/2, discard/2]).

keep(Fn, L)     -> tranche(Fn, L, [], true).
discard(Fn, L)  -> tranche(Fn, L, [], false).

tranche(_, [], Acc, _) -> lists:reverse(Acc);
tranche(Fn, [H|T], Acc, Keep) ->
  NotKeep = not Keep,
  case Fn(H) of
    Keep    -> tranche(Fn, T, [H|Acc], Keep);
    NotKeep -> tranche(Fn, T, Acc, Keep)
  end.


