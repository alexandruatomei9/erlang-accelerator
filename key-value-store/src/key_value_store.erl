-module(key_value_store).
-export([init/0, add/2, update/2, retrieve/1, remove/1, list/0, counter_value/0]).

init() ->
  put(store, #{}),
  Counter = atomics:new(1, []),
  atomics:put(Counter, 1, 0),
  put(store_counter, Counter),
  io:format("Store initialized.~n"),
  ok.

increment_counter() ->
  Counter = get(store_counter),
  atomics:add_get(Counter, 1, 1).

add(Key, Value) ->
  Store = get(store),
  Updated = maps:put(Key, Value, Store),
  put(store, Updated),
  increment_counter(),
  io:format("Added ~p = ~p~n", [Key, Value]),
  ok.

update(Key, Value) ->
  Store = get(store),
  case maps:is_key(Key, Store) of
    true ->
      Updated = maps:put(Key, Value, Store),
      put(store, Updated),
      increment_counter(),
      io:format("Updated ~p = ~p~n", [Key, Value]),
      ok;
    false ->
      io:format("Error: key ~p not found~n", [Key]),
      error
  end.

retrieve(Key) ->
  Store = get(store),
  case maps:is_key(Key, Store) of
    true ->
      increment_counter(),
      maps:get(Key, Store, undefined),
      ok;
    false ->
      io:format("Error: key ~p not found~n", [Key]),
      error
  end.

remove(Key) ->
  Store = get(store),
  case maps:is_key(Key, Store) of
    true ->
      Updated = maps:remove(Key, Store),
      put(store, Updated),
      increment_counter(),
      io:format("Removed ~p~n", [Key]),
      ok;
    false ->
      io:format("Error: key ~p not found~n", [Key]),
      error
  end.

list() ->
  Store = get(store),
  increment_counter(),
  lists:sort(maps:keys(Store)).

counter_value() ->
  Counter = get(store_counter),
  atomics:get(Counter, 1).