# BluefinShieldconex Golang SDK Reference

Complete API reference for the BluefinShieldconex Golang SDK.


## BluefinShieldconexSDK

### Constructor

```go
func NewBluefinShieldconexSDK(options map[string]any) *BluefinShieldconexSDK
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `map[string]any` | SDK configuration options. |
| `options["apikey"]` | `string` | API key for authentication. |
| `options["base"]` | `string` | Base URL for API requests. |
| `options["prefix"]` | `string` | URL prefix appended after base. |
| `options["suffix"]` | `string` | URL suffix appended after path. |
| `options["headers"]` | `map[string]any` | Custom headers for all requests. |
| `options["feature"]` | `map[string]any` | Feature configuration. |
| `options["system"]` | `map[string]any` | System overrides (e.g. custom fetch). |


### Static Methods

#### `Test() *BluefinShieldconexSDK`

No-arg convenience constructor for the common no-options test case.

```go
client := sdk.Test()
```

#### `TestSDK(testopts, sdkopts map[string]any) *BluefinShieldconexSDK`

Test client with options. Both arguments may be `nil`.

```go
client := sdk.TestSDK(testopts, sdkopts)
```


### Instance Methods

#### `Detokenize(data map[string]any) BluefinShieldconexEntity`

Create a new `Detokenize` entity instance. Pass `nil` for no initial data.

#### `Tokenize(data map[string]any) BluefinShieldconexEntity`

Create a new `Tokenize` entity instance. Pass `nil` for no initial data.

#### `TokenizeBatch(data map[string]any) BluefinShieldconexEntity`

Create a new `TokenizeBatch` entity instance. Pass `nil` for no initial data.

#### `TokenizeRead(data map[string]any) BluefinShieldconexEntity`

Create a new `TokenizeRead` entity instance. Pass `nil` for no initial data.

#### `Validate(data map[string]any) BluefinShieldconexEntity`

Create a new `Validate` entity instance. Pass `nil` for no initial data.

#### `OptionsMap() map[string]any`

Return a deep copy of the current SDK options.

#### `GetUtility() *Utility`

Return a copy of the SDK utility object.

#### `Direct(fetchargs map[string]any) (map[string]any, error)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `map[string]any` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `map[string]any` | Query string parameters. |
| `fetchargs["headers"]` | `map[string]any` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (maps are JSON-serialized). |
| `fetchargs["ctrl"]` | `map[string]any` | Control options (e.g. `map[string]any{"explain": true}`). |

**Returns:** `(map[string]any, error)`

#### `Prepare(fetchargs map[string]any) (map[string]any, error)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `Direct()`.

**Returns:** `(map[string]any, error)`


---

## DetokenizeEntity

```go
detokenize := client.Detokenize(nil)
fmt.Println(detokenize.GetName()) // "detokenize"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `[]any` | No |  |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `name` | `string` | No |  |
| `reference` | `string` | No |  |
| `value` | `[]any` | No |  |

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

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Detokenize(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.Detokenize(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `DetokenizeEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## TokenizeEntity

```go
tokenize := client.Tokenize(nil)
fmt.Println(tokenize.GetName()) // "tokenize"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `[]any` | No |  |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `name` | `string` | No |  |
| `reference` | `string` | No |  |
| `template_ref` | `string` | Yes |  |
| `value` | `[]any` | No |  |

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

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Tokenize(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.Tokenize(nil).Create(map[string]any{
    "template_ref": "example_template_ref",
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `TokenizeEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## TokenizeBatchEntity

```go
tokenizeBatch := client.TokenizeBatch(nil)
fmt.Println(tokenizeBatch.GetName()) // "tokenize_batch"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `[]any` | No |  |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batch` | Yes |
| `message_id` | - |
| `reference` | - |

### Operations

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.TokenizeBatch(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `TokenizeBatchEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## TokenizeReadEntity

```go
tokenizeRead := client.TokenizeRead(nil)
fmt.Println(tokenizeRead.GetName()) // "tokenize_read"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |
| `state` | `map[string]any` | No |  |
| `value` | `[]any` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `message_id` | - |
| `reference` | - |
| `state` | - |
| `value` | - |

### Operations

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.TokenizeRead(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `TokenizeReadEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ValidateEntity

```go
validate := client.Validate(nil)
fmt.Println(validate.GetName()) // "validate"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |
| `template_ref` | `string` | Yes |  |

### Operations

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.Validate(nil).Create(map[string]any{
    "template_ref": "example_template_ref",
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ValidateEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```go
client := sdk.NewBluefinShieldconexSDK(map[string]any{
    "feature": map[string]any{
        "test": map[string]any{"active": true},
    },
})
```

