# BluefinShieldconex Java SDK Reference

Complete API reference for the BluefinShieldconex Java SDK.


## BluefinShieldconexSDK

### Constructor

```java
BluefinShieldconexSDK client = new BluefinShieldconexSDK(options);
```

Create a new SDK client instance. `options` is a `Map<String, Object>`.

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

```java
BluefinShieldconexSDK client = BluefinShieldconexSDK.testSDK(null, null);
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

#### `optionsMap() -> Map`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> Map`

Make a direct HTTP request to any API endpoint. Returns a result
`Map<String, Object>` with `ok`, `status`, `headers`, and `data` (or
`err` on failure). This escape hatch never raises — branch on
`result.get("ok")`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Map` | Path parameter values. |
| `fetchargs["query"]` | `Map` | Query string parameters. |
| `fetchargs["headers"]` | `Map` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Object` | Request body (maps are JSON-serialized). |

**Returns:** `Map<String, Object>`

#### `prepare(fetchargs) -> Map`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Detokenize

```java
SdkEntity detokenize = client.detokenize(null);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `List<Object>` | No |  |
| `bfid` | `String` | No |  |
| `message_id` | `String` | No |  |
| `name` | `String` | No |  |
| `reference` | `String` | No |  |
| `value` | `List<Object>` | No |  |

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

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```java
Object result = client.detokenize(null).create(Map.of(
), null);
```

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```java
Object results = client.detokenize(null).list(null, null);
System.out.println(results);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Detokenize` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Tokenize

```java
SdkEntity tokenize = client.tokenize(null);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `List<Object>` | No |  |
| `bfid` | `String` | No |  |
| `message_id` | `String` | No |  |
| `name` | `String` | No |  |
| `reference` | `String` | No |  |
| `template_ref` | `String` | Yes |  |
| `value` | `List<Object>` | No |  |

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

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```java
Object result = client.tokenize(null).create(Map.of(
    "template_ref", "example_template_ref"  // String
), null);
```

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```java
Object results = client.tokenize(null).list(null, null);
System.out.println(results);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Tokenize` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## TokenizeBatch

```java
SdkEntity tokenizeBatch = client.tokenizeBatch(null);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `List<Object>` | No |  |
| `message_id` | `String` | No |  |
| `reference` | `String` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batch` | Yes |
| `message_id` | - |
| `reference` | - |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```java
Object result = client.tokenizeBatch(null).create(Map.of(
), null);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `TokenizeBatch` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## TokenizeRead

```java
SdkEntity tokenizeRead = client.tokenizeRead(null);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `String` | No |  |
| `message_id` | `String` | No |  |
| `reference` | `String` | No |  |
| `state` | `Map<String, Object>` | No |  |
| `value` | `List<Object>` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `message_id` | - |
| `reference` | - |
| `state` | - |
| `value` | - |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```java
Object result = client.tokenizeRead(null).create(Map.of(
), null);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `TokenizeRead` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Validate

```java
SdkEntity validate = client.validate(null);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `message_id` | `String` | No |  |
| `reference` | `String` | No |  |
| `template_ref` | `String` | Yes |  |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```java
Object result = client.validate(null).create(Map.of(
    "template_ref", "example_template_ref"  // String
), null);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

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

```java
Map<String, Object> feature = new java.util.LinkedHashMap<>();
feature.put("test", Map.of("active", true));
Map<String, Object> options = new java.util.LinkedHashMap<>();
options.put("feature", feature);
BluefinShieldconexSDK client = new BluefinShieldconexSDK(options);
```

