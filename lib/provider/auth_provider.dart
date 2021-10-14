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
