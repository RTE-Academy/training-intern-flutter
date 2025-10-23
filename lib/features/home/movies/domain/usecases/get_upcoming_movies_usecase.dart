import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetUpcomingMoviesUsecase {
  final MovieRepository repository;

  GetUpcomingMoviesUsecase(this.repository);

  Future<Either<Failure, List<Movie>>> call(int page) async {
    return await repository.getUpcomingMovies(page: page);
  }
}
