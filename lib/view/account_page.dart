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
      bottomNavigationBar: TextButton(
        onPressed: () => context.read<AuthProvider>().singOut(),
        child: const Text('Logout'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Profile',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: ThemeColor.primaryColor.withOpacity(0.1),
                  radius: 25,
                  child: user!.photoURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            user.photoURL!,
                            scale: 3.2,
                          ),
                        )
                      : const Icon(
                          Icons.photo_camera,
                          color: ThemeColor.primaryColor,
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            user.email!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: ThemeColor.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
