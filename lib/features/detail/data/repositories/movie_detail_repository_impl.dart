import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:clean_architecture_tdd_course/features/detail/data/datasources/movie_detail_remote_datasource.dart';
import 'package:clean_architecture_tdd_course/features/detail/domain/entities/cast.dart';
import 'package:clean_architecture_tdd_course/features/detail/domain/entities/movie_detail.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/movie_detail_repository.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final MovieDetailRemoteDataSource remoteDataSource;

  MovieDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail({required int movieId}) async {
    try {
      final detail = await remoteDataSource.getMovieDetail(movieId: movieId);
      return Right(detail);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Cast>>> getMovieCredits({required int movieId}) async {
    try {
      final result = await remoteDataSource.getMovieCredits(movieId: movieId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override@override
  Future<Either<Failure, String?>> getMovieTrailer(int movieId) async {
    try {
      final trailerKey = await remoteDataSource.getMovieTrailer(movieId: movieId);
      return Right(trailerKey);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}