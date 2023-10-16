/// Interface of project's base error.
abstract class AppError implements Exception {
  /// Message of error.
  final String? message;

  /// StackTrace of error.
  final StackTrace? stackTrace;

  /// Code of error.
  final String code;

  /// Base constructor of [AppError].
  AppError({
    required this.code,
    this.message,
    this.stackTrace,
  });

  @override
  String toString() {
    var value = '$runtimeType: $message';
    if (stackTrace != null) {
      value += '\n$stackTrace';
    }
    return value;
  }
}

/// Error used when something goes totally off the mark in adapters.
class AdapterError extends AppError {
  ///Base constructor of [AdapterError]
  AdapterError({
    required super.message,
    required super.code,
    required super.stackTrace,
  });
}

/// Error used when something goes totally off the mark.
class UnknownError extends AppError {
  ///Base constructor of [UnknownError]
  UnknownError({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'unknown-error');
}

/// Error used when encrypt error.
class EncryptError extends AppError {
  /// Base constructor of [EncryptError].
  EncryptError({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'encrypt-error');
}

/// Error used when decrypt error.
class DecryptError extends AppError {
  /// Base constructor of [DecryptError].
  DecryptError({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'decrypt-error');
}
