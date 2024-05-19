import 'package:flutter/material.dart';
import 'package:mobile/Database.dart';
import 'package:mobile/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import './GetFromDB.dart';
import 'package:mobile/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeNotifications();
  await Firebase.initializeApp(
    // for web deploy
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: const LoginScreen(),
      // home: const NavScreen()
    );
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

