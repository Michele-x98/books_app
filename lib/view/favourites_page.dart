/*
 * BSD 3-Clause License

    Copyright (c) 2021, MICHELE BENEDETTI - MailTo: michelebenx98@gmail.com
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 */

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
                'Your Favourites Books',
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
