# BluefinShieldconex JavaScript SDK



The JavaScript SDK for the BluefinShieldconex API — an entity-oriented client with full async/await support.

The API is exposed as capitalised, semantic **Entities** — e.g.
`client.Detokenize()` — each with a small set of operations (`list`, `create`)
instead of raw URL paths and query parameters. This keeps the surface
predictable and low-friction for both humans and AI agents.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
```js
npm install bluefin-shieldconex
```
## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.


### Create a Client

```js
const { BluefinShieldconexSDK } = require('@voxgig-sdk/bluefin-shieldconex-js')

const client = new BluefinShieldconexSDK({
  apikey: process.env.BLUEFIN_SHIELDCONEX_APIKEY,
})
```

### List Detokenize Records

```js
const detokenizes = await client.Detokenize().list()
for (const detokenize of detokenizes) {
  console.log(detokenize)
}
```

### Create a Detokenize

```js
const created = await client.Detokenize().create({
  batch: [],
  bfid: 'example_bfid',
})
console.log(created)
```

### Direct API Access

Use `client.direct()` to call any API endpoint directly:

```js
const result = await client.direct({
  path: '/custom/endpoint/{id}',
  method: 'GET',
  params: { id: 'abc123' },
})

if (result.ok) {
  console.log(result.data)
}
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

```js
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})

if (result instanceof Error) {
  throw result
}
if (result.ok) {
  console.log(result.status)  // 200
  console.log(result.data)    // response body
}
```

### Prepare a request without sending it

```js
const fetchdef = await client.prepare({
  path: '/api/resource/{id}',
  method: 'DELETE',
  params: { id: 'example' },
})

// Inspect before sending
console.log(fetchdef.url)
console.log(fetchdef.method)
console.log(fetchdef.headers)
```

### Use test mode

Create a mock client for unit testing — no server required:

```js
const client = BluefinShieldconexSDK.test()

const detokenize = await client.Detokenize().list()
// detokenize is a bare entity populated with mock response data
console.log(detokenize)
```

You can also use the instance method:

```js
const client = new BluefinShieldconexSDK({ apikey: '...' })
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```js
const entity = client.Detokenize()

// First call runs the operation and stores its result
await entity.list()

// Subsequent calls reuse the stored state
const data = entity.data()
console.log(data)
```

### Add custom middleware

Pass features via the `extend` option:

```js
const logger = {
  hooks: {
    PreRequest: (ctx) => {
      console.log('Requesting:', ctx.spec.method, ctx.spec.path)
    },
    PreResponse: (ctx) => {
      console.log('Status:', ctx.out.request?.status)
    },
  },
}

const client = new BluefinShieldconexSDK({
  apikey: '...',
  extend: [logger],
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_SHIELDCONEX_TEST_LIVE=TRUE
BLUEFIN_SHIELDCONEX_APIKEY=<your-key>
```

Then run:

```bash
cd js && npm test
```


## Reference

### BluefinShieldconexSDK

#### Constructor

```js
new BluefinShieldconexSDK(options?)
```

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `object` | Feature activation flags (e.g. `{ test: { active: true } }`). |
| `extend` | `Feature[]` | Additional feature instances to load. |

#### Methods

| Method | Returns | Description |
| --- | --- | --- |
| `options()` | `object` | Deep copy of current SDK options. |
| `utility()` | `Utility` | Deep copy of the SDK utility object. |
| `prepare(fetchargs?)` | `Promise<FetchDef>` | Build an HTTP request definition without sending it. |
| `direct(fetchargs?)` | `Promise<DirectResult>` | Build and send an HTTP request. |
| `Detokenize(data?)` | `DetokenizeEntity` | Create a Detokenize entity instance. |
| `Tokenize(data?)` | `TokenizeEntity` | Create a Tokenize entity instance. |
| `TokenizeBatch(data?)` | `TokenizeBatchEntity` | Create a TokenizeBatch entity instance. |
| `TokenizeRead(data?)` | `TokenizeReadEntity` | Create a TokenizeRead entity instance. |
| `Validate(data?)` | `ValidateEntity` | Create a Validate entity instance. |
| `tester(testopts?, sdkopts?)` | `BluefinShieldconexSDK` | Create a test-mode client instance. |

#### Static methods

| Method | Returns | Description |
| --- | --- | --- |
| `BluefinShieldconexSDK.test(testopts?, sdkopts?)` | `BluefinShieldconexSDK` | Create a test-mode client. |

### Entity interface

All entities share the same interface.

#### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `list` | `list(reqmatch?, ctrl?): Promise<Entity[]>` | List entities matching the criteria. |
| `create` | `create(reqdata?, ctrl?): Promise<Entity>` | Create a new entity. |
| `data` | `data(data?: Partial<Entity>): Entity` | Get or set entity data. |
| `match` | `match(match?: Partial<Entity>): Partial<Entity>` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): BluefinShieldconexSDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Return values

Entity operations resolve to the entity data directly — there is no
result envelope:

- `create` resolves to a single entity object.
- `list` resolves to an **array** of entity objects (iterate it directly;
  there is no `.data` and no `.ok`).

On a failed request these methods **throw**, so wrap calls in
`try`/`catch` to handle errors. Only `direct()` returns the result
envelope described below.

### DirectResult shape

The `direct()` method returns:

```js
{
  ok: true,
  status: 200,
  headers: {},
  data: {}
}
```

On error, `ok` is `false` and an `err` property contains the error.

### FetchDef shape

The `prepare()` method returns:

```js
{
  url: 'string',
  method: 'string',
  headers: {},
  body: undefined
}
```

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

Operations: create, list.

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

Operations: create, list.

API path: `/tokenization/batch/tokenize`

#### TokenizeBatch

| Field | Description |
| --- | --- |
| `batch` |  |
| `message_id` |  |
| `reference` |  |

Operations: create.

API path: `/tokenization/batch/delete`

#### TokenizeRead

| Field | Description |
| --- | --- |
| `bfid` |  |
| `message_id` |  |
| `reference` |  |
| `state` |  |
| `value` |  |

Operations: create.

API path: `/tokenization/read`

#### Validate

| Field | Description |
| --- | --- |
| `message_id` |  |
| `reference` |  |
| `template_ref` |  |

Operations: create.

API path: `/partner/validate`



## Entities


### Detokenize

Create an instance: `const detokenize = client.Detokenize()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `batch` | `Array` |  |
| `bfid` | `string` |  |
| `message_id` | `string` |  |
| `name` | `string` |  |
| `reference` | `string` |  |
| `value` | `Array` |  |

#### Example: List

```ts
const detokenizes = await client.Detokenize().list()
```

#### Example: Create

```ts
const detokenize = await client.Detokenize().create({
})
```


### Tokenize

Create an instance: `const tokenize = client.Tokenize()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `batch` | `Array` |  |
| `bfid` | `string` |  |
| `message_id` | `string` |  |
| `name` | `string` |  |
| `reference` | `string` |  |
| `template_ref` | `string` |  |
| `value` | `Array` |  |

#### Example: List

```ts
const tokenizes = await client.Tokenize().list()
```

#### Example: Create

```ts
const tokenize = await client.Tokenize().create({
  template_ref: 'example_template_ref',
})
```


### TokenizeBatch

Create an instance: `const tokenize_batch = client.TokenizeBatch()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `batch` | `Array` |  |
| `message_id` | `string` |  |
| `reference` | `string` |  |

#### Example: Create

```ts
const tokenize_batch = await client.TokenizeBatch().create({
})
```


### TokenizeRead

Create an instance: `const tokenize_read = client.TokenizeRead()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `bfid` | `string` |  |
| `message_id` | `string` |  |
| `reference` | `string` |  |
| `state` | `Object` |  |
| `value` | `Array` |  |

#### Example: Create

```ts
const tokenize_read = await client.TokenizeRead().create({
})
```


### Validate

Create an instance: `const validate = client.Validate()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `message_id` | `string` |  |
| `reference` | `string` |  |
| `template_ref` | `string` |  |

#### Example: Create

```ts
const validate = await client.Validate().create({
  template_ref: 'example_template_ref',
})
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

### Module structure

```
bluefin-shieldconex/
├── src/
│   ├── BluefinShieldconexSDK.js        # Main SDK class
│   ├── entity/             # Entity implementations
│   ├── feature/            # Built-in features (Base, Test, Log)
│   └── utility/            # Utility functions
└── test/                   # Test suites
```

Import the SDK from the package root:

```js
const { BluefinShieldconexSDK } = require('@voxgig-sdk/bluefin-shieldconex-js')
```

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
