-module(circular_buffer).
-export([create/1, size/1, read/1, write/2, write_attempt/2]).

circular_buffer(Elems, Size) ->
  receive
    {From, size} ->
      From ! {ok, Size},
      circular_buffer(Elems, Size);
    {From, read} ->
      case Elems of
        []    ->  From ! {error, empty},
                  circular_buffer(Elems, Size);
        [H|T] ->  From ! {ok, H},
                  circular_buffer(T, Size)
      end;
    {write, El} ->
      NewElems = circular_write(Elems, Size, El),
      circular_buffer(NewElems, Size);
    {From, write_attempt, El} ->
      case length(Elems) of
        Size  ->  From ! {error, full},
                  circular_buffer(Elems, Size);
        _     ->  From ! ok,
                  NewElems = circular_write(Elems, Size, El),
                  circular_buffer(NewElems, Size)
      end;
    terminate ->
      ok
  end.

% yeah prepending isn't ideal...
circular_write(Elems, Size, El) when length(Elems) < Size ->
  Elems ++ [El];
circular_write([_|T], Size, El) when length(T) =:= Size-1 ->
  T ++ [El].

%%
% public interface

create(Size) ->
  spawn(fun() -> circular_buffer([], Size) end).

size(Buffer) ->
  Buffer ! {self(), size},
  receive
    Resp -> Resp
  end.

read(Buffer) ->
  Buffer ! {self(), read},
  receive
    Resp -> Resp
  end.

write(Buffer, Data) ->
  Buffer ! {write, Data}.

write_attempt(Buffer, Data) ->
  Buffer ! {self(), write_attempt, Data},
  receive
    Resp -> Resp
  end.
