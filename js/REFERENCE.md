# BluefinShieldconex JavaScript SDK Reference

Complete API reference for the BluefinShieldconex JavaScript SDK.


## BluefinShieldconexSDK

### Constructor

```ts
new BluefinShieldconexSDK(options?: object)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `object` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `object` | Custom headers for all requests. |
| `options.feature` | `object` | Feature configuration. |
| `options.system` | `object` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinShieldconexSDK.test(testopts?, sdkopts?)`

Create a test client with mock features active.

```ts
const client = BluefinShieldconexSDK.test()
```

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `testopts` | `object` | Test feature options. |
| `sdkopts` | `object` | Additional SDK options merged with test defaults. |

**Returns:** `BluefinShieldconexSDK` instance in test mode.


### Instance Methods

#### `Detokenize(data?: object)`

Create a new `Detokenize` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `DetokenizeEntity` instance.

#### `Tokenize(data?: object)`

Create a new `Tokenize` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `TokenizeEntity` instance.

#### `TokenizeBatch(data?: object)`

Create a new `TokenizeBatch` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `TokenizeBatchEntity` instance.

#### `TokenizeRead(data?: object)`

Create a new `TokenizeRead` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `TokenizeReadEntity` instance.

#### `Validate(data?: object)`

Create a new `Validate` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ValidateEntity` instance.

#### `options()`

Return a deep copy of the current SDK options.

**Returns:** `object`

#### `utility()`

Return a copy of the SDK utility object.

**Returns:** `object`

#### `direct(fetchargs?: object)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `GET`). |
| `fetchargs.params` | `object` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `object` | Query string parameters. |
| `fetchargs.headers` | `object` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (objects are JSON-serialized). |
| `fetchargs.ctrl` | `object` | Control options (e.g. `{ explain: true }`). |

**Returns:** `Promise<{ ok, status, headers, data } | Error>`

#### `prepare(fetchargs?: object)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `Promise<{ url, method, headers, body } | Error>`

#### `tester(testopts?, sdkopts?)`

Alias for `BluefinShieldconexSDK.test()`.

**Returns:** `BluefinShieldconexSDK` instance in test mode.


---

## DetokenizeEntity

```ts
const detokenize = client.Detokenize()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `Array` | No |  |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `name` | `string` | No |  |
| `reference` | `string` | No |  |
| `value` | `Array` | No |  |

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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Detokenize().create({
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Detokenize().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `DetokenizeEntity` instance with the same client and
options.

#### `client()`

Return the parent `BluefinShieldconexSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## TokenizeEntity

```ts
const tokenize = client.Tokenize()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `Array` | No |  |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `name` | `string` | No |  |
| `reference` | `string` | No |  |
| `template_ref` | `string` | Yes |  |
| `value` | `Array` | No |  |

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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Tokenize().create({
  template_ref: 'example_template_ref',
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Tokenize().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `TokenizeEntity` instance with the same client and
options.

#### `client()`

Return the parent `BluefinShieldconexSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## TokenizeBatchEntity

```ts
const tokenize_batch = client.TokenizeBatch()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `Array` | No |  |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batch` | Yes |
| `message_id` | - |
| `reference` | - |

### Operations

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.TokenizeBatch().create({
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `TokenizeBatchEntity` instance with the same client and
options.

#### `client()`

Return the parent `BluefinShieldconexSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## TokenizeReadEntity

```ts
const tokenize_read = client.TokenizeRead()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |
| `state` | `Object` | No |  |
| `value` | `Array` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `message_id` | - |
| `reference` | - |
| `state` | - |
| `value` | - |

### Operations

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.TokenizeRead().create({
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `TokenizeReadEntity` instance with the same client and
options.

#### `client()`

Return the parent `BluefinShieldconexSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ValidateEntity

```ts
const validate = client.Validate()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |
| `template_ref` | `string` | Yes |  |

### Operations

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Validate().create({
  template_ref: 'example_template_ref',
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ValidateEntity` instance with the same client and
options.

#### `client()`

Return the parent `BluefinShieldconexSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ts
const client = new BluefinShieldconexSDK({
  feature: {
    test: { active: true },
  }
})
```

