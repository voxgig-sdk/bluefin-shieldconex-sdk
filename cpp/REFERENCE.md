# BluefinShieldconex C++ SDK Reference

Complete API reference for the BluefinShieldconex C++ SDK.


## BluefinShieldconexSDK

### Constructor

```cpp
#include "core/sdk.hpp"

using namespace sdk;

auto client = std::make_shared<BluefinShieldconexSDK>(options);
```

Create a new SDK client instance. `options` is an `sdk::Value` map.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Value` | SDK configuration options (a map). |
| `options["apikey"]` | `std::string` | API key for authentication. |
| `options["base"]` | `std::string` | Base URL for API requests. |
| `options["prefix"]` | `std::string` | URL prefix appended after base. |
| `options["suffix"]` | `std::string` | URL suffix appended after path. |
| `options["headers"]` | `Value` | Custom headers for all requests. |
| `options["feature"]` | `Value` | Feature configuration. |
| `options["system"]` | `Value` | System overrides. |


### Static Methods

#### `BluefinShieldconexSDK::testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be
`Value::undef()`; a no-arg overload is also provided.

```cpp
auto client = BluefinShieldconexSDK::testSDK();
```


### Instance Methods

#### `detokenize(entopts = Value::undef()) -> std::shared_ptr<DetokenizeEntity>`

Create a new `DetokenizeEntity` instance bound to this client.

#### `tokenize(entopts = Value::undef()) -> std::shared_ptr<TokenizeEntity>`

Create a new `TokenizeEntity` instance bound to this client.

#### `tokenize_batch(entopts = Value::undef()) -> std::shared_ptr<TokenizeBatchEntity>`

Create a new `TokenizeBatchEntity` instance bound to this client.

#### `tokenize_read(entopts = Value::undef()) -> std::shared_ptr<TokenizeReadEntity>`

Create a new `TokenizeReadEntity` instance bound to this client.

#### `validate(entopts = Value::undef()) -> std::shared_ptr<ValidateEntity>`

Create a new `ValidateEntity` instance bound to this client.

#### `optionsMap() -> Value`

Return a deep copy of the current SDK options.

#### `getUtility() -> UtilityPtr`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> Value`

Make a direct HTTP request to any API endpoint. Returns a result `Value` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never throws — branch on `getp(result, "ok")`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `std::string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `std::string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Value` | Path parameter values. |
| `fetchargs["query"]` | `Value` | Query string parameters. |
| `fetchargs["headers"]` | `Value` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Value` | Request body (maps are JSON-serialized). |

**Returns:** `Value` (result map)

#### `prepare(fetchargs) -> Value`

Prepare a fetch definition without sending. Returns the `fetchdef` and throws on error.


---

## DetokenizeEntity

```cpp
auto detokenize = client->detokenize();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `std::vector<Value>` | No |  |
| `bfid` | `std::string` | No |  |
| `message_id` | `std::string` | No |  |
| `name` | `std::string` | No |  |
| `reference` | `std::string` | No |  |
| `value` | `std::vector<Value>` | No |  |

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

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->detokenize()->create(vmap({
}), Value::undef());
```

#### `list(reqmatch, ctrl) -> Value`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns a Value list and throws on error.

```cpp
Value results = client->detokenize()->list(Value::undef(), Value::undef());
for (const auto& detokenize : *results.as_list()) {
  std::cout << Struct::jsonify(detokenize) << std::endl;
}
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `DetokenizeEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## TokenizeEntity

```cpp
auto tokenize = client->tokenize();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `std::vector<Value>` | No |  |
| `bfid` | `std::string` | No |  |
| `message_id` | `std::string` | No |  |
| `name` | `std::string` | No |  |
| `reference` | `std::string` | No |  |
| `template_ref` | `std::string` | Yes |  |
| `value` | `std::vector<Value>` | No |  |

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

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->tokenize()->create(vmap({
    {"template_ref", Value("example_template_ref")},  // std::string
}), Value::undef());
```

#### `list(reqmatch, ctrl) -> Value`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns a Value list and throws on error.

```cpp
Value results = client->tokenize()->list(Value::undef(), Value::undef());
for (const auto& tokenize : *results.as_list()) {
  std::cout << Struct::jsonify(tokenize) << std::endl;
}
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `TokenizeEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## TokenizeBatchEntity

```cpp
auto tokenize_batch = client->tokenize_batch();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `std::vector<Value>` | No |  |
| `message_id` | `std::string` | No |  |
| `reference` | `std::string` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batch` | Yes |
| `message_id` | - |
| `reference` | - |

### Operations

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->tokenize_batch()->create(vmap({
}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `TokenizeBatchEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## TokenizeReadEntity

```cpp
auto tokenize_read = client->tokenize_read();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `std::string` | No |  |
| `message_id` | `std::string` | No |  |
| `reference` | `std::string` | No |  |
| `state` | `std::map<std::string, Value>` | No |  |
| `value` | `std::vector<Value>` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `message_id` | - |
| `reference` | - |
| `state` | - |
| `value` | - |

### Operations

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->tokenize_read()->create(vmap({
}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `TokenizeReadEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## ValidateEntity

```cpp
auto validate = client->validate();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `message_id` | `std::string` | No |  |
| `reference` | `std::string` | No |  |
| `template_ref` | `std::string` | Yes |  |

### Operations

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->validate()->create(vmap({
    {"template_ref", Value("example_template_ref")},  // std::string
}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `ValidateEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```cpp
auto client = std::make_shared<BluefinShieldconexSDK>(vmap({
    {"feature", vmap({
        {"test", vmap({{"active", Value(true)}})},
    })},
}));
```

