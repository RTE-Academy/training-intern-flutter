import 'package:clean_architecture_tdd_course/features/auth/domain/usecases/login_usecase.dart';
import 'package:clean_architecture_tdd_course/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
// import 'features/home/movies/data/datasources/movie_remote_datasource.dart';
// import 'features/home/movies/data/repositories/movie_repository_impl.dart';
// import 'features/home/movies/domain/repositories/movie_repository.dart';
// import 'features/home/movies/domain/usecases/get_nowplaying_movie_usecase.dart';
// import 'features/home/movies/domain/usecases/get_popular_movie_usecase.dart';
// import 'features/home/movies/domain/usecases/get_toprated_movie_usecase.dart';
// import 'features/home/movies/domain/usecases/get_upcoming_movie_usecase.dart';
// import 'features/home/movies/presentation/bloc/movie_bloc.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl(),
    ),
  );

  //Bloc_Auth
  sl.registerFactory(
    () => AuthBloc(sl(),),
  );

  //Bloc_Movie
  // sl.registerFactory(() => MovieBloc(
  //     getNowPlayingMovies: sl(),
  //     getPopularMovies: sl(),
  //     getTopRatedMovies: sl(),
  //     getUpcomingMovies: sl(),
  //   )
  // );

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Use cases_Auth
  sl.registerLazySingleton(() => LoginUsecase(sl()));

  // Use cases_Movie
  // sl.registerLazySingleton(() => GetNowPlayingMovies(sl()));
  // sl.registerLazySingleton(() => GetPopularMovie(sl()));
  // sl.registerLazySingleton(() => GetTopRatedMovie(sl()));
  // sl.registerLazySingleton(() => GetUpcomingMovie(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // AuthRemoteDataSource
  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(),
  );

  // Repository_Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Repository_Movie
  // sl.registerLazySingleton<MovieRepository>(
  //   () => MovieRepositoryImpl(
  //     remoteDataSource: sl(),
  //   ),
  // );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );

  // Data sources_Auth
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );


  // Data sources_Movie
  // sl.registerLazySingleton<MovieRemoteDataSource>(
  //   () => MovieRemoteDataSourceImpl(client: sl()),
  // );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()), // InternetConnectionChecker injected
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker.createInstance());
}
