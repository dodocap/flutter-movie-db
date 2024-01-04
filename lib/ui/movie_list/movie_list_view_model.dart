import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/model/movie_info.dart';
import 'package:orm_movie_db/data/repository/movie_repository.dart';
import 'package:orm_movie_db/ui/movie_list/movie_list_state.dart';

class MovieListViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieListViewModel({required MovieRepository movieRepository}) : _movieRepository = movieRepository;

  MovieListState _state = const MovieListState();
  MovieListState get state => _state;

  Future<void> getMovies([int page = 1]) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    (await _movieRepository.getMovies(page)).when(
      success: (data) => _state = _state.copyWith(isLoading: false, movieInfo: data),
      error: (e) {
        _state = _state.copyWith(isLoading: false, movieInfo: const MovieInfo());
      },
    );
    notifyListeners();
  }
}