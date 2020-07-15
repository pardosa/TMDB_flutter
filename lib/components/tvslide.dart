import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tmdb/components/tvcard.dart';
import 'package:flutter_tmdb/const.dart';
import 'package:flutter_tmdb/models/tv.dart';
import 'dart:math' as math;

import 'moviecard.dart';

class TvSlide extends StatefulWidget {
  final List<Tv> tvs;

  const TvSlide({Key key, this.tvs}) : super(key: key);

  @override
  _TvSlideState createState() => _TvSlideState(tvs);
}

class _TvSlideState extends State<TvSlide> {
  PageController _pageController;
  int initialPage = 1;
  final List<Tv> tvs;

  _TvSlideState(this.tvs);

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
          itemCount: this.tvs.length,
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
              child: TvCard(tv: tvs[index]),
            ),
          );
        },
      );
}
