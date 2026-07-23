# BluefinShieldconex Kotlin SDK Reference

Complete API reference for the BluefinShieldconex Kotlin SDK.


## BluefinShieldconexSDK

### Constructor

```kotlin
val client = BluefinShieldconexSDK(options)
```

Create a new SDK client instance. `options` is a `MutableMap<String, Any?>`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Map` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Map` | Custom headers for all requests. |
| `options["feature"]` | `Map` | Feature configuration. |
| `options["system"]` | `Map` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinShieldconexSDK.testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be `null`.

```kotlin
val client = BluefinShieldconexSDK.testSDK(null, null)
```


### Instance Methods

#### `detokenize(entopts)`

Create a new `Detokenize` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `tokenize(entopts)`

Create a new `Tokenize` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `tokenizeBatch(entopts)`

Create a new `TokenizeBatch` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `tokenizeRead(entopts)`

Create a new `TokenizeRead` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `validate(entopts)`

Create a new `Validate` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `optionsMap() -> MutableMap`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> MutableMap`

Make a direct HTTP request to any API endpoint. Returns a result
`MutableMap<String, Any?>` with `ok`, `status`, `headers`, and `data`
(or `err` on failure). This escape hatch never raises — branch on
`result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Map` | Path parameter values. |
| `fetchargs["query"]` | `Map` | Query string parameters. |
| `fetchargs["headers"]` | `Map` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Any?` | Request body (maps are JSON-serialized). |

**Returns:** `MutableMap<String, Any?>`

#### `prepare(fetchargs) -> MutableMap`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Detokenize

```kotlin
val detokenize = client.detokenize(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `List<Any?>?` | No |  |
| `bfid` | `String?` | No |  |
| `message_id` | `String?` | No |  |
| `name` | `String?` | No |  |
| `reference` | `String?` | No |  |
| `value` | `List<Any?>?` | No |  |

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

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.detokenize(null).create(mutableMapOf<String, Any?>(
), null)
```

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```kotlin
val results = client.detokenize(null).list(null, null)
println(results)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Detokenize` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Tokenize

```kotlin
val tokenize = client.tokenize(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `List<Any?>?` | No |  |
| `bfid` | `String?` | No |  |
| `message_id` | `String?` | No |  |
| `name` | `String?` | No |  |
| `reference` | `String?` | No |  |
| `template_ref` | `String?` | Yes |  |
| `value` | `List<Any?>?` | No |  |

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

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.tokenize(null).create(mutableMapOf<String, Any?>(
    "template_ref" to "example_template_ref"  // String?
), null)
```

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```kotlin
val results = client.tokenize(null).list(null, null)
println(results)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Tokenize` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## TokenizeBatch

```kotlin
val tokenizeBatch = client.tokenizeBatch(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `List<Any?>?` | No |  |
| `message_id` | `String?` | No |  |
| `reference` | `String?` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batch` | Yes |
| `message_id` | - |
| `reference` | - |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.tokenizeBatch(null).create(mutableMapOf<String, Any?>(
), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `TokenizeBatch` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## TokenizeRead

```kotlin
val tokenizeRead = client.tokenizeRead(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `String?` | No |  |
| `message_id` | `String?` | No |  |
| `reference` | `String?` | No |  |
| `state` | `Map<String, Any?>?` | No |  |
| `value` | `List<Any?>?` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `message_id` | - |
| `reference` | - |
| `state` | - |
| `value` | - |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.tokenizeRead(null).create(mutableMapOf<String, Any?>(
), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `TokenizeRead` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Validate

```kotlin
val validate = client.validate(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `message_id` | `String?` | No |  |
| `reference` | `String?` | No |  |
| `template_ref` | `String?` | Yes |  |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.validate(null).create(mutableMapOf<String, Any?>(
    "template_ref" to "example_template_ref"  // String?
), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Validate` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```kotlin
val feature = mutableMapOf<String, Any?>(
    "test" to mapOf("active" to true),
)
val client = BluefinShieldconexSDK(mutableMapOf<String, Any?>("feature" to feature))
```

