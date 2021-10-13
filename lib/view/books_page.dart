import 'dart:ui';

import 'package:books_app/model/book.dart';
import 'package:books_app/service/book_page_service.dart';
import 'package:books_app/widgets/book_card.dart';
import 'package:books_app/widgets/loading_books.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bc = Get.put(BooksPageService());
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
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
        Container(
          height: 60,
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                spreadRadius: 0,
                color: Colors.grey.shade300,
              )
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.search_sharp, color: Colors.grey.shade400),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  autofocus: false,
                  onChanged: (val) => {
                    if (val.isNotEmpty) {bc.searchBooks(val)}
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    label: Text(
                      'Search for books..',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  cursorColor: Colors.indigo,
                ),
              )
            ],
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
              ? const LoadingBooks()
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
