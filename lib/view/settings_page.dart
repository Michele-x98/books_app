import 'package:books_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().currentUser;
    return Scaffold(
      body: ListView(
        children: [
          CircleAvatar(
            child: Image.network(user!.photoURL!),
          )
        ],
      ),
    );
  }
}
