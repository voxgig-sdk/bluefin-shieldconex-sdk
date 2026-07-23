# BluefinShieldconex Dart SDK Reference

Complete API reference for the BluefinShieldconex Dart SDK.

## BluefinShieldconexSDK

### Constructor

```dart
import 'package:bluefin_shieldconex_sdk/BluefinShieldconexSDK.dart';

final client = BluefinShieldconexSDK(options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Map` | SDK configuration options. |
| `options['apikey']` | `String` | API key for authentication. |
| `options['base']` | `String` | Base URL for API requests. |
| `options['prefix']` | `String` | URL prefix appended after base. |
| `options['suffix']` | `String` | URL suffix appended after path. |
| `options['headers']` | `Map` | Custom headers for all requests. |
| `options['feature']` | `Map` | Feature configuration. |
| `options['system']` | `Map` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinShieldconexSDK.test([testopts, sdkopts])`

Create a test client with mock features active. Both arguments may be `null`.

```dart
final client = BluefinShieldconexSDK.test();
```


### Instance Methods

#### `Detokenize([entopts])`

Create a new `DetokenizeEntity` instance. Pass no argument for no initial data.

#### `Tokenize([entopts])`

Create a new `TokenizeEntity` instance. Pass no argument for no initial data.

#### `TokenizeBatch([entopts])`

Create a new `TokenizeBatchEntity` instance. Pass no argument for no initial data.

#### `TokenizeRead([entopts])`

Create a new `TokenizeReadEntity` instance. Pass no argument for no initial data.

#### `Validate([entopts])`

Create a new `ValidateEntity` instance. Pass no argument for no initial data.

#### `options() -> Map`

Return a deep copy of the current SDK options.

#### `utility() -> Utility`

Return the SDK utility object.

#### `direct([fetchargs]) -> Future<Map>`

Make a direct HTTP request to any API endpoint. Returns a result `Map` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never throws — branch on `result['ok']`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs['path']` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs['method']` | `String` | HTTP method (default: `'GET'`). |
| `fetchargs['params']` | `Map` | Path parameter values. |
| `fetchargs['query']` | `Map` | Query string parameters. |
| `fetchargs['headers']` | `Map` | Request headers (merged with defaults). |
| `fetchargs['body']` | `dynamic` | Request body (maps are JSON-serialized). |

**Returns:** `Future<Map>`

#### `prepare([fetchargs]) -> Future`

Prepare a fetch definition without sending. Returns the `fetchdef` (or an error value on failure).


---

## DetokenizeEntity

```dart
final detokenize = client.Detokenize();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `List<dynamic>` | No |  |
| `bfid` | `String` | No |  |
| `message_id` | `String` | No |  |
| `name` | `String` | No |  |
| `reference` | `String` | No |  |
| `value` | `List<dynamic>` | No |  |

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

#### `create(reqdata, [ctrl]) -> Future<dynamic>`

Create a new entity with the given data. Returns the created entity data and throws on error.

```dart
final result = await client.Detokenize().create({
});
```

#### `list([reqmatch, ctrl]) -> Future<List>`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entity instances and throws on error.

```dart
final results = await client.Detokenize().list();
for (final detokenize in results) {
  print(detokenize.data());
}
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `DetokenizeEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## TokenizeEntity

```dart
final tokenize = client.Tokenize();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `List<dynamic>` | No |  |
| `bfid` | `String` | No |  |
| `message_id` | `String` | No |  |
| `name` | `String` | No |  |
| `reference` | `String` | No |  |
| `template_ref` | `String` | Yes |  |
| `value` | `List<dynamic>` | No |  |

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

#### `create(reqdata, [ctrl]) -> Future<dynamic>`

Create a new entity with the given data. Returns the created entity data and throws on error.

```dart
final result = await client.Tokenize().create({
  'template_ref': 'example_template_ref',  // String
});
```

#### `list([reqmatch, ctrl]) -> Future<List>`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entity instances and throws on error.

```dart
final results = await client.Tokenize().list();
for (final tokenize in results) {
  print(tokenize.data());
}
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `TokenizeEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## TokenizeBatchEntity

```dart
final tokenize_batch = client.TokenizeBatch();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `batch` | `List<dynamic>` | No |  |
| `message_id` | `String` | No |  |
| `reference` | `String` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `batch` | Yes |
| `message_id` | - |
| `reference` | - |

### Operations

#### `create(reqdata, [ctrl]) -> Future<dynamic>`

Create a new entity with the given data. Returns the created entity data and throws on error.

```dart
final result = await client.TokenizeBatch().create({
});
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `TokenizeBatchEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## TokenizeReadEntity

```dart
final tokenize_read = client.TokenizeRead();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bfid` | `String` | No |  |
| `message_id` | `String` | No |  |
| `reference` | `String` | No |  |
| `state` | `Map<String, dynamic>` | No |  |
| `value` | `List<dynamic>` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `bfid` | Yes |
| `message_id` | - |
| `reference` | - |
| `state` | - |
| `value` | - |

### Operations

#### `create(reqdata, [ctrl]) -> Future<dynamic>`

Create a new entity with the given data. Returns the created entity data and throws on error.

```dart
final result = await client.TokenizeRead().create({
});
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `TokenizeReadEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## ValidateEntity

```dart
final validate = client.Validate();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `message_id` | `String` | No |  |
| `reference` | `String` | No |  |
| `template_ref` | `String` | Yes |  |

### Operations

#### `create(reqdata, [ctrl]) -> Future<dynamic>`

Create a new entity with the given data. Returns the created entity data and throws on error.

```dart
final result = await client.Validate().create({
  'template_ref': 'example_template_ref',  // String
});
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `ValidateEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```dart
final client = BluefinShieldconexSDK({
  'feature': {
    'test': {'active': true},
  },
});
```

