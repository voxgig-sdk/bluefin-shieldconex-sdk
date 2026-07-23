# BluefinShieldconex Perl SDK Reference

Complete API reference for the BluefinShieldconex Perl SDK.


## BluefinShieldconexSDK

### Constructor

```perl
use lib 'lib';
use BluefinShieldconexSDK;

my $client = BluefinShieldconexSDK->new($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `hashref` | SDK configuration options. |
| `$options->{apikey}` | `string` | API key for authentication. |
| `$options->{base}` | `string` | Base URL for API requests. |
| `$options->{prefix}` | `string` | URL prefix appended after base. |
| `$options->{suffix}` | `string` | URL suffix appended after path. |
| `$options->{headers}` | `hashref` | Custom headers for all requests. |
| `$options->{feature}` | `hashref` | Feature configuration. |
| `$options->{system}` | `hashref` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinShieldconexSDK->test($testopts, $sdkopts)`

Create a test client with mock features active. Both arguments may be `undef`.

```perl
my $client = BluefinShieldconexSDK->test();
```


### Instance Methods

#### `Detokenize($data)`

Create a new `Detokenize` entity instance. Pass `undef` for no initial data.

#### `Tokenize($data)`

Create a new `Tokenize` entity instance. Pass `undef` for no initial data.

#### `TokenizeBatch($data)`

Create a new `TokenizeBatch` entity instance. Pass `undef` for no initial data.

#### `TokenizeRead($data)`

Create a new `TokenizeRead` entity instance. Pass `undef` for no initial data.

#### `Validate($data)`

Create a new `Validate` entity instance. Pass `undef` for no initial data.

#### `options_map() -> hashref`

Return a deep copy of the current SDK options.

#### `get_utility() -> utility`

Return a copy of the SDK utility object.

#### `direct($fetchargs) -> hashref`

Make a direct HTTP request to any API endpoint. Returns a result `hashref` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never dies — branch on `$result->{ok}`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs->{path}` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs->{method}` | `string` | HTTP method (default: `'GET'`). |
| `$fetchargs->{params}` | `hashref` | Path parameter values. |
| `$fetchargs->{query}` | `hashref` | Query string parameters. |
| `$fetchargs->{headers}` | `hashref` | Request headers (merged with defaults). |
| `$fetchargs->{body}` | `any` | Request body (hashrefs are JSON-serialized). |

**Returns:** `hashref`

#### `prepare($fetchargs) -> hashref`

Prepare a fetch definition without sending. Returns the `fetchdef` and dies on error.


---

## Detokenize entity

```perl
my $detokenize = $client->Detokenize;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `arrayref` | No |  |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `name` | `string` | No |  |
| `reference` | `string` | No |  |
| `value` | `arrayref` | No |  |

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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Detokenize->create({
});
```

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Detokenize->list;
for my $detokenize (@$results) {
    print "$detokenize->{id}\n";
}
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Detokenize` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Tokenize entity

```perl
my $tokenize = $client->Tokenize;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `arrayref` | No |  |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `name` | `string` | No |  |
| `reference` | `string` | No |  |
| `template_ref` | `string` | Yes |  |
| `value` | `arrayref` | No |  |

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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Tokenize->create({
    'template_ref' => 'example_template_ref',  # string
});
```

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Tokenize->list;
for my $tokenize (@$results) {
    print "$tokenize->{id}\n";
}
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Tokenize` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## TokenizeBatch entity

```perl
my $tokenize_batch = $client->TokenizeBatch;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `arrayref` | No |  |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batch` | Yes |
| `message_id` | - |
| `reference` | - |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->TokenizeBatch->create({
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `TokenizeBatch` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## TokenizeRead entity

```perl
my $tokenize_read = $client->TokenizeRead;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `string` | No |  |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |
| `state` | `hashref` | No |  |
| `value` | `arrayref` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `message_id` | - |
| `reference` | - |
| `state` | - |
| `value` | - |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->TokenizeRead->create({
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `TokenizeRead` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Validate entity

```perl
my $validate = $client->Validate;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `message_id` | `string` | No |  |
| `reference` | `string` | No |  |
| `template_ref` | `string` | Yes |  |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Validate->create({
    'template_ref' => 'example_template_ref',  # string
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Validate` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```perl
my $client = BluefinShieldconexSDK->new({
    'feature' => {
        'test' => { 'active' => 1 },
    },
});
```

