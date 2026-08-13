# BluefinShieldconex Swift SDK Reference

Complete API reference for the BluefinShieldconex Swift SDK.


## BluefinShieldconexSDK

### Constructor

```swift
let client = BluefinShieldconexSDK(options)
```

Create a new SDK client instance. `options` is a `VMap` of `Value`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `VMap` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `VMap` | Custom headers for all requests. |
| `options["feature"]` | `VMap` | Feature configuration. |
| `options["system"]` | `VMap` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinShieldconexSDK.testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be `nil`.

```swift
let client = BluefinShieldconexSDK.testSDK(nil, nil)
```


### Instance Methods

#### `Detokenize(entopts)`

Create a new `Detokenize` entity instance. Pass `nil` for no initial
options.

#### `Tokenize(entopts)`

Create a new `Tokenize` entity instance. Pass `nil` for no initial
options.

#### `TokenizeBatch(entopts)`

Create a new `TokenizeBatch` entity instance. Pass `nil` for no initial
options.

#### `TokenizeRead(entopts)`

Create a new `TokenizeRead` entity instance. Pass `nil` for no initial
options.

#### `Validate(entopts)`

Create a new `Validate` entity instance. Pass `nil` for no initial
options.

#### `optionsMap() -> VMap`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> VMap`

Make a direct HTTP request to any API endpoint. Returns a result `VMap`
with `ok`, `status`, `headers`, and `data` (or `err` on failure).
This escape hatch never throws — branch on `result.entries["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `VMap` | Path parameter values. |
| `fetchargs["query"]` | `VMap` | Query string parameters. |
| `fetchargs["headers"]` | `VMap` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Value` | Request body (maps are JSON-serialized). |

**Returns:** `VMap`

#### `prepare(fetchargs) throws -> VMap`

Prepare a fetch definition without sending. Returns the `fetchdef` and throws on error.


---

## Detokenize

```swift
let detokenize = client.Detokenize()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batches` | `[Value]` | No |  |
| `bfid` | `String` | No |  |
| `messageId` | `String` | No |  |
| `name` | `String` | No |  |
| `reference` | `String` | No |  |
| `value` | `String` | No |  |
| `values` | `[Value]` | No |  |

### Field Usage by Operation

| Field | list | create |
| --- | --- | --- |
| `batches` | - | Yes |
| `bfid` | - | Yes |
| `messageId` | - | - |
| `name` | - | - |
| `reference` | - | - |
| `value` | - | - |
| `values` | - | Yes |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Detokenize().create(VMap([
]), nil)
```

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.Detokenize().list(nil, nil)
print(results)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Detokenize` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Tokenize

```swift
let tokenize = client.Tokenize()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batches` | `[Value]` | No |  |
| `bfid` | `String` | No |  |
| `messageId` | `String` | No |  |
| `name` | `String` | No |  |
| `reference` | `String` | No |  |
| `templateRef` | `String` | Yes |  |
| `value` | `String` | No |  |
| `values` | `[Value]` | No |  |

### Field Usage by Operation

| Field | list | create |
| --- | --- | --- |
| `batches` | - | Yes |
| `bfid` | - | Yes |
| `messageId` | - | - |
| `name` | - | - |
| `reference` | - | - |
| `templateRef` | - | - |
| `value` | - | - |
| `values` | - | Yes |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Tokenize().create(VMap([
    ("templateRef", .string("example_templateRef"))  // String
]), nil)
```

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.Tokenize().list(nil, nil)
print(results)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Tokenize` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## TokenizeBatch

```swift
let tokenizeBatch = client.TokenizeBatch()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batches` | `[Value]` | No |  |
| `messageId` | `String` | No |  |
| `reference` | `String` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batches` | Yes |
| `messageId` | - |
| `reference` | - |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.TokenizeBatch().create(VMap([
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `TokenizeBatch` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## TokenizeRead

```swift
let tokenizeRead = client.TokenizeRead()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `String` | No |  |
| `messageId` | `String` | No |  |
| `reference` | `String` | No |  |
| `state` | `VMap` | No |  |
| `values` | `[Value]` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `messageId` | - |
| `reference` | - |
| `state` | - |
| `values` | - |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.TokenizeRead().create(VMap([
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `TokenizeRead` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Validate

```swift
let validate = client.Validate()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `messageId` | `String` | No |  |
| `reference` | `String` | No |  |
| `templateRef` | `String` | Yes |  |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Validate().create(VMap([
    ("templateRef", .string("example_templateRef"))  // String
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Validate` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```swift
let feature = VMap()
feature.entries["test"] = .map([("active", .bool(true))])
let options = VMap()
options.entries["feature"] = .map(feature)
let client = BluefinShieldconexSDK(options)
```

