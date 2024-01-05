import 'package:go_router/go_router.dart';
import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/di/di_setup.dart';
import 'package:orm_movie_db/presenter/movie_detail/movie_detail_screen.dart';
import 'package:orm_movie_db/presenter/movie_detail/movie_detail_view_model.dart';
import 'package:orm_movie_db/presenter/movie_list/movie_list_screen.dart';
import 'package:orm_movie_db/presenter/movie_list/movie_list_view_model.dart';
import 'package:provider/provider.dart';

final routes = GoRouter(
  initialLocation: '/movie',
  routes: [
    GoRoute(
        path: '/movie',
        builder: (_, __) => ChangeNotifierProvider(
              create: (_) => getIt<MovieListViewModel>(),
              child: const MovieListScreen(),
            ),
        routes: [
          GoRoute(
            path: 'detail',
            builder: (_, state) {
              return ChangeNotifierProvider(
                create: (_) => getIt<MovieDetailViewModel>(),
                child: MovieDetailScreen(movieId: state.uri.queryParameters[qpMovieId]!),
              );
            },
          )
        ]),
  ],
);
