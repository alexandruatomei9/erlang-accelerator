-module(key_value_store).
-export([init/0, add/2, update/2, retrieve/1, remove/1, list/0]).

init() ->
  put(store, #{}),
  io:format("Store initialized.~n"),
  ok.

add(Key, Value) ->
  Store = get(store),
  Updated = maps:put(Key, Value, Store),
  put(store, Updated),
  io:format("Added ~p = ~p~n", [Key, Value]),
  ok.

update(Key, Value) ->
  Store = get(store),
  case maps:is_key(Key, Store) of
    true ->
      Updated = maps:put(Key, Value, Store),
      put(store, Updated),
      io:format("Updated ~p = ~p~n", [Key, Value]),
      ok;
    false ->
      io:format("Error: key ~p not found~n", [Key]),
      error
  end.

retrieve(Key) ->
  Store = get(store),
  maps:get(Key, Store, undefined).

remove(Key) ->
  Store = get(store),
  Updated = maps:remove(Key, Store),
  put(store, Updated),
  io:format("Removed ~p~n", [Key]),
  ok.

list() ->
  Store = get(store),
  lists:sort(maps:keys(Store)).