import 'dart:ui';

import 'package:books_app/controller/book_controller.dart';
import 'package:books_app/model/book.dart';
import 'package:books_app/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BooksPageService extends GetxController {
  List<Book> fetchedBooks = [];
  var inAsync = false.obs;

  BooksPageService() {
    fetchBooks();
  }

  fetchBooks() async {
    inAsync.value = true;
    final res = await BookController.instance.getSomeBooks();
    if (res != null) {
      fetchedBooks = res;
    }
    inAsync.value = false;
  }
}

class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bc = Get.put(BooksPageService());
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: SizedBox(
            width: Get.width * 0.8,
            child: const Text(
              'Explore thousands of\nbooks on the go',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text(
            'Famous Books',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Obx(
          () => bc.inAsync.value
              ? const Text('Loading..')
              : bc.fetchedBooks.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bc.fetchedBooks.length,
                      itemBuilder: (BuildContext context, int index) {
                        Book book = bc.fetchedBooks[index];
                        return BookCard(book: book);
                      })
                  : const Text('Nessun libro trovato'),
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}
