import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies(int page);
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int page);
  Future<Either<Failure, List<Movie>>> getUpcomingMovies(int page);
}
