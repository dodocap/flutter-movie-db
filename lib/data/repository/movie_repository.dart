import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/model/movie_info.dart';

abstract interface class MovieRepository {
  Future<Result<MovieInfo>> getMovies();
}