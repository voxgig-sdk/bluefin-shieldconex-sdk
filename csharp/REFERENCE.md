# BluefinShieldconex C# SDK Reference

Complete API reference for the BluefinShieldconex C# SDK.


## BluefinShieldconexSDK

### Constructor

```csharp
using BluefinShieldconexSdk;

var client = new BluefinShieldconexSDK(options);
```

Create a new SDK client instance. `options` is a
`Dictionary<string, object?>`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Dictionary` | SDK configuration options. |
| `options["apikey"]` | `string` | API key for authentication. |
| `options["base"]` | `string` | Base URL for API requests. |
| `options["prefix"]` | `string` | URL prefix appended after base. |
| `options["suffix"]` | `string` | URL suffix appended after path. |
| `options["headers"]` | `Dictionary` | Custom headers for all requests. |
| `options["feature"]` | `Dictionary` | Feature configuration. |
| `options["system"]` | `Dictionary` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinShieldconexSDK.TestSDK(testopts = null, sdkopts = null)`

Create a test client with mock features active. Both arguments may be `null`.

```csharp
var client = BluefinShieldconexSDK.TestSDK(null, null);
```


### Instance Methods

#### `Detokenize(entopts = null)`

Create a new `Detokenize` entity instance (returns
`BluefinShieldconexEntityBase`). Pass `null` for no initial options.

#### `Tokenize(entopts = null)`

Create a new `Tokenize` entity instance (returns
`BluefinShieldconexEntityBase`). Pass `null` for no initial options.

#### `TokenizeBatch(entopts = null)`

Create a new `TokenizeBatch` entity instance (returns
`BluefinShieldconexEntityBase`). Pass `null` for no initial options.

#### `TokenizeRead(entopts = null)`

Create a new `TokenizeRead` entity instance (returns
`BluefinShieldconexEntityBase`). Pass `null` for no initial options.

#### `Validate(entopts = null)`

Create a new `Validate` entity instance (returns
`BluefinShieldconexEntityBase`). Pass `null` for no initial options.

#### `OptionsMap() -> Dictionary`

Return a deep copy of the current SDK options.

#### `GetUtility() -> Utility`

Return a copy of the SDK utility object.

#### `Direct(fetchargs = null) -> Dictionary`

Make a direct HTTP request to any API endpoint. Returns a result
`Dictionary<string, object?>` with `ok`, `status`, `headers`, and `data`
(or `err` on failure). This escape hatch never raises — branch on
`result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Dictionary` | Path parameter values. |
| `fetchargs["query"]` | `Dictionary` | Query string parameters. |
| `fetchargs["headers"]` | `Dictionary` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `object?` | Request body (dictionaries are JSON-serialized). |

**Returns:** `Dictionary<string, object?>`

#### `Prepare(fetchargs = null) -> Dictionary`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Detokenize

```csharp
var detokenize = client.Detokenize();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `List<object?>` | No |  |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `name` | `string` | No |  |
| `reference` | `string` | No |  |
| `value` | `List<object?>` | No |  |

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

#### `Create(reqdata, ctrl = null) -> object?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```csharp
var result = client.Detokenize().Create(new Dictionary<string, object?>
{
});
```

#### `List(reqmatch, ctrl = null) -> object?`

List entities matching the given criteria. The match is optional — call `List(null)` to list all records. Returns an aggregate list and raises on error.

```csharp
var results = client.Detokenize().List(null);
Console.WriteLine(results);
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `Detokenize` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## Tokenize

```csharp
var tokenize = client.Tokenize();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `List<object?>` | No |  |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `name` | `string` | No |  |
| `reference` | `string` | No |  |
| `template_ref` | `string` | Yes |  |
| `value` | `List<object?>` | No |  |

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

#### `Create(reqdata, ctrl = null) -> object?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```csharp
var result = client.Tokenize().Create(new Dictionary<string, object?>
{
    ["template_ref"] = "example_template_ref",  // string
});
```

#### `List(reqmatch, ctrl = null) -> object?`

List entities matching the given criteria. The match is optional — call `List(null)` to list all records. Returns an aggregate list and raises on error.

```csharp
var results = client.Tokenize().List(null);
Console.WriteLine(results);
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `Tokenize` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## TokenizeBatch

```csharp
var tokenizeBatch = client.TokenizeBatch();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `List<object?>` | No |  |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batch` | Yes |
| `message_id` | - |
| `reference` | - |

### Operations

#### `Create(reqdata, ctrl = null) -> object?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```csharp
var result = client.TokenizeBatch().Create(new Dictionary<string, object?>
{
});
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `TokenizeBatch` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## TokenizeRead

```csharp
var tokenizeRead = client.TokenizeRead();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |
| `state` | `Dictionary<string, object?>` | No |  |
| `value` | `List<object?>` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `message_id` | - |
| `reference` | - |
| `state` | - |
| `value` | - |

### Operations

#### `Create(reqdata, ctrl = null) -> object?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```csharp
var result = client.TokenizeRead().Create(new Dictionary<string, object?>
{
});
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `TokenizeRead` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## Validate

```csharp
var validate = client.Validate();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |
| `template_ref` | `string` | Yes |  |

### Operations

#### `Create(reqdata, ctrl = null) -> object?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```csharp
var result = client.Validate().Create(new Dictionary<string, object?>
{
    ["template_ref"] = "example_template_ref",  // string
});
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `Validate` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```csharp
var client = new BluefinShieldconexSDK(new Dictionary<string, object?>
{
    ["feature"] = new Dictionary<string, object?>
    {
        ["test"] = new Dictionary<string, object?> { ["active"] = true },
    },
});
```

