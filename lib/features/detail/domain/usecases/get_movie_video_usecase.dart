import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/movie_detail_repository.dart';

class GetMovieVideoUsecase {
  final MovieDetailRepository repository;

  GetMovieVideoUsecase(this.repository);

  Future<Either<Failure, String?>> call(int movieId) async {
    return await repository.getMovieTrailer(movieId);
  }
}