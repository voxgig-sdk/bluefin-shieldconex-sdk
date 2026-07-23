# BluefinShieldconex Lua SDK Reference

Complete API reference for the BluefinShieldconex Lua SDK.


## BluefinShieldconexSDK

### Constructor

```lua
local sdk = require("bluefin-shieldconex_sdk")
local client = sdk.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `table` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `table` | Custom headers for all requests. |
| `options.feature` | `table` | Feature configuration. |
| `options.system` | `table` | System overrides (e.g. custom fetch). |


### Static Methods

#### `sdk.test(testopts?, sdkopts?)`

Create a test client with mock features active. Both arguments are optional.

```lua
local client = sdk.test()
```


### Instance Methods

#### `Detokenize(data)`

Create a new `Detokenize` entity instance. Pass `nil` for no initial data.

#### `Tokenize(data)`

Create a new `Tokenize` entity instance. Pass `nil` for no initial data.

#### `TokenizeBatch(data)`

Create a new `TokenizeBatch` entity instance. Pass `nil` for no initial data.

#### `TokenizeRead(data)`

Create a new `TokenizeRead` entity instance. Pass `nil` for no initial data.

#### `Validate(data)`

Create a new `Validate` entity instance. Pass `nil` for no initial data.

#### `options_map() -> table`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> table, err`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs.params` | `table` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `table` | Query string parameters. |
| `fetchargs.headers` | `table` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (tables are JSON-serialized). |
| `fetchargs.ctrl` | `table` | Control options (e.g. `{ explain = true }`). |

**Returns:** `table, err`

#### `prepare(fetchargs) -> table, err`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `table, err`


---

## DetokenizeEntity

```lua
local detokenize = client:Detokenize(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `table` | No |  |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `name` | `string` | No |  |
| `reference` | `string` | No |  |
| `value` | `table` | No |  |

### Field Usage by Operation

| Field | list | create |
| --- | --- | --- |
| `batch` | - | Yes |
| `bfid` | - | Yes |
| `message_id` | - | - |
| `name` | - | - |
| `reference` | - | - |
| `value` | - | Yes |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Detokenize():create({
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Detokenize():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `DetokenizeEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## TokenizeEntity

```lua
local tokenize = client:Tokenize(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `table` | No |  |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `name` | `string` | No |  |
| `reference` | `string` | No |  |
| `template_ref` | `string` | Yes |  |
| `value` | `table` | No |  |

### Field Usage by Operation

| Field | list | create |
| --- | --- | --- |
| `batch` | - | Yes |
| `bfid` | - | Yes |
| `message_id` | - | - |
| `name` | - | - |
| `reference` | - | - |
| `template_ref` | - | - |
| `value` | - | Yes |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Tokenize():create({
  template_ref = --[[ string ]],
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Tokenize():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `TokenizeEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## TokenizeBatchEntity

```lua
local tokenize_batch = client:TokenizeBatch(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `table` | No |  |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batch` | Yes |
| `message_id` | - |
| `reference` | - |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:TokenizeBatch():create({
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `TokenizeBatchEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## TokenizeReadEntity

```lua
local tokenize_read = client:TokenizeRead(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |
| `state` | `table` | No |  |
| `value` | `table` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `message_id` | - |
| `reference` | - |
| `state` | - |
| `value` | - |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:TokenizeRead():create({
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `TokenizeReadEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ValidateEntity

```lua
local validate = client:Validate(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |
| `template_ref` | `string` | Yes |  |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Validate():create({
  template_ref = --[[ string ]],
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ValidateEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```lua
local client = sdk.new({
  feature = {
    test = { active = true },
  },
})
```

