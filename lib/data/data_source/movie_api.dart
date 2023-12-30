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

  Future<Result<List<MovieDto>>> getMovies({int page = 1}) async {
    Result<List<MovieDto>> result;

    try {
      final http.Response response = await http.get(Uri.parse('$_movieMainUrl$page'));
      if (response.statusCode == 200) {
        final List<MovieDto> movieDtoList = (jsonDecode(response.body)['results'] as List<dynamic>).map((e) => MovieDto.fromJson(e)).toList();

        result = Success(movieDtoList);
      } else {
        result = Error('$errorNetwork: ErrorCode(${response.statusCode})');
      }
    } catch (e) {
      result = Error('$errorNetwork\n$e');
    }
    return result;
  }

  Future<Result<MovieDetailDto>> getMovieDetail(int movieId) async {
    Result<MovieDetailDto> result;

    try {
      final http.Response response = await http.get(Uri.parse('$_movieDetailUrlPrefix$movieId$_movieDetailUrlSuffix'));
      if (response.statusCode == 200) {
        final MovieDetailDto movieDetailDto = MovieDetailDto.fromJson(jsonDecode(response.body));

        result = Success(movieDetailDto);
      } else {
        result = Error('$errorNetwork: ErrorCode(${response.statusCode})');
      }
    } catch (e) {
      result = Error('$errorNetwork\n$e');
    }
    return result;
  }
}
