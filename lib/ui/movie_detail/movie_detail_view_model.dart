import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orm_movie_db/common/ui_event.dart';
import 'package:orm_movie_db/data/repository/movie_repository.dart';
import 'package:orm_movie_db/ui/movie_detail/movie_detail_state.dart';

class MovieDetailViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieDetailViewModel({required MovieRepository movieRepository}) : _movieRepository = movieRepository;

  MovieDetailState _state = const MovieDetailState();
  MovieDetailState get state => _state;

  final StreamController<UiEvent> _eventController = StreamController();
  Stream<UiEvent> get eventStream => _eventController.stream;

  Future<void> getMovieDetail(String movieId) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    (await _movieRepository.getMovieDetail(movieId)).when(
      success: (data) {
        _state = _state.copyWith(isLoading: false, movieDetail: data);
      },
      error: (e) {
        _state = _state.copyWith(isLoading: false);
        _eventController.add(UiEvent.showSnackBar(e));
      },
    );
    notifyListeners();
  }
}