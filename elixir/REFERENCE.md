# BluefinShieldconex Elixir SDK Reference

Complete API reference for the BluefinShieldconex Elixir SDK.


## BluefinShieldconex

### Constructor

```elixir
sdk = BluefinShieldconex.new(options)
```

Create a new SDK client. `options` is a struct value node — build one from a
native map with `BluefinShieldconex.Helpers.deep/1`.

**Options:**

| Name | Type | Description |
| --- | --- | --- |
| `apikey` | `String.t()` | API key for authentication. |
| `base` | `String.t()` | Base URL for API requests. |
| `prefix` | `String.t()` | URL prefix appended after base. |
| `suffix` | `String.t()` | URL suffix appended after path. |
| `headers` | `map()` | Custom headers for all requests. |
| `feature` | `map()` | Feature configuration. |
| `system` | `map()` | System overrides (e.g. custom fetch). |


### Constructors

#### `BluefinShieldconex.test(testopts \\ nil, sdkopts \\ nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```elixir
sdk = BluefinShieldconex.test()
```


### Functions

#### `BluefinShieldconex.detokenize(client, entopts \\ nil)`

Create a `BluefinShieldconex.Entity.Detokenize` handle.

#### `BluefinShieldconex.tokenize(client, entopts \\ nil)`

Create a `BluefinShieldconex.Entity.Tokenize` handle.

#### `BluefinShieldconex.tokenize_batch(client, entopts \\ nil)`

Create a `BluefinShieldconex.Entity.TokenizeBatch` handle.

#### `BluefinShieldconex.tokenize_read(client, entopts \\ nil)`

Create a `BluefinShieldconex.Entity.TokenizeRead` handle.

#### `BluefinShieldconex.validate(client, entopts \\ nil)`

Create a `BluefinShieldconex.Entity.Validate` handle.

#### `options_map(client) :: map()`

Return a deep copy of the current SDK options.

#### `get_utility(client) :: map()`

Return the SDK utility node.

#### `direct(client, fetchargs) :: map()`

Make a direct HTTP request to any API endpoint. Returns a result node with
`ok`, `status`, `headers`, and `data` (or `err` on failure). This escape
hatch never raises — branch on `Voxgig.Struct.getprop(result, "ok")`.

**fetchargs keys:**

| Key | Type | Description |
| --- | --- | --- |
| `path` | `String.t()` | URL path with optional `{param}` placeholders. |
| `method` | `String.t()` | HTTP method (default: `"GET"`). |
| `params` | `map()` | Path parameter values. |
| `query` | `map()` | Query string parameters. |
| `headers` | `map()` | Request headers (merged with defaults). |
| `body` | `any()` | Request body (maps are JSON-serialized). |

#### `prepare(client, fetchargs) :: map()`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises
on error.


---

## BluefinShieldconex.Entity.Detokenize

```elixir
detokenize = BluefinShieldconex.detokenize(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `list()` | No |  |
| `bfid` | `String.t()` | No |  |
| `message_id` | `String.t()` | No |  |
| `name` | `String.t()` | No |  |
| `reference` | `String.t()` | No |  |
| `value` | `list()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = BluefinShieldconex.Entity.Detokenize.create(detokenize, BluefinShieldconex.Helpers.deep(%{
}))
```

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = BluefinShieldconex.Entity.Detokenize.list(detokenize)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `BluefinShieldconex.Entity.Detokenize` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## BluefinShieldconex.Entity.Tokenize

```elixir
tokenize = BluefinShieldconex.tokenize(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `list()` | No |  |
| `bfid` | `String.t()` | No |  |
| `message_id` | `String.t()` | No |  |
| `name` | `String.t()` | No |  |
| `reference` | `String.t()` | No |  |
| `template_ref` | `String.t()` | Yes |  |
| `value` | `list()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = BluefinShieldconex.Entity.Tokenize.create(tokenize, BluefinShieldconex.Helpers.deep(%{
  "template_ref" => "example_template_ref",  # String.t()
}))
```

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = BluefinShieldconex.Entity.Tokenize.list(tokenize)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `BluefinShieldconex.Entity.Tokenize` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## BluefinShieldconex.Entity.TokenizeBatch

```elixir
tokenize_batch = BluefinShieldconex.tokenize_batch(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `list()` | No |  |
| `message_id` | `String.t()` | No |  |
| `reference` | `String.t()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = BluefinShieldconex.Entity.TokenizeBatch.create(tokenize_batch, BluefinShieldconex.Helpers.deep(%{
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `BluefinShieldconex.Entity.TokenizeBatch` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## BluefinShieldconex.Entity.TokenizeRead

```elixir
tokenize_read = BluefinShieldconex.tokenize_read(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `String.t()` | No |  |
| `message_id` | `String.t()` | No |  |
| `reference` | `String.t()` | No |  |
| `state` | `map()` | No |  |
| `value` | `list()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = BluefinShieldconex.Entity.TokenizeRead.create(tokenize_read, BluefinShieldconex.Helpers.deep(%{
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `BluefinShieldconex.Entity.TokenizeRead` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## BluefinShieldconex.Entity.Validate

```elixir
validate = BluefinShieldconex.validate(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `message_id` | `String.t()` | No |  |
| `reference` | `String.t()` | No |  |
| `template_ref` | `String.t()` | Yes |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = BluefinShieldconex.Entity.Validate.create(validate, BluefinShieldconex.Helpers.deep(%{
  "template_ref" => "example_template_ref",  # String.t()
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `BluefinShieldconex.Entity.Validate` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```elixir
sdk = BluefinShieldconex.new(BluefinShieldconex.Helpers.deep(%{
  "feature" => %{
    "test" => %{"active" => true},
  }
}))
```

