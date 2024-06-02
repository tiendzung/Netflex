import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';
import '../GetFromDB.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_database/firebase_database.dart';
import './api_call.dart';

class Database extends ChangeNotifier {
  List<Content> _contents = [];
  List<Content> get contents => _contents;
  bool _isContentsLoaded = false;
  bool get isContentsLoaded => _isContentsLoaded;


  late User _user;
  bool _isUsersLoaded = false;
  User get user => _user;
  bool get isUsersLoaded => _isUsersLoaded;

  List<Content> _recommendedContent = [];
  List<Content> get recommendedContent => _recommendedContent;
  bool _isRecommenedContentLoaded = false;
  bool get isRecommenedContentLoaded => _isRecommenedContentLoaded;


  Future<void> getContents() async {
    await GetFromDB.getContents().then((contents) {
      // _contents.clear();
      _contents = contents;
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

  Future<void> getRecommendedContent() async {
    List<Content> result = [];
    try {
      final ApiService apiService = ApiService(baseUrl: "http://192.168.1.3:8000");
      List<String> recommendations = await apiService.fetchRecommendations(_user.id);
      print('Recommendations: $recommendations');

      // Lấy danh sách các content từ _contents mà có trong recommendations
      List<Content> filteredContents = _contents.where((content) {
        return recommendations.contains(content.id);
      }).toList(); // Chuyển đổi thành List<Content>

      _recommendedContent = filteredContents;
    } catch (e) {
      print(e);
    }
  }

}
