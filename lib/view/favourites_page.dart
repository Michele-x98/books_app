import 'package:books_app/controller/book_controller.dart';
import 'package:books_app/controller/firestore_controller.dart';
import 'package:books_app/model/book.dart';
import 'package:books_app/provider/auth_provider.dart';
import 'package:books_app/widgets/book_card.dart';
import 'package:books_app/widgets/empty_favourites.dart';
import 'package:books_app/widgets/loading_books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

/* 
 * In questa pagina ho utilizzato un approccio differente dalle altre,
 * attraverso un StreamBuilder mi metto in ascolto dei preferiti dell'utente
 * e della loro variazione, cosi che ad ogni variazione, anche esterena, la pagina si
 * ricarichi con i nuovi libri aggiunti ai prefereiti.
 */
class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: SizedBox(
              width: Get.width * 0.8,
              child: const Text(
                'Your Favorites Books',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: FirestoreController.instance.subscribeToFavoritesChange(
              context.read<AuthProvider>().currentUser!.uid,
            ),
            builder: (
              context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
            ) {
              if (snapshot.hasData) {
                var json = snapshot.data!['favoritesBooks'];
                var favorites = json as List;
                List<String> ids =
                    favorites.map((item) => item as String).toList();
                return FutureBuilder(
                  future: BookController.instance.fetchFavoriteBooks(ids),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Book>?> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            Book book = snapshot.data![index];
                            return BookCard(book: book);
                          },
                        );
                      }
                      return const EmptyFavorites();
                    }
                    return const LoadingBooks();
                  },
                );
              }
              return const LoadingBooks();
            },
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
