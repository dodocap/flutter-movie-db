import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/domain/model/movie_detail.dart';
import 'package:orm_movie_db/domain/repository/movie_repository.dart';

class GetMovieByIdUseCase {
  final MovieRepository _movieRepository;

  GetMovieByIdUseCase({required MovieRepository movieRepository}) : _movieRepository = movieRepository;

  Future<Result<MovieDetail>> execute(String movieId) {
    return _movieRepository.getMovieDetail(movieId);
  }
}