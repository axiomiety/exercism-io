-module(grains).
-export([square/1,total/0]).

% note the use of `round` to get around scientific notation/float formatting
square(X) -> round(math:pow(2,X-1)).
total() -> lists:sum([square(S) || S <- lists:seq(1,64)]).
