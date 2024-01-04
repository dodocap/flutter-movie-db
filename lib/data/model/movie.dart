import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'movie.freezed.dart';

part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    @Default(-1) int id,
    @Default('') String title,
    @Default('') String overview,
    @Default('') String posterPath,
  }) = _Movie;

  factory Movie.fromJson(Map<String, Object?> json) => _$MovieFromJson(json);
}