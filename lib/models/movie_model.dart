/// Data Model
class Movie {
  final String id;
  String name;
  String director;
  String poster;
  DateTime time;
  bool done;
  Movie({
    required this.id,
    required this.name,
    required this.director,
    required this.poster,
    required this.time,
    required this.done,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'director': director,
      'poster': poster,
      'time': time.millisecondsSinceEpoch,
      'done': done,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      name: map['name'],
      director: map['director'],
      poster: map['poster'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      done: map['done'],
    );
  }
}
