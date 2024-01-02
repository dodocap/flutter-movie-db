import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/model/movie_info.dart';
import 'package:orm_movie_db/data/repository/movie_repository.dart';

class MovieListViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieListViewModel({required MovieRepository movieRepository}) : _movieRepository = movieRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Result<MovieInfo> _movies = Result.error(errorNone);
  Result<MovieInfo> get movies => _movies;

  Future<void> getMovies([int page = 1]) async {
    _isLoading = true;
    notifyListeners();

    _movies = await _movieRepository.getMovies(page);
    _isLoading = false;
    notifyListeners();
  }
}