-module(counter_proc).
-export([start/0, start/1, stop/1]).

start() ->
  Pid = spawn(fun() -> loop(0) end),
  io:format("State initialized with value 0. PID: ~p.~n", [Pid]),
  Pid.

start(Initial_value) ->
  Pid = spawn(fun() -> loop(Initial_value) end),
  io:format("State initialized with value ~p. PID: ~p.~n", [Initial_value, Pid]),
  Pid.

stop(Pid) ->
  io:format("Sending stop message to ~p. ~n", [Pid]),
  Pid ! {stop, self()},
  ok.

%%Accepted messages (from any process):
%%- ping -> reply pong to the sender.
%%- {inc, N} where N is integer (allow negative) -> update state State + N, reply ok.
%%- get -> reply {ok, State} to the sender.
%%- stop → reply stopped then terminate gracefully.
%%- Unexpected messages -> ignore and reply {error, unsupported}.

loop(State) ->
  receive
    {ping, From} ->
      From ! pong,
      loop(State);
    {inc, N, From} when is_integer(N) ->
      NewState = State + N,
      From ! ok,
      loop(NewState);
    {inc, _, From} ->
      From ! {error, badarg},
      loop(State);
    {get, From} ->
      From ! {ok, State},
      loop(State);
    {stop, From} ->
      From ! stopped,
      io:format("Counter process ~p stopping gracefully with final value ~p~n", [self(), State]),
      ok;
    {_, From} ->
      From ! {error, unsupported},
      loop(State)
  end.