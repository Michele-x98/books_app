import 'package:books_app/controller/book_controller.dart';
import 'package:books_app/model/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BooksPageService extends GetxController {
  List<Book> fetchedBooks = [];
  var inAsync = false.obs;
  TextEditingController textController = TextEditingController();

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

  searchBooks(String val) async {
    inAsync.value = true;
    final res = await BookController.instance.searchBooks(val);
    if (res != null) {
      fetchedBooks = res;
    }
    inAsync.value = false;
  }
}
