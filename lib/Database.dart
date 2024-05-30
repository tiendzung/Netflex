import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';
import '../GetFromDB.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_database/firebase_database.dart';

class Database extends ChangeNotifier {
  List<Content> _contents = [];
  late User _user;
  bool _isContentsLoaded = false;
  bool _isUsersLoaded = false;

  List<Content> get contents => _contents;
  User get user => _user;
  bool get isContentsLoaded => _isContentsLoaded;
  bool get isUsersLoaded => _isUsersLoaded;

  Future<void> getContents() async {
    await GetFromDB.getContents().then((contents) {
      _contents.clear();
      _contents.addAll(contents);
      _isContentsLoaded = true;
      notifyListeners();
    });
  }

  Future<void> getUser() async {
    try {
      final databaseReference = FirebaseDatabase.instance.reference();

      fba.User? user = fba.FirebaseAuth.instance.currentUser;
      final userId = user!.uid;

      final userSnapshot = await databaseReference.child('list-users/$userId').get();
      final userMap = Map<String, dynamic>.from(userSnapshot.value as Map);

      _user = User(
        id: userId,
        email: userMap['email'] as String,
        list: Map<String, bool>.from(userMap['list'] as Map),
        rating: Map<String, int>.from(
          userMap['rating'].map((k, v) => MapEntry(k, v)),
        ),
      );

      _isUsersLoaded = true;
      notifyListeners();
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  void updateUserRating(Map<String, int> updatedRating) {
    user.rating = updatedRating;
  }

}
