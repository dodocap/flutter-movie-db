class MovieDetail {
  String title;
  String originalTitle;
  String overview;
  String backdropPath;
  String releaseDate;
  String status;
  List<String> genres;
  bool adult;

  MovieDetail({
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.backdropPath,
    required this.releaseDate,
    required this.status,
    required this.genres,
    required this.adult,
  });

  @override
  String toString() {
    return 'MovieDetail{title: $title, originalTitle: $originalTitle, overview: $overview, backdropPath: $backdropPath, releaseDate: $releaseDate, status: $status, genres: $genres, adult: $adult}';
  }
}