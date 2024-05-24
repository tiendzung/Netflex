class User {
  final String id;
  final String email;
  Map<String, bool> list;
  Map<String, int> rating;

  User({
    required this.id,
    required this.email,
    required this.list,
    required this.rating,
  });

  void addFilm(String filmId) {
    list[filmId] = true;
  }

  void updateRating(String filmId, int newRating) {
    if (rating.containsKey(filmId)) {
      rating[filmId] = newRating;
    }
  }

  void removeFilm(String filmId) {
    list.remove(filmId);
    rating.remove(filmId);
  }
}
