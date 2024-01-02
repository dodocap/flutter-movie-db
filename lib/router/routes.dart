import 'package:go_router/go_router.dart';
import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/data/repository/movie_repository_impl.dart';
import 'package:orm_movie_db/ui/movie_detail/movie_detail_screen.dart';
import 'package:orm_movie_db/ui/movie_detail/movie_detail_view_model.dart';
import 'package:orm_movie_db/ui/movie_list/movie_list_screen.dart';
import 'package:orm_movie_db/ui/movie_list/movie_list_view_model.dart';
import 'package:provider/provider.dart';

final routes = GoRouter(
  initialLocation: '/movie',
  routes: [
    GoRoute(
        path: '/movie',
        builder: (_, __) => ChangeNotifierProvider(
              create: (_) => MovieListViewModel(movieRepository: MovieRepositoryImpl()),
              child: const MovieListScreen(),
            ),
        routes: [
          GoRoute(
            path: 'detail',
            builder: (_, state) {
              return ChangeNotifierProvider(
                create: (_) => MovieDetailViewModel(movieRepository: MovieRepositoryImpl()),
                child: MovieDetailScreen(movieId: state.uri.queryParameters[qpMovieId]!),
              );
            },
          )
        ]),
  ],
);
