class MovieInfo {
  int totalPages;
  int page;
  List<Movie> movieList;

  // MovieInfo({this.totalPages = 0, this.page = 0, this.movieList = const []});

  MovieInfo({
    required this.totalPages,
    required this.page,
    required this.movieList,
  });

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

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, overview: $overview, posterPath: $posterPath}';
  }
}