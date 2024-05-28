import 'package:flutter/material.dart';
import 'package:mobile/models/profile.dart';
import 'package:mobile/widgets/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Database.dart';
import 'screens.dart';
import 'package:mobile/models/all_user.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  // final User user;
  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {

  bool _isDataLoaded = false; // Biến bool để kiểm tra trạng thái dữ liệu đã được tải
  bool _isUsersLoaded = false; // Biến bool để kiểm tra trạng thái dữ liệu đã được tải

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getUser();
  }

  Future<void> getData() async {
    await context.read<Database>().getContents();
    setState(() {
      _isDataLoaded = true; // Đặt trạng thái dữ liệu đã được tải xong thành true
    });
  }

  Future<void> getUser() async {
    await context.read<Database>().getUser();
    setState(() {
      _isUsersLoaded = true;
    });
  }


  @override
  Widget build(BuildContext context) {

    final filmInList = context.watch<Database>().user.list;
    final films = context.watch<Database>().contents.where((content) => filmInList[content.id] == true).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'My List',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  child: const SearchPage(),
                ),
              );
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
          const SizedBox(
            width: 7.0,
          ),
          IconButton(
            padding: const EdgeInsets.only(right: 15.0),
            icon: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                    image: AssetImage('assets/images/netflix-avatar.png')),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  child: ProfileScreen(
                    profiles: demoProfile[0],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: const [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Smart Downloads',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: context.watch<Database>().user.list.values.where((value) => value == true).length,
              // itemBuilder: (context, index) => DownloadMovieCard(
              //   movie: context.watch<Database>().contents[index],
              // ),

              itemBuilder: (context, index) {
                return DownloadMovieCard(movie: films[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
