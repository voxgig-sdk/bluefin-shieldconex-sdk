class BluefinShieldconexError extends Error {
  final bool isBluefinShieldconexError = true;

  final String sdk = 'BluefinShieldconex';

  String code;
  String message;
  dynamic ctx;

  // Populated by makeError with the (cleaned) result and spec.
  dynamic result;
  dynamic spec;

  // HTTP status of the response that caused this error, or -1 when the
  // request never got one. PROMOTED to the top level: it used to be
  // reachable only at `err.result['status']`, so every consumer coupled
  // itself to the internal shape of `result`.
  int status = -1;

  bool get notFound => 404 == status;

  BluefinShieldconexError(this.code, this.message, [this.ctx]);

  @override
  String toString() => 'BluefinShieldconexError: ' + code + ': ' + message;
}
