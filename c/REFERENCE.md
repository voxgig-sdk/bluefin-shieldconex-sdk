# BluefinShieldconex C SDK Reference

Complete API reference for the BluefinShieldconex C SDK.


## BluefinShieldconexSDK

### Constructor

```c
#include "core/api.h"

BluefinShieldconexSDK* client = bluefin_shieldconex_sdk_new(options);
```

Create a new SDK client instance. `options` is a `voxgig_value*` map
(`NULL` for none).

**Parameters (`options` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides. |


### Test Constructor

#### `BluefinShieldconexSDK* test_sdk(voxgig_value* testopts, voxgig_value* sdkopts)`

Create a test client with mock features active. Both arguments may be
`NULL`.

```c
BluefinShieldconexSDK* client = test_sdk(NULL, NULL);
```


### Entity Accessors

#### `Entity* bluefin_shieldconex_detokenize(BluefinShieldconexSDK* client, voxgig_value* entopts)`

Create a new `Detokenize` entity instance. Pass `NULL` for no initial
options.

#### `Entity* bluefin_shieldconex_tokenize(BluefinShieldconexSDK* client, voxgig_value* entopts)`

Create a new `Tokenize` entity instance. Pass `NULL` for no initial
options.

#### `Entity* bluefin_shieldconex_tokenize_batch(BluefinShieldconexSDK* client, voxgig_value* entopts)`

Create a new `TokenizeBatch` entity instance. Pass `NULL` for no initial
options.

#### `Entity* bluefin_shieldconex_tokenize_read(BluefinShieldconexSDK* client, voxgig_value* entopts)`

Create a new `TokenizeRead` entity instance. Pass `NULL` for no initial
options.

#### `Entity* bluefin_shieldconex_validate(BluefinShieldconexSDK* client, voxgig_value* entopts)`

Create a new `Validate` entity instance. Pass `NULL` for no initial
options.

#### `voxgig_value* sdk_direct(BluefinShieldconexSDK* client, voxgig_value* fetchargs, PNError** err)`

Make a direct HTTP request to any API endpoint. Returns a result map with
`ok`, `status`, `headers`, and `data` (or `err` on failure). This escape
hatch never sets `*err` for a non-2xx response — branch on
`getp(result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `voxgig_value* sdk_prepare(BluefinShieldconexSDK* client, voxgig_value* fetchargs, PNError** err)`

Prepare a fetch definition without sending. Returns the fetchdef and sets
`*err` on failure.


---

## Detokenize

```c
Entity* detokenize = bluefin_shieldconex_detokenize(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `voxgig_value* (list)` | No |  |
| `bfid` | `char*` | No |  |
| `message_id` | `char*` | No |  |
| `name` | `char*` | No |  |
| `reference` | `char*` | No |  |
| `value` | `voxgig_value* (list)` | No |  |

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

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* detokenize = bluefin_shieldconex_detokenize(client, NULL);
voxgig_value* result = detokenize->vt->create(detokenize, NULL, NULL, &err);
```

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* detokenize = bluefin_shieldconex_detokenize(client, NULL);
voxgig_value* results = detokenize->vt->list(detokenize, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Detokenize` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Tokenize

```c
Entity* tokenize = bluefin_shieldconex_tokenize(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `voxgig_value* (list)` | No |  |
| `bfid` | `char*` | No |  |
| `message_id` | `char*` | No |  |
| `name` | `char*` | No |  |
| `reference` | `char*` | No |  |
| `template_ref` | `char*` | Yes |  |
| `value` | `voxgig_value* (list)` | No |  |

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

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* tokenize = bluefin_shieldconex_tokenize(client, NULL);
voxgig_value* result = tokenize->vt->create(tokenize, cmap(1,
    "template_ref", v_str("example_template_ref"))  // char*
, NULL, &err);
```

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* tokenize = bluefin_shieldconex_tokenize(client, NULL);
voxgig_value* results = tokenize->vt->list(tokenize, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Tokenize` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## TokenizeBatch

```c
Entity* tokenize_batch = bluefin_shieldconex_tokenize_batch(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `voxgig_value* (list)` | No |  |
| `message_id` | `char*` | No |  |
| `reference` | `char*` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batch` | Yes |
| `message_id` | - |
| `reference` | - |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* tokenize_batch = bluefin_shieldconex_tokenize_batch(client, NULL);
voxgig_value* result = tokenize_batch->vt->create(tokenize_batch, NULL, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `TokenizeBatch` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## TokenizeRead

```c
Entity* tokenize_read = bluefin_shieldconex_tokenize_read(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `char*` | No |  |
| `message_id` | `char*` | No |  |
| `reference` | `char*` | No |  |
| `state` | `voxgig_value* (map)` | No |  |
| `value` | `voxgig_value* (list)` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `message_id` | - |
| `reference` | - |
| `state` | - |
| `value` | - |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* tokenize_read = bluefin_shieldconex_tokenize_read(client, NULL);
voxgig_value* result = tokenize_read->vt->create(tokenize_read, NULL, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `TokenizeRead` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Validate

```c
Entity* validate = bluefin_shieldconex_validate(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `message_id` | `char*` | No |  |
| `reference` | `char*` | No |  |
| `template_ref` | `char*` | Yes |  |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* validate = bluefin_shieldconex_validate(client, NULL);
voxgig_value* result = validate->vt->create(validate, cmap(1,
    "template_ref", v_str("example_template_ref"))  // char*
, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Validate` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```c
BluefinShieldconexSDK* client = bluefin_shieldconex_sdk_new(cmap(1,
    "feature", cmap(1,
        "test", cmap(1, "active", v_bool(true)))
));
```

