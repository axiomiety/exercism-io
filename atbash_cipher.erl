-module(atbash_cipher).
-export([encode/1, decode/1]).

% constants defined as macros - is this right?
-define(DigitsAsString, integer_to_list(1234567890)).
-define(AtBashMap, dict:from_list(lists:zip(lists:seq($a,$z)++?DigitsAsString,
                                  lists:seq($z,$a,-1)++?DigitsAsString))).
-define(ChunkSize, 5).

encode(Cn) ->
  SanitisedInput = re:replace(string:to_lower(Cn), "[^a-z0-9]", "",[global,{return,list}]),
  Trans = lists:map(fun(X) -> encode_single_char(X) end, SanitisedInput),
  string:join(chunkify(Trans), " ").

encode_single_char(C) -> dict:fetch(C,?AtBashMap).

decode(Cn) ->
  % remove spaces!
  SanitisedInput = re:replace(Cn, "\\s+", "", [global, {return,list}]),
  lists:map(fun(X) -> encode_single_char(X) end, SanitisedInput).

% helper fn to split a string in chunks of ?ChunkSize characters
chunkify(L) -> chunkify(L, []).

chunkify(L, Acc) when length(L) =< ?ChunkSize ->
  lists:reverse([L|Acc]);
chunkify(L, Acc) -> 
  {H, T} = lists:split(?ChunkSize, L),
  chunkify(T, [H|Acc]).

