import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';

class Database extends ChangeNotifier {
  final List<Content> _contents = [];
  final List<User> _users = [];
  bool _isContentsLoaded = false;
  bool _isUsersLoaded = false;

  List<Content> get contents => _contents;
  List<User> get users => _users;
  bool get isContentsLoaded => _isContentsLoaded;
  bool get isUsersLoaded => _isUsersLoaded;

  void addContents(List<Content> contents) {
    _contents.addAll(contents);
    _isContentsLoaded = true;
    notifyListeners();
  }

  void addUser(User user) {
    _users.add(user);
    _isUsersLoaded = true;
    notifyListeners();
  }
}
