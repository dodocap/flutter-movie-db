class MovieInfo {
  int totalPages;
  int page;
  List<Movie> movieList;

  /*MovieInfo({
    required this.page,
    required this.movieList,
  });*/

  MovieInfo({this.totalPages = 0, this.page = 0, this.movieList = const []});

  @override
  String toString() {
    return 'MovieInfo{page: $page, movieList: $movieList}';
  }
}

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
  });

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, overview: $overview, posterPath: $posterPath, releaseDate: $releaseDate}';
  }
}