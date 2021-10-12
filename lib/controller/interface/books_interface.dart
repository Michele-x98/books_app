import 'package:books_app/model/book.dart';

abstract class BooksControllerInterface {
  Future<List<Book>?> getSomeBooks();
  Future<List<Book>?> searchBooks(String search);
  Future<List<Book>?> fetchFavoriteBooks(List<String> ids);
}
