import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';

class Database extends ChangeNotifier {
  final List<Content> _content = [];
  bool _isLoaded = false;

  List<Content> get content => _content;
  bool get isLoaded => _isLoaded;

  void addContents(List<Content> contents) {
    _content.addAll(contents);
    _isLoaded = true;
    notifyListeners();
  }
}
