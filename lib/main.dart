import 'package:books_app/provider/auth_provider.dart';
import 'package:books_app/view/home_page.dart';
import 'package:books_app/view/sign_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AuthProvider(),
          lazy: false,
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser != null
            ? const HomePage()
            : const SignPage(),
      ),
    );
  }
}
