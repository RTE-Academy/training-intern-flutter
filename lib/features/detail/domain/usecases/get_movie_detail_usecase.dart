import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_detail_repository.dart';

class GetMovieDetailUsecase {
  final MovieDetailRepository repository;

  GetMovieDetailUsecase(this.repository);

  Future<Either<Failure, MovieDetail>> call(int movieId) async {
    return await repository.getMovieDetail(movieId: movieId);
  }
}