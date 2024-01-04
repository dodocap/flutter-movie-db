import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/common/ui_event.dart';
import 'package:orm_movie_db/data/model/movie_detail.dart';
import 'package:orm_movie_db/ui/common/error_screen_widget.dart';
import 'package:orm_movie_db/ui/movie_detail/movie_detail_view_model.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieId;

  const MovieDetailScreen({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  StreamSubscription? _uiEventSubscription;

  @override
  void initState() {
    Future.microtask(() {
      final viewModel = context.read<MovieDetailViewModel>();
      _uiEventSubscription = viewModel.eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(event.msg)));
        }
      });
      viewModel.getMovieDetail(widget.movieId);
    });
    super.initState();
  }

  @override
  void dispose() {
    _uiEventSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MovieDetailViewModel viewModel = context.watch();
    final state = viewModel.state;

    return Scaffold(
      body: state.isLoading ?
        const Center(child: CircularProgressIndicator())
        : _getContentView(state.movieDetail),
    );
  }

  Widget _getContentView(MovieDetail movieDetail) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: false,
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.width / (16 / 9),
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: context.pop,
            borderRadius: BorderRadius.circular(50.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.white24
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1.0,
            title: Padding(
              padding: const EdgeInsets.only(right: 72),
              child: Text(
                movieDetail.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            collapseMode: CollapseMode.pin,
            background: CachedNetworkImage(
              imageUrl: movieDetail.backdropPath,
              alignment: Alignment.topCenter,
              fit: BoxFit.contain,
              placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
              errorWidget: (_, __, ___) => const Center(
                child: Text(
                  errorNotFoundImage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(
                  label: Text(
                    movieDetail.screenInfo.title,
                    style: TextStyle(color: movieDetail.screenInfo.fontColor, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: movieDetail.screenInfo.backgroundColor,
                ),
                const SizedBox(height: 8),
                Text(
                  movieDetail.originalTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(movieDetail.runtime, style: const TextStyle(fontSize: 18),),
                const SizedBox(height: 8),
                Text(
                  '개봉: ${movieDetail.releaseDate}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                movieDetail.voteAverage > 0
                ? Column(
                  children: [
                    RatingBar.builder(
                      initialRating: movieDetail.voteAverageByRatingBar,
                      minRating: 0,
                      direction: Axis.horizontal,
                      maxRating: 5,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) { },
                    ),
                    Text('평점: ${movieDetail.voteAverage}'),
                  ],
                )
                : const Text('평점 정보 없음', style: TextStyle(fontSize: 18),),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    movieDetail.genres.length + 1,
                    (index) {
                      if (movieDetail.genres.isEmpty) {
                        return const Text('장르 정보 없음');
                      }

                      String text;
                      if (index == 0) {
                        text = '장르 : ';
                      } else if (index == movieDetail.genres.length) {
                        text = '[${movieDetail.genres[index-1]}]';
                      } else {
                        text = '[${movieDetail.genres[index-1]}] ';
                      }
                      return Text(text);
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  movieDetail.overview,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 32)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
