import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tmdb/const.dart';
import 'package:flutter_tmdb/models/movie.dart';
import 'dart:math' as math;

import 'moviecard.dart';

class MovieSlide extends StatefulWidget {
  final List<Movie> movies;

  const MovieSlide({Key key, this.movies}) : super(key: key);

  @override
  _MovieSlideState createState() => _MovieSlideState(movies);
}

class _MovieSlideState extends State<MovieSlide> {
  PageController _pageController;
  int initialPage = 1;
  final List<Movie> movies;

  _MovieSlideState(this.movies);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.85,
      initialPage: initialPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: AspectRatio(
        aspectRatio: 0.88,
        child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              initialPage = value;
            });
          },
          controller: _pageController,
          physics: ClampingScrollPhysics(),
          itemCount: this.movies.length,
          itemBuilder: (context, index) => buildMovieSlider(index),
        ),
      ),
    );
  }

  Widget buildMovieSlider(int index) => AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double value = 0;
          if (_pageController.position.haveDimensions) {
            value = index - _pageController.page;
            value = (value * 0.038).clamp(-1, 1);
          }
          return AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: initialPage == index ? 1 : 0.4,
            child: Transform.rotate(
              angle: math.pi * value,
              child: MovieCard(movie: movies[index]),
            ),
          );
        },
      );
}
