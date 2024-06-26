
import 'dart:ffi';

class Content {
  final String id;
  final String name;
  final String imageUrl;
  final String titleImageUrl;
  final String videoUrl;
  final String description;
  final String ageLimit;
  final String director;
  final String releaseYear;
  final Map<String, int> rating;
  // final Color color;

  const Content({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.titleImageUrl,
    required this.videoUrl,
    required this.description,
    required this.ageLimit,
    required this.director,
    required this.releaseYear,
    required this.rating
    // required this.color,
  });

  double getAverateRating() {
      int total = rating.values.reduce((sum, value) => sum + value);
      double average = total / rating.length;
      return average;
  }
}
