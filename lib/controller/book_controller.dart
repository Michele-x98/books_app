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
