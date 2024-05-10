import 'package:flutter/material.dart';
import 'package:mobile/screens/screens.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import '../../assets.dart';

class Detail extends StatelessWidget {
  final Content item;

  const Detail({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // leading: const BackButton(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
          IconButton(
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
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    profiles: demoProfile[0],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 250.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                // image: AssetImage(item.imageUrl),
                image: NetworkImage(item.titleImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0), // trai phai
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    item.name,
                    style: const TextStyle(
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
                      Text(
                        item.releaseYear,
                        style: const TextStyle(
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
                        child: Text(
                          item.ageLimit + "+",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                ),
                const _actionButton(isDownload: false),
                const _actionButton(isDownload: true),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    item.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Creator: " + item.director,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 11.0,
                    ),
                  ),
                ),
                const _ButtonBar(),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: const SizedBox(
              height: 2.0,
            ),
          ),
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
