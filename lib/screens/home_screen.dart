import 'package:flutter/material.dart';
import 'package:mobile/Database.dart';
import 'package:mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../GetFromDB.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _scrollOffset = 0.0;
  late ScrollController _scrollController;
  bool _isDataLoaded = false; // Biến bool để kiểm tra trạng thái dữ liệu đã được tải
  bool _isUsersLoaded = false; // Biến bool để kiểm tra trạng thái dữ liệu đã được tải


  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });
    super.initState();
    // Thực hiện tải dữ liệu khi initState được gọi
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

  // Future<void> getAllUser() async {
  //   await GetFromDB.getAllUser().then((users) {
  //     context.read<Database>().addUser(users);
  //     setState(() {
  //       _isUsersLoaded = true; // Đặt trạng thái dữ liệu đã được tải xong thành true
  //     });
  //   });
  // }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
        onPressed: () => {},
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: CustomAppBar(
          scrollOffset: _scrollOffset,
        ),
      ),
      body: _isDataLoaded && _isUsersLoaded // Kiểm tra xem dữ liệu đã được tải xong chưa
          ? CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: ContentHeader(
                    featuredContent: context.watch<Database>().contents[4],
                  ),
                ),
                SliverToBoxAdapter(
                  child: ContentList(
                    key: const PageStorageKey('recommendedForYou'),
                    title: 'Recommended For You',
                    contentList: context.watch<Database>().contents,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ContentList(
                    key: const PageStorageKey('originals'),
                    title: 'Netflix Originals',
                    contentList: context.watch<Database>().contents,
                    isOriginals: true,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  sliver: SliverToBoxAdapter(
                    child: ContentList(
                      key: const PageStorageKey('trending'),
                      title: 'Trending',
                      contentList: context.watch<Database>().contents,
                    ),
                  ),
                )
              ],
            )
          : Center(child: CircularProgressIndicator()), // Hiển thị tiến trình tải khi dữ liệu đang được tải
    );
  }
}
