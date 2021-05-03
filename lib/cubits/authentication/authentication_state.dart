part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();

  @override
  String toString() => 'Initial';
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();

  @override
  String toString() => 'Logging';
}

class AuthenticationLoaded extends AuthenticationState {
  final User? user;

  const AuthenticationLoaded(
    this.user,
  );

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is AuthenticationLoaded && o.user == user;
  }

  @override
  int get hashCode => user.hashCode;

  @override
  String toString() => 'Logged';
}

class AuthenticationError extends AuthenticationState {
  final Exception exception;

  const AuthenticationError(
    this.exception,
  );
}
