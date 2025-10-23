import '../../../../core/dio/dio_base.dart';
import '../../../../core/dio/dio_path.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String username, String password);
  Future<String> getRequestToken();
  Future<String> validateLogin({
    required String username,
    required String password,
    required String requestToken,
  });
  Future<String> createSession(String validatedToken);
  Future<UserModel> getAccount(String sessionId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const String _apiKey = 'bc61215c7bd10ef8c519d48f1f033d0d';

  @override
  Future<String> getRequestToken() async {
    try {
      final response = await dio.get(
        '$authentication/token/new',
        queryParameters: {'api_key': _apiKey},
      );
      return response.data['request_token'];
    } catch (e) {
      print("Failed to get request token: $e");
      throw Exception('Failed to get request token: $e');
    }
  }

  @override
  Future<String> validateLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    try {
      final response = await dio.post(
        '$authentication/token/validate_with_login',
        queryParameters: {'api_key': _apiKey},
        data: {
          'username': username,
          'password': password,
          'request_token': requestToken,
        },
      );
      return response.data['request_token'];
    } catch (e) {
      print("Failed to validate login: $e");
      throw Exception('Failed to validate login: $e');
    }
  }

  @override
  Future<String> createSession(String validatedToken) async {
    try {
      final response = await dio.post(
        '$authentication/session/new',
        queryParameters: {'api_key': _apiKey},
        data: {'request_token': validatedToken},
      );
      return response.data['session_id'];
    } catch (e) {
      print("Failed to create session: $e");
      throw Exception('Failed to create session: $e');
    }
  }

  @override
  Future<UserModel> getAccount(String sessionId) async {
    try {
      final response = await dio.get(
        '/account',
        queryParameters: {'api_key': _apiKey, 'session_id': sessionId},
      );
      return UserModel.fromJson({
        ...response.data,
        'session_id': sessionId,
      });
    } catch (e) {
      print("Failed to load user account: $e");
      throw Exception('Failed to load user account: $e');
    }
  }

  @override
  Future<UserModel> login(String username, String password) async {
    try {
      final requestToken = await getRequestToken();
      final validatedToken = await validateLogin(
        username: username,
        password: password,
        requestToken: requestToken,
      );
      final sessionId = await createSession(validatedToken);
      return await getAccount(sessionId);
    } catch (e) {
      print("Login failed: $e");
      throw Exception('Login failed: $e');
    }
  }
}
