import 'dart:convert';
import 'package:http/http.dart' as http;
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
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  static const String _apiKey = 'bc61215c7bd10ef8c519d48f1f033d0d';

  @override
  Future<String> validateLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final response = await client.post(
      Uri.parse('https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=$_apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'request_token': requestToken,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['request_token'] as String;
    } else {
      throw Exception('Failed to validate login');
    }
  }

  @override
  Future<String> createSession(String validatedToken) async {
    final response = await client.post(
      Uri.parse('https://api.themoviedb.org/3/authentication/session/new?api_key=$_apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'request_token': validatedToken,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['session_id'] as String;
    } else {
      throw Exception('Failed to create session');
    }
  }

  @override
  Future<String> getRequestToken() async {
    final tokenRes = await client.get(
      Uri.parse('https://api.themoviedb.org/3/authentication/token/new?api_key=$_apiKey'),
    );
    
    if (tokenRes.statusCode != 200) {
      throw Exception("Failed to get request token");
    }
    
    final requestToken = jsonDecode(tokenRes.body)['request_token'];
    return requestToken;
  }

  @override
  Future<UserModel> getAccount(String sessionId) async {
    final response = await client.get(
      Uri.parse('https://api.themoviedb.org/3/account?api_key=$_apiKey&session_id=$sessionId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson({
        ...data,
        'session_id': sessionId, // Include session_id in the user model
      });
    } else {
      throw Exception('Failed to load user account');
    }
  }

  @override
  Future<UserModel> login(String username, String password) async {
    try {
      // 1. Get request_token
      final requestToken = await getRequestToken();

      // 2. Validate with login
      final validateRes = await client.post(
        Uri.parse('https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=$_apiKey'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password,
          "request_token": requestToken,
        }),
      );

      if (validateRes.statusCode != 200) {
        throw Exception("Invalid TMDB credentials: ${validateRes.body}");
      }

      final validatedToken = jsonDecode(validateRes.body)['request_token'];

      // 3. Create session
      final sessionRes = await client.post(
        Uri.parse('https://api.themoviedb.org/3/authentication/session/new?api_key=$_apiKey'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"request_token": validatedToken}),
      );

      if (sessionRes.statusCode != 200) {
        throw Exception("Failed to create session: ${sessionRes.body}");
      }
      final sessionId = jsonDecode(sessionRes.body)['session_id'];

      // 4. Get user/account info
      final accountRes = await client.get(
        Uri.parse('https://api.themoviedb.org/3/account?api_key=$_apiKey&session_id=$sessionId'),
      );

      if (accountRes.statusCode != 200) {
        throw Exception("Failed to get account info");
      }

      final accountJson = jsonDecode(accountRes.body);

      // Optional: Nếu muốn, thêm sessionId vào user model
      return UserModel.fromJson({
        ...accountJson,
        'session_id': sessionId,
      });
    } catch (e) {
        throw Exception("Login failed: $e");
    }
  }
}
