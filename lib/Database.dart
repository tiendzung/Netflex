import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';

class Database extends ChangeNotifier {
  final List<Content> _contents = [];
  late User _user;
  bool _isContentsLoaded = false;
  bool _isUsersLoaded = false;

  List<Content> get contents => _contents;
  User get user => _user;
  bool get isContentsLoaded => _isContentsLoaded;
  bool get isUsersLoaded => _isUsersLoaded;

  void addContents(List<Content> contents) {
    _contents.addAll(contents);
    _isContentsLoaded = true;
    notifyListeners();
  }

  void addUser(List<User> users, String email) {
    // users.forEach(print);
    _user = users.firstWhere((user) => user.email == email);
    _isUsersLoaded = true;
    notifyListeners();
  }
}
