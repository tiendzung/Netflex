import 'package:flutter/material.dart';

import '../assets.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: BackBar(),
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
                        ),
                      ),
                    ],
                  ),
                ),
                _PlayButton(),
                _DownloadButton(),
                const Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Text(
                    'Alone little boy moves into a ramshackle apartment building all on his own and makes friends with the broke manga artist who lives next door.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      // fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Starring: Patton Oswalt, Catherine, .....',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14.0,
                      // fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                _ButtonBar(),
              ],
            ),
          ),
          Container(
            // padding: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              // borderRadius: BorderRadius.circular(3),
            ),
            child: const SizedBox(
              // width: 10.0,
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

class _PlayButton extends StatelessWidget {
  const _PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      // padding: const EdgeInsets.fromLTRB(160.0, 5.0, 160.0, 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 160.0),
      onPressed: () => print('play'),
      color: Colors.white,
      icon: const Icon(
        Icons.play_arrow,
        size: 30.0,
      ),
      label: const Text(
        'Play',
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _DownloadButton extends StatelessWidget {
  const _DownloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      // padding: const EdgeInsets.fromLTRB(160.0, 5.0, 160.0, 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 139.5),
      onPressed: () => print('Download'),
      color: Colors.black12,
      icon: const Icon(
        Icons.download,
        size: 30.0,
        color: Colors.white,
      ),
      label: const Text(
        'Download',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
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

class _DownloadEpisode extends StatelessWidget {
  const _DownloadEpisode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      // padding: const EdgeInsets.fromLTRB(160.0, 5.0, 160.0, 5.0),
      // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 139.5),
      onPressed: () => print('Download'),
      color: Colors.black12,
      icon: const Icon(
        Icons.download,
        size: 30.0,
        color: Colors.white,
      ),
      label: Text(''),
    );
  }
}

class Episode extends StatelessWidget {
  const Episode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                // alignment: Alignment.topLeft,
                children: [
                  Container(
                    height: 100.0,
                    width: 160.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.kotaro_ep1),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // color: Colors.white,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: SizedBox(
                      height: 60.0,
                      child: Icon(Icons.play_circle),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '1. Episode 1',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '26m',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 48.0,
              ),
              _DownloadEpisode(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'A strange four-year-old boy named Kotaro moves into Shimizu Apartment all on his own. He doest seem to have any parents or family around.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackBar extends StatelessWidget {
  const BackBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: () => print("Back"),
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            const SizedBox(
              width: 240.0,
            ),
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
      ),
    );
  }
}

class VerticalIconButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const VerticalIconButton(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            height: 2.0,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
