class ServerException implements Exception {
  int? i;
  Exception? e;

  ServerException([
    i,
    e,
  ]);

  @override
  String toString() => 'ServerException: code $e';
}

class AuthenticationException implements Exception {
  final Exception e;

  const AuthenticationException(
    this.e,
  );

  @override
  String toString() => 'AuthenticationException: $e';
}

class CriticalException implements Exception {
  final Exception _exception;

  const CriticalException(this._exception);

  @override
  String toString() => 'CriticalException: ${_exception.toString()}';
}
