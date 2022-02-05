-module(phone).
-export([number/1, pretty_print/1, areacode/1]).

number(Num) -> 
  CleanNum = lists:filtermap(fun isdigit/1, Num),
  TrimNum = isrightlength(CleanNum),
  case TrimNum of
    false   -> "0000000000";
    _       -> TrimNum
  end.

areacode(Num) -> 
  areacode(Num, []).

% we assume Num is at least of length 4!
areacode(_, Area) when length(Area) =:= 3 ->
  lists:reverse(Area);
areacode([H|T], Area) ->
  areacode(T, [H|Area]).

pretty_print([$1|Num]) when length(Num) =:= 10 ->
  pretty_print(Num);
pretty_print(Num) -> 
  {AreaCode, Tel} = lists:split(3, Num),
  {Tel1, Tel2} = lists:split(3, Tel),
  "(" ++ AreaCode ++ ") " ++ Tel1 ++ "-" ++ Tel2.

% a phone number is 10 digits in length
% if it is 11, the first digit must be a 1
% though the overloading is perhaps little ugly
isrightlength(Num) when length(Num) > 11 ->
  false;
isrightlength([$1|T]) when length(T) =:= 10 ->
  T;
isrightlength([_|T]) when length(T) =:= 10 ->
  false;
isrightlength(Num) when length(Num) < 10 ->
  false;
isrightlength(Num) ->
  Num.

% we only want to capture numerical characters
isdigit(Char) when Char >= $0, Char =< $9 ->
  {true, Char};
isdigit(_) ->
  false.
