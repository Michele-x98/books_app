import 'package:books_app/provider/auth_provider.dart';
import 'package:books_app/controller/firestore_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text('Favorites'),
          TextButton(
            onPressed: () => FirestoreController.instance
                .initFavoritesFirestoreField('testUserUID'),
            child: Text('generate'),
          ),
          TextButton(
            onPressed: () => FirestoreController.instance
                .addFavoritesBooksUser('testUserUID', 'id1'),
            child: Text('add'),
          ),
          TextButton(
            onPressed: () => FirestoreController.instance
                .deleteFavoritesBooksUser('testUserUID', 'id1'),
            child: Text('delete'),
          ),
          TextButton(
            onPressed: () => context.read<AuthProvider>().singOut(),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
