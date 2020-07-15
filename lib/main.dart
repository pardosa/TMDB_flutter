import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tmdb/components/personslide.dart';
import 'package:flutter_tmdb/models/movieresult.dart';
import 'package:flutter_tmdb/models/personresult.dart';
import 'package:flutter_tmdb/models/tvresult.dart';
import 'package:http/http.dart' as http;

import 'components/tvslide.dart';
import 'components/menu.dart';
import 'components/movieslide.dart';
import 'const.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter TMDB',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Future<MovieResult> fetchFutuPopularMovie(int idx) async {
  List<String> mode = ["movie", "tv", "person"];
  var urlPopular =
      'https://api.themoviedb.org/3/${mode[idx]}/popular?api_key=$API_KEY';
  var urlTrending =
      'https://api.themoviedb.org/3/trending/${mode[idx]}/day?api_key=$API_KEY';

  final response = await http.get(urlTrending,
      headers: {'Content-Type': 'application/json;charset=utf-8'});

  if (response.statusCode == 200) {
    // print(json.decode(response.body).toString());
    return MovieResult.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load MovieResult');
  }
}

Future<TVResult> fetchFutureTrendingTv() async {
  var urlTrending =
      'https://api.themoviedb.org/3/trending/tv/day?api_key=$API_KEY';

  final response = await http.get(urlTrending,
      headers: {'Content-Type': 'application/json;charset=utf-8'});

  if (response.statusCode == 200) {
    // print(json.decode(response.body).toString());
    return TVResult.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load TVResult');
  }
}

Future<PersonResult> fetchFutureTrendingPerson() async {
  var urlTrending =
      'https://api.themoviedb.org/3/trending/person/day?api_key=$API_KEY';

  final response = await http.get(urlTrending,
      headers: {'Content-Type': 'application/json;charset=utf-8'});

  if (response.statusCode == 200) {
    // print(json.decode(response.body).toString());
    return PersonResult.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load PersonResult');
  }
}

class _HomeState extends State<MyHomePage> {
  int selectedMenu = 0;
  int selectedSubMenu = 0;
  Future<MovieResult> futurePopularMovie;
  Future<TVResult> futureTvResult;
  Future<PersonResult> futurePersonResult;

  void setSelectedMenu(idx) {
    setState(() {
      selectedMenu = idx;
      if (idx == 0) {
        futurePopularMovie = fetchFutuPopularMovie(idx);
      } else if (idx == 1) {
        futureTvResult = fetchFutureTrendingTv();
      } else if (idx == 2) {
        futurePersonResult = fetchFutureTrendingPerson();
      }
    });
  }

  void setSelectedSubMenu(idx) {
    setState(() {
      selectedSubMenu = idx;
    });
  }

  @override
  void initState() {
    super.initState();
    futurePopularMovie = fetchFutuPopularMovie(selectedMenu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: null,
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Menus(
            setSelectedMenu, setSelectedSubMenu, selectedMenu, selectedSubMenu),
        selectedMenu == 0
            ? FutureBuilder<MovieResult>(
                future: futurePopularMovie,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MovieSlide(movies: snapshot.data.results);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              )
            : selectedMenu == 1
                ? FutureBuilder<TVResult>(
                    future: futureTvResult,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return TvSlide(tvs: snapshot.data.results);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  )
                : selectedMenu == 2
                    ? FutureBuilder<PersonResult>(
                        future: futurePersonResult,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return PersonSlide(persons: snapshot.data.results);
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      )
                    : null,
      ])),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            title: Text('Movies'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            title: Text('TV Series'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Person'),
          ),
        ],
        currentIndex: selectedMenu,
        selectedItemColor: Colors.amber[800],
        onTap: (index) => setSelectedMenu(index),
      ),
    );
  }
}
