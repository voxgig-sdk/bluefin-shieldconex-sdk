# BluefinShieldconex C SDK



The C SDK for the BluefinShieldconex API — an entity-oriented client following idiomatic C conventions (explicit structs, function-pointer vtables, and a trailing `PNError**` out-param for errors).

The SDK exposes the API as capitalised, semantic **Entities** — for example `bluefinshieldconex_detokenize(client, NULL)` — each
carrying a small, uniform set of operations (`list`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
C has no central package registry — a release is the git tag
(`c/vX.Y.Z`, see [Tags](https://github.com/voxgig-sdk/bluefin-shieldconex-sdk/tags)). Build from a
source checkout with the bundled `Makefile`; the voxgig struct library is
vendored under `utility/struct`, so there are no external dependencies to
fetch:

```bash
cd c && make          # builds libsdk.a
cd c && make test     # builds + runs the test binaries
```

Link your program against `libsdk.a` and include `core/api.h`:

```bash
cc -I c/core -I c/utility/struct \
   myapp.c c/libsdk.a -lm -o myapp
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```c
#include "core/api.h"

BluefinShieldconexSDK* client = bluefinshieldconex_sdk_new(cmap(1,
    "apikey", v_str(getenv("BLUEFIN_SHIELDCONEX_APIKEY"))));
PNError* err = NULL;
```

### 2. List detokenize records

`list()` returns a `NULL`-terminated array of entities, one per record,
and sets `*err` on failure — check `err` after the call. `vt->data`
reads an entity's record.

```c
Entity* detokenize = bluefinshieldconex_detokenize(client, NULL);
Entity** detokenizes = detokenize->vt->list(detokenize, cmap(1, "bfid", v_str("example")), NULL, &err);
if (err) {
    fprintf(stderr, "list failed: %s\n", err->msg);
} else {
    for (size_t i = 0; detokenizes[i]; i++) {
        printf("%s\n", voxgig_to_json(detokenizes[i]->vt->data(detokenizes[i], NULL)));
    }
}
```

### 4. Create, update, and remove

```c
// Create — returns the created entity, or NULL with *err set
Entity* created = detokenize->vt->create(detokenize, cmap(2, "batches", v_list(), "bfid", v_str("example_bfid")), NULL, &err);

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

For endpoints not covered by entity operations:

```c
PNError* err = NULL;
voxgig_value* result = sdk_direct(client, cmap(3,
    "path", v_str("/api/resource/{id}"),
    "method", v_str("GET"),
    "params", cmap(1, "id", v_str("example"))), &err);

if (voxgig_as_bool(getp(result, "ok"))) {
    printf("%lld\n", (long long)to_int(getp(result, "status")));  // 200
    printf("%s\n", voxgig_to_json(getp(result, "data")));         // response body
} else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present.
    printf("%s\n", voxgig_to_json(getp(result, "err")));
}
```

`sdk_direct()` never sets `*err` for a non-2xx response — it always returns
a result map you branch on via `getp(result, "ok")`.

### Prepare a request without sending it

```c
PNError* err = NULL;
voxgig_value* fetchdef = sdk_prepare(client, cmap(3,
    "path", v_str("/api/resource/{id}"),
    "method", v_str("DELETE"),
    "params", cmap(1, "id", v_str("example"))), &err);

printf("%s\n", get_str(fetchdef, "url"));
printf("%s\n", get_str(fetchdef, "method"));
printf("%s\n", voxgig_to_json(getp(fetchdef, "headers")));
```

### Use test mode

Create a mock client for unit testing — no server required:

```c
BluefinShieldconexSDK* client = test_sdk(NULL, NULL);
PNError* err = NULL;

// list returns one entity per mock record, and sets *err on failure.
Entity* detokenize = bluefinshieldconex_detokenize(client, NULL);
Entity** detokenizes = detokenize->vt->list(detokenize, cmap(1, "bfid", v_str("example")), NULL, &err);
// detokenizes[i]->vt->data(detokenizes[i], NULL) is a mock record
```

### Use a custom fetch function

Replace the HTTP transport with your own function (the same shape the test
transport uses):

```c
static voxgig_value* mock_fetch(void* ud, voxgig_value* args) {
    (void)ud; (void)args;
    return cmap(4,
        "status", v_num(200),
        "statusText", v_str("OK"),
        "headers", v_map(),
        "json", json_thunk(cmap(1, "id", v_str("mock01"))));
}

BluefinShieldconexSDK* client = bluefinshieldconex_sdk_new(cmap(2,
    "base", v_str("http://localhost:8080"),
    "system", cmap(1, "fetch", vfn(mock_fetch, NULL))));
```

### Point at a different server

Override the base URL to reach a local or staging server:

```c
BluefinShieldconexSDK* client = bluefinshieldconex_sdk_new(cmap(1,
    "base", v_str("http://localhost:8080")));
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_SHIELDCONEX_TEST_LIVE=TRUE
BLUEFIN_SHIELDCONEX_APIKEY=<your-key>
```

Then run:

```bash
cd c && make test
```


## Reference

### BluefinShieldconexSDK

```c
#include "core/api.h"

BluefinShieldconexSDK* client = bluefinshieldconex_sdk_new(options);
```

Creates a new SDK client. `options` is a `voxgig_value*` map (`NULL` for
none) carrying any of the following keys:

| Option | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `map` | Feature activation flags. |
| `system` | `map` | System overrides (e.g. a custom `fetch`). |

### test_sdk

```c
BluefinShieldconexSDK* client = test_sdk(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`NULL`.

### BluefinShieldconexSDK functions

| Function | Signature | Description |
| --- | --- | --- |
| `sdk_prepare` | `(BluefinShieldconexSDK*, fetchargs, PNError**) -> voxgig_value*` | Build an HTTP request definition without sending. |
| `sdk_direct` | `(BluefinShieldconexSDK*, fetchargs, PNError**) -> voxgig_value*` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `bluefinshieldconex_detokenize` | `(BluefinShieldconexSDK*, entopts) -> Entity*` | Create a Detokenize entity instance. |
| `bluefinshieldconex_tokenize` | `(BluefinShieldconexSDK*, entopts) -> Entity*` | Create a Tokenize entity instance. |
| `bluefinshieldconex_tokenize_batch` | `(BluefinShieldconexSDK*, entopts) -> Entity*` | Create a TokenizeBatch entity instance. |
| `bluefinshieldconex_tokenize_read` | `(BluefinShieldconexSDK*, entopts) -> Entity*` | Create a TokenizeRead entity instance. |
| `bluefinshieldconex_validate` | `(BluefinShieldconexSDK*, entopts) -> Entity*` | Create a Validate entity instance. |

### Entity interface (vtable)

All entities share the same `EntityVT` vtable, reached via `e->vt->...`.

| Method | Signature | Description |
| --- | --- | --- |
| `list` | `(Entity*, reqmatch, ctrl, PNError**) -> Entity**` | List entities matching the criteria: a `NULL`-terminated array, one per record. |
| `create` | `(Entity*, reqdata, ctrl, PNError**) -> Entity*` | Create a new entity. |
| `data` | `(Entity*, args) -> voxgig_value*` | Get entity data (pass a map to set). |
| `matchv` | `(Entity*, args) -> voxgig_value*` | Get entity match criteria (pass a map to set). |
| `make` | `(Entity*) -> Entity*` | Create a new instance with the same options. |
| `get_name` | `(Entity*) -> const char*` | Return the entity name. |

### Result shape

Entity operations return the entity, and `list` a `NULL`-terminated array
of entities, one per record; `vt->data` reads an entity's record. On
failure they return `NULL` and set `*err` to a `PNError*`. Always
initialise `PNError* err = NULL;` and check it after the call.

The `sdk_direct()` escape hatch never sets `*err` for a non-2xx response —
it returns a result map you branch on via `getp(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `number` | HTTP status code. |
| `headers` | `map` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `false` and `err` carries the error value.

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

Create an instance: `Entity* detokenize = bluefinshieldconex_detokenize(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `Entity* vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `Entity** vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria: a `NULL`-terminated array, one per record. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `batches` | `voxgig_value* (list)` |  |
| `bfid` | `char*` | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | `char*` | Message Id |
| `name` | `char*` | Field Name. |
| `reference` | `char*` | Request Reference. |
| `value` | `char*` | Field Value. |
| `values` | `voxgig_value* (list)` |  |

#### Example: List

```c
Entity* detokenize = bluefinshieldconex_detokenize(client, NULL);
Entity** detokenizes = detokenize->vt->list(detokenize, cmap(1, "bfid", v_str("example")), NULL, &err);
for (size_t i = 0; detokenizes && detokenizes[i]; i++) {
    printf("%s\n", voxgig_to_json(detokenizes[i]->vt->data(detokenizes[i], NULL)));
}
```

#### Example: Create

```c
Entity* detokenize = bluefinshieldconex_detokenize(client, NULL);
Entity* created = detokenize->vt->create(detokenize, NULL, NULL, &err);
```


### Tokenize

Create an instance: `Entity* tokenize = bluefinshieldconex_tokenize(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `Entity* vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `Entity** vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria: a `NULL`-terminated array, one per record. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `batches` | `voxgig_value* (list)` |  |
| `bfid` | `char*` | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | `char*` | Message Id |
| `name` | `char*` | Field Name. |
| `reference` | `char*` | Request Reference. |
| `templateRef` | `char*` | Template Reference |
| `value` | `char*` | Field Value. |
| `values` | `voxgig_value* (list)` |  |

#### Example: List

```c
Entity* tokenize = bluefinshieldconex_tokenize(client, NULL);
Entity** tokenizes = tokenize->vt->list(tokenize, cmap(1, "template_ref", v_str("example")), NULL, &err);
for (size_t i = 0; tokenizes && tokenizes[i]; i++) {
    printf("%s\n", voxgig_to_json(tokenizes[i]->vt->data(tokenizes[i], NULL)));
}
```

#### Example: Create

```c
Entity* tokenize = bluefinshieldconex_tokenize(client, NULL);
Entity* created = tokenize->vt->create(tokenize, cmap(1,
    "templateRef", v_str("example_templateRef"))  // char*
, NULL, &err);
```


### TokenizeBatch

Create an instance: `Entity* tokenize_batch = bluefinshieldconex_tokenize_batch(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `Entity* vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `batches` | `voxgig_value* (list)` |  |
| `messageId` | `char*` | Message Id |
| `reference` | `char*` | Request Reference. |

#### Example: Create

```c
Entity* tokenize_batch = bluefinshieldconex_tokenize_batch(client, NULL);
Entity* created = tokenize_batch->vt->create(tokenize_batch, NULL, NULL, &err);
```


### TokenizeRead

Create an instance: `Entity* tokenize_read = bluefinshieldconex_tokenize_read(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `Entity* vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `bfid` | `char*` | The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request). |
| `messageId` | `char*` | Message Id |
| `reference` | `char*` | Request Reference. |
| `state` | `voxgig_value* (map)` | Tokenized State Data (if available) |
| `values` | `voxgig_value* (list)` |  |

#### Example: Create

```c
Entity* tokenize_read = bluefinshieldconex_tokenize_read(client, NULL);
Entity* created = tokenize_read->vt->create(tokenize_read, NULL, NULL, &err);
```


### Validate

Create an instance: `Entity* validate = bluefinshieldconex_validate(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `Entity* vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `messageId` | `char*` | Message Id |
| `reference` | `char*` | Request Reference. |
| `templateRef` | `char*` | Template Reference. |

#### Example: Create

```c
Entity* validate = bluefinshieldconex_validate(client, NULL);
Entity* created = validate->vt->create(validate, cmap(1,
    "templateRef", v_str("example_templateRef"))  // char*
, NULL, &err);
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

### Data as `voxgig_value*`

The C SDK uses a single dynamic `voxgig_value*` type throughout rather than
a typed struct per entity. `voxgig_value` is the vendored voxgig struct
port (a JSON-shaped tagged union: string, number, bool, list, map, null,
undef). This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Build request maps with the `cmap` / `clist` / `v_str` / `v_num` /
`v_bool` helper builders, and read fields back with `getp` (or the typed
`get_str` / `get_bool` / `to_int`); use `to_map` to safely coerce a
value to a map.

Memory follows a retain-heavy, never-free discipline — pipeline values are
never released. This is safe (no use-after-free) and leaks are acceptable
for the short-lived SDK and test binaries.

### Error handling

Fallible functions return a `voxgig_value*` (or a struct pointer) and take a
trailing `PNError** err` out-param. On success `*err` is left `NULL`; on
failure `*err` points to a heap `PNError` carrying `code` and `msg`.
Always initialise `PNError* err = NULL;` and branch on it after each call.

### Project structure

```
c/
├── core/          -- Pipeline types, config, client (client.c), api.h + sdk.h
├── entity/        -- Per-entity implementations (one .c each)
├── feature/       -- Built-in features (base, test, log, ...)
├── utility/       -- Utilities + the vendored voxgig struct port (utility/struct)
├── tests/         -- Test binaries (each a standalone main())
└── Makefile       -- Builds libsdk.a and runs every tests/*.c
```

The public entry header is `core/api.h` — it includes `core/sdk.h` (the
umbrella runtime header) and declares each entity's constructor and SDK
accessor. Include it and link against `libsdk.a`.

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
