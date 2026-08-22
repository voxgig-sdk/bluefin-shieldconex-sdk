# BluefinShieldconex Python SDK Reference

Complete API reference for the BluefinShieldconex Python SDK.


## BluefinShieldconexSDK

### Constructor

```python
from bluefinshieldconex_sdk import BluefinShieldconexSDK

client = BluefinShieldconexSDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["apikey"]` | `str` | API key for authentication. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinShieldconexSDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = BluefinShieldconexSDK.test()
```


### Instance Methods

#### `Detokenize(data=None)`

Create a new `DetokenizeEntity` instance. Pass `None` for no initial data.

#### `Tokenize(data=None)`

Create a new `TokenizeEntity` instance. Pass `None` for no initial data.

#### `TokenizeBatch(data=None)`

Create a new `TokenizeBatchEntity` instance. Pass `None` for no initial data.

#### `TokenizeRead(data=None)`

Create a new `TokenizeReadEntity` instance. Pass `None` for no initial data.

#### `Validate(data=None)`

Create a new `ValidateEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> dict`

Make a direct HTTP request to any API endpoint. Returns a result `dict` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `result_dict`

#### `prepare(fetchargs=None) -> dict`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## DetokenizeEntity

```python
detokenize = client.Detokenize()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batches` | `list` | No |  |
| `bfid` | `str` | No | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | `str` | No | Message Id |
| `name` | `str` | No | Field Name. |
| `reference` | `str` | No | Request Reference. |
| `value` | `str` | No | Field Value. |
| `values` | `list` | No |  |

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

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.Detokenize().create({
})
```

#### `list(reqmatch=None, ctrl=None) -> list`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list and raises on error.

```python
results = client.Detokenize().list()
for detokenize in results:
    print(detokenize)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `DetokenizeEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## TokenizeEntity

```python
tokenize = client.Tokenize()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batches` | `list` | No |  |
| `bfid` | `str` | No | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | `str` | No | Message Id |
| `name` | `str` | No | Field Name. |
| `reference` | `str` | No | Request Reference. |
| `templateRef` | `str` | Yes | Template Reference |
| `value` | `str` | No | Field Value. |
| `values` | `list` | No |  |

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

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.Tokenize().create({
    "templateRef": "example_templateRef",  # str
})
```

#### `list(reqmatch=None, ctrl=None) -> list`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list and raises on error.

```python
results = client.Tokenize().list()
for tokenize in results:
    print(tokenize)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `TokenizeEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## TokenizeBatchEntity

```python
tokenize_batch = client.TokenizeBatch()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batches` | `list` | No |  |
| `messageId` | `str` | No | Message Id |
| `reference` | `str` | No | Request Reference. |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batches` | Yes |
| `messageId` | - |
| `reference` | - |

### Operations

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.TokenizeBatch().create({
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `TokenizeBatchEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## TokenizeReadEntity

```python
tokenize_read = client.TokenizeRead()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `str` | No | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | `str` | No | Message Id |
| `reference` | `str` | No | Request Reference. |
| `state` | `dict` | No | Tokenized State Data (if available) |
| `values` | `list` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `messageId` | - |
| `reference` | - |
| `state` | - |
| `values` | - |

### Operations

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.TokenizeRead().create({
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `TokenizeReadEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ValidateEntity

```python
validate = client.Validate()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `messageId` | `str` | No | Message Id |
| `reference` | `str` | No | Request Reference. |
| `templateRef` | `str` | Yes | Template Reference. |

### Operations

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.Validate().create({
    "templateRef": "example_templateRef",  # str
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ValidateEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```python
client = BluefinShieldconexSDK({
    "feature": {
        "test": {"active": True},
    },
})
```

