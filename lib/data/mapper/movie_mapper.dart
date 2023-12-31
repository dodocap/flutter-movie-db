import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/data/dto/movie_dto.dart';
import 'package:orm_movie_db/data/model/movie_info.dart';

extension MovieDtoMapperMovieInfo on MovieDto {
  MovieInfo mapToMovieInfo() {
    return MovieInfo(
      totalPages: totalPages?.toInt() ?? 0,
      page: page?.toInt() ?? 0,
      movieList: results?.map((e) => e._mapToMovie()).toList() ?? [],
    );
  }
}
extension ResultMapperMovie on Results {
  Movie _mapToMovie() {
    return Movie(
      id: id?.toInt() ?? -1,
      title: title ?? '',
      overview: overview ?? '',
      posterPath: posterPath != null ? '$imagePathSmall$posterPath' : '',
    );
  }
}
