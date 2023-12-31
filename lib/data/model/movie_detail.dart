import 'package:orm_movie_db/common/constants.dart';

class MovieDetail {
  String title;
  String originalTitle;
  String overview;
  String backdropPath;
  String releaseDate;
  ScreenInfo screenInfo;
  List<String> genres;
  bool adult;

  MovieDetail({
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.backdropPath,
    required this.releaseDate,
    required this.screenInfo,
    required this.genres,
    required this.adult,
  });

  @override
  String toString() {
    return 'MovieDetail{title: $title, originalTitle: $originalTitle, overview: $overview, backdropPath: $backdropPath, releaseDate: $releaseDate, screenInfo: $screenInfo, genres: $genres, adult: $adult}';
  }
}