import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class EmptyFavorites extends StatelessWidget {
  const EmptyFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.7,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_rounded,
              size: 65,
              color: ThemeColor.primaryColor.withOpacity(0.5),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Your favourites list is empty!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeColor.primaryColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Explore books and add them to favourites\nto show them here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ThemeColor.primaryColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
