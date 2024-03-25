import 'package:flutter/material.dart';
import 'package:mobile/models/profile.dart';
import 'package:mobile/screens/profiles_more.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Netflix Sans',
      ),
      home: ProfileScreen(
        profiles: demoProfile[0],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
