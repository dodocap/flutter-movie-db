import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/model/movie_detail.dart';
import 'package:orm_movie_db/ui/common/error_screen_widget.dart';
import 'package:orm_movie_db/ui/movie_detail/movie_detail_view_model.dart';

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
  final MovieDetailViewModel _viewModel = MovieDetailViewModel();

  @override
  void initState() {
    _viewModel.getMovieDetail(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
          initialData: false,
          stream: _viewModel.isLoading,
          builder: (context, snapshot) {
            if (snapshot.data!) {
              return const Center(child: CircularProgressIndicator());
            }

            switch (_viewModel.movies) {
              case Success<MovieDetail>(:final data):
                return _getContentView(data);
              case Error(:final error):
                return ErrorScreenWidget(
                  error: error,
                  callback: () => _viewModel.getMovieDetail(widget.movieId),
                );
            }
          }),
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
        // TODO 추가정보
        // runtime : 124분
        // belongs_to_collection 관련작품
        // spoken_languages 언어
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
                      initialRating: _customFloor(movieDetail.voteAverage) / 2,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
  double _customFloor(double value) {
    double floorValue = value.floorToDouble();
    double decimalPart = value - floorValue;

    double ratingBarValue;

    if (decimalPart >= 0.0 && decimalPart <= 0.4) {
      ratingBarValue = floorValue.toDouble();
    } else if (decimalPart >= 0.5 && decimalPart <= 0.9) {
      ratingBarValue = floorValue + 0.5;
    } else {
      ratingBarValue = value;
    }
    return ratingBarValue;
  }
}
