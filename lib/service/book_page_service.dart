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
import 'package:books_app/model/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BooksPageService extends GetxController {
  List<Book> fetchedBooks = [];
  var inAsync = false.obs;
  TextEditingController textController = TextEditingController();
  BookController _bookController = BookController.instance;

  BooksPageService() {
    fetchBooks();
  }

  fetchBooks() async {
    inAsync.value = true;
    final res = await _bookController.getSomeBooks();
    if (res != null) {
      fetchedBooks = res;
    }
    inAsync.value = false;
  }

  searchBooks(String val) async {
    inAsync.value = true;
    final res = await Future.delayed(
      Duration(milliseconds: 500),
      () => _bookController.searchBooks(val),
    );
    if (res != null) {
      fetchedBooks = res;
    }
    inAsync.value = false;
  }
}
