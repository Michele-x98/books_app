import 'dart:developer';

import 'package:books_app/widgets/error_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isUserLoggedIn = false.obs;
  User? currentUser;

  AuthController() {
    subscribeToUserChange();
  }

  Future subscribeToUserChange() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User NOT logged in');
        currentUser = user;
        isUserLoggedIn.value = false;
      } else {
        print('User Logged in');
        currentUser = user;
        isUserLoggedIn.value = true;
      }
    });
  }

  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await auth.createUserWithEmailAndPassword(
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

  Future<UserCredential?> loginInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
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

  Future<void> singOut() async {
    await auth.signOut();
  }

  //TODO Handle excpetion
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception {
      return null;
    }
  }
}
