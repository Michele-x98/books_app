import 'dart:developer';

import 'package:books_app/widgets/error_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'interface/auth_interface.dart';

class AuthController implements AuthControllerInterface {
  AuthController._privateConstructor();
  static final instance = AuthController._privateConstructor();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorSnackbar('The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        errorSnackbar('The account already exists for that email.');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserCredential?> loginInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorSnackbar('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        errorSnackbar('Wrong password provided for that user.');
        return null;
      }
    }
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;
        if (googleAuth != null) {
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          return userCredential;
        }
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<void> singOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Stream<User?> subscribeToUserChange() {
    return firebaseAuth.authStateChanges();
  }
}
