import 'package:flutter_tmdb/models/tv.dart';

class TVResult {
  int page;
  List<Tv> results;
  int totalPages;
  int totalResults;

  TVResult({this.page, this.results, this.totalPages, this.totalResults});

  TVResult.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = new List<Tv>();
      json['results'].forEach((v) {
        results.add(new Tv.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}
