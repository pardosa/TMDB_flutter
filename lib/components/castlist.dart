import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tmdb/const.dart';
import 'package:flutter_tmdb/models/cast.dart';

import 'castcard.dart';

class CastList extends StatelessWidget {
  final List<Cast> list;

  const CastList({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(list);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context, index) => list[index].name.isNotEmpty
          ? CastCard(
              cast: list[index],
            )
          : Padding(
              padding: EdgeInsets.only(left: kDefaultPadding),
            ),
    );
  }
}
