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
      status: _statusMap[status ?? ''] ?? ' - ',
      genres: genres?.map((e) => e.name ?? '').toList() ?? [],
      adult: adult ?? false,
      /*
      belongsToCollection: belongsToCollection,
      budget: budget,
      genres: genres,
      homepage: homepage,
      id: id,
      imdbId: imdbId,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      productionCompanies: productionCompanies,
      productionCountries: productionCountries,
      releaseDate: releaseDate,
      revenue: revenue,
      runtime: runtime,
      spokenLanguages: spokenLanguages,
      status: status,
      tagline: tagline,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,*/
    );
  }
}