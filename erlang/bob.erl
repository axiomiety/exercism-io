-module(bob).
-export([response_for/1,is_re_match/1]).

response_for("") -> "Fine. Be that way!";
response_for(Something) ->
  % yell means there's at least one alpha character
  Q = lists:last(Something) =:= $?,
  Y = (string:to_upper(Something) == Something) andalso is_re_match(re:run(Something, "[A-Z]+")),
  E = is_re_match(re:run(Something, "^\s+$")),
  if
    % yell > question
    Y -> "Whoa, chill out!"; 
    Q -> "Sure.";
    E -> "Fine. Be that way!";
    true -> "Whatever."
  end.

is_re_match({match,_}) -> true;
is_re_match(_) -> false.
