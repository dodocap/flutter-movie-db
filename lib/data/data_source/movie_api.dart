import 'dart:convert';

import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/dto/movie_detail_dto.dart';
import 'package:orm_movie_db/data/dto/movie_dto.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  static const _movieMainUrl = 'https://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=';
  static const _movieDetailUrlPrefix = 'https://api.themoviedb.org/3/movie/';
  static const _movieDetailUrlSuffix = '?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR';

  Future<Result<MovieDto>> getMovies(int page) async {
    Result<MovieDto> result;

    try {
      final http.Response response = await http.get(Uri.parse('$_movieMainUrl$page'));
      if (response.statusCode == 200) {
        final MovieDto movieDto = MovieDto.fromJson(jsonDecode(response.body));
        result = Result.success(movieDto);
      } else {
        result = Result.error('$errorNetwork: ErrorCode(${response.statusCode})');
      }
    } catch (e) {
      result = Result.error('$errorNetwork\n$e');
    }
    return result;
  }

  Future<Result<MovieDetailDto>> getMovieDetail(int movieId) async {
    Result<MovieDetailDto> result;

    try {
      final http.Response response = await http.get(Uri.parse('$_movieDetailUrlPrefix$movieId$_movieDetailUrlSuffix'));
      if (response.statusCode == 200) {
        final MovieDetailDto movieDetailDto = MovieDetailDto.fromJson(jsonDecode(response.body));

        result = Result.success(movieDetailDto);
      } else {
        result = Result.error('$errorNetwork: ErrorCode(${response.statusCode})');
      }
    } catch (e) {
      result = Result.error('$errorNetwork\n$e');
    }
    return result;
  }
}