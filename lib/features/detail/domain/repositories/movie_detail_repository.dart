import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/cast.dart';
import '../entities/movie_detail.dart';

abstract class MovieDetailRepository {
  Future<Either<Failure, MovieDetail>> getMovieDetail(int movieId);
  Future<Either<Failure, List<Cast>>> getMovieCredits(int movieId);
  Future<Either<Failure, String?>> getMovieTrailer(int movieId);
}
