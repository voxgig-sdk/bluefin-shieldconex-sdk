# BluefinShieldconex OCaml SDK Reference

Complete API reference for the BluefinShieldconex OCaml SDK.


## Sdk_client

### Constructor

```ocaml
open Voxgig_struct
open Sdk_helpers

let client = Sdk_client.make options
```

Create a new SDK client instance from a `value` options map. Use
`Sdk_client.make0 ()` for defaults.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `value` | SDK configuration options (a Map). |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides (e.g. custom fetch). |


### Static constructors

#### `Sdk_client.test testopts sdkopts`

Create a test client with mock features active. Both arguments may be `Noval`
(`Sdk_client.test ()` uses defaults, `Sdk_client.test_with` takes explicit
options).

```ocaml
let client = Sdk_client.test ()
```


### Instance functions

#### `Sdk_client.detokenize client entopts : entity_obj`

Create a `Detokenize` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.tokenize client entopts : entity_obj`

Create a `Tokenize` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.tokenize_batch client entopts : entity_obj`

Create a `TokenizeBatch` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.tokenize_read client entopts : entity_obj`

Create a `TokenizeRead` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.validate client entopts : entity_obj`

Create a `Validate` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.direct client fetchargs : value`

Make a direct HTTP request to any API endpoint. Returns a result `value` map
with `ok`, `status`, `headers`, and `data` (or `err` on failure). This
escape hatch never raises — branch on `getp result "ok"`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `value` | Request body (Maps are JSON-serialized). |

**Returns:** a result `value` map.

#### `Sdk_client.prepare client fetchargs : value`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises
on error.


---

## Detokenize

```ocaml
let detokenize = Sdk_client.detokenize client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `value list` | No |  |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `name` | `string` | No |  |
| `reference` | `string` | No |  |
| `value` | `value list` | No |  |

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

#### `e_create reqdata ctrl : value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```ocaml
let result = (Sdk_client.detokenize client Noval).e_create (jo [
]) Noval
```

#### `e_list reqmatch ctrl : value`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Returns a List and raises on error.

```ocaml
let results = (Sdk_client.detokenize client Noval).e_list (empty_map ()) Noval in
(match results with
 | List items -> List.iter (fun r -> print_endline (stringify r)) !items
 | _ -> ())
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Detokenize` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Tokenize

```ocaml
let tokenize = Sdk_client.tokenize client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `value list` | No |  |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `name` | `string` | No |  |
| `reference` | `string` | No |  |
| `template_ref` | `string` | Yes |  |
| `value` | `value list` | No |  |

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

#### `e_create reqdata ctrl : value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```ocaml
let result = (Sdk_client.tokenize client Noval).e_create (jo [
    ("template_ref", (Str "example_template_ref"));  (* string *)
]) Noval
```

#### `e_list reqmatch ctrl : value`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Returns a List and raises on error.

```ocaml
let results = (Sdk_client.tokenize client Noval).e_list (empty_map ()) Noval in
(match results with
 | List items -> List.iter (fun r -> print_endline (stringify r)) !items
 | _ -> ())
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Tokenize` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## TokenizeBatch

```ocaml
let tokenize_batch = Sdk_client.tokenize_batch client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `value list` | No |  |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batch` | Yes |
| `message_id` | - |
| `reference` | - |

### Operations

#### `e_create reqdata ctrl : value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```ocaml
let result = (Sdk_client.tokenize_batch client Noval).e_create (jo [
]) Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `TokenizeBatch` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## TokenizeRead

```ocaml
let tokenize_read = Sdk_client.tokenize_read client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |
| `state` | `value map` | No |  |
| `value` | `value list` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `message_id` | - |
| `reference` | - |
| `state` | - |
| `value` | - |

### Operations

#### `e_create reqdata ctrl : value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```ocaml
let result = (Sdk_client.tokenize_read client Noval).e_create (jo [
]) Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `TokenizeRead` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Validate

```ocaml
let validate = Sdk_client.validate client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |
| `template_ref` | `string` | Yes |  |

### Operations

#### `e_create reqdata ctrl : value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```ocaml
let result = (Sdk_client.validate client Noval).e_create (jo [
    ("template_ref", (Str "example_template_ref"));  (* string *)
]) Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Validate` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ocaml
let client = Sdk_client.make (jo [
    ("feature", jo [
        ("test", jo [("active", Bool true)]);
    ]);
])
```

