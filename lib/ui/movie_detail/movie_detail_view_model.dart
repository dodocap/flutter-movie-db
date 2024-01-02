import 'dart:async';
import 'package:flutter/material.dart';
import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/model/movie_detail.dart';
import 'package:orm_movie_db/data/repository/movie_repository.dart';
import 'package:orm_movie_db/data/repository/movie_repository_impl.dart';

class MovieDetailViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieDetailViewModel({required MovieRepository movieRepository}) : _movieRepository = movieRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Result<MovieDetail> _movies = Result.error(errorNone);
  Result<MovieDetail> get movies => _movies;

  Future<void> getMovieDetail(String movieId) async {
    _isLoading = true;
    notifyListeners();

    _movies = await _movieRepository.getMovieDetail(movieId);
    _isLoading = false;
    notifyListeners();
  }
}