import 'company.dart';
import 'country.dart';
import 'genre.dart';
import 'language.dart';

class Movie {
  bool adult;
  String backdropPath;
  String belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<Company> productionCompanies;
  List<Country> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<Language> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  List<int> genreIds;

  Movie(
      {this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.genreIds});

  Movie.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    belongsToCollection = json['belongs_to_collection'];
    budget = json['budget'];
    if (json['genres'] != null) {
      genres = new List<Genre>();
      json['genres'].forEach((v) {
        genres.add(new Genre.fromJson(v));
      });
    }
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
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    if (json['production_companies'] != null) {
      productionCompanies = new List<Company>();
      json['production_companies'].forEach((v) {
        productionCompanies.add(new Company.fromJson(v));
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = new List<Country>();
      json['production_countries'].forEach((v) {
        productionCountries.add(new Country.fromJson(v));
      });
    }
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    if (json['spoken_languages'] != null) {
      spokenLanguages = new List<Language>();
      json['spoken_languages'].forEach((v) {
        spokenLanguages.add(new Language.fromJson(v));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = double.parse(json['vote_average'].toString());
    voteCount = json['vote_count'];
  }
}
