import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tmdb/components/credits.dart';
import 'package:flutter_tmdb/components/genres.dart';
import 'package:flutter_tmdb/components/mediatitle.dart';
import 'package:flutter_tmdb/const.dart';
import 'package:flutter_tmdb/models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'mediaheader.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: OpenContainer(
        closedElevation: 0,
        openElevation: 0,
        closedBuilder: (context, action) => buildMovieCard(context),
        openBuilder: (context, action) => buildMovieDetail(context),
      ),
    );
  }

  Column buildMovieCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [kDefaultShadow]),
              ),
              ClipRRect(
                child: movie.backdropPath != null
                    ? CachedNetworkImage(
                        imageUrl: 'https://image.tmdb.org/t/p/w500/' +
                            movie.posterPath,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            new Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      )
                    : null,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
          child: Text(
            movie.title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Scaffold buildMovieDetail(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white70,
                boxShadow: [kDefaultShadow],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.1), BlendMode.dstATop),
                    image: NetworkImage('https://image.tmdb.org/t/p/w500/' +
                        movie.posterPath))),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MediaHeader(
                  size: size,
                  voteAverage: movie.voteAverage,
                  voteCount: movie.voteCount,
                  popularity: movie.popularity,
                  img: movie.backdropPath,
                ),
                MediaTitle(
                  title: movie.title,
                  releaseDate: movie.releaseDate,
                ),
                Genres(movie: movie),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding / 2,
                    horizontal: kDefaultPadding,
                  ),
                  child: Text(
                    "Plot Summary",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          movie.overview,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    )),
                SizedBox(height: kDefaultPadding / 2),
                Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: kDefaultPadding / 2,
                      horizontal: kDefaultPadding,
                    ),
                    child: null),
                Credits(
                  movieId: movie.id,
                  mode: "movie",
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
