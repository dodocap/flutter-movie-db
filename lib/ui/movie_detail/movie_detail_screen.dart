import 'package:flutter/material.dart';
import 'package:orm_movie_db/ui/movie_detail/movie_detail_view_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final String id;

  const MovieDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final MovieDetailViewModel _viewModel = MovieDetailViewModel();

  @override
  void initState() {
    print(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Placeholder(),
    );
  }
}
