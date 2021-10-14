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

import 'package:books_app/provider/auth_provider.dart';
import 'package:books_app/model/book.dart';
import 'package:books_app/service/book_detail_service.dart';
import 'package:books_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class BookDetail extends StatelessWidget {
  final Book book;
  const BookDetail({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userUid = context.read<AuthProvider>().currentUser!.uid;
    final bookId = book.id;
    final bookDetailService = Get.put(BookDetailService(userUid, bookId!));
    final hasImage = book.volumeInfo!.imageLinks != null;
    return Scaffold(
      extendBody: true,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                height: 620,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // color: ThemeColor.primaryColor.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 30),
                      height: 100,
                      width: Get.width,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.black87,
                              size: 30,
                            ),
                          ),
                          const Spacer(),
                          Obx(
                            () => LikeButton(
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: ThemeColor.primaryColor,
                                dotSecondaryColor: Colors.black,
                              ),
                              likeBuilder: (bool isLiked) {
                                return isLiked
                                    ? const Icon(
                                        Icons.bookmark,
                                        color: Colors.black87,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.bookmark_border_rounded,
                                        color: Colors.black87,
                                        size: 30,
                                      );
                              },
                              isLiked: bookDetailService.isLiked.value,
                              onTap: (val) =>
                                  bookDetailService.updateFavorite(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Hero(
                      tag: book.volumeInfo!.hashCode,
                      transitionOnUserGestures: true,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 5,
                              blurRadius: 15,
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(10, 10),
                            )
                          ],
                        ),
                        child: GestureDetector(
                          onDoubleTap: () => bookDetailService.updateFavorite(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: hasImage
                                ? Image.network(
                                    book.volumeInfo!.imageLinks!.thumbnail!,
                                    scale: 0.65,
                                  )
                                : Image.network(
                                    'https://m.media-amazon.com/images/I/31l7Cfuq8oL.jpg',
                                    scale: 1.65,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: Get.width * 0.7,
                      child: Text(
                        book.volumeInfo!.title!,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.7,
                      child: Text(
                        "by " + book.volumeInfo!.authors!.first,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    RatingStars(
                      value: book.volumeInfo!.averageRating!.toDouble(),
                      starCount: 5,
                      valueLabelVisibility: false,
                      starColor: const Color.fromRGBO(239, 190, 78, 100),
                    ),
                  ],
                ),
              ),
            ],
          ),
          book.volumeInfo?.categories != null ? buildCatgories() : Container(),
          const SizedBox(height: 20),
          book.volumeInfo?.description != null
              ? buildDescription()
              : Container(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 70,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                spreadRadius: 5,
                color: Colors.grey.withOpacity(0.6),
              )
            ]),
        child: const Text(
          'Buy this book',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildCatgories() => SizedBox(
        height: 60,
        width: Get.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: book.volumeInfo!.categories!.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              margin: const EdgeInsets.only(left: 15, right: 5),
              alignment: Alignment.center,
              child: Text(
                book.volumeInfo!.categories![index],
                style: const TextStyle(fontSize: 22),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: const Color.fromRGBO(175, 221, 255, 50),
              ),
            );
          },
        ),
      );

  Widget buildDescription() => Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              'Description',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            endIndent: 20,
            indent: 20,
            color: Colors.indigo.withOpacity(0.4),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
              left: 12,
              right: 12,
              bottom: 20,
            ),
            child: Text(
              book.volumeInfo!.description!,
              style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
          ),
        ],
      );
}
