import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/domain/model/movie_detail.dart';
import 'package:orm_movie_db/domain/model/movie_info.dart';

abstract interface class MovieRepository {
  Future<Result<MovieInfo>> getMovies(int page);
  Future<Result<MovieDetail>> getMovieDetail(String movieId);
}