# BluefinShieldconex Clojure SDK Reference

Complete API reference for the BluefinShieldconex Clojure SDK.


## Client

### make-sdk

```clojure
(require '[sdk.api :as api]
         '[voxgig.struct :as vs])

(def client (api/make-sdk options))
```

Create a new SDK client instance. `options` is a `voxgig.struct` map.

**Options:**

| Key | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides (e.g. custom fetch). |


### Test client

#### `(api/test-sdk testopts sdkopts)`

Create a test client with mock features active. Both arguments may be `nil`.

```clojure
(def client (api/test-sdk nil nil))
```


### Client functions

#### `(api/detokenize client data)`

Create a new `Detokenize` entity instance. Pass `nil` for no initial data.

#### `(api/tokenize client data)`

Create a new `Tokenize` entity instance. Pass `nil` for no initial data.

#### `(api/tokenize_batch client data)`

Create a new `TokenizeBatch` entity instance. Pass `nil` for no initial data.

#### `(api/tokenize_read client data)`

Create a new `TokenizeRead` entity instance. Pass `nil` for no initial data.

#### `(api/validate client data)`

Create a new `Validate` entity instance. Pass `nil` for no initial data.

#### `(api/options-map client) -> map`

Return a deep copy of the current SDK options.

#### `(api/get-utility client) -> utility`

Return a copy of the SDK utility object.

#### `(api/direct client fetchargs) -> map`

Make a direct HTTP request to any API endpoint. Returns a result `map` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `(vs/getprop result "ok")`.

**Fetch args:**

| Key | Type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

**Returns:** a result `map`.

#### `(api/prepare client fetchargs) -> map`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Detokenize

```clojure
(require '[sdk.entity.detokenize :as e-detokenize])

(def detokenize (api/detokenize client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batches` | `vector` | No |  |
| `bfid` | `string` | No | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | `string` | No | Message Id |
| `name` | `string` | No | Field Name. |
| `reference` | `string` | No | Request Reference. |
| `value` | `string` | No | Field Value. |
| `values` | `vector` | No |  |

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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-detokenize/create (api/detokenize client nil)
    (vs/jm
      )
    nil))
```

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [detokenize (e-detokenize/list (api/detokenize client nil) nil nil)]
  (println detokenize))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Detokenize` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Tokenize

```clojure
(require '[sdk.entity.tokenize :as e-tokenize])

(def tokenize (api/tokenize client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batches` | `vector` | No |  |
| `bfid` | `string` | No | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | `string` | No | Message Id |
| `name` | `string` | No | Field Name. |
| `reference` | `string` | No | Request Reference. |
| `templateRef` | `string` | Yes | Template Reference |
| `value` | `string` | No | Field Value. |
| `values` | `vector` | No |  |

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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-tokenize/create (api/tokenize client nil)
    (vs/jm
      "templateRef" "example_templateRef"  ;; string
      )
    nil))
```

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [tokenize (e-tokenize/list (api/tokenize client nil) nil nil)]
  (println tokenize))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Tokenize` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## TokenizeBatch

```clojure
(require '[sdk.entity.tokenize_batch :as e-tokenize_batch])

(def tokenize_batch (api/tokenize_batch client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batches` | `vector` | No |  |
| `messageId` | `string` | No | Message Id |
| `reference` | `string` | No | Request Reference. |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batches` | Yes |
| `messageId` | - |
| `reference` | - |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-tokenize_batch/create (api/tokenize_batch client nil)
    (vs/jm
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `TokenizeBatch` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## TokenizeRead

```clojure
(require '[sdk.entity.tokenize_read :as e-tokenize_read])

(def tokenize_read (api/tokenize_read client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `string` | No | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | `string` | No | Message Id |
| `reference` | `string` | No | Request Reference. |
| `state` | `map` | No | Tokenized State Data (if available) |
| `values` | `vector` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `messageId` | - |
| `reference` | - |
| `state` | - |
| `values` | - |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-tokenize_read/create (api/tokenize_read client nil)
    (vs/jm
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `TokenizeRead` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Validate

```clojure
(require '[sdk.entity.validate :as e-validate])

(def validate (api/validate client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `messageId` | `string` | No | Message Id |
| `reference` | `string` | No | Request Reference. |
| `templateRef` | `string` | Yes | Template Reference. |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-validate/create (api/validate client nil)
    (vs/jm
      "templateRef" "example_templateRef"  ;; string
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Validate` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```clojure
(def client
  (api/make-sdk
    (vs/jm "feature"
      (vs/jm
        "test" (vs/jm "active" true)
        ))))
```

