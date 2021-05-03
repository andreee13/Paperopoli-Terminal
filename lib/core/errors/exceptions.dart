class FetchException implements Exception {
  int? i;
  Exception? e;

  FetchException([
    i,
    e,
  ]);

  @override
  String toString() => 'FetchException: code $e';
}

class DatabaseException implements Exception {
  final Exception e;

  const DatabaseException(
    this.e,
  );
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
