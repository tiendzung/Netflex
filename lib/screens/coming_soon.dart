import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile/assets.dart';
import 'package:mobile/models/profile.dart';
import 'package:mobile/widgets/vertical_icon_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'screens.dart';

class ComingSoon extends StatelessWidget {
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  ComingSoon({Key? key}) : super(key: key) {
    flutterLocalNotificationsPlugin = initializeNotifications();
  }

  FlutterLocalNotificationsPlugin initializeNotifications() {
    final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
    tz.initializeTimeZones();
    return plugin;
  }

  Future<void> _scheduleNotification() async {
    // Tạo ra múi giờ cụ thể
    final location = tz.getLocation('Asia/Ho_Chi_Minh');

    // Tạo ra ngày cụ thể
    final DateTime scheduledDate = DateTime(2024, 6, 12, 18, 48, 0); // 12h00

    // Chuyển đổi thời gian sang múi giờ cụ thể
    final scheduledTime = tz.TZDateTime(
      location,
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      scheduledDate.hour,
      scheduledDate.minute,
      scheduledDate.second,
    );

    // Khởi tạo một Notification
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'my_netflex_notification_channel', // ID duy nhất cho kênh thông báo của bạn
      'Netflex Cooming Soon Notification', // Tên của kênh thông báo
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/netflix_logo', // Đường dẫn đến hình ảnh logo Netflix
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Lập lịch thông báo
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // ID thông báo duy nhất
      'Avatar', // Tiêu đề thông báo
      "Season 1 coming August 05", // Nội dung thông báo
      scheduledTime, // Thời gian hiển thị thông báo
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

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
                image: AssetImage(Assets.strangerThings),
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
                // const Image(image: AssetImage(Assets.atlaTitle)),
                Container(
                  width: 200,
                  height: 85,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.strangerThingsTitle),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  children: [
                    VerticalIconButton(
                      icon: Icons.notifications,
                      title: 'Remind Me',
                      onTap: _scheduleNotification,
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
                  'Season 1 coming August 05',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Stranger Things',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces and one strange little girl.",
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
