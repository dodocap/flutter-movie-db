import 'dart:convert';

import 'package:orm_movie_db/common/constants.dart';
import 'package:orm_movie_db/common/result.dart';
import 'package:orm_movie_db/data/dto/movie_detail_dto.dart';
import 'package:orm_movie_db/data/dto/movie_dto.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  Future<Result<MovieDto>> getMovies(int page) async {
    Result<MovieDto> result;

    try {
      final http.Response response = await http.get(Uri.parse('$movieMainUrl$page'));
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

  Future<Result<MovieDetailDto>> getMovieDetail(String movieId) async {
    Result<MovieDetailDto> result;

    try {
      final http.Response response = await http.get(Uri.parse('$movieDetailUrlPrefix$movieId$movieDetailUrlSuffix'));
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