import 'package:dio/dio.dart';
import '../../../../injection_container.dart';
import 'auth_remote_data_source.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'https://api.themoviedb.org/3',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
  headers: {'Content-Type': 'application/json'},
));

final authRemote = sl<AuthRemoteDataSource>();