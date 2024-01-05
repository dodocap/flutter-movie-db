import 'package:get_it/get_it.dart';
import 'package:orm_movie_db/domain/repository/movie_repository.dart';
import 'package:orm_movie_db/data/repository/movie_repository_impl.dart';
import 'package:orm_movie_db/domain/use_case/get_movie_by_id_use_case.dart';
import 'package:orm_movie_db/domain/use_case/get_movie_list_use_case.dart';
import 'package:orm_movie_db/presenter/movie_detail/movie_detail_view_model.dart';
import 'package:orm_movie_db/presenter/movie_list/movie_list_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<MovieRepository>(MovieRepositoryImpl());

  getIt.registerSingleton<GetMovieListUseCase>(GetMovieListUseCase(movieRepository: getIt<MovieRepository>()));
  getIt.registerSingleton<GetMovieByIdUseCase>(GetMovieByIdUseCase(movieRepository: getIt<MovieRepository>()));

  getIt.registerFactory<MovieListViewModel>(() => MovieListViewModel(getMovieListUseCase: getIt<GetMovieListUseCase>()));
  getIt.registerFactory<MovieDetailViewModel>(() => MovieDetailViewModel(getMovieByIdUseCase: getIt<GetMovieByIdUseCase>()));
}
