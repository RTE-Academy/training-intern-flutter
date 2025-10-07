import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/cast.dart';
import '../entities/movie_detail.dart';

abstract class MovieDetailRepository {
  Future<Either<Failure, MovieDetail>> getMovieDetail({required int movieId});
  Future<Either<Failure, List<Cast>>> getMovieCredits({required int movieId});
  Future<Either<Failure, String?>> getMovieTrailer(int movieId);
}