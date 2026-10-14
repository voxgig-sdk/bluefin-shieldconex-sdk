# BluefinShieldconex C++ SDK



The C++ SDK for the BluefinShieldconex API — a header-only,
entity-oriented client following idiomatic modern C++ (C++17) conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client->detokenize()` — each
carrying a small, uniform set of operations (`list`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low. Every value flows through a single dynamic
`sdk::Value` type (a JSON-like variant), so there is no schema-driven code to
regenerate when the API changes.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
The C++ SDK is **header-only** — there is no package to install
from a registry. Vendor the `cpp/` directory into your project (or add the
repository as a git submodule) and put it on your compiler's include path.
Releases are cut as the git tag `cpp/vX.Y.Z` (see
[Tags](https://github.com/voxgig-sdk/bluefin-shieldconex-sdk/tags)).

```bash
# Add the SDK as a submodule (or copy the cpp/ directory into your tree).
git submodule add <repo-url> third_party/bluefinshieldconex-sdk
```

Then include the umbrella header and compile with C++17:

```cpp
#include "core/sdk.hpp"
```

```bash
g++ -std=c++17 -Ithird_party/bluefinshieldconex-sdk/cpp your_app.cpp -o your_app
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```cpp
#include <cstdlib>
#include "core/sdk.hpp"

using namespace sdk;

const char* apikey = std::getenv("BLUEFIN_SHIELDCONEX_APIKEY");
auto client = std::make_shared<BluefinShieldconexSDK>(vmap({
    {"apikey", Value(apikey ? apikey : "")},
}));
```

### 2. List detokenize records

`list()` returns a `std::vector` of entities, one per record, and throws
`sdk::SdkErrorPtr` on error; `data()` reads an entity's record.

```cpp
try {
  std::vector<SdkEntityPtr> detokenizes = client->detokenize()->list(vmap({{"bfid", Value("example")}}), Value::undef());
  for (const auto& detokenize : detokenizes) {
    std::cout << Struct::jsonify(detokenize->data()) << std::endl;
  }
} catch (const SdkErrorPtr& err) {
  std::cerr << "list failed: " << err->msg << std::endl;
}
```

### 4. Create, update, and remove

```cpp
// Create — returns the created entity.
SdkEntityPtr created = client->detokenize()->create(vmap({{"batches", vlist()}, {"bfid", Value("example_bfid")}}), Value::undef());

```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const detokenizes = await client.Detokenize().list({ bfid: "example" })
  console.log(detokenizes.map((item) => item.data()))
} catch (err) {
  console.error('list failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
result envelope. Branch on `ok`; on failure `status` holds the HTTP status
(for error responses) and `err` holds the error:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (!result.ok) {
  console.error('request failed:', result.status, result.err)
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```cpp
Value result = client->direct(vmap({
    {"path", Value("/api/resource/{id}")},
    {"method", Value("GET")},
    {"params", vmap({{"id", Value("example")}})},
}));

if (getp(result, "ok") == Value(true)) {
  std::cout << Helpers::toInt(getp(result, "status")) << std::endl;  // 200
  std::cout << Struct::jsonify(getp(result, "data")) << std::endl;   // response body
} else {
  // A non-2xx response carries status + data (the error body); a
  // transport-level failure carries err instead. Only one is present.
  std::cerr << Helpers::toInt(getp(result, "status")) << " "
            << Struct::jsonify(getp(result, "err")) << std::endl;
}
```

`direct()` is the escape hatch: it never throws — branch on
`getp(result, "ok")`.

### Prepare a request without sending it

```cpp
// prepare() returns the fetch definition and throws on error.
Value fetchdef = client->prepare(vmap({
    {"path", Value("/api/resource/{id}")},
    {"method", Value("DELETE")},
    {"params", vmap({{"id", Value("example")}})},
}));

std::cout << Struct::stringify(getp(fetchdef, "url")) << std::endl;
std::cout << Struct::stringify(getp(fetchdef, "method")) << std::endl;
std::cout << Struct::jsonify(getp(fetchdef, "headers")) << std::endl;
```

### Use test mode

Create a mock client for unit testing — no server required. The test
feature installs an in-memory mock transport:

```cpp
auto client = BluefinShieldconexSDK::testSDK();

// list returns one entity per mock record, and throws on error.
for (const auto& detokenize : client->detokenize()->list(vmap({{"bfid", Value("example")}}), Value::undef())) {
  std::cout << Struct::jsonify(detokenize->data()) << std::endl;
}
```

You can seed the mock store by passing test options — see the generated
`test/` suite for worked examples.

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_SHIELDCONEX_TEST_LIVE=TRUE
BLUEFIN_SHIELDCONEX_APIKEY=<your-key>
```

Then build and run the test suite:

```bash
cd cpp && make test
```


## Reference

### BluefinShieldconexSDK

```cpp
#include "core/sdk.hpp"

using namespace sdk;

auto client = std::make_shared<BluefinShieldconexSDK>(options);
```

Creates a new SDK client. `options` is an `sdk::Value` map.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `std::string` | API key for authentication. |
| `base` | `std::string` | Base URL of the API server. |
| `prefix` | `std::string` | URL path prefix prepended to all requests. |
| `suffix` | `std::string` | URL path suffix appended to all requests. |
| `feature` | `Value` | Feature activation flags. |
| `system` | `Value` | System overrides. |

### testSDK

```cpp
auto client = BluefinShieldconexSDK::testSDK(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`Value::undef()`; a no-arg `BluefinShieldconexSDK::testSDK()` overload is
also provided.

### BluefinShieldconexSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `optionsMap` | `() -> Value` | Deep copy of current SDK options. |
| `getUtility` | `() -> UtilityPtr` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Value` | Build an HTTP request definition without sending. Throws on error. |
| `direct` | `(fetchargs) -> Value` | Build and send an HTTP request. Returns a result Value (branch on `ok`). |
| `detokenize` | `(entopts) -> std::shared_ptr<DetokenizeEntity>` | Create a Detokenize entity instance. |
| `tokenize` | `(entopts) -> std::shared_ptr<TokenizeEntity>` | Create a Tokenize entity instance. |
| `tokenize_batch` | `(entopts) -> std::shared_ptr<TokenizeBatchEntity>` | Create a TokenizeBatch entity instance. |
| `tokenize_read` | `(entopts) -> std::shared_ptr<TokenizeReadEntity>` | Create a TokenizeRead entity instance. |
| `validate` | `(entopts) -> std::shared_ptr<ValidateEntity>` | Create a Validate entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `list` | `(reqmatch, ctrl) -> std::vector<SdkEntityPtr>` | List entities matching the criteria, one per record. Throws on error. |
| `create` | `(reqdata, ctrl) -> SdkEntityPtr` | Create a new entity. Throws on error. |
| `data` | `(arg) -> Value` | Get (no arg) or set (with arg) entity data. |
| `match` | `(arg) -> Value` | Get (no arg) or set (with arg) entity match criteria. |
| `make` | `() -> EntityPtr` | Create a new instance with the same options. |
| `getName` | `() -> std::string` | Return the entity name. |

### Result shape

Entity operations return the entity, and `list` a `std::vector` of
entities, one per record; `data()` reads an entity's record. They throw
`sdk::SdkErrorPtr` on error, so wrap calls in `try`/`catch` to handle
failures.

The `direct()` escape hatch never throws — it returns a result `Value`
you branch on via `getp(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Value` | Response headers. |
| `data` | `Value` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

### Entities

#### Detokenize

| Field | Description |
| --- | --- |
| `batches` |  |
| `bfid` | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | Message Id |
| `name` | Field Name. |
| `reference` | Request Reference. |
| `value` | Field Value. |
| `values` |  |

Operations: Create, List.

API path: `/tokenization/batch/detokenize`

#### Tokenize

| Field | Description |
| --- | --- |
| `batches` |  |
| `bfid` | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | Message Id |
| `name` | Field Name. |
| `reference` | Request Reference. |
| `templateRef` | Template Reference |
| `value` | Field Value. |
| `values` |  |

Operations: Create, List.

API path: `/tokenization/batch/tokenize`

#### TokenizeBatch

| Field | Description |
| --- | --- |
| `batches` |  |
| `messageId` | Message Id |
| `reference` | Request Reference. |

Operations: Create.

API path: `/tokenization/batch/delete`

#### TokenizeRead

| Field | Description |
| --- | --- |
| `bfid` | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | Message Id |
| `reference` | Request Reference. |
| `state` | Tokenized State Data (if available) |
| `values` |  |

Operations: Create.

API path: `/tokenization/read`

#### Validate

| Field | Description |
| --- | --- |
| `messageId` | Message Id |
| `reference` | Request Reference. |
| `templateRef` | Template Reference. |

Operations: Create.

API path: `/partner/validate`



## Entities


### Detokenize

Create an instance: `auto detokenize = client->detokenize();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl) -> SdkEntityPtr` | Create a new entity with the given data. |
| `list(match, ctrl) -> std::vector<SdkEntityPtr>` | List entities, optionally matching the given criteria: one entity per record. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `batches` | `std::vector<Value>` |  |
| `bfid` | `std::string` | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | `std::string` | Message Id |
| `name` | `std::string` | Field Name. |
| `reference` | `std::string` | Request Reference. |
| `value` | `std::string` | Field Value. |
| `values` | `std::vector<Value>` |  |

#### Example: List

```cpp
std::vector<SdkEntityPtr> detokenizes = client->detokenize()->list(vmap({{"bfid", Value("example")}}), Value::undef());
for (const auto& detokenize : detokenizes) {
  std::cout << Struct::jsonify(detokenize->data()) << std::endl;
}
```

#### Example: Create

```cpp
SdkEntityPtr detokenize = client->detokenize()->create(vmap({
}), Value::undef());
```


### Tokenize

Create an instance: `auto tokenize = client->tokenize();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl) -> SdkEntityPtr` | Create a new entity with the given data. |
| `list(match, ctrl) -> std::vector<SdkEntityPtr>` | List entities, optionally matching the given criteria: one entity per record. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `batches` | `std::vector<Value>` |  |
| `bfid` | `std::string` | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | `std::string` | Message Id |
| `name` | `std::string` | Field Name. |
| `reference` | `std::string` | Request Reference. |
| `templateRef` | `std::string` | Template Reference |
| `value` | `std::string` | Field Value. |
| `values` | `std::vector<Value>` |  |

#### Example: List

```cpp
std::vector<SdkEntityPtr> tokenizes = client->tokenize()->list(vmap({{"template_ref", Value("example")}}), Value::undef());
for (const auto& tokenize : tokenizes) {
  std::cout << Struct::jsonify(tokenize->data()) << std::endl;
}
```

#### Example: Create

```cpp
SdkEntityPtr tokenize = client->tokenize()->create(vmap({
    {"templateRef", Value("example_templateRef")},  // std::string
}), Value::undef());
```


### TokenizeBatch

Create an instance: `auto tokenize_batch = client->tokenize_batch();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl) -> SdkEntityPtr` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `batches` | `std::vector<Value>` |  |
| `messageId` | `std::string` | Message Id |
| `reference` | `std::string` | Request Reference. |

#### Example: Create

```cpp
SdkEntityPtr tokenize_batch = client->tokenize_batch()->create(vmap({
}), Value::undef());
```


### TokenizeRead

Create an instance: `auto tokenize_read = client->tokenize_read();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl) -> SdkEntityPtr` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `bfid` | `std::string` | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | `std::string` | Message Id |
| `reference` | `std::string` | Request Reference. |
| `state` | `std::map<std::string, Value>` | Tokenized State Data (if available) |
| `values` | `std::vector<Value>` |  |

#### Example: Create

```cpp
SdkEntityPtr tokenize_read = client->tokenize_read()->create(vmap({
}), Value::undef());
```


### Validate

Create an instance: `auto validate = client->validate();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl) -> SdkEntityPtr` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `messageId` | `std::string` | Message Id |
| `reference` | `std::string` | Request Reference. |
| `templateRef` | `std::string` | Template Reference. |

#### Example: Create

```cpp
SdkEntityPtr validate = client->validate()->create(vmap({
    {"templateRef", Value("example_templateRef")},  // std::string
}), Value::undef());
```

## Features

This SDK ships 12 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`audit`](#audit) | Audit trail |
| [`clienttrack`](#clienttrack) | Client tracking |
| [`debug`](#debug) | Debug capture |
| [`idempotency`](#idempotency) | Idempotency |
| [`log`](#log) | Logging |
| [`metrics`](#metrics) | Metrics |
| [`paging`](#paging) | Paging |
| [`ratelimit`](#ratelimit) | Rate limiting |
| [`retry`](#retry) | Retry |
| [`telemetry`](#telemetry) | Telemetry |
| [`test`](#test) | Test transport |
| [`timeout`](#timeout) | Timeout |

> **Order matters for `ratelimit`, `retry`, `timeout`.** These wrap the
> transport, so each one wraps whatever is already installed: the order you
> activate them in IS the nesting order. Activating them as an ordered list
> rather than a map is what fixes that order.

### audit

Audit trail.

| Option | Default |
|---|---|
| `active` | `false` |
| `actor` | `'anonymous'` |
| `max` | `1000` |

Set `feature.audit.active` to enable it, then override any of the options above.

### clienttrack

Client tracking.

| Option | Default |
|---|---|
| `active` | `false` |
| `clientVersion` | `'0.0.1'` |

Set `feature.clienttrack.active` to enable it, then override any of the options above.

### debug

Debug capture.

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `100` |
| `redact` | `['authorization', 'cookie', 'set-cookie', 'api-key', 'apikey', 'x-api-key', 'idempotency-key']` |

Set `feature.debug.active` to enable it, then override any of the options above.

### idempotency

Idempotency.

| Option | Default |
|---|---|
| `active` | `false` |
| `header` | `'Idempotency-Key'` |
| `methods` | `['POST', 'PUT', 'PATCH', 'DELETE']` |
| `ops` | `['create', 'update', 'remove']` |

Set `feature.idempotency.active` to enable it, then override any of the options above.

### log

Logging.

| Option | Default |
|---|---|
| `active` | `true` |

Set `feature.log.active` to enable it, then override any of the options above.

### metrics

Metrics.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.metrics.active` to enable it, then override any of the options above.

### paging

Paging.

| Option | Default |
|---|---|
| `active` | `false` |
| `afterVar` | `'after'` |
| `cursorParam` | `'cursor'` |
| `firstVar` | `'first'` |
| `limitParam` | `'limit'` |
| `pageParam` | `'page'` |
| `startPage` | `1` |

Set `feature.paging.active` to enable it, then override any of the options above.

### ratelimit

Rate limiting.

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

Set `feature.ratelimit.active` to enable it, then override any of the options above.

`ratelimit` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### retry

Retry.

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

Set `feature.retry.active` to enable it, then override any of the options above.

`retry` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### telemetry

Telemetry.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.telemetry.active` to enable it, then override any of the options above.

### test

Test transport.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.

### timeout

Timeout.

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

Set `feature.timeout.active` to enable it, then override any of the options above.

`timeout` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.


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

- **AuditFeature**: Audit trail
- **ClienttrackFeature**: Client tracking
- **DebugFeature**: Debug capture
- **IdempotencyFeature**: Idempotency
- **LogFeature**: Logging
- **MetricsFeature**: Metrics
- **PagingFeature**: Paging
- **RatelimitFeature**: Rate limiting
- **RetryFeature**: Retry
- **TelemetryFeature**: Telemetry
- **TestFeature**: Test transport
- **TimeoutFeature**: Timeout

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as `Value`

The C++ SDK uses a single dynamic `sdk::Value` type (a JSON-like variant
over string / number / bool / list / map) throughout rather than generated
typed structs. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema changes.

Build maps with `sdk::vmap({{"key", sdk::Value("v")}})` and lists with
`sdk::vlist({...})`; read fields back with `sdk::getp(value, "key")`. Use
`sdk::to_map()` to safely coerce a value that should be a map, and
`sdk::Struct::jsonify(value)` to render it as JSON.

### Directory structure

```
cpp/
├── core/                        -- Runtime type graph, config, generated client
├── entity/                      -- Per-entity client headers
├── feature/                     -- Built-in features (Base, Test, Log, ...)
├── utility/                     -- Operation pipeline + vendored struct library
├── test/                        -- Test suites
├── Makefile                     -- Build & run the tests (C++17)
└── VERSION                      -- SDK version
```

Include the umbrella header `core/sdk.hpp` to pull in the whole SDK: the
runtime types, the pipeline utilities, the vendored struct, the generated
config, the per-entity clients and the generated `BluefinShieldconexSDK`
client class. Everything lives in the `sdk` namespace.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const detokenize = client.Detokenize()
await detokenize.list({ bfid: "example" })

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
