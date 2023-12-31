import 'package:go_router/go_router.dart';
import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/ui/movie_detail/movie_detail_screen.dart';
import 'package:orm_movie_db/ui/movie_list/movie_list_screen.dart';

final routes = GoRouter(
  initialLocation: '/movie',
  routes: [
    GoRoute(
      path: '/movie',
      builder: (_, __) => const MovieListScreen(),
      routes: [
        GoRoute(
          path: 'detail',
          builder: (_, state) {
            return MovieDetailScreen(movieId: state.uri.queryParameters[qpMovieId]!);
          },
        )
      ]
    ),
  ],
);
