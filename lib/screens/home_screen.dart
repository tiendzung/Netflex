import 'package:flutter/material.dart';
import 'package:mobile/Database.dart';
import 'package:mobile/data/data.dart';
import 'package:mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../GetFromDB.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _scrollOffset = 0.0;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });
    super.initState();

    getData();
  }

  Future<void> getData() async {
    await GetFromDB.getContents().then((contents) {
      context.read<Database>().addContents(contents);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
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
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: ContentHeader(
                  featuredContent: context.watch<Database>().content[4]),
            ),
            SliverToBoxAdapter(
              child: ContentList(
                key: const PageStorageKey('myList'),
                title: 'My List',
                // contentList: myList,
                contentList: context.watch<Database>().content,
              ),
            ),
            SliverToBoxAdapter(
              child: ContentList(
                key: const PageStorageKey('originals'),
                title: 'Netflix Originals',
                contentList: context.watch<Database>().content,
                isOriginals: true,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 20.0),
              sliver: SliverToBoxAdapter(
                child: ContentList(
                  key: const PageStorageKey('trending'),
                  title: 'Trending',
                  contentList: context.watch<Database>().content,
                ),
              ),
            )
          ],
        ));
  }
}
