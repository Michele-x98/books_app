import 'package:books_app/provider/auth_provider.dart';
import 'package:books_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ThemeColor.primaryColor,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundColor: ThemeColor.primaryColor.withOpacity(0.1),
              radius: 50,
              child: user!.photoURL != null
                  ? Image.network(user.photoURL!)
                  : const Icon(
                      Icons.add_photo_alternate,
                      color: ThemeColor.primaryColor,
                      size: 60,
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Change profile picture',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ThemeColor.primaryColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              user.email!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ThemeColor.primaryColor,
              ),
            ),
            const Spacer(),
            TextButton(
                onPressed: () => context.read<AuthProvider>().singOut(),
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
