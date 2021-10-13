import 'package:books_app/service/home_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hpc = Get.find<HomePageService>();
    return Obx(
      () => SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: (index) => hpc.animateTo(index),
        iconSize: 30,
        activeColor: const Color(0xFF01579B),
        selectedIndex: hpc.currentIndex.value,
        barItems: [
          BarItem(
            icon: Icons.menu_book_rounded,
            title: 'Books',
          ),
          BarItem(
            icon: Icons.favorite_rounded,
            title: 'Favorites',
          ),
          BarItem(
            icon: Icons.tune_rounded,
            title: 'Account',
          ),
        ],
      ),
    );
  }
}
