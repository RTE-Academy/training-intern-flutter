import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:clean_architecture_tdd_course/features/home/movies/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import '../entities/cast.dart';

abstract class MovieDetailRepository {
  Future<Either<Failure, Movie>> getMovieDetail(int movieId);
  Future<Either<Failure, List<Cast>>> getMovieCredits(int movieId);
  Future<Either<Failure, String?>> getMovieTrailer(int movieId);
}
