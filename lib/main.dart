import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Database.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'GetFromDB.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(const MyApp());
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Database())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Netflix Sans',
      ),
      // home: Splash(),
      // home: const VideoApp(
      //   movieUrl:
      //       'https://firebasestorage.googleapis.com/v0/b/netflix-8b506.appspot.com/o/videos%2Fbee.mp4?alt=media&token=5514f33d-f3ad-410b-86e1-ade8d490c0e6',
      // ),
      // home: MainPage(),
      home: NavScreen(),
    );
  }
}
