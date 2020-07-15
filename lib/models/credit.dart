import 'cast.dart';
import 'crew.dart';

class Credit {
  int id;
  List<Cast> cast;
  List<Crew> crew;

  Credit({this.id, this.cast, this.crew});

  Credit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      cast = new List<Cast>();
      json['cast'].forEach((v) {
        cast.add(new Cast.fromJson(v));
      });
    }
    if (json['crew'] != null) {
      crew = new List<Crew>();
      json['crew'].forEach((v) {
        crew.add(new Crew.fromJson(v));
      });
    }
  }
}
