import 'package:firebase_auth/firebase_auth.dart';
import 'package:paperopoli_terminal/core/errors/exceptions.dart';

class UserRepository {
  final FirebaseAuth firebaseAuth;

  UserRepository({
    required this.firebaseAuth,
  });

  Future<User?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async =>
      await firebaseAuth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (result) => result.user,
          )
          .catchError(
            (e) => throw AuthenticationException(
              e,
            ),
          );

  Future<bool> isSignedIn() async => firebaseAuth.currentUser != null;

  Future<User?> getUser() async => firebaseAuth.currentUser;
}
