import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:orm_movie_db/domain/model/movie_info.dart';

part 'movie_list_state.freezed.dart';

part 'movie_list_state.g.dart';

@freezed
class MovieListState with _$MovieListState {
  const factory MovieListState({
    @Default(MovieInfo()) MovieInfo movieInfo,
    @Default(false) bool isLoading,
  }) = _MovieListState;

  factory MovieListState.fromJson(Map<String, Object?> json) => _$MovieListStateFromJson(json);
}