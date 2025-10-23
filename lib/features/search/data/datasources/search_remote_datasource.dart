import 'package:clean_architecture_tdd_course/core/dio/dio_base.dart';
import 'package:clean_architecture_tdd_course/core/dio/dio_path.dart';
import 'package:clean_architecture_tdd_course/core/error/exceptions.dart';
import 'package:clean_architecture_tdd_course/features/search/data/models/search_model.dart';
import 'package:dio/dio.dart';

abstract class SearchRemoteDatasource {
  Future<SearchModel> searchMovies(String query, int page);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDatasource {
  static const String _bearerToken =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYzYxMjE1YzdiZDEwZWY4YzUxOWQ0OGYxZjAzM2QwZCIsIm5iZiI6MTc0Nzc5OTkxMi44MDA5OTk5LCJzdWIiOiI2ODJkNGY2OGJkZDA3MTYzZGQyZjdjOWQiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.-_VBCStmWn0jf4lJBDJRhCed-UmukU1z9eEQOw-2FZE';
  Map<String, dynamic> get _headers => {
    'accept': 'application/json',
    'Authorization': _bearerToken,
  };

  @override
  Future<SearchModel> searchMovies(String query, int page) async {
    try {
      final response = await dio.get(
        '/search/$movie',
        queryParameters: {
          'query': query,
          'include_adult': false,
          'language': 'en-US',
          'page': page,
        },
        options: Options(headers: _headers),
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return SearchModel.fromJson(data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
