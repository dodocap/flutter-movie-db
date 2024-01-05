import 'package:orm_movie_db/common/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail.freezed.dart';
part 'movie_detail.g.dart';

@freezed
class MovieDetail with _$MovieDetail {
  const factory MovieDetail({
    @Default('') String title,
    @Default('') String originalTitle,
    @Default('영화 소개 정보가 없습니다') String overview,
    @Default('') String backdropPath,
    @Default('') String releaseDate,
    @Default(ScreenInfo.none) ScreenInfo screenInfo,
    @Default(0.0) double voteAverage,
    @Default(0.0) double voteAverageByRatingBar,
    @Default('상영시간 정보 없음') String runtime,
    @Default([]) List<String> genres,
    @Default(false) bool adult,
  }) = _MovieDetail;
  
  factory MovieDetail.fromJson(Map<String, Object?> json) => _$MovieDetailFromJson(json); 
}