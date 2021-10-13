import 'package:books_app/service/home_service.dart';
import 'package:books_app/view/account_page.dart';
import 'package:books_app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'books_page.dart';
import 'favourites_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hpc = Get.put(HomePageService());
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: hpc.controller,
        children: const [
          BooksPage(),
          FavouritesPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
