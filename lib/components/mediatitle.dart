import 'package:flutter/material.dart';
import 'package:flutter_tmdb/const.dart';
import 'package:intl/intl.dart';

class MediaTitle extends StatelessWidget {
  final String title;
  final String releaseDate;

  const MediaTitle({Key key, this.title, this.releaseDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kDefaultPadding),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: kDefaultPadding / 2),
                releaseDate != null
                    ? Row(
                        children: <Widget>[
                          Text(
                            '${DateFormat.yMMMEd().format(DateTime.parse(releaseDate))}',
                            style: TextStyle(color: kTextLightColor),
                          ),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.only(left: 10),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
