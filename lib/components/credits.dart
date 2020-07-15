import 'package:flutter/material.dart';
import 'package:flutter_tmdb/const.dart';
import 'package:flutter_tmdb/models/credit.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'castlist.dart';

class Credits extends StatefulWidget {
  final int movieId;
  final String mode;

  const Credits({Key key, this.movieId, this.mode}) : super(key: key);

  @override
  _CreditsState createState() => _CreditsState(movieId, mode);
}

Future<Credit> fetchFutureMovieCredits(movieId, mode) async {
  var url =
      'https://api.themoviedb.org/3/$mode/$movieId/credits?api_key=$API_KEY';

  final response = await http
      .get(url, headers: {'Content-Type': 'application/json;charset=utf-8'});

  if (response.statusCode == 200) {
    // print(json.decode(response.body).toString());
    return Credit.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load PopularMovie');
  }
}

class _CreditsState extends State<Credits> {
  final int movieId;
  final String mode;
  Future<Credit> futureMovieCredits;

  _CreditsState(this.movieId, this.mode);

  @override
  void initState() {
    super.initState();
    futureMovieCredits = fetchFutureMovieCredits(movieId, mode);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Cast Member",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            FutureBuilder<Credit>(
              future: futureMovieCredits,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                      height: 120, child: CastList(list: snapshot.data.cast));
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ],
        ));
  }
}
