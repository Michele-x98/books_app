abstract class FirestoreControllerInterface {
  Future initFavoritesFirestoreField(String userUid);
  void subscribeToFavoritesChange(String userUid);
  Future<bool> addFavoritesBooksUser(String userUid, String id);
  Future<bool> deleteFavoritesBooksUser(String userUid, String id);
}
