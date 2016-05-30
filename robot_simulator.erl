-module(robot_simulator).
-export([create/0, place/3, direction/1, position/1,
          left/1, right/1, advance/1, control/2]).


-record(robot,
        {direction=undefined,
        position={undefined, undefined}
        }).

loop(Robot) ->
  receive
    {From, get_direction} ->
      From ! Robot#robot.direction,
      loop(Robot);
    {From, get_position} ->
      From ! Robot#robot.position,
      loop(Robot);
    {set_direction, Direction} -> 
      NewRobot = Robot#robot{direction=Direction},
      loop(NewRobot);
    {set_position, Position} -> 
      NewRobot = Robot#robot{position=Position},
      loop(NewRobot);
    {advance} ->
      NewPosition = move(Robot#robot.direction, Robot#robot.position),
      NewRobot = Robot#robot{position=NewPosition},
      loop(NewRobot);
    terminate ->
      ok
  end.

create() ->
  Robot = #robot{},
  spawn(fun() -> loop(Robot) end).

place(Robot, Direction, Position) ->
  Robot ! {set_direction, Direction},
  Robot ! {set_position, Position}.

direction(Robot) ->
  Robot ! {self(), get_direction},
  receive
    Resp -> Resp
  end.

position(Robot) ->
  Robot ! {self(), get_position},
  receive
    Resp -> Resp
  end.

left(Robot) ->
  CurrentDirection = direction(Robot),
  NewDirection = change_direction(CurrentDirection, left),
  Robot ! {set_direction, NewDirection}.

right(Robot) ->
  CurrentDirection = direction(Robot),
  NewDirection = change_direction(CurrentDirection, right),
  Robot ! {set_direction, NewDirection}.

advance(Robot) ->
  Robot ! {advance}.

control(Robot, []) ->
  Robot;
control(Robot, [$R|T]) ->
  right(Robot),
  control(Robot, T);
control(Robot, [$L|T]) ->
  left(Robot),
  control(Robot, T);
control(Robot, [$A|T]) ->
  advance(Robot),
  control(Robot, T);
control(Robot, [_|T]) ->
  control(Robot, T).

change_direction(north, left)   -> west;
change_direction(north, right)  -> east;
change_direction(west, left)    -> south;
change_direction(west, right)   -> north;
change_direction(south, left)   -> east;
change_direction(south, right)  -> west;
change_direction(east, left)    -> north;
change_direction(east, right)   -> south.

move(north, {X, Y}) -> {X, Y+1};
move(west, {X, Y})  -> {X-1, Y};
move(south, {X, Y}) -> {X, Y-1};
move(east, {X, Y})  -> {X+1, Y}.
