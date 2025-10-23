import 'package:clean_architecture_tdd_course/core/models/movie_model.dart';
import 'package:dio/dio.dart';

import '../../../../../core/dio/dio_base.dart';
import '../../../../../core/dio/dio_path.dart';
import '../../../../../core/error/exceptions.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies(int page);
  Future<List<MovieModel>> getTopRatedMovies(int page);
  Future<List<MovieModel>> getUpcomingMovies(int page);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const String _bearerToken =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYzYxMjE1YzdiZDEwZWY4YzUxOWQ0OGYxZjAzM2QwZCIsIm5iZiI6MTc0Nzc5OTkxMi44MDA5OTk5LCJzdWIiOiI2ODJkNGY2OGJkZDA3MTYzZGQyZjdjOWQiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.-_VBCStmWn0jf4lJBDJRhCed-UmukU1z9eEQOw-2FZE';
  Map<String, dynamic> get _headers => {
        'accept': 'application/json',
        'Authorization': _bearerToken,
      };

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final response = await dio.get(
        '$movie/now_playing',
        queryParameters: {'language': 'en-US', 'page': 1},
        options: Options(headers: _headers),
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List results = data['results'];

        return results.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    try {
      final response = await dio.get(
        '$movie/popular',
        queryParameters: {'language': 'en-US', 'page': page},
        options: Options(headers: _headers),
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List results = data['results'];

        return results.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies(int page) async {
    try {
      final response = await dio.get(
        '$movie/top_rated',
        queryParameters: {'language': 'en-US', 'page': page},
        options: Options(headers: _headers),
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List results = data['results'];

        return results.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies(int page) async {
    try {
      final response = await dio.get(
        '$movie/upcoming',
        queryParameters: {'language': 'en-US', 'page': page},
        options: Options(headers: _headers),
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List results = data['results'];

        return results.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
