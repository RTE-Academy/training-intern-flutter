import 'package:clean_architecture_tdd_course/core/models/movie_model.dart';
import 'package:dio/dio.dart';
import '../../../../core/dio/dio_base.dart';
import '../../../../core/dio/dio_path.dart';
import '../../../../core/error/exceptions.dart';
import '../model/cast_model.dart';

abstract class MovieDetailRemoteDataSource {
  Future<MovieModel> getMovieDetail(int movieId);
  Future<List<CastModel>> getMovieCredits(int movieId);
  Future<String?> getMovieTrailer(int movieId);
}

class MovieDetailRemoteDatasourceImpl implements MovieDetailRemoteDataSource {
  static const String _bearerToken =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYzYxMjE1YzdiZDEwZWY4YzUxOWQ0OGYxZjAzM2QwZCIsIm5iZiI6MTc0Nzc5OTkxMi44MDA5OTk5LCJzdWIiOiI2ODJkNGY2OGJkZDA3MTYzZGQyZjdjOWQiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.-_VBCStmWn0jf4lJBDJRhCed-UmukU1z9eEQOw-2FZE';
  Map<String, dynamic> get _headers => {
        'accept': 'application/json',
        'Authorization': _bearerToken,
      };

  @override
  Future<MovieModel> getMovieDetail(int movieId) async {
    try {
      final response = await dio.get(
        '$movie/$movieId',
        queryParameters: {
          'language': 'en-US',
        },
        options: Options(headers: _headers),
      );

      final trailerKey = await getMovieTrailer(movieId);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return MovieModel.fromJson({...data, 'trailerKey': trailerKey});
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<CastModel>> getMovieCredits(int movieId) async {
    try {
      final response = await dio.get(
        '$movie/$movieId/credits',
        options: Options(headers: _headers),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final castList = data['cast'] as List<dynamic>? ?? [];

        return castList
            .map((json) => CastModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<String?> getMovieTrailer(int movieId) async {
    try {
      final response = await dio.get(
        '$movie/$movieId/videos',
        options: Options(headers: _headers),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results =
            (data['results'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
                [];

        final trailer = results.firstWhere(
          (video) =>
              video['type'] == 'Trailer' &&
              video['site'] == 'YouTube' &&
              video['official'] == true,
          orElse: () => <String, dynamic>{},
        );

        final trailerKey = trailer['key'] as String?;
        return trailerKey;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
