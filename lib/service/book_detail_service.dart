import 'package:books_app/controller/firestore_controller.dart';
import 'package:get/get.dart';

class BookDetailService extends GetxController {
  var isLiked = false.obs;
  late String userUid;
  late String bookId;

  BookDetailService(String idUser, String idBook) {
    userUid = idUser;
    bookId = idBook;
    subToFavorites();
  }

  void subToFavorites() {
    FirestoreController.instance.subscribeToFavoritesChange(userUid).listen(
      (event) {
        List<String>? favorites = (event['favoritesBooks'] as List)
            .map((item) => item as String)
            .toList();
        isLiked.value = favorites.contains(bookId);
      },
    );
  }

  Future<bool> updateFavorite() async {
    if (isLiked.value) {
      await FirestoreController.instance
          .deleteFavoritesBooksUser(userUid, bookId);
      isLiked.value = false;
      return false;
    }
    await FirestoreController.instance.addFavoritesBooksUser(userUid, bookId);
    isLiked.value = true;
    return true;
  }
}
