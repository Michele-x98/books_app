import 'package:books_app/controller/home_controller.dart';
import 'package:books_app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'books_page.dart';
import 'favorites_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hpc = Get.put(HomePageController());
    return Scaffold(
      body: Obx(
        () => PageView(
          controller: hpc.controller,
          children: const [
            BooksPage(),
            FavoritesPage(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
