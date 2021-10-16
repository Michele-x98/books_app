/*
 * BSD 3-Clause License

    Copyright (c) 2021, MICHELE BENEDETTI - MailTo: michelebenx98@gmail.com
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 */

import 'dart:math';

import 'package:books_app/provider/auth_provider.dart';
import 'package:books_app/view/home_page.dart';
import 'package:books_app/widgets/completed_snackbar.dart';
import 'package:books_app/widgets/show_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';

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

  String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'Error, empty email';
    }
    if (email.length < 4 || email.length > 16) {
      return 'Error, the password must be between 4 and 16 characters';
    }
    if (EmailValidator.validate(email)) {
      return null;
    } else {
      return 'Error, invalid email';
    }
  }

  void login(AuthProvider controller) async {
    if (!formKey.currentState!.validate()) return;
    UserCredential? res = await showOverlayDuringAsync(
      controller.loginInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      ),
    );
    if (res != null) {
      await showOverlayDuringAsync(_initFirestoreFavoritesField(res.user!));
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
      await _initFirestoreFavoritesField(res.user!);
      Get.offAll(const HomePage());
      completeSnackbar('Registration completed');
    }
  }

  void signWithGoogle(AuthProvider controller) async {
    UserCredential? res =
        await showOverlayDuringAsync(controller.signInWithGoogle());

    if (res != null) {
      await _initFirestoreFavoritesField(res.user!);
      Get.offAll(const HomePage());
    }
  }

  Future _initFirestoreFavoritesField(User user) async {
    await FirestoreController.instance.initFavoritesFirestoreField(user);
  }
}
