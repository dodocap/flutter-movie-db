import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/domain/model/movie_info.dart';
import 'package:orm_movie_db/domain/repository/movie_repository.dart';

class GetMovieListUseCase {
  final MovieRepository _movieRepository;

  GetMovieListUseCase({required MovieRepository movieRepository}) : _movieRepository = movieRepository;

  Future<Result<MovieInfo>> execute(int page) {
    return _movieRepository.getMovies(page);
  }
}