import 'package:flutter_tmdb/models/person.dart';

class PersonResult {
  int page;
  List<Person> results;
  int totalPages;
  int totalResults;

  PersonResult({this.page, this.results, this.totalPages, this.totalResults});

  PersonResult.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = new List<Person>();
      json['results'].forEach((v) {
        results.add(new Person.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}
