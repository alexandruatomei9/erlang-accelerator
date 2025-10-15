## REPL for key_value_store module

### Initialize the store
```shell

key_value_store:init().
```

### Add key/value pairs

```shell

key_value_store:add(apple, 10).
key_value_store:add(banana, 12).
key_value_store:add(1, 100).
key_value_store:add(-8, 3).
```

### Retrieve values

```shell

key_value_store:retrieve(apple).
key_value_store:retrieve(banana).
key_value_store:retrieve(1).
key_value_store:retrieve(-8).
key_value_store:retrieve(aaa).
```

### Update values
```shell

key_value_store:update(banana, 12).
key_value_store:update(aaa, 100).
```

### Remove a key/value pair
```shell

key_value_store:remove(apple).
key_value_store:remove(aaa).
```

### Retrieve the counter value
```shell

key_value_store:counter_value().
```