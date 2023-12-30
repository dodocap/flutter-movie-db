import 'package:flutter/material.dart';
import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/model/movie_info.dart';
import 'package:orm_movie_db/ui/movie_list/movie_list_view_model.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final MovieListViewModel _viewModel = MovieListViewModel();

  @override
  void initState() {
    _viewModel.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<bool>(
          initialData: false,
          stream: _viewModel.isLoading,
          builder: (context, snapshot) {
            if (snapshot.data!) {
              return const Center(child: CircularProgressIndicator());
            }

            switch (_viewModel.movies) {
              case Success<MovieInfo>(:final data):
                return _getContentView(data);
              case Error(:final error):
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _viewModel.getMovies,
                        icon: const Icon(Icons.refresh),
                      ),
                      Text(
                        error,
                        style: const TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
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
              return ListTile(
                title: Text(movie.title),
                subtitle: Text(
                  movie.overview,
                  maxLines: 1,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                trailing: const Icon(Icons.navigate_next),
                onTap: () {
                  // TODO Next Screen
                },
              );
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 32, left: 20, right: 20),
            child: _buildPageButtonBar(
              currentPage: movieInfo.page,
              totalPages: movieInfo.totalPages,
              buttonsToShow: 9,
              onPressed: (page) {
                if (movieInfo.page != page) {
                  _viewModel.getMovies(page);
                }
              },
            )),
      ],
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
