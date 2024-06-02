import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/screens.dart';
import 'package:provider/provider.dart';
import '../Database.dart';
import '../models/models.dart';
import '../widgets/rating_bar.dart';
import '../widgets/widgets.dart';

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:share/share.dart';

class Detail extends StatelessWidget {
  final Content item;

  const Detail({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
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
                image: NetworkImage(item.titleImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                _actionButton(item: item, isDownload: false),
                _actionButton(item: item, isDownload: true),
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
                _ButtonBar(item: item), // Pass item to _ButtonBar
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


class _actionButton extends StatefulWidget {
  final Content item;
  final bool isDownload;

  const _actionButton({Key? key, required this.item, required this.isDownload})
      : super(key: key);

  @override
  __actionButtonState createState() => __actionButtonState();
}

class __actionButtonState extends State<_actionButton> {
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
    checkFileExists(widget.item.name);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      child: FlatButton.icon(
        onPressed: () {
          if (!widget.isDownload) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoApp(
                  movieUrl: widget.item.videoUrl,
                ),
              ),
            );
          } else if (!isDownloading && !fileExists) {
            downloadMovie(widget.item.videoUrl, '${widget.item.name}.mp4');
          }
        },
        color: widget.isDownload ? Colors.black26 : Colors.white,
        icon: widget.isDownload
            ? (isDownloading
                ? CircularProgressIndicator(value: downloadProgress)
                : (fileExists
                    ? const Icon(
                        Icons.check,
                        size: 30.0,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.download,
                        size: 30.0,
                        color: Colors.white,
                      )))
            : const Icon(
                Icons.play_arrow,
                size: 30.0,
              ),
        label: widget.isDownload
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


// class _ButtonBar extends StatelessWidget {
//   final Content item;
//
//   const _ButtonBar({Key? key, required this.item}) : super(key: key);
//
//   void _showShareOptions(BuildContext context) {
//       showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//         return Container(
//           color: Colors.black,
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: const Icon(Icons.share, color: Colors.white),
//                 title: const Text('Share via', style: TextStyle(color: Colors.white)),
//                 onTap: () {
//                   Share.share('Check out this movie: ${item.name}\n\n${item.description}\n\n${item.videoUrl}');
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.copy, color: Colors.white),
//                 title: const Text('Copy link', style: TextStyle(color: Colors.white)),
//                 onTap: () {
//                   // Implement copy link functionality
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.close, color: Colors.white),
//                 title: const Text('Cancel', style: TextStyle(color: Colors.white)),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _rateMovie(int rating) {
//
//   }
//   //
//   // final userRating = context.watch<Database>().user.rating;
//   //
//   String _getRateScore() {
//     String res = "Rating"; //(userRating[item.id].toString() != "null") ? 'You rated: ' + userRating[item.id].toString() : "Rating";
//
//     return res;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final userRating = context.watch<Database>().user.rating;
//
//     String _getRateScore() {
//       String res = (userRating[item.id].toString() != "null") ? 'You rated: ' + userRating[item.id].toString() : "Rating";
//
//       return res;
//     }
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           AddListButton(movie: item),
//           VerticalIconButton(
//             icon: Icons.star,
//             title: _getRateScore(),
//             onTap: () {
//               // Hiển thị hộp thoại đánh giá bộ phim
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('Rate ${item.name}'),
//                   content: RatingBar(
//                     onRatingSelected: _rateMovie,
//                   ),
//                 ),
//               );
//             },
//           ),
//           VerticalIconButton(
//               icon: Icons.share, title: 'Share', onTap: () => _showShareOptions(context)),
//         ],
//       ),
//     );
//   }
// }

class _ButtonBar extends StatefulWidget {
  final Content item;

  const _ButtonBar({Key? key, required this.item}) : super(key: key);

  @override
  State<_ButtonBar> createState() => _ButtonBarState();
}

class _ButtonBarState extends State<_ButtonBar> {
  late User user = context.read<Database>().user;
  late Map<String, int> userRating = context.read<Database>().user.rating;
  final databaseReference = FirebaseDatabase.instance.reference();


  @override
  void initState() {
    super.initState();
  }

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black,
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.share, color: Colors.white),
                title: const Text('Share via', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Share.share('Check out this movie: ${widget.item.name}\n\n${widget.item.description}\n\n${widget.item.videoUrl}');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.copy, color: Colors.white),
                title: const Text('Copy link', style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Implement copy link functionality
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close, color: Colors.white),
                title: const Text('Cancel', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _rateMovie(int rating) async {
    final String userId = user.id;
    final String movieId = widget.item.id;
    // userRating = user.rating;
    final int currentRating = userRating[movieId] ?? 0;

    // Nếu đánh giá mới bằng đánh giá hiện tại, không cần cập nhật
    if (currentRating == rating) return;

    // Cập nhật đánh giá cho bộ phim trong thông tin người dùng
    final Map<String, int> updatedRating = {...userRating, movieId: rating};
    final Map<String, int> updatedFilmRating = {...widget.item.rating, userId: rating};
    // Cập nhật thông tin người dùng trong cơ sở dữ liệu Firebase
    try {
      // await context.read<Database>().updateUserRating(userId, updatedRating);
      await databaseReference.child('list-users/$userId/rating').set(updatedRating);
      await databaseReference.child('contents/$movieId/rating').set(updatedFilmRating);
      context.read<Database>().updateUserRating(updatedRating);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Rating for ${widget.item.name} updated successfully')),
      // );

      // Đóng Dialog sau khi cập nhật thành công
      Navigator.of(context).pop();

      setState(() {
        userRating = updatedRating;
      });

      // print("OKKKKKKKKKK");
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Failed to update rating for ${widget.item.name}: $e')),
      // );
      // print("FAILEDDDDDD :(((((");
    }
  }

  String _getRateScore() {
    String res = (userRating[widget.item.id].toString() != "null") ? 'You rated: ' + userRating[widget.item.id].toString() : "Rating";
    // print(userRating[widget.item.id].toString());
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AddListButton(movie: widget.item),
          VerticalIconButton(
            icon: Icons.star,
            title: _getRateScore(),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Rate ${widget.item.name}'),
                  content: RatingBar(
                    onRatingSelected: _rateMovie,
                  ),
                ),
              );
            },
          ),
          VerticalIconButton(
            icon: Icons.share,
            title: 'Share',
            onTap: () => _showShareOptions(context),
          ),
        ],
      ),
    );
  }
}
