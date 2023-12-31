import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/data/dto/movie_detail_dto.dart';
import 'package:orm_movie_db/data/model/movie_detail.dart';

extension MovieDetailDtoMapperMovieDetail on MovieDetailDto {
  MovieDetail mapToMovieDetail() {
    return MovieDetail(
      title: title ?? '',
      originalTitle: originalTitle ?? '',
      overview: overview?.isNotEmpty ?? false ? overview! : '영화 소개 정보가 없습니다',
      backdropPath: backdropPath != null ? '$imagePathLarge$backdropPath' : '',
      releaseDate: releaseDate ?? '',
      screenInfo: ScreenInfo.getByString(status ?? 'none'),
      voteAverage: voteAverage != null ? (voteAverage!.toDouble() * 10).round() / 10 : -1,
      voteAverageByRatingBar: _calculateRatingAverage(voteAverage),
      runtime: _covertRuntime(runtime),
      genres: genres?.map((e) => e.name ?? '').toList() ?? [],
      adult: adult ?? false,
    );
  }

  String _covertRuntime(num? runtime) {
    if (runtime == null || runtime == 0) {
      return "상영시간 정보 없음";
    }

    int time = runtime.toInt();
    int hours = time ~/ 60;
    int minutes = time % 60;

    if (hours > 0 && minutes > 0) {
      return '$hours시간 $minutes분';
    } else if (hours > 0) {
      return '$hours시간';
    } else {
      return '$minutes분';
    }
  }

  double _calculateRatingAverage(num? value) {
    if (value == null || value == 0) {
      return 0;
    }

    double floorValue = value.floorToDouble();
    double decimalPart = value - floorValue;

    double ratingBarValue;

    if (decimalPart >= 0.0 && decimalPart <= 0.4) {
      ratingBarValue = floorValue.toDouble();
    } else if (decimalPart >= 0.5 && decimalPart <= 0.9) {
      ratingBarValue = floorValue + 0.5;
    } else {
      ratingBarValue = floorValue;
    }
    return ratingBarValue / 2;
  }
}