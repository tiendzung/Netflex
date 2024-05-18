// import 'package:flutter/material.dart';
// import 'package:mobile/models/models.dart';

// class DownloadMovieCard extends StatefulWidget {
//   const DownloadMovieCard({Key? key, required this.movie}) : super(key: key);

//   final Content movie;

//   @override
//   State<DownloadMovieCard> createState() => _DownloadMovieCardState();
// }

// class _DownloadMovieCardState extends State<DownloadMovieCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(
//         bottom: 10,
//         left: 15,
//         right: 15,
//       ),
//       // color: const Color(0xff221f1f),
//       child: Row(
//         children: [
//           Container(
//             width: 140,
//             height: 75,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               image: DecorationImage(
//                 // image: AssetImage(widget.movie.imageUrl),
//                 image: NetworkImage(widget.movie.imageUrl),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Text(
//                 widget.movie.name,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 14.0,
//                 ),
//               ),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(right: 15.0),
//             child: Icon(
//               Icons.arrow_forward_ios,
//               color: Colors.white,
//               size: 15,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DownloadMovieCard extends StatefulWidget {
  const DownloadMovieCard({Key? key, required this.movie}) : super(key: key);

  final Content movie;

  @override
  State<DownloadMovieCard> createState() => _DownloadMovieCardState();
}

class _DownloadMovieCardState extends State<DownloadMovieCard> {
  bool isDownloading = false;
  double downloadProgress = 0.0;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> _showNotification(String filePath) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'Channel for download notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      'The file has been downloaded to $filePath',
      platformChannelSpecifics,
      payload: filePath,
    );
  }

  Future<void> downloadMovie(String url, String fileName) async {
    setState(() {
      isDownloading = true;
      downloadProgress = 0.0;
    });

    try {

      // Directory dir = Directory('/storage/emulated/0/Download'); 

      // Directory appDocDir = await getApplicationDocumentsDirectory();
      
      // String savePath = "/Internal storage/Download/${fileName}"; //'${appDocDir.path}/$fileName';

      Directory? externalDir = await getExternalStorageDirectory();
      String downloadsPath = '/storage/emulated/0/Download'; // Android-specific Download folder
      String savePath = '$downloadsPath/$fileName';


      Dio dio = Dio();
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              downloadProgress = received / total;
            });
          }
        },
      );

      setState(() {
        isDownloading = false;
      });

      await _showNotification(savePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download completed: $savePath')),
      );
    } catch (e) {
      setState(() {
        isDownloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
        left: 15,
        right: 15,
      ),
      child: Row(
        children: [
          Container(
            width: 140,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage(widget.movie.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                widget.movie.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          isDownloading
              ? CircularProgressIndicator(value: downloadProgress)
              : IconButton(
                  icon: const Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    downloadMovie(widget.movie.videoUrl, '${widget.movie.name}.mp4');
                  },
                ),
        ],
      ),
    );
  }
}
