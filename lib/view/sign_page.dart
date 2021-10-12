import 'package:books_app/provider/auth_provider.dart';
import 'package:books_app/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 100,
            ),
            Obx(
              () => Form(
                key: authService.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
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
                        obscureText: authService.showPassword.value,
                        controller: authService.passwordController,
                        validator: authService.validatePassword,
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
                            onPressed: () => authService.showPassword.value =
                                !authService.showPassword.value,
                            icon: authService.showPassword.value
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AnimatedContainer(
                        height: authService.onLogin.value ? 0 : null,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                        child: authService.onLogin.value
                            ? Container()
                            : TextFormField(
                                obscureText: authService.showPassword.value,
                                controller:
                                    authService.confirmPasswordController,
                                validator: authService.validatePassword,
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
                                    onPressed: () =>
                                        authService.showPassword.value =
                                            !authService.showPassword.value,
                                    icon: authService.showPassword.value
                                        ? const Icon(Icons.visibility_outlined)
                                        : const Icon(
                                            Icons.visibility_off_outlined),
                                  ),
                                ),
                              ),
                      ),
                      authService.onLogin.value
                          ? Container()
                          : const SizedBox(
                              height: 20,
                            ),
                      ElevatedButton(
                        onPressed: authService.onLogin.value
                            ? () => authService.login(authProvider)
                            : () => authService.reg(authProvider),
                        child: Text(
                            authService.onLogin.value ? 'LOGIN' : 'REGISTRATI'),
                      ),
                      TextButton(
                        onPressed: () => authService.onLogin.value =
                            !authService.onLogin.value,
                        child: Text(
                            authService.onLogin.value ? 'REGISTRATI' : 'LOGIN'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SignInButton(
              buttonType: ButtonType.google,
              onPressed: () => authService.signWithGoogle(authProvider),
            ),
          ],
        ),
      ),
    );
  }
}
