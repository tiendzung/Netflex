import 'package:flutter/material.dart';
import 'package:mobile/widgets/widgets.dart';
import '../data/data.dart';
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
                    image: AssetImage(item.imageUrl),
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
                        children: const [
                          Text(
                            '2022',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '13+',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                          // ),
                          SizedBox(
                            width: 15.0,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      sintelContent.description,
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
        const _ButtonBar(),
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
                        // item: item,
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
    ;
  }
}

class _ButtonBar extends StatelessWidget {
  const _ButtonBar({Key? key}) : super(key: key);

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
