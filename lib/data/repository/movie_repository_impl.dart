import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/data_source/movie_api.dart';
import 'package:orm_movie_db/data/dto/movie_dto.dart';
import 'package:orm_movie_db/data/mapper/movie_mapper.dart';
import 'package:orm_movie_db/data/model/movie_info.dart';
import 'package:orm_movie_db/data/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApi _movieApi = MovieApi();

  @override
  Future<Result<MovieInfo>> getMovies(int page) async {
    Result<MovieInfo> result;

    Result<MovieDto> dtoResult = await _movieApi.getMovies(page);
    switch (dtoResult) {
      case Success<MovieDto>(:final data):
        result = Result.success(data.mapToMovieInfo());
        break;
      case Error<MovieDto>(:final error):
        result = Result.error(error);
        break;
    }

    return result;
  }
}