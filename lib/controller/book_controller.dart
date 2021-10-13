import 'package:books_app/model/book.dart';
import 'package:dio/dio.dart';

import 'interface/books_interface.dart';

class BookController implements BooksControllerInterface {
  BookController._privateConstructor();

  static final instance = BookController._privateConstructor();

  @override
  Future<List<Book>?> getSomeBooks() async {
    List<Book> books = [];
    try {
      final res = await Dio()
          .get('https://www.googleapis.com/books/v1/volumes?q=harry+potter');
      for (var item in res.data['items']) {
        final book = Book.fromJson(item);
        books.add(book);
      }
      return books;
    } on Exception {
      return null;
    }
  }

  @override
  Future<List<Book>?> searchBooks(String search) async {
    List<Book> books = [];
    try {
      final res = await Dio()
          .get('https://www.googleapis.com/books/v1/volumes?q=$search');
      for (var item in res.data['items']) {
        final book = Book.fromJson(item);
        books.add(book);
      }
      return books;
    } on Exception {
      return null;
    }
  }

  @override
  Future<List<Book>?> fetchFavoriteBooks(List<String> ids) async {
    List<Book> books = [];
    for (var item in ids) {
      Book? book = await fetchBookById(item);
      if (book != null) {
        books.add(book);
      }
    }
    return books;
  }

  Future<Book?> fetchBookById(String id) async {
    try {
      final res =
          await Dio().get('https://www.googleapis.com/books/v1/volumes/$id');
      if (res.statusCode == 200) {
        final book = Book.fromJson(res.data);
        return book;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
