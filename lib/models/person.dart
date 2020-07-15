import 'package:flutter_tmdb/models/movie.dart';
import 'package:flutter_tmdb/models/tv.dart';

class Person {
  String knownForDepartment;
  bool adult;
  int id;
  String profilePath;
  String title;
  List<dynamic> knownFor;
  int gender;
  double popularity;
  String mediaType;

  Person(
      {this.knownForDepartment,
      this.adult,
      this.id,
      this.profilePath,
      this.title,
      this.knownFor,
      this.gender,
      this.popularity,
      this.mediaType});

  Person.fromJson(Map<String, dynamic> json) {
    knownForDepartment = json['known_for_department'];
    adult = json['adult'];
    id = json['id'];
    profilePath = json['profile_path'];
    title = json['name'];
    if (json['known_for'] != null && json['media_type'] != null) {
      if (json['media_type'] == 'movie') {
        knownFor = new List<Movie>();
        json['known_for'].forEach((v) {
          knownFor.add(new Movie.fromJson(v));
        });
      } else if (json['media_type'] == 'tv') {
        knownFor = new List<Tv>();
        json['known_for'].forEach((v) {
          knownFor.add(new Tv.fromJson(v));
        });
      }
    }
    gender = json['gender'];
    popularity = json['popularity'];
    mediaType = json['media_type'];
  }
}
