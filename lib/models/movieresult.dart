import 'movie.dart';

class MovieResult {
  int page;
  int totalResults;
  int totalPages;
  List<Movie> results;

  MovieResult({this.page, this.totalResults, this.totalPages, this.results});

  MovieResult.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<Movie>();
      json['results'].forEach((v) {
        results.add(new Movie.fromJson(v));
      });
    }
  }
}
