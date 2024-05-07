import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';

class Database extends ChangeNotifier {
  final List<Content> _content = [];

  List<Content> get content => _content;

  void addContents(List<Content> contents) {
    _content.addAll(contents);
    notifyListeners();
  }
}
