import 'package:books_app/controller/auth_controller.dart';
import 'package:books_app/controller/sign_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/create_button.dart';
import 'package:sign_button/sign_button.dart';

import 'home_page.dart';

class SignPage extends StatelessWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sc = Get.put(SignController());
    final authController = context.read<AuthController>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(
            size: 100,
          ),
          Obx(
            () => Form(
              key: sc.formKey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: sc.emailController,
                      validator: (v) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Email',
                        //TODO validate email
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.account_circle,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: sc.showPassword.value,
                      controller: sc.passwordController,
                      validator: sc.validatePassword,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Password',
                        prefixIcon: const Icon(
                          CupertinoIcons.lock_fill,
                          size: 25,
                        ),
                        errorText: null,
                        suffixIcon: IconButton(
                          onPressed: () =>
                              sc.showPassword.value = !sc.showPassword.value,
                          icon: sc.showPassword.value
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedContainer(
                      height: sc.onLogin.value ? 0 : null,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      child: sc.onLogin.value
                          ? Container()
                          : TextFormField(
                              obscureText: sc.showPassword.value,
                              controller: sc.confirmPasswordController,
                              validator: sc.validatePassword,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Confirm Password',
                                prefixIcon: const Icon(
                                  CupertinoIcons.lock_fill,
                                  size: 25,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () => sc.showPassword.value =
                                      !sc.showPassword.value,
                                  icon: sc.showPassword.value
                                      ? const Icon(Icons.visibility_outlined)
                                      : const Icon(
                                          Icons.visibility_off_outlined),
                                ),
                              ),
                            ),
                    ),
                    sc.onLogin.value
                        ? Container()
                        : const SizedBox(
                            height: 20,
                          ),
                    ElevatedButton(
                      onPressed: sc.onLogin.value
                          ? () => sc.login(authController)
                          : () => sc.reg(authController),
                      child: Text(sc.onLogin.value ? 'LOGIN' : 'REGISTRATI'),
                    ),
                    TextButton(
                      onPressed: () => sc.onLogin.value = !sc.onLogin.value,
                      child: Text(sc.onLogin.value ? 'REGISTRATI' : 'LOGIN'),
                    )
                  ],
                ),
              ),
            ),
          ),
          SignInButton(
            buttonType: ButtonType.google,
            onPressed: () => sc.signWithGoogle(authController),
          ),
        ],
      ),
    );
  }
}
