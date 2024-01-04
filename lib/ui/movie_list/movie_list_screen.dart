import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/model/movie_info.dart';
import 'package:orm_movie_db/ui/common/error_screen_widget.dart';
import 'package:orm_movie_db/ui/movie_list/movie_list_view_model.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<MovieListViewModel>().getMovies());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MovieListViewModel viewModel = context.watch();
    return Scaffold(
      body: SafeArea(
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : _getResultView()
      ),
    );
  }

  Widget _getResultView() {
    final MovieListViewModel viewModel = context.read();
    switch (viewModel.movies) {
      case Success<MovieInfo>(:final data):
        return _getContentView(data);
      case Error(:final e):
        return ErrorScreenWidget(
            error: e,
            callback: viewModel.getMovies
        );
    }
  }

  Widget _getContentView(MovieInfo movieInfo) {
    final List<Movie> movieList = movieInfo.movieList;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: movieList.length,
            itemBuilder: (context, index) {
              final Movie movie = movieList[index];
              return _movieWidget(movie);
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 32),
            child: _buildPageButtonBar(
              currentPage: movieInfo.page,
              totalPages: movieInfo.totalPages,
              buttonsToShow: 9,
              onPressed: (page) {
                if (movieInfo.page != page) {
                  context.read<MovieListViewModel>().getMovies(page);
                }
              },
            )),
      ],
    );
  }

  Widget _movieWidget(Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => context.push(Uri(path: '/movie/detail', queryParameters: { qpMovieId: movie.id.toString() }).toString()),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl: movie.posterPath,
                fit: BoxFit.cover,
                width: 100,
                height: 150,
                placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => const Center(
                  child: Text(
                    errorNotFoundImage,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Visibility(
                      visible: movie.overview.isNotEmpty,
                      child: Text(
                        movie.overview,
                        maxLines: 4,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageButtonBar({
    required int currentPage,
    required int totalPages,
    required int buttonsToShow,
    required void Function(int page) onPressed,
  }) {
    int start = currentPage - buttonsToShow ~/ 2;
    if (start < 1) {
      start = 1;
    }
    int end = start + buttonsToShow - 1;
    if (end > totalPages) {
      end = totalPages;
      start = end - buttonsToShow + 1;
      if (start < 1) {
        start = 1;
      }
    }

    List<Widget> buttons = [];
    for (int i = start; i <= end; i++) {
      buttons.add(_bottomButton(i, currentPage, onPressed));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons,
    );
  }

  Widget _bottomButton(int number, int currentPage, void Function(int page) onPressed) {
    return InkWell(
      onTap: () => onPressed(number),
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.25),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          color: number == currentPage ? Colors.orangeAccent : null,
        ),
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          child: Text(
            number < 10 ? ' $number ' : '$number',
          ),
        ),
      ),
    );
  }
}
