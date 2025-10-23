import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final movieModel = await remoteDataSource.getNowPlayingMovies();
      final movies = movieModel.map((m) => m.toEntity()).toList();
      return Right(movies);
    } catch (e) {
      throw Exception("Failed to fetch now playing movies: $e");
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies(int page) async {
    try {
      final movieModel = await remoteDataSource.getPopularMovies(page);
      final movies = movieModel.map((m) => m.toEntity()).toList();
      return Right(movies);
    } catch (e) {
      throw Exception("Failed to fetch popular movies: $e");
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int page) async {
    try {
      final movieModel = await remoteDataSource.getTopRatedMovies(page);
      final movies = movieModel.map((m) => m.toEntity()).toList();
      return Right(movies);
    } catch (e) {
      throw Exception("Failed to fetch top rated movies: $e");
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies(int page) async {
    try {
      final movieModel = await remoteDataSource.getUpcomingMovies(page);
      final movies = movieModel.map((m) => m.toEntity()).toList();
      return Right(movies);
    } catch (e) {
      throw Exception("Failed to fetch upcoming movies: $e");
    }
  }
}
