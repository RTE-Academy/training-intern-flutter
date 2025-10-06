import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'https://api.themoviedb.org/3',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
  headers: {'Content-Type': 'application/json'},
));

