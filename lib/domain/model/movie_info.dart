import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:orm_movie_db/domain/model/movie.dart';

part 'movie_info.freezed.dart';

part 'movie_info.g.dart';

@freezed
class MovieInfo with _$MovieInfo {
  const factory MovieInfo({
    @Default(0) int totalPages,
    @Default(0) int page,
    @Default([]) List<Movie> movieList,
  }) = _MovieInfo;

  factory MovieInfo.fromJson(Map<String, Object?> json) => _$MovieInfoFromJson(json);
}