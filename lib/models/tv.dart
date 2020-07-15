import 'genre.dart';

class Tv {
  String originalName;
  int id;
  String title;
  int voteCount;
  double voteAverage;
  String releaseDate;
  String posterPath;
  List<int> genreIds;
  String originalLanguage;
  String backdropPath;
  String overview;
  List<String> originCountry;
  double popularity;
  String mediaType;
  List<Genre> genres;

  Tv(
      {this.originalName,
      this.id,
      this.title,
      this.voteCount,
      this.voteAverage,
      this.releaseDate,
      this.posterPath,
      this.genreIds,
      this.genres,
      this.originalLanguage,
      this.backdropPath,
      this.overview,
      this.originCountry,
      this.popularity,
      this.mediaType});

  Tv.fromJson(Map<String, dynamic> json) {
    originalName = json['original_name'];
    id = json['id'];
    title = json['name'];
    voteCount = json['vote_count'];
    voteAverage = json['vote_average'];
    releaseDate = json['first_air_date'];
    posterPath = json['poster_path'];
    genreIds = json['genre_ids'].cast<int>();
    if (json['genre_ids'] != null) {
      genres = new List<Genre>();
      listGenre.forEach((gen) {
        json['genre_ids'].forEach((id) {
          if (gen.id == id) {
            genres.add(gen);
          }
        });
      });
      // print(genres);
    }
    originalLanguage = json['original_language'];
    backdropPath = json['backdrop_path'];
    overview = json['overview'];
    originCountry = json['origin_country'].cast<String>();
    popularity = json['popularity'];
    mediaType = json['media_type'];
  }
}
