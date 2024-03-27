// import 'package:flutter/material.dart';

class Profile {
  String imgPath;
  String name;

  Profile({
    required this.imgPath,
    required this.name,
  });
}

List<Profile> demoProfile = [
  Profile(
    imgPath: "assets/images/netflix-avatar.png",
    name: "Netflix Member",
  ),
];
