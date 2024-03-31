import 'package:flutter/material.dart';
import 'package:mobile/assets.dart';
import 'package:mobile/widgets/vertical_icon_button.dart';

import '../data/data.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Coming Soon',
          style: TextStyle(
            fontSize: 20.0,
          ),
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
          //Notification
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Notifications',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          //image
          Container(
            width: 140,
            height: 190,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.atla),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // remind_me info
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(image: AssetImage(Assets.atlaTitle)),
                Row(
                  children: [
                    VerticalIconButton(
                      icon: Icons.notifications,
                      title: 'Remind Me',
                      onTap: () => print('Remind Me'),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    VerticalIconButton(
                      icon: Icons.info_outline,
                      title: 'Info',
                      onTap: () => print('Info'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Season 1 coming April 12',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Avatar',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  sintelContent.description,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
