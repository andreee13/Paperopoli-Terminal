import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:paperopoli_terminal/core/errors/exceptions.dart';
import 'package:paperopoli_terminal/data/repositories/user_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final UserRepository repository;

  AuthenticationCubit({
    required this.repository,
  }) : super(
          AuthenticationInitial(),
        );

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(
        AuthenticationLoading(),
      );
      emit(
        AuthenticationLoaded(
          await repository.isSignedIn()
              ? await repository.getUser()
              : await repository.signInWithEmailPassword(
                  email: email,
                  password: password,
                ),
        ),
      );
    } on AuthenticationException catch (e, _) {
      emit(
        AuthenticationError(e),
      );
    }
  }
}
