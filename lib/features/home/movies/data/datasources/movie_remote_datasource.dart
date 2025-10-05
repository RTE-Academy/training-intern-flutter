import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../auth/data/datasources/dio_base.dart';
import '../models/movie_model.dart';
import 'dio_path.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies({required int page});
  Future<List<MovieModel>> getTopRatedMovies({required int page});
  Future<List<MovieModel>> getUpcomingMovies({required int page});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {

  static const String _apiKey = 'bc61215c7bd10ef8c519d48f1f033d0d';

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final response = await dio.get(
        '$movie/now_playing',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'en-US',
        },
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
  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        '$movie/popular',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'en-US',
        },
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
  Future<List<MovieModel>> getTopRatedMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        '$movie/top_rated',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'en-US',
        },
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
  Future<List<MovieModel>> getUpcomingMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        '$movie/upcoming',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'en-US',
        },
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
