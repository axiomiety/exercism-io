-module(sum_of_multiples).
-export([sumOfMultiplesDefault/1, sumOfMultiples/2]).

sumOfMultiplesDefault(Num) ->
  sumOfMultiples([3,5], Num).

sumOfMultiples(_, 1) -> 0;
sumOfMultiples(Multiples, Num) ->
  sumOfMultiplesAcc(Multiples, Num-1, []).

sumOfMultiplesAcc(_, 1, Acc) -> lists:sum(Acc);

sumOfMultiplesAcc(Multiples, Num, Acc) ->
  case lists:any(fun(V) -> Num rem V == 0 end, Multiples) of
    true -> sumOfMultiplesAcc(Multiples, Num-1, [Num|Acc]);
    false -> sumOfMultiplesAcc(Multiples, Num-1, Acc)
  end.
