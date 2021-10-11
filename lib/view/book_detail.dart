import 'package:books_app/model/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookDetail extends StatelessWidget {
  final Book book;
  const BookDetail({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.indigo,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.fadeTitle],
              titlePadding: const EdgeInsets.only(top: 40),
              background: Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: book.volumeInfo!.imageLinks != null
                    ? Hero(
                        tag: book.volumeInfo!.imageLinks!.thumbnail!,
                        child: Image.network(
                            book.volumeInfo!.imageLinks!.thumbnail!),
                      )
                    : const Icon(Icons.device_unknown),
              ),
              centerTitle: true,
            ),
            leading: IconButton(
              icon:
                  const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: 100,
                  width: Get.width,
                  color: Colors.indigo,
                ),
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                  ),
                  child: SizedBox(
                    width: Get.width * 0.8,
                    child: Text(
                      book.volumeInfo!.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data')
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
