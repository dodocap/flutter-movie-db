import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orm_movie_db/data/model/movie_detail.dart';

part 'movie_detail_state.freezed.dart';
part 'movie_detail_state.g.dart';

@freezed
class MovieDetailState with _$MovieDetailState {
  const factory MovieDetailState({
    @Default(false) bool isLoading,
    @Default(MovieDetail()) MovieDetail movieDetail,
  }) = _MovieDetailState;

  factory MovieDetailState.fromJson(Map<String, Object?> json) => _$MovieDetailStateFromJson(json);
}
