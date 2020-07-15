import 'package:flutter/material.dart';
import 'package:flutter_tmdb/models/cast.dart';

import '../const.dart';

class CastCard extends StatelessWidget {
  final Cast cast;

  const CastCard({Key key, this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(cast);
    return Container(
        margin: EdgeInsets.only(right: kDefaultPadding),
        width: 80,
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage('https://image.tmdb.org/t/p/w500/' +
                          cast.profilePath))),
            ),
            SizedBox(height: kDefaultPadding / 2),
            Text(
              cast.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
              maxLines: 2,
            ),
          ],
        ));
  }
}
