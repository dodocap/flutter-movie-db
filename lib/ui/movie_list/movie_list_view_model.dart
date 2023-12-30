import 'dart:async';

import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/model/movie_info.dart';
import 'package:orm_movie_db/data/repository/movie_repository.dart';
import 'package:orm_movie_db/data/repository/movie_repository_impl.dart';

class MovieListViewModel {
  final MovieRepository _movieRepository = MovieRepositoryImpl();

  final StreamController<bool> _isLoading = StreamController();
  Stream<bool> get isLoading => _isLoading.stream;

  Result<MovieInfo> _movies = Result.success(MovieInfo());
  Result<MovieInfo> get movies => _movies;

  Future<void> getMovies([int page = 1]) async {
    _isLoading.add(true);
    _movies = await _movieRepository.getMovies(page);
    _isLoading.add(false);
  }
}