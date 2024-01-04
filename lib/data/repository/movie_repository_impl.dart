import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/data_source/movie_api.dart';
import 'package:orm_movie_db/data/dto/movie_detail_dto.dart';
import 'package:orm_movie_db/data/dto/movie_dto.dart';
import 'package:orm_movie_db/data/mapper/movie_detail_mapper.dart';
import 'package:orm_movie_db/data/mapper/movie_mapper.dart';
import 'package:orm_movie_db/data/model/movie_detail.dart';
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
      case Error<MovieDto>(:final e):
        result = Result.error(e);
        break;
    }

    return result;
  }

  @override
  Future<Result<MovieDetail>> getMovieDetail(String movieId) async {
    Result<MovieDetail> result;

    Result<MovieDetailDto> dtoResult = await _movieApi.getMovieDetail(movieId);
    switch (dtoResult) {
      case Success<MovieDetailDto>(:final data):
        result = Result.success(data.mapToMovieDetail());
        break;
      case Error(:final e):
        result = Result.error(e);
        break;
    }

    return result;
  }
}