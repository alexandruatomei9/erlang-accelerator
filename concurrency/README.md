## REPL for counter_proc module

Keep in mind to call `flush().` in order to see the messages the Shell gets from the counter_proc.

```shell

Pid = counter_proc:start().
```

```shell

Pid = counter_proc:start(10).
```

```shell

Pid ! {get, self()}.
```

```shell

Pid ! {ping, self()}.
```
```shell

Pid ! {inc, 5, self()}.
```

```shell

Pid ! {get, self()}.
```

```shell

Pid ! {inc, a, self()}.
```
```shell

Pid ! {bad, self()}.
```

```shell

counter_proc:stop(Pid).
```