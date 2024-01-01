import 'dart:async';

import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/model/movie_detail.dart';
import 'package:orm_movie_db/data/repository/movie_repository.dart';
import 'package:orm_movie_db/data/repository/movie_repository_impl.dart';

class MovieDetailViewModel {
  final MovieRepository _movieRepository = MovieRepositoryImpl();

  final StreamController<bool> _isLoading = StreamController();
  Stream<bool> get isLoading => _isLoading.stream;

  Result<MovieDetail> _movies = Result.error(errorNone);
  Result<MovieDetail> get movies => _movies;

  Future<void> getMovieDetail(String movieId) async {
    _isLoading.add(true);
    _movies = await _movieRepository.getMovieDetail(movieId);
    _isLoading.add(false);
  }
}