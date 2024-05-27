import 'package:firebase_database/firebase_database.dart';
import 'package:mobile/models/models.dart';

import 'package:firebase_core/firebase_core.dart';
// class FirebaseDatabaseService {
//   final DatabaseReference _database = FirebaseDatabase.instance.reference();
//
//   Future<void> addContent(List<Content> previews) async {
//     for (var content in previews) {
//       await _database.child('contents').push().set({
//         'name': content.name,
//         'imageUrl': content.imageUrl,
//         'titleImageUrl': content.titleImageUrl,
//         'description': content.description,
//         'videoUrl': content.videoUrl,
//         'releaseYear': content.releaseYear,
//         'ageLimit': content.ageLimit,
//         'director': content.director
//       });
//     }
//   }
// }

class GetFromDB {
  static Future<List<Content>> getContents() async {
    final res = await FirebaseDatabase.instance.ref('/contents').get();

    final List<Content> contents = [];

    Map<String, dynamic>.from(res.value as Map).forEach((key, value) async {
      contents.add(
        Content(
          id: key,
          name: value['name'],
          imageUrl: value['imageUrl'],
          titleImageUrl: value['titleImageUrl'],
          description: value['description'],
          videoUrl: value['videoUrl'],
          releaseYear: value['releaseYear'],
          ageLimit: value['ageLimit'],
          director: value['director'],
        ),
      );
    });

    print("Length of data provide:" + contents.length.toString());
    return contents;
  }

  static Future<List<User>> getAllUser() async {
    final res = await FirebaseDatabase.instance.ref('/list-users').get();

    final List<User> users = [];

    if (res.value != null) {
      Map<String, dynamic>.from(res.value as Map).forEach((key, value) {
        users.add(
          User(
            id: key,
            email: value['email'] as String,
            list: Map<String, bool>.from(value['list'] as Map),
            rating: Map<String, int>.from(
              value['rating'].map((k, v) => MapEntry(k, int.parse(v))),
            ),
          ),
        );
      });
    }

    print("Length of users provide: " + users.length.toString());
    return users;
  }
}


