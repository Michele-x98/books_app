import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  final PageController controller = PageController();
  final currentIndex = 0.obs;

  void animateTo(int index) {
    currentIndex.value = index;
    controller.animateToPage(
      currentIndex.value,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuad,
    );
  }
}
