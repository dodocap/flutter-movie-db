import 'package:get_it/get_it.dart';
import 'package:orm_movie_db/data/repository/movie_repository.dart';
import 'package:orm_movie_db/data/repository/movie_repository_impl.dart';
import 'package:orm_movie_db/ui/movie_detail/movie_detail_view_model.dart';
import 'package:orm_movie_db/ui/movie_list/movie_list_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<MovieRepository>(MovieRepositoryImpl());

  getIt.registerFactory<MovieListViewModel>(() => MovieListViewModel(movieRepository: getIt<MovieRepository>()));
  getIt.registerFactory<MovieDetailViewModel>(() => MovieDetailViewModel(movieRepository: getIt<MovieRepository>()));
}
