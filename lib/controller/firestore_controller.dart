/*
 * BSD 3-Clause License

    Copyright (c) 2021, MICHELE BENEDETTI - MailTo: michelebenx98@gmail.com
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'interface/firestore_interface.dart';

class FirestoreController implements FirestoreControllerInterface {
  FirestoreController._privateConstructor();

  static final instance = FirestoreController._privateConstructor();

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Future initFavoritesFirestoreField(User user) async {
    //Check if user already exist on Firestore
    final userUid = user.uid;
    await users.doc(userUid).get().then((value) async {
      if (value.exists) {
        return;
      }
      await users.doc(userUid).set(
          {"favoritesBooks": FieldValue.arrayUnion([]), "email": user.email});
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
