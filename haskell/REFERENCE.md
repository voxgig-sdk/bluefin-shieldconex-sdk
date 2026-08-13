# BluefinShieldconex Haskell SDK Reference

Complete API reference for the BluefinShieldconex Haskell SDK.


## Client

### Constructors

```haskell
import qualified SdkClient as Sdk
import VoxgigStruct (Value (..))
import SdkHelpers (jo)

makeClient :: IO Sdk.Client
makeClient = do
  opts <- jo [("base", VStr "https://api.example.com")]
  Sdk.newSdk opts
```

Construct a live SDK client.

**Functions:**

| Function | Signature | Description |
| --- | --- | --- |
| `newSdk` | `Value -> IO Client` | Construct a client from an options map. |
| `newSdk0` | `IO Client` | Construct a client with defaults. |

**Options (map keys):**

| Key | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL for API requests. |
| `prefix` | `String` | URL prefix appended after base. |
| `suffix` | `String` | URL suffix appended after path. |
| `headers` | `Value` | Custom headers for all requests. |
| `feature` | `Value` | Feature configuration. |
| `system` | `Value` | System overrides (e.g. custom fetch). |


### Test constructors

```haskell
client <- Sdk.testSdk0
```

`testSdk :: Value -> Value -> IO Client` constructs a test client with mock
features active (`testSdk0 :: IO Client` for the no-argument form). Pass
`VNoval` for defaults.


### Entity accessors

#### `detokenize :: Client -> Value -> IO Entity`

Construct a `Detokenize` entity bound to the client. Pass `VNoval` for no initial options.

#### `tokenize :: Client -> Value -> IO Entity`

Construct a `Tokenize` entity bound to the client. Pass `VNoval` for no initial options.

#### `tokenize_batch :: Client -> Value -> IO Entity`

Construct a `TokenizeBatch` entity bound to the client. Pass `VNoval` for no initial options.

#### `tokenize_read :: Client -> Value -> IO Entity`

Construct a `TokenizeRead` entity bound to the client. Pass `VNoval` for no initial options.

#### `validate :: Client -> Value -> IO Entity`

Construct a `Validate` entity bound to the client. Pass `VNoval` for no initial options.

### HTTP escape hatches

#### `direct :: Client -> Value -> IO Value` (module `SdkFeatures`)

Make a direct HTTP request to any API endpoint. Returns a result `Value` with
`ok`, `status`, `headers`, and `data` (or `err` on failure). This escape
hatch never raises — branch on `getp result "ok"`.

**Argument (map keys):**

| Key | Type | Description |
| --- | --- | --- |
| `path` | `String` | URL path with optional `{param}` placeholders. |
| `method` | `String` | HTTP method (default: `"GET"`). |
| `params` | `Value` | Path parameter values. |
| `query` | `Value` | Query string parameters. |
| `headers` | `Value` | Request headers (merged with defaults). |
| `body` | `Value` | Request body (maps are JSON-serialized). |

#### `prepare :: Client -> Value -> IO Value` (module `SdkFeatures`)

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Detokenize

```haskell
  ent <- Sdk.detokenize sdk VNoval
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

#### `eCreate ent data ctrl :: IO Entity`

Create a new entity with the given data. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

```haskell
  ent <- Sdk.detokenize sdk VNoval
  d <- jo
    []
  ctrl <- emptyMap
  result <- Sdk.eCreate ent d ctrl   -- the ENTITY
  d2 <- Sdk.eDataGet result
```

#### `eList ent match ctrl :: IO [Entity]`

List entities matching the given criteria. The match is optional — pass an empty map to list all records. Resolves to one ENTITY per record and raises on error.

```haskell
  ent <- Sdk.detokenize sdk VNoval
  match <- emptyMap
  ctrl <- emptyMap
  results <- Sdk.eList ent match ctrl   -- one ENTITY per record
  datas <- mapM Sdk.eDataGet results
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `Detokenize` entity with the same options.

#### `eName :: String`

The entity name.


---

## Tokenize

```haskell
  ent <- Sdk.tokenize sdk VNoval
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

#### `eCreate ent data ctrl :: IO Entity`

Create a new entity with the given data. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

```haskell
  ent <- Sdk.tokenize sdk VNoval
  d <- jo
    [ ("templateRef", VStr "example_templateRef")   -- String
    ]
  ctrl <- emptyMap
  result <- Sdk.eCreate ent d ctrl   -- the ENTITY
  d2 <- Sdk.eDataGet result
```

#### `eList ent match ctrl :: IO [Entity]`

List entities matching the given criteria. The match is optional — pass an empty map to list all records. Resolves to one ENTITY per record and raises on error.

```haskell
  ent <- Sdk.tokenize sdk VNoval
  match <- emptyMap
  ctrl <- emptyMap
  results <- Sdk.eList ent match ctrl   -- one ENTITY per record
  datas <- mapM Sdk.eDataGet results
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `Tokenize` entity with the same options.

#### `eName :: String`

The entity name.


---

## TokenizeBatch

```haskell
  ent <- Sdk.tokenize_batch sdk VNoval
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

#### `eCreate ent data ctrl :: IO Entity`

Create a new entity with the given data. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

```haskell
  ent <- Sdk.tokenize_batch sdk VNoval
  d <- jo
    []
  ctrl <- emptyMap
  result <- Sdk.eCreate ent d ctrl   -- the ENTITY
  d2 <- Sdk.eDataGet result
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `TokenizeBatch` entity with the same options.

#### `eName :: String`

The entity name.


---

## TokenizeRead

```haskell
  ent <- Sdk.tokenize_read sdk VNoval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `String` | No |  |
| `messageId` | `String` | No |  |
| `reference` | `String` | No |  |
| `state` | `Value` | No |  |
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

#### `eCreate ent data ctrl :: IO Entity`

Create a new entity with the given data. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

```haskell
  ent <- Sdk.tokenize_read sdk VNoval
  d <- jo
    []
  ctrl <- emptyMap
  result <- Sdk.eCreate ent d ctrl   -- the ENTITY
  d2 <- Sdk.eDataGet result
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `TokenizeRead` entity with the same options.

#### `eName :: String`

The entity name.


---

## Validate

```haskell
  ent <- Sdk.validate sdk VNoval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `messageId` | `String` | No |  |
| `reference` | `String` | No |  |
| `templateRef` | `String` | Yes |  |

### Operations

#### `eCreate ent data ctrl :: IO Entity`

Create a new entity with the given data. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

```haskell
  ent <- Sdk.validate sdk VNoval
  d <- jo
    [ ("templateRef", VStr "example_templateRef")   -- String
    ]
  ctrl <- emptyMap
  result <- Sdk.eCreate ent d ctrl   -- the ENTITY
  d2 <- Sdk.eDataGet result
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `Validate` entity with the same options.

#### `eName :: String`

The entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```haskell
  active <- jo [("active", VBool True)]
  featureCfg <- jo
    [ ("test", active)
    ]
  opts <- jo [("feature", featureCfg)]
  client <- Sdk.newSdk opts
```

