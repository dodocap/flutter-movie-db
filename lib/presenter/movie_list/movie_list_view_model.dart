import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orm_movie_db/common/ui_event.dart';
import 'package:orm_movie_db/domain/model/movie_info.dart';
import 'package:orm_movie_db/domain/use_case/get_movie_list_use_case.dart';
import 'package:orm_movie_db/presenter/movie_list/movie_list_state.dart';

class MovieListViewModel extends ChangeNotifier {
  final GetMovieListUseCase _getMovieListUseCase;
  MovieListViewModel({required GetMovieListUseCase getMovieListUseCase}) : _getMovieListUseCase = getMovieListUseCase;

  MovieListState _state = const MovieListState();

  MovieListState get state => _state;

  final StreamController<UiEvent> _eventController = StreamController();
  Stream<UiEvent> get eventStream => _eventController.stream;

  Future<void> getMovies([int page = 1]) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    (await _getMovieListUseCase.execute(page)).when(
      success: (data) => _state = _state.copyWith(isLoading: false, movieInfo: data),
      error: (e) {
        _state = _state.copyWith(isLoading: false, movieInfo: const MovieInfo());
        _eventController.add(UiEvent.showSnackBar(e));
      },
    );
    notifyListeners();
  }
}