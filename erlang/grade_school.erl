-module(grade_school).
-export([new/0,add/3,get/2,sort/1]).

new() ->
 orddict:new().

add(Name, Class, School) ->
  orddict:append(Class, Name, School).

get(Class, School) ->
  case orddict:find(Class, School) of
    {ok, Students} -> lists:sort(Students);
    error -> []
  end.

sort(School) ->
  orddict:map(fun(_K,V) -> lists:sort(V) end, School).
