import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile/screens/details.dart';

class DownloadMovieCard extends StatefulWidget {
  const DownloadMovieCard({Key? key, required this.movie}) : super(key: key);

  final Content movie;

  @override
  State<DownloadMovieCard> createState() => _DownloadMovieCardState();
}

class _DownloadMovieCardState extends State<DownloadMovieCard> {
  bool isDownloading = false;
  double downloadProgress = 0.0;
  bool fileExists = false;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

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

  String _sanitizeFileName(String fileName) {
    // Loại bỏ dấu cách và các ký tự đặc biệt, chỉ giữ lại các chữ cái thường
    return (fileName + 'n').replaceAll(RegExp(r'[^\w]'), '').toLowerCase();
  }

  Future<void> downloadMovie(String url, String fileName) async {
    setState(() {
      isDownloading = true;
      downloadProgress = 0.0;
    });

    try {
      Directory? externalDir = await getExternalStorageDirectory();
      String downloadsPath = '/storage/emulated/0/Download'; // Android-specific Download folder
      String sanitizedFileName = _sanitizeFileName(fileName);
      String savePath = '$downloadsPath/$sanitizedFileName.mp4';

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
        fileExists = true;
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

  Future<void> checkFileExists(String fileName) async {
    Directory? externalDir = await getExternalStorageDirectory();
    String downloadsPath = '/storage/emulated/0/Download'; // Android-specific Download folder
    String sanitizedFileName = _sanitizeFileName(fileName);
    String filePath = '$downloadsPath/$sanitizedFileName.mp4';

    setState(() {
      fileExists = File(filePath).existsSync();
    });
  }

  @override
  void initState() {
    super.initState();
    checkFileExists(widget.movie.name);
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
          InkWell(
              child: Container(
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
              onTap: () => {
                // Navigator.of(context).pop(),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detail(
                      item: widget.movie,
                    ),
                  ),
                ),
              },
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
              : fileExists
              ? const Icon(
            Icons.check,
            color: Colors.white,
            size: 20,
          )
              : IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              downloadMovie(widget.movie.videoUrl, widget.movie.name);
            },
          ),
        ],
      ),
    );
  }
}
