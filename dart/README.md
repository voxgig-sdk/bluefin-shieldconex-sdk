# BluefinShieldconex Dart SDK



The Dart SDK for the BluefinShieldconex API — an entity-oriented client following idiomatic Dart conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Detokenize()` — each
carrying a small, uniform set of operations (`list`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to pub.dev. Add it as a git
dependency (pinned to a release tag `dart/vX.Y.Z`, see
[Releases](https://github.com/voxgig-sdk/bluefin-shieldconex-sdk/releases)) in your `pubspec.yaml`:

```yaml
dependencies:
  bluefin_shieldconex_sdk:
    git:
      url: https://github.com/voxgig-sdk/bluefin-shieldconex-sdk
      path: dart
      ref: dart/v0.0.1
```

Or depend on a local source checkout:

```yaml
dependencies:
  bluefin_shieldconex_sdk:
    path: ../dart
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```dart
import 'dart:io';
import 'package:bluefin_shieldconex_sdk/BluefinShieldconexSDK.dart';

final client = BluefinShieldconexSDK({
  'apikey': Platform.environment['BLUEFIN_SHIELDCONEX_APIKEY'],
});
```

### 2. List detokenize records

`list()` returns a `List` of entity instances and throws on error — iterate
it and read each record's data via `.data()`.

```dart
try {
  final detokenizes = await client.Detokenize().list();
  for (final item in detokenizes) {
    print(item.data());
  }
} catch (err) {
  print('list failed: $err');
}
```

### 4. Create, update, and remove

```dart
// Create — returns the bare created record (a Map)
final created = await client.Detokenize().create({'batch': <dynamic>[], 'bfid': 'example_bfid'});

```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const detokenizes = await client.Detokenize().list()
  console.log(detokenizes)
} catch (err) {
  console.error('list failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```dart
final result = await client.direct({
  'path': '/api/resource/{id}',
  'method': 'GET',
  'params': {'id': 'example'},
});

if (true == result['ok']) {
  print(result['status']);  // 200
  print(result['data']);    // response body
} else {
  // A non-2xx response carries status + data (the error body); a
  // transport-level failure carries err instead. direct() never throws —
  // branch on result['ok'].
  print(result['status']);
  print(result['err']);
}
```

### Prepare a request without sending it

```dart
// prepare() returns the fetch definition (or an error value on failure).
final fetchdef = await client.prepare({
  'path': '/api/resource/{id}',
  'method': 'DELETE',
  'params': {'id': 'example'},
});

print(fetchdef['url']);
print(fetchdef['method']);
print(fetchdef['headers']);
```

### Use test mode

Create a mock client for unit testing — no server required:

```dart
final client = BluefinShieldconexSDK.test();

// Entity ops return the bare record and throw on error.
final detokenize = await client.Detokenize().list();
// detokenize contains the mock response record
print(detokenize);
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```dart
Future<dynamic> mockFetch(dynamic url, dynamic init) async {
  return {
    'status': 200,
    'statusText': 'OK',
    'headers': <String, dynamic>{},
    'json': () => {'id': 'mock01'},
  };
}

final client = BluefinShieldconexSDK({
  'base': 'http://localhost:8080',
  'system': {
    'fetch': mockFetch,
  },
});
```

### Run live tests

Set the live-mode environment variables:

```bash
export BLUEFIN_SHIELDCONEX_TEST_LIVE=TRUE
export BLUEFIN_SHIELDCONEX_APIKEY=<your-key>
```

Then run:

```bash
cd dart && dart run test/main.dart
```


## Reference

### BluefinShieldconexSDK

```dart
import 'package:bluefin_shieldconex_sdk/BluefinShieldconexSDK.dart';

final client = BluefinShieldconexSDK(options);
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Map` | Feature activation flags. |
| `extend` | `List` | Additional Feature instances to load. |
| `system` | `Map` | System overrides (e.g. custom `fetch` function). |

### test

```dart
final client = BluefinShieldconexSDK.test(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### BluefinShieldconexSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options` | `() -> Map` | Deep copy of current SDK options. |
| `utility` | `() -> Utility` | The SDK utility object. |
| `prepare` | `([fetchargs]) -> Future` | Build an HTTP request definition without sending. Returns an error value on failure. |
| `direct` | `([fetchargs]) -> Future<Map>` | Build and send an HTTP request. Returns a result map (branch on `ok`); never throws. |
| `Detokenize` | `([entopts]) -> DetokenizeEntity` | Create a Detokenize entity instance. |
| `Tokenize` | `([entopts]) -> TokenizeEntity` | Create a Tokenize entity instance. |
| `TokenizeBatch` | `([entopts]) -> TokenizeBatchEntity` | Create a TokenizeBatch entity instance. |
| `TokenizeRead` | `([entopts]) -> TokenizeReadEntity` | Create a TokenizeRead entity instance. |
| `Validate` | `([entopts]) -> ValidateEntity` | Create a Validate entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `list` | `(reqmatch, [ctrl]) -> Future<List>` | List entities matching the criteria (a list of entity instances). Throws on error. |
| `create` | `(reqdata, [ctrl]) -> Future<dynamic>` | Create a new entity. Throws on error. |
| `data` | `([d]) -> Map` | Get (or, with an argument, set) entity data. |
| `match` | `([m]) -> Map` | Get (or, with an argument, set) entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `entopts` | `() -> Map` | Return the entity options. |
| `Name` | `String` | The entity name (a public field). |

### Result shape

Entity operations return the bare result data (a `Map` for single-entity
ops, a `List` of entity instances for `list`) and throw on error. Wrap calls
in `try`/`catch` to handle failures.

The `direct()` escape hatch never throws — it returns a result `Map` you
branch on via `result['ok']`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Map` | Response headers. |
| `data` | `dynamic` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

### Entities

#### Detokenize

| Field | Description |
| --- | --- |
| `batch` |  |
| `bfid` |  |
| `message_id` |  |
| `name` |  |
| `reference` |  |
| `value` |  |

Operations: Create, List.

API path: `/tokenization/batch/detokenize`

#### Tokenize

| Field | Description |
| --- | --- |
| `batch` |  |
| `bfid` |  |
| `message_id` |  |
| `name` |  |
| `reference` |  |
| `template_ref` |  |
| `value` |  |

Operations: Create, List.

API path: `/tokenization/batch/tokenize`

#### TokenizeBatch

| Field | Description |
| --- | --- |
| `batch` |  |
| `message_id` |  |
| `reference` |  |

Operations: Create.

API path: `/tokenization/batch/delete`

#### TokenizeRead

| Field | Description |
| --- | --- |
| `bfid` |  |
| `message_id` |  |
| `reference` |  |
| `state` |  |
| `value` |  |

Operations: Create.

API path: `/tokenization/read`

#### Validate

| Field | Description |
| --- | --- |
| `message_id` |  |
| `reference` |  |
| `template_ref` |  |

Operations: Create.

API path: `/partner/validate`



## Entities


### Detokenize

Create an instance: `final detokenize = client.Detokenize();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `batch` | `List<dynamic>` |  |
| `bfid` | `String` |  |
| `message_id` | `String` |  |
| `name` | `String` |  |
| `reference` | `String` |  |
| `value` | `List<dynamic>` |  |

#### Example: List

```dart
final detokenizes = await client.Detokenize().list();
```

#### Example: Create

```dart
final detokenize = await client.Detokenize().create({
});
```


### Tokenize

Create an instance: `final tokenize = client.Tokenize();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `batch` | `List<dynamic>` |  |
| `bfid` | `String` |  |
| `message_id` | `String` |  |
| `name` | `String` |  |
| `reference` | `String` |  |
| `template_ref` | `String` |  |
| `value` | `List<dynamic>` |  |

#### Example: List

```dart
final tokenizes = await client.Tokenize().list();
```

#### Example: Create

```dart
final tokenize = await client.Tokenize().create({
  'template_ref': 'example_template_ref',  // String
});
```


### TokenizeBatch

Create an instance: `final tokenize_batch = client.TokenizeBatch();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `batch` | `List<dynamic>` |  |
| `message_id` | `String` |  |
| `reference` | `String` |  |

#### Example: Create

```dart
final tokenize_batch = await client.TokenizeBatch().create({
});
```


### TokenizeRead

Create an instance: `final tokenize_read = client.TokenizeRead();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `bfid` | `String` |  |
| `message_id` | `String` |  |
| `reference` | `String` |  |
| `state` | `Map<String, dynamic>` |  |
| `value` | `List<dynamic>` |  |

#### Example: Create

```dart
final tokenize_read = await client.TokenizeRead().create({
});
```


### Validate

Create an instance: `final validate = client.Validate();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `message_id` | `String` |  |
| `reference` | `String` |  |
| `template_ref` | `String` |  |

#### Example: Create

```dart
final validate = await client.Validate().create({
  'template_ref': 'example_template_ref',  // String
});
```


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Maps in, typed models alongside

The Dart SDK passes plain `Map<String, dynamic>` values through the
operation pipeline rather than requiring typed objects at every call. This
mirrors the dynamic nature of the API and keeps calls terse — a create is
just `create({'name': 'example'})`.

For a typed, documented view of each entity and operation, the generated
`BluefinShieldconexTypes.dart` provides a class per entity plus per-op request/match
classes (e.g. `BluefinShieldconex.fromMap(entity.data())` and `model.toMap()`), so you
can convert to and from those maps wherever you want compile-time structure.

### Package structure

```
dart/
├── lib/
│   ├── BluefinShieldconexSDK.dart          -- Main SDK library (exported entry point)
│   ├── BluefinShieldconexTypes.dart        -- Typed entity + request/match models
│   ├── BluefinShieldconexEntityBase.dart   -- Base class for entities
│   ├── BluefinShieldconexError.dart        -- SDK error type
│   ├── Config.dart              -- Configuration
│   ├── entity/                  -- Entity implementations
│   ├── feature/                 -- Built-in features (base, test, log, ...)
│   └── utility/                 -- Utility functions and vendored struct library
└── test/                        -- Test suites (dart run test/main.dart)
```

The main library (`BluefinShieldconexSDK.dart`) re-exports the SDK class, the typed
models, and every entity class, so a single
`import 'package:bluefin_shieldconex_sdk/BluefinShieldconexSDK.dart';`
brings in everything you need.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const detokenize = client.Detokenize()
await detokenize.list()

// detokenize.data() now returns the detokenize data from the last `list`
// detokenize.match() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
