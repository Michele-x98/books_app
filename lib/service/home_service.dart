import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageService extends GetxController {
  final PageController controller = PageController();
  final currentIndex = 0.obs;

  void jumpTo(int index) {
    currentIndex.value = index;
    controller.jumpToPage(
      currentIndex.value,
    );
  }

  void goTo(int index) {
    (currentIndex.value - index).abs() > 1 ? jumpTo(index) : animateTo(index);
  }

  void animateTo(int index) {
    currentIndex.value = index;
    controller.animateToPage(
      currentIndex.value,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuad,
    );
  }
}
