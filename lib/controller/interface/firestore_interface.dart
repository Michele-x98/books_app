import 'package:firebase_auth/firebase_auth.dart';

abstract class FirestoreControllerInterface {
  Future initFavoritesFirestoreField(User user);
  void subscribeToFavoritesChange(String userUid);
  Future<bool> addFavoritesBooksUser(String userUid, String id);
  Future<bool> deleteFavoritesBooksUser(String userUid, String id);
}
