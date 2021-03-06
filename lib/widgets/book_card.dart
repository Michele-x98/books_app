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
import 'package:books_app/theme.dart';
import 'package:books_app/view/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = book.volumeInfo?.title ?? 'Unknown';
    var authors = book.volumeInfo?.authors?.first ?? 'Unknown';
    var categories = book.volumeInfo?.categories?.first ?? 'Unknown';
    var rating = book.volumeInfo?.averageRating ?? 0;

    return Bounceable(
      onTap: () => Get.to(
        () => BookDetail(book: book),
        duration: const Duration(seconds: 1),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 25),
        padding: const EdgeInsets.all(12),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              spreadRadius: 5,
              color: Colors.grey.shade200,
            )
          ],
        ),
        child: Row(
          children: [
            book.volumeInfo!.imageLinks?.thumbnail != null
                ? Hero(
                    tag: book.volumeInfo!.hashCode,
                    transitionOnUserGestures: true,
                    child: ClipRRect(
                      child: Image.network(
                          book.volumeInfo!.imageLinks!.thumbnail!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )
                : ClipRRect(
                    child: Image.network(
                      'https://m.media-amazon.com/images/I/31l7Cfuq8oL.jpg',
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: Get.width * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "by " + authors,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildRating(rating),
                  const SizedBox(
                    height: 15,
                  ),
                  builCategories(categories),
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  Widget builCategories(String categories) => Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: ThemeColor.categoryContainerColor,
        margin: const EdgeInsets.all(0),
        child: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 5,
            bottom: 5,
          ),
          child: Text(
            categories,
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(75, 162, 255, 50),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  Widget buildRating(num rating) => Row(
        children: [
          const Icon(
            Icons.star,
            size: 18,
            color: Color.fromRGBO(239, 190, 78, 100),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            rating != 0 ? rating.toString() : "Unknown",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
}
