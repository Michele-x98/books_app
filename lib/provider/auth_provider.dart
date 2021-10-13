import 'package:books_app/controller/auth_controller.dart';
import 'package:books_app/service/home_service.dart';
import 'package:books_app/view/sign_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class AuthProvider {
  RxBool isUserLoggedIn = false.obs;
  User? currentUser;

  AuthProvider() {
    subscribeToUserChange();
  }

  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password) async {
    return await AuthController.instance
        .createUserWithEmailAndPassword(email, password);
  }

  Future<UserCredential?> loginInWithEmailAndPassword(
      String email, String password) async {
    return await AuthController.instance
        .loginInWithEmailAndPassword(email, password);
  }

  Future<UserCredential?> signInWithGoogle() async {
    return await AuthController.instance.signInWithGoogle();
  }

  Future<void> singOut() async {
    return await AuthController.instance.singOut().then((value) => {
          Get.find<HomePageService>().controller.jumpTo(0),
          Get.offAll(() => const SignPage())
        });
  }

  void subscribeToUserChange() {
    AuthController.instance.subscribeToUserChange().listen(
          (User? event) => _handleUserChange(event),
        );
  }

  Future<bool> checkUserLoggedIn() async {
    return FirebaseAuth.instance.currentUser != null ? true : false;
  }

  _handleUserChange(User? user) {
    if (user == null) {
      currentUser = user;
      isUserLoggedIn.value = false;
    } else {
      currentUser = user;
      isUserLoggedIn.value = true;
    }
  }
}
