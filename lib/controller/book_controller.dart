import 'package:books_app/model/book.dart';
import 'package:dio/dio.dart';

class BookController {
  BookController._privateConstructor();

  static final instance = BookController._privateConstructor();

  Future<List<Book>?> getSomeBooks() async {
    List<Book> books = [];
    try {
      final res = await Dio()
          .get('https://www.googleapis.com/books/v1/volumes?q=harrypotter');
      for (var item in res.data['items']) {
        final book = Book.fromJson(item);
        books.add(book);
      }
      return books;
    } on Exception catch (e) {
      return null;
    }
  }
}
