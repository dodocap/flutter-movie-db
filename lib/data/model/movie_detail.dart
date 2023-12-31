import 'package:orm_movie_db/common/constants.dart';

class MovieDetail {
  String title;
  String originalTitle;
  String overview;
  String backdropPath;
  String releaseDate;
  ScreenInfo screenInfo;
  double voteAverage;
  String runtime;
  List<String> genres;
  bool adult;

  MovieDetail({
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.backdropPath,
    required this.releaseDate,
    required this.screenInfo,
    required this.voteAverage,
    required this.runtime,
    required this.genres,
    required this.adult,
  });
}