import 'package:flutter/material.dart';
import 'package:mobile/screens/download_screen.dart';
import 'package:mobile/screens/screens.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    const MyHomePage(key: PageStorageKey('homeScreen')),
    // SearchPage(),
    ComingSoon(),
    // const Detail(),
    const DownloadPage(),
    // LoginScreen(),
  ];

  final Map<String, IconData> _icons = const {
    'Home': Icons.home,
    // 'Search': Icons.search,
    'Coming Soon': Icons.queue_play_next,
    'My List': Icons.list,
    // 'More': Icons.menu,
  };
  
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          items: _icons
              .map((title, icon) => MapEntry(
                  title,
                  BottomNavigationBarItem(
                    icon: Icon(icon, size: 30.0),
                    label: title,
                  )))
              .values
              .toList(),
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          selectedFontSize: 11.0,
          unselectedItemColor: Colors.grey,
          unselectedFontSize: 11.0,
          onTap: (index) => setState(() => _currentIndex = index),
        ));
  }
}
