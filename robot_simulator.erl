-module(robot_simulator).

% this will warn us if we don't implement all the required methods
% though it won't fail if we don't - it's just a warning
-behaviour(gen_fsm).

% public API
-export([create/0, place/3, direction/1, position/1,
          left/1, right/1, advance/1, control/2, cmd/2]).

% methods for gen_fsm
-export([init/1, handle_event/3, handle_sync_event/4, terminate/3]).

% FSM - though there's only one state currently : ()
-export([idle/3, idle/2]).

% (L)eft, (R)ight, (A)dvance
-define(VALID_COMMANDS, "LRA").

-record(robot,
        {direction=undefined,
        position={undefined, undefined}
        }).

init(_Args) ->
  State = #robot{},
  {ok, idle, State}.

% stubs, but it works
handle_event(_Event, StateName, StateData) ->
  {next_state, StateName, StateData}.
handle_sync_event(_Event, _From, StateName, StateData) ->
  {reply, ok, StateName, StateData}.
handle_info(_Info, StateName, StateData) ->
  {next_state, StateName, StateData}.
terminate(_Reason, _StateName, _StateData) ->
    ok.

% 'getters'
idle({get_direction}, _From, State) ->
  {reply, State#robot.direction, idle, State};
idle({get_position}, _From, State) ->
  {reply, State#robot.position, idle, State}.

% the set/action methods don't expect a reply
idle({set_position, Position}, State) ->
  {next_state, idle, State#robot{position=Position}};
idle({set_direction, Direction}, State) ->
  {next_state, idle, State#robot{direction=Direction}};
idle({turn, WhichWay}, State) ->
  NewDirection = change_direction(State#robot.direction, WhichWay),
  {next_state, idle, State#robot{direction=NewDirection}};
idle({advance}, State) ->
  NewPosition = move(State#robot.direction, State#robot.position),
  {next_state, idle, State#robot{position=NewPosition}}.

create() ->
  % we could use this to pass arguments to our init function
  Args = [], Options = [],
  % bit of a hack because it makes it simpler to handle the unit tests
  {ok, Pid} = gen_fsm:start_link(?MODULE, Args, Options),
  Pid.

place(Robot, Direction, Position) ->
  % we are not expecting a reply, so we send this async
  gen_fsm:send_event(Robot, {set_direction, Direction}),
  gen_fsm:send_event(Robot, {set_position, Position}).

direction(Robot) ->
  gen_fsm:sync_send_event(Robot, {get_direction}).

position(Robot) ->
  gen_fsm:sync_send_event(Robot, {get_position}).

left(Robot) ->
  gen_fsm:send_event(Robot, {turn, left}).

right(Robot) ->
  gen_fsm:send_event(Robot, {turn, right}).

advance(Robot) ->
  gen_fsm:send_event(Robot, {advance}).

cmd($R, Robot) ->
  right(Robot);
cmd($L, Robot) ->
  left(Robot);
cmd($A, Robot) ->
  advance(Robot).

control(Robot, Commands) ->
  % though we don't need to return a list
  [cmd(C, Robot) || C <- Commands, lists:member(C, ?VALID_COMMANDS)].

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
