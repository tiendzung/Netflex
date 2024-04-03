import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../assets.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          color: Colors.white,
          onPressed: () => print("back"),
        ),
        actions: [
          IconButton(
            onPressed: () => print("Search"),
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
          const SizedBox(
            width: 7.0,
          ),
          IconButton(
            onPressed: () => print("Back"),
            icon: Icon(Icons.man),
            color: Colors.white,
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 250.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.kotaro),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0), // trai phai
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Kotaro Lives Alone',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    children: [
                      const Text(
                        '2022',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Text(
                          '13+',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      const Text(
                        '1 Season',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const _actionButton(isDownload: false),
                const _actionButton(isDownload: true),
                const Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Alone little boy moves into a ramshackle apartment building all on his own and makes friends with the broke manga artist who lives next door.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'Starring: Patton Oswalt, Catherine, .....',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 11.0,
                      // fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                _ButtonBar(),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: const SizedBox(
              height: 2.0,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'EPISODES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Season 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Episode(),
        ],
      ),
    );
  }
}

class _actionButton extends StatelessWidget {
  final bool isDownload;

  const _actionButton({Key? key, required this.isDownload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      child: FlatButton.icon(
        onPressed: () => print('play'),
        color: isDownload == true ? Colors.black26 : Colors.white,
        icon: isDownload == true
            ? const Icon(
                Icons.download,
                size: 30.0,
                color: Colors.white,
              )
            : const Icon(
                Icons.play_arrow,
                size: 30.0,
              ),
        label: isDownload == true
            ? const Text(
                'Download',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )
            : const Text(
                'Play',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}

class _ButtonBar extends StatelessWidget {
  const _ButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          VerticalIconButton(
              icon: Icons.add, title: 'List', onTap: () => print('My list')),
          VerticalIconButton(
              icon: Icons.thumb_up,
              title: 'List',
              onTap: () => print('My list')),
          VerticalIconButton(
              icon: Icons.share, title: 'Share', onTap: () => print('Share')),
        ],
      ),
    );
  }
}
