import 'package:flutter/material.dart';
import 'package:mobile/assets.dart';
import 'package:mobile/models/profile.dart';
import 'package:mobile/widgets/vertical_icon_button.dart';
import 'package:page_transition/page_transition.dart';

import 'screens.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'Coming Soon',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  child: const SearchPage(),
                ),
              );
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
          const SizedBox(
            width: 7.0,
          ),
          IconButton(
            padding: const EdgeInsets.only(right: 15.0),
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
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  child: ProfileScreen(
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
          //Notification
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: const [
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          //image
          Container(
            width: 140,
            height: 190,
            decoration: const BoxDecoration(
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
                const Image(image: AssetImage(Assets.atlaTitle)),
                Row(
                  children: [
                    VerticalIconButton(
                      icon: Icons.notifications,
                      title: 'Remind Me',
                      onTap: () => print('Remind Me'),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    VerticalIconButton(
                      icon: Icons.info_outline,
                      title: 'Info',
                      onTap: () => {
                        // Showmodalinfo(context).showmodalinfo()
                      },
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
              children: const [
                Text(
                  'Season 1 coming April 12',
                  style: TextStyle(
                    fontSize: 12.0,
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
                  "sintelContent.description",
                  style: TextStyle(
                    fontSize: 12.0,
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
