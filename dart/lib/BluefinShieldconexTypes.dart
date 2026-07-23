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
  List<dynamic>? batch;
  /// STRING
  String? bfid;
  /// STRING
  String? message_id;
  /// STRING
  String? name;
  /// STRING
  String? reference;
  /// ARRAY
  List<dynamic>? value;

  Detokenize({
    this.batch,
    this.bfid,
    this.message_id,
    this.name,
    this.reference,
    this.value,
  });

  factory Detokenize.fromMap(Map<String, dynamic> m) => Detokenize(
        batch: m['batch'] is List<dynamic> ? m['batch'] : null,
        bfid: m['bfid'] is String ? m['bfid'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        name: m['name'] is String ? m['name'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        value: m['value'] is List<dynamic> ? m['value'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batch) {
      m['batch'] = batch;
    }
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
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
    return m;
  }
}

class DetokenizeListMatch {
  /// ARRAY
  List<dynamic>? batch;
  /// STRING
  String? bfid;
  /// STRING
  String? message_id;
  /// STRING
  String? name;
  /// STRING
  String? reference;
  /// ARRAY
  List<dynamic>? value;

  DetokenizeListMatch({
    this.batch,
    this.bfid,
    this.message_id,
    this.name,
    this.reference,
    this.value,
  });

  factory DetokenizeListMatch.fromMap(Map<String, dynamic> m) => DetokenizeListMatch(
        batch: m['batch'] is List<dynamic> ? m['batch'] : null,
        bfid: m['bfid'] is String ? m['bfid'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        name: m['name'] is String ? m['name'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        value: m['value'] is List<dynamic> ? m['value'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batch) {
      m['batch'] = batch;
    }
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
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
    return m;
  }
}

class DetokenizeCreateData {
  /// ARRAY
  List<dynamic>? batch;
  /// STRING
  String? bfid;
  /// STRING
  String? message_id;
  /// STRING
  String? name;
  /// STRING
  String? reference;
  /// ARRAY
  List<dynamic>? value;

  DetokenizeCreateData({
    this.batch,
    this.bfid,
    this.message_id,
    this.name,
    this.reference,
    this.value,
  });

  factory DetokenizeCreateData.fromMap(Map<String, dynamic> m) => DetokenizeCreateData(
        batch: m['batch'] is List<dynamic> ? m['batch'] : null,
        bfid: m['bfid'] is String ? m['bfid'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        name: m['name'] is String ? m['name'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        value: m['value'] is List<dynamic> ? m['value'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batch) {
      m['batch'] = batch;
    }
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
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
    return m;
  }
}

class Tokenize {
  /// ARRAY
  List<dynamic>? batch;
  /// STRING
  String? bfid;
  /// STRING
  String? message_id;
  /// STRING
  String? name;
  /// STRING
  String? reference;
  /// STRING (required at the API)
  String? template_ref;
  /// ARRAY
  List<dynamic>? value;

  Tokenize({
    this.batch,
    this.bfid,
    this.message_id,
    this.name,
    this.reference,
    this.template_ref,
    this.value,
  });

  factory Tokenize.fromMap(Map<String, dynamic> m) => Tokenize(
        batch: m['batch'] is List<dynamic> ? m['batch'] : null,
        bfid: m['bfid'] is String ? m['bfid'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        name: m['name'] is String ? m['name'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        template_ref: m['template_ref'] is String ? m['template_ref'] : null,
        value: m['value'] is List<dynamic> ? m['value'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batch) {
      m['batch'] = batch;
    }
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != name) {
      m['name'] = name;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != template_ref) {
      m['template_ref'] = template_ref;
    }
    if (null != value) {
      m['value'] = value;
    }
    return m;
  }
}

class TokenizeListMatch {
  /// ARRAY
  List<dynamic>? batch;
  /// STRING
  String? bfid;
  /// STRING
  String? message_id;
  /// STRING
  String? name;
  /// STRING
  String? reference;
  /// STRING
  String? template_ref;
  /// ARRAY
  List<dynamic>? value;

  TokenizeListMatch({
    this.batch,
    this.bfid,
    this.message_id,
    this.name,
    this.reference,
    this.template_ref,
    this.value,
  });

  factory TokenizeListMatch.fromMap(Map<String, dynamic> m) => TokenizeListMatch(
        batch: m['batch'] is List<dynamic> ? m['batch'] : null,
        bfid: m['bfid'] is String ? m['bfid'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        name: m['name'] is String ? m['name'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        template_ref: m['template_ref'] is String ? m['template_ref'] : null,
        value: m['value'] is List<dynamic> ? m['value'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batch) {
      m['batch'] = batch;
    }
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != name) {
      m['name'] = name;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != template_ref) {
      m['template_ref'] = template_ref;
    }
    if (null != value) {
      m['value'] = value;
    }
    return m;
  }
}

class TokenizeCreateData {
  /// ARRAY
  List<dynamic>? batch;
  /// STRING
  String? bfid;
  /// STRING
  String? message_id;
  /// STRING
  String? name;
  /// STRING
  String? reference;
  /// STRING (required at the API)
  String? template_ref;
  /// ARRAY
  List<dynamic>? value;

  TokenizeCreateData({
    this.batch,
    this.bfid,
    this.message_id,
    this.name,
    this.reference,
    this.template_ref,
    this.value,
  });

  factory TokenizeCreateData.fromMap(Map<String, dynamic> m) => TokenizeCreateData(
        batch: m['batch'] is List<dynamic> ? m['batch'] : null,
        bfid: m['bfid'] is String ? m['bfid'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        name: m['name'] is String ? m['name'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        template_ref: m['template_ref'] is String ? m['template_ref'] : null,
        value: m['value'] is List<dynamic> ? m['value'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batch) {
      m['batch'] = batch;
    }
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != name) {
      m['name'] = name;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != template_ref) {
      m['template_ref'] = template_ref;
    }
    if (null != value) {
      m['value'] = value;
    }
    return m;
  }
}

class TokenizeBatch {
  /// ARRAY
  List<dynamic>? batch;
  /// STRING
  String? message_id;
  /// STRING
  String? reference;

  TokenizeBatch({
    this.batch,
    this.message_id,
    this.reference,
  });

  factory TokenizeBatch.fromMap(Map<String, dynamic> m) => TokenizeBatch(
        batch: m['batch'] is List<dynamic> ? m['batch'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batch) {
      m['batch'] = batch;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    return m;
  }
}

class TokenizeBatchCreateData {
  /// ARRAY
  List<dynamic>? batch;
  /// STRING
  String? message_id;
  /// STRING
  String? reference;

  TokenizeBatchCreateData({
    this.batch,
    this.message_id,
    this.reference,
  });

  factory TokenizeBatchCreateData.fromMap(Map<String, dynamic> m) => TokenizeBatchCreateData(
        batch: m['batch'] is List<dynamic> ? m['batch'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != batch) {
      m['batch'] = batch;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
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
  String? message_id;
  /// STRING
  String? reference;
  /// OBJECT
  Map<String, dynamic>? state;
  /// ARRAY
  List<dynamic>? value;

  TokenizeRead({
    this.bfid,
    this.message_id,
    this.reference,
    this.state,
    this.value,
  });

  factory TokenizeRead.fromMap(Map<String, dynamic> m) => TokenizeRead(
        bfid: m['bfid'] is String ? m['bfid'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        state: m['state'] is Map<String, dynamic> ? m['state'] : null,
        value: m['value'] is List<dynamic> ? m['value'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != state) {
      m['state'] = state;
    }
    if (null != value) {
      m['value'] = value;
    }
    return m;
  }
}

class TokenizeReadCreateData {
  /// STRING
  String? bfid;
  /// STRING
  String? message_id;
  /// STRING
  String? reference;
  /// OBJECT
  Map<String, dynamic>? state;
  /// ARRAY
  List<dynamic>? value;

  TokenizeReadCreateData({
    this.bfid,
    this.message_id,
    this.reference,
    this.state,
    this.value,
  });

  factory TokenizeReadCreateData.fromMap(Map<String, dynamic> m) => TokenizeReadCreateData(
        bfid: m['bfid'] is String ? m['bfid'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        state: m['state'] is Map<String, dynamic> ? m['state'] : null,
        value: m['value'] is List<dynamic> ? m['value'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != bfid) {
      m['bfid'] = bfid;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != state) {
      m['state'] = state;
    }
    if (null != value) {
      m['value'] = value;
    }
    return m;
  }
}

class Validate {
  /// STRING
  String? message_id;
  /// STRING
  String? reference;
  /// STRING (required at the API)
  String? template_ref;

  Validate({
    this.message_id,
    this.reference,
    this.template_ref,
  });

  factory Validate.fromMap(Map<String, dynamic> m) => Validate(
        message_id: m['message_id'] is String ? m['message_id'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        template_ref: m['template_ref'] is String ? m['template_ref'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != template_ref) {
      m['template_ref'] = template_ref;
    }
    return m;
  }
}

class ValidateCreateData {
  /// STRING
  String? message_id;
  /// STRING
  String? reference;
  /// STRING (required at the API)
  String? template_ref;

  ValidateCreateData({
    this.message_id,
    this.reference,
    this.template_ref,
  });

  factory ValidateCreateData.fromMap(Map<String, dynamic> m) => ValidateCreateData(
        message_id: m['message_id'] is String ? m['message_id'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        template_ref: m['template_ref'] is String ? m['template_ref'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != template_ref) {
      m['template_ref'] = template_ref;
    }
    return m;
  }
}

