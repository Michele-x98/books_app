import 'package:books_app/controller/auth_controller.dart';
import 'package:books_app/view/home_page.dart';
import 'package:books_app/widgets/completed_snackbar.dart';
import 'package:books_app/widgets/show_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignController extends GetxController {
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

  void login(AuthController controller) async {
    if (!formKey.currentState!.validate()) return;
    final res = await showOverlayDuringAsync(
      controller.loginInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      ),
    );

    if (res != null) {
      completeSnackbar('Login completed');
      Get.to(const HomePage());
    }
  }

  void reg(AuthController controller) async {
    if (!formKey.currentState!.validate()) return;
    final res = await showOverlayDuringAsync(
      controller.createUserWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      ),
    );

    if (res != null) {
      completeSnackbar('Registration completed');
      Get.to(const HomePage());
    }
  }

  void signWithGoogle(AuthController controller) async {
    final res = await controller.signInWithGoogle();
    if (res != null) {
      Get.to(const HomePage());
    }
  }
}
