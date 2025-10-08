import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/cast.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_detail_repository.dart';
import '../datasources/movie_detail_remote_datasource.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final MovieDetailRemoteDataSource remoteDataSource;

  MovieDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(int movieId) async {
    try {
      final detail = await remoteDataSource.getMovieDetail(movieId);
      return Right(detail);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Cast>>> getMovieCredits(int movieId) async {
    try {
      final result = await remoteDataSource.getMovieCredits(movieId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getMovieTrailer(int movieId) async {
    try {
      final trailerKey = await remoteDataSource.getMovieTrailer(movieId);
      print(trailerKey);
      return Right(trailerKey);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
