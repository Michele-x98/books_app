import 'package:flutter/material.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('Explore thousands of books on the go'),
        //Search box
        Text('Famous Books'),
        //Card of books
      ],
    );
  }
}
