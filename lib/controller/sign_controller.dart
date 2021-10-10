import 'package:books_app/controller/auth_controller.dart';
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
    await controller.loginInWithEmailAndPassword(
      emailController.text,
      passwordController.text,
    );
    //Go to home page..
  }

  void reg(AuthController controller) async {
    if (!formKey.currentState!.validate()) return;
    await controller.createUserWithEmailAndPassword(
      emailController.text,
      passwordController.text,
    );
    //Go to home page..
  }

  void signWithGoogle(AuthController controller) async {
    await controller.signInWithGoogle();
    //Go to home page..
  }
}
