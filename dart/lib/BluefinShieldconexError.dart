class BluefinShieldconexError extends Error {
  final bool isBluefinShieldconexError = true;

  final String sdk = 'BluefinShieldconex';

  String code;
  String message;
  dynamic ctx;

  // Populated by makeError with the (cleaned) result and spec.
  dynamic result;
  dynamic spec;

  BluefinShieldconexError(this.code, this.message, [this.ctx]);

  @override
  String toString() => 'BluefinShieldconexError: ' + code + ': ' + message;
}
