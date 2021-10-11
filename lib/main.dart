import 'package:books_app/controller/auth_controller.dart';
import 'package:books_app/view/home_page.dart';
import 'package:books_app/view/sign_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthController(),
      lazy: false,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context) {
          return Obx(
            () => context.read<AuthController>().isUserLoggedIn.value
                ? HomePage()
                : SignPage(),
          );
        }),
      ),
    );
  }
}
