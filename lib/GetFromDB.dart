import 'package:firebase_database/firebase_database.dart';
import 'package:mobile/models/models.dart';

class GetFromDB {
  static Future<List<Content>> getContents() async {
    final res = await FirebaseDatabase.instance.ref('/content').get();

    final List<Content> contents = [];

    Map<String, dynamic>.from(res.value as Map).forEach((key, value) async {
      contents.add(
        Content(
          // id: key,
          name: value['name'],
          imageUrl: value['imageUrl'],
          titleImageUrl: value['titleImageUrl'],
          videoUrl: value['videoUrl'],
          description: value['description'], releaseYear: value['releaseYear'],
          ageLimit: value['ageLimit'], director: value['director'],
        ),
      );
    });

    print("Length of data provide:" + contents.length.toString());
    return contents;
  }
}
