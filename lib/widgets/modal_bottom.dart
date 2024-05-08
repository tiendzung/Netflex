import 'package:flutter/material.dart';
import 'package:mobile/widgets/widgets.dart';
import '../models/content_model.dart';
import '../screens/screens.dart';

class ModalBottomInfo extends StatelessWidget {
  final Content item;
  const ModalBottomInfo({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 125.0,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // image: AssetImage(item.imageUrl),
                    image: NetworkImage(item.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        children: [
                          Text(
                            item.releaseYear,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            item.ageLimit,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                            // ),
                            // SizedBox(
                            //   width: 15.0,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      item.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        _ButtonBar(item: item),
        SizedBox(
          height: 50.0,
          child: Card(
            color: const Color(0xff292929),
            child: InkWell(
              onTap: () => {
                Navigator.of(context).pop(),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detail(
                      item: item,
                    ),
                  ),
                ),
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.info_outline,
                        size: 20.0,
                        color: Colors.white,
                      )),
                  Expanded(
                      flex: 4,
                      child: Text(
                        "Episodes & Info",
                        style: TextStyle(color: Colors.white),
                      )),
                  Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ButtonBar extends StatelessWidget {
  final Content item;
  const _ButtonBar({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          VerticalIconButton(
              icon: Icons.play_arrow_outlined,
              title: 'Play',
              onTap: () => print('My list')),
          VerticalIconButton(
              icon: Icons.cloud_download,
              title: 'Download',
              onTap: () => print('My list')),
          AddListButton(movie: item),
          VerticalIconButton(
              icon: Icons.share, title: 'Share', onTap: () => print('Share')),
        ],
      ),
    );
  }
}
