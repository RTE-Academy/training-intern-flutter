import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/cast.dart';
import '../repositories/movie_detail_repository.dart';

class GetMovieCreditsUsecase {
  final MovieDetailRepository repository;

  GetMovieCreditsUsecase(this.repository);

  Future<Either<Failure, List<Cast>>> call(int movieId) async {
    return await repository.getMovieCredits(movieId);
  }
}
