import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthControllerInterface {
  Stream<User?> subscribeToUserChange();
  Future<void> singOut();
  Future<UserCredential?> createUserWithEmailAndPassword(
    String email,
    String password,
  );
  Future<UserCredential?> loginInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<UserCredential?> signInWithGoogle();
}
