import 'package:flutter/material.dart';
import 'package:mobile/data/data.dart';
import 'package:mobile/widgets/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _scrollOffset = 0.0;
  late ScrollController _scrollController;
  @override
  void initState(){
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset=_scrollController.offset;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
        onPressed: () => print('Cast'),
      ),
      appBar: PreferredSize(
        preferredSize: Size(100.0,50.0),
        child: CustomAppBar(),
      ),
      body: CustomScrollView(controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: ContentHeader(featuredContent : sintelContent),
        )
      ],)
    );
  }
}

