import 'package:cloud_firestore/cloud_firestore.dart';

import 'interface/firestore_interface.dart';

class FirestoreController implements FirestoreControllerInterface {
  FirestoreController._privateConstructor();

  static final instance = FirestoreController._privateConstructor();

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Future initFavoritesFirestoreField(String userUid) async {
    //Check if user already exist on Firestore
    await users.doc(userUid).get().then((value) async {
      if (value.exists) {
        return;
      }
      await users
          .doc(userUid)
          .set({"favoritesBooks": FieldValue.arrayUnion([])});
    });
  }

  @override
  Future<bool> addFavoritesBooksUser(String userUid, String id) async {
    try {
      users.doc(userUid).update({
        "favoritesBooks": FieldValue.arrayUnion([id])
      });
      return true;
    } on Exception {
      return false;
    }
  }

  @override
  Future<bool> deleteFavoritesBooksUser(String userUid, String id) async {
    try {
      await users.doc(userUid).update({
        "favoritesBooks": FieldValue.arrayRemove([id])
      });
      return true;
    } on Exception {
      return false;
    }
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> subscribeToFavoritesChange(
    String userUid,
  ) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userUid)
        .snapshots();
  }
}
