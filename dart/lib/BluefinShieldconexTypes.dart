// Typed models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON).
// Do not edit by hand.
//
// The operation pipeline passes plain maps; these classes are the typed,
// convertible view: `BluefinShieldconex.fromMap(ent.data())` / `model.toMap()`.

class Detokenize {
  /// ARRAY
  List<dynamic>? batches;
  /// STRING
  String? bfid;
  /// STRING
  String? messageId;
  /// STRING
  String? name;
  /// STRING
  String? reference;
  /// STRING
  String? value;
  /// ARRAY
  List<dynamic>? values;

  Detokenize({
    this.batches,
    this.bfid,
    this.messageId,
    this.name,
    this.reference,
    this.value,
    this.values,
  });

  factory Detokenize.fromMap(Map<String, dynamic> m) => Detokenize(
        batches: m['batches'] is List<dynamic> ? m['batches'] : null,
        bfid: m['bfid'] is String ? m['bfid'] : null,
        messageId: m['messageId'] is String ? m['messageId'] : null,
        name: m['name'] is String ? m['name'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        value: m['value'] is String ? m['value'] : null,
        values: m['values'] is List<dynamic> ? m['values'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batches) {
      m['batches'] = batches;
    }
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != messageId) {
      m['messageId'] = messageId;
    }
    if (null != name) {
      m['name'] = name;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != value) {
      m['value'] = value;
    }
    if (null != values) {
      m['values'] = values;
    }
    return m;
  }
}

class DetokenizeListMatch {
  /// ARRAY
  List<dynamic>? batches;
  /// STRING
  String? bfid;
  /// STRING
  String? messageId;
  /// STRING
  String? name;
  /// STRING
  String? reference;
  /// STRING
  String? value;
  /// ARRAY
  List<dynamic>? values;

  DetokenizeListMatch({
    this.batches,
    this.bfid,
    this.messageId,
    this.name,
    this.reference,
    this.value,
    this.values,
  });

  factory DetokenizeListMatch.fromMap(Map<String, dynamic> m) => DetokenizeListMatch(
        batches: m['batches'] is List<dynamic> ? m['batches'] : null,
        bfid: m['bfid'] is String ? m['bfid'] : null,
        messageId: m['messageId'] is String ? m['messageId'] : null,
        name: m['name'] is String ? m['name'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        value: m['value'] is String ? m['value'] : null,
        values: m['values'] is List<dynamic> ? m['values'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batches) {
      m['batches'] = batches;
    }
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != messageId) {
      m['messageId'] = messageId;
    }
    if (null != name) {
      m['name'] = name;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != value) {
      m['value'] = value;
    }
    if (null != values) {
      m['values'] = values;
    }
    return m;
  }
}

class DetokenizeCreateData {
  /// ARRAY
  List<dynamic>? batches;
  /// STRING
  String? bfid;
  /// STRING
  String? messageId;
  /// STRING
  String? name;
  /// STRING
  String? reference;
  /// STRING
  String? value;
  /// ARRAY
  List<dynamic>? values;

  DetokenizeCreateData({
    this.batches,
    this.bfid,
    this.messageId,
    this.name,
    this.reference,
    this.value,
    this.values,
  });

  factory DetokenizeCreateData.fromMap(Map<String, dynamic> m) => DetokenizeCreateData(
        batches: m['batches'] is List<dynamic> ? m['batches'] : null,
        bfid: m['bfid'] is String ? m['bfid'] : null,
        messageId: m['messageId'] is String ? m['messageId'] : null,
        name: m['name'] is String ? m['name'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        value: m['value'] is String ? m['value'] : null,
        values: m['values'] is List<dynamic> ? m['values'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batches) {
      m['batches'] = batches;
    }
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != messageId) {
      m['messageId'] = messageId;
    }
    if (null != name) {
      m['name'] = name;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != value) {
      m['value'] = value;
    }
    if (null != values) {
      m['values'] = values;
    }
    return m;
  }
}

class Tokenize {
  /// ARRAY
  List<dynamic>? batches;
  /// STRING
  String? bfid;
  /// STRING
  String? messageId;
  /// STRING
  String? name;
  /// STRING
  String? reference;
  /// STRING (required at the API)
  String? templateRef;
  /// STRING
  String? value;
  /// ARRAY
  List<dynamic>? values;

  Tokenize({
    this.batches,
    this.bfid,
    this.messageId,
    this.name,
    this.reference,
    this.templateRef,
    this.value,
    this.values,
  });

  factory Tokenize.fromMap(Map<String, dynamic> m) => Tokenize(
        batches: m['batches'] is List<dynamic> ? m['batches'] : null,
        bfid: m['bfid'] is String ? m['bfid'] : null,
        messageId: m['messageId'] is String ? m['messageId'] : null,
        name: m['name'] is String ? m['name'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        templateRef: m['templateRef'] is String ? m['templateRef'] : null,
        value: m['value'] is String ? m['value'] : null,
        values: m['values'] is List<dynamic> ? m['values'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batches) {
      m['batches'] = batches;
    }
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != messageId) {
      m['messageId'] = messageId;
    }
    if (null != name) {
      m['name'] = name;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != templateRef) {
      m['templateRef'] = templateRef;
    }
    if (null != value) {
      m['value'] = value;
    }
    if (null != values) {
      m['values'] = values;
    }
    return m;
  }
}

class TokenizeListMatch {
  /// ARRAY
  List<dynamic>? batches;
  /// STRING
  String? bfid;
  /// STRING
  String? messageId;
  /// STRING
  String? name;
  /// STRING
  String? reference;
  /// STRING
  String? templateRef;
  /// STRING
  String? value;
  /// ARRAY
  List<dynamic>? values;

  TokenizeListMatch({
    this.batches,
    this.bfid,
    this.messageId,
    this.name,
    this.reference,
    this.templateRef,
    this.value,
    this.values,
  });

  factory TokenizeListMatch.fromMap(Map<String, dynamic> m) => TokenizeListMatch(
        batches: m['batches'] is List<dynamic> ? m['batches'] : null,
        bfid: m['bfid'] is String ? m['bfid'] : null,
        messageId: m['messageId'] is String ? m['messageId'] : null,
        name: m['name'] is String ? m['name'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        templateRef: m['templateRef'] is String ? m['templateRef'] : null,
        value: m['value'] is String ? m['value'] : null,
        values: m['values'] is List<dynamic> ? m['values'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batches) {
      m['batches'] = batches;
    }
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != messageId) {
      m['messageId'] = messageId;
    }
    if (null != name) {
      m['name'] = name;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != templateRef) {
      m['templateRef'] = templateRef;
    }
    if (null != value) {
      m['value'] = value;
    }
    if (null != values) {
      m['values'] = values;
    }
    return m;
  }
}

class TokenizeCreateData {
  /// ARRAY
  List<dynamic>? batches;
  /// STRING
  String? bfid;
  /// STRING
  String? messageId;
  /// STRING
  String? name;
  /// STRING
  String? reference;
  /// STRING (required at the API)
  String? templateRef;
  /// STRING
  String? value;
  /// ARRAY
  List<dynamic>? values;

  TokenizeCreateData({
    this.batches,
    this.bfid,
    this.messageId,
    this.name,
    this.reference,
    this.templateRef,
    this.value,
    this.values,
  });

  factory TokenizeCreateData.fromMap(Map<String, dynamic> m) => TokenizeCreateData(
        batches: m['batches'] is List<dynamic> ? m['batches'] : null,
        bfid: m['bfid'] is String ? m['bfid'] : null,
        messageId: m['messageId'] is String ? m['messageId'] : null,
        name: m['name'] is String ? m['name'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        templateRef: m['templateRef'] is String ? m['templateRef'] : null,
        value: m['value'] is String ? m['value'] : null,
        values: m['values'] is List<dynamic> ? m['values'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batches) {
      m['batches'] = batches;
    }
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != messageId) {
      m['messageId'] = messageId;
    }
    if (null != name) {
      m['name'] = name;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != templateRef) {
      m['templateRef'] = templateRef;
    }
    if (null != value) {
      m['value'] = value;
    }
    if (null != values) {
      m['values'] = values;
    }
    return m;
  }
}

class TokenizeBatch {
  /// ARRAY
  List<dynamic>? batches;
  /// STRING
  String? messageId;
  /// STRING
  String? reference;

  TokenizeBatch({
    this.batches,
    this.messageId,
    this.reference,
  });

  factory TokenizeBatch.fromMap(Map<String, dynamic> m) => TokenizeBatch(
        batches: m['batches'] is List<dynamic> ? m['batches'] : null,
        messageId: m['messageId'] is String ? m['messageId'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batches) {
      m['batches'] = batches;
    }
    if (null != messageId) {
      m['messageId'] = messageId;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    return m;
  }
}

class TokenizeBatchCreateData {
  /// ARRAY
  List<dynamic>? batches;
  /// STRING
  String? messageId;
  /// STRING
  String? reference;

  TokenizeBatchCreateData({
    this.batches,
    this.messageId,
    this.reference,
  });

  factory TokenizeBatchCreateData.fromMap(Map<String, dynamic> m) => TokenizeBatchCreateData(
        batches: m['batches'] is List<dynamic> ? m['batches'] : null,
        messageId: m['messageId'] is String ? m['messageId'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batches) {
      m['batches'] = batches;
    }
    if (null != messageId) {
      m['messageId'] = messageId;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    return m;
  }
}

class TokenizeRead {
  /// STRING
  String? bfid;
  /// STRING
  String? messageId;
  /// STRING
  String? reference;
  /// OBJECT
  Map<String, dynamic>? state;
  /// ARRAY
  List<dynamic>? values;

  TokenizeRead({
    this.bfid,
    this.messageId,
    this.reference,
    this.state,
    this.values,
  });

  factory TokenizeRead.fromMap(Map<String, dynamic> m) => TokenizeRead(
        bfid: m['bfid'] is String ? m['bfid'] : null,
        messageId: m['messageId'] is String ? m['messageId'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        state: m['state'] is Map<String, dynamic> ? m['state'] : null,
        values: m['values'] is List<dynamic> ? m['values'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != messageId) {
      m['messageId'] = messageId;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != state) {
      m['state'] = state;
    }
    if (null != values) {
      m['values'] = values;
    }
    return m;
  }
}

class TokenizeReadCreateData {
  /// STRING
  String? bfid;
  /// STRING
  String? messageId;
  /// STRING
  String? reference;
  /// OBJECT
  Map<String, dynamic>? state;
  /// ARRAY
  List<dynamic>? values;

  TokenizeReadCreateData({
    this.bfid,
    this.messageId,
    this.reference,
    this.state,
    this.values,
  });

  factory TokenizeReadCreateData.fromMap(Map<String, dynamic> m) => TokenizeReadCreateData(
        bfid: m['bfid'] is String ? m['bfid'] : null,
        messageId: m['messageId'] is String ? m['messageId'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        state: m['state'] is Map<String, dynamic> ? m['state'] : null,
        values: m['values'] is List<dynamic> ? m['values'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != messageId) {
      m['messageId'] = messageId;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != state) {
      m['state'] = state;
    }
    if (null != values) {
      m['values'] = values;
    }
    return m;
  }
}

class Validate {
  /// STRING
  String? messageId;
  /// STRING
  String? reference;
  /// STRING (required at the API)
  String? templateRef;

  Validate({
    this.messageId,
    this.reference,
    this.templateRef,
  });

  factory Validate.fromMap(Map<String, dynamic> m) => Validate(
        messageId: m['messageId'] is String ? m['messageId'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        templateRef: m['templateRef'] is String ? m['templateRef'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != messageId) {
      m['messageId'] = messageId;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != templateRef) {
      m['templateRef'] = templateRef;
    }
    return m;
  }
}

class ValidateCreateData {
  /// STRING
  String? messageId;
  /// STRING
  String? reference;
  /// STRING (required at the API)
  String? templateRef;

  ValidateCreateData({
    this.messageId,
    this.reference,
    this.templateRef,
  });

  factory ValidateCreateData.fromMap(Map<String, dynamic> m) => ValidateCreateData(
        messageId: m['messageId'] is String ? m['messageId'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        templateRef: m['templateRef'] is String ? m['templateRef'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != messageId) {
      m['messageId'] = messageId;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != templateRef) {
      m['templateRef'] = templateRef;
    }
    return m;
  }
}

