import 'package:books_app/provider/auth_provider.dart';
import 'package:books_app/service/auth_service.dart';
import 'package:books_app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/create_button.dart';
import 'package:sign_button/sign_button.dart';

class SignPage extends StatelessWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return GetBuilder<AuthService>(
      init: AuthService(),
      builder: (AuthService authService) => Scaffold(
        body: Scaffold(
          body: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.indigo.withOpacity(0.05),
                  radius: 60,
                  child: const Icon(
                    Icons.menu_book_rounded,
                    size: 70,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Welcome to MyBooks!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Search and buy your books',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.indigo.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Form(
                    key: authService.formKey,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 18.0, right: 18, top: 18),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: authService.emailController,
                            validator: (v) {},
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                            obscureText: authService.showPassword.value,
                            controller: authService.passwordController,
                            validator: authService.validatePassword,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              alignLabelWithHint: true,
                              labelText: 'Password',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              prefixIcon: const Icon(
                                CupertinoIcons.lock_fill,
                                size: 25,
                              ),
                              errorText: null,
                              suffixIcon: IconButton(
                                onPressed: () => authService.showPassword
                                    .value = !authService.showPassword.value,
                                icon: authService.showPassword.value
                                    ? const Icon(Icons.visibility_outlined)
                                    : const Icon(Icons.visibility_off_outlined),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AnimatedSlide(
                            duration: const Duration(milliseconds: 600),
                            offset: authService.onLogin.value
                                ? const Offset(2, 0)
                                : Offset.zero,
                            child: AnimatedContainer(
                              height: authService.onLogin.value ? 0 : 85,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                              child: authService.onLogin.value
                                  ? Container()
                                  : TextFormField(
                                      obscureText:
                                          authService.showPassword.value,
                                      controller:
                                          authService.confirmPasswordController,
                                      validator: authService.validatePassword,
                                      decoration: InputDecoration(
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        labelText: 'Confirm Password',
                                        prefixIcon: const Icon(
                                          CupertinoIcons.lock_fill,
                                          size: 25,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () => authService
                                                  .showPassword.value =
                                              !authService.showPassword.value,
                                          icon: authService.showPassword.value
                                              ? const Icon(
                                                  Icons.visibility_outlined)
                                              : const Icon(Icons
                                                  .visibility_off_outlined),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          authService.onLogin.value
                              ? Container()
                              : const SizedBox(
                                  height: 20,
                                ),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                width: Get.width * 0.9, height: 60),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: authService.onLogin.value
                                  ? () => authService.login(authProvider)
                                  : () => authService.reg(authProvider),
                              child: Text(
                                authService.onLogin.value
                                    ? 'Login'
                                    : 'Register',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          TextButton(
                            child: const Text('Forgot Password?'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Text(
                  'or',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18, top: 10),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: Get.width * 0.8,
                      height: 60,
                    ),
                    child: SignInButton(
                      buttonType: ButtonType.google,
                      buttonSize: ButtonSize.medium,
                      onPressed: () => authService.signWithGoogle(authProvider),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Obx(
              () => RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: authService.onLogin.value
                      ? "Don't have an account? "
                      : "Already have an account?",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text:
                          authService.onLogin.value ? ' Register!' : ' Login!',
                      style: const TextStyle(color: Colors.indigo),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => authService.onLogin.value =
                            !authService.onLogin.value,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
