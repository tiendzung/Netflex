import 'package:flutter/material.dart';
import 'package:mobile/models/content_model.dart';
import 'package:mobile/widgets/widgets.dart';

import '../screens/screens.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({
    Key? key,
    required this.featuredContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 499.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              // image: AssetImage(featuredContent.imageUrl),
              image: NetworkImage(featuredContent.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            // child: Image.asset(featuredContent.titleImageUrl),
            child: Image.network(featuredContent.titleImageUrl),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AddListButton(movie: featuredContent),
              _PlayButton(item: featuredContent),
              VerticalIconButton(
                icon: Icons.info_outline,
                title: 'Info',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detail(
                      item: featuredContent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlayButton extends StatelessWidget {
  final Content item;
  const _PlayButton({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoApp(
            movieUrl: item.videoUrl,
          ),
        ),
      ),
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
