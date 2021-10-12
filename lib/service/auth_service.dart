import 'dart:developer';

import 'package:books_app/provider/auth_provider.dart';
import 'package:books_app/view/home_page.dart';
import 'package:books_app/widgets/completed_snackbar.dart';
import 'package:books_app/widgets/show_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/firestore_controller.dart';

class AuthService extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool showPassword = true.obs;
  RxBool onLogin = true.obs;

  String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Error, empty password';
    }
    if (password.length < 4 || password.length > 12) {
      return 'Error, password incorrect';
    }
    return null;
  }

  void login(AuthProvider controller) async {
    if (!formKey.currentState!.validate()) return;
    final res = await showOverlayDuringAsync(
      controller.loginInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      ),
    );
    if (res != null) {
      await showOverlayDuringAsync(_initFirestoreFavoritesField(res.user!.uid));
      Get.offAll(() => const HomePage());
    }
  }

  void reg(AuthProvider controller) async {
    if (!formKey.currentState!.validate()) return;
    UserCredential? res = await showOverlayDuringAsync(
      controller.createUserWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      ),
    );

    if (res != null) {
      await _initFirestoreFavoritesField(res.user!.uid);
      Get.offAll(const HomePage());
      completeSnackbar('Registration completed');
    }
  }

  void signWithGoogle(AuthProvider controller) async {
    final res = await controller.signInWithGoogle();
    if (res != null) {
      await _initFirestoreFavoritesField(res.user!.uid);
      Get.offAll(const HomePage());
    }
  }

  Future _initFirestoreFavoritesField(String userUid) async {
    await FirestoreController.instance.initFavoritesFirestoreField(userUid);
  }

  @override
  void onClose() {
    log('AuthService close');
    super.onClose();
  }
}
