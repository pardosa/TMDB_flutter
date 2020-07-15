import 'package:flutter/material.dart';
import 'package:flutter_tmdb/models/movie.dart';

import '../const.dart';

class Genres extends StatelessWidget {
  const Genres({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final dynamic movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: SizedBox(
        height: 36,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movie.genres != null ? movie.genres.length : 0,
            itemBuilder: (context, index) => Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: kDefaultPadding),
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding / 4, // 5 padding top and bottom
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    movie.genres[index].name,
                    style: TextStyle(
                        color: kTextColor.withOpacity(0.9), fontSize: 16),
                  ),
                )),
      ),
    );
  }
}
