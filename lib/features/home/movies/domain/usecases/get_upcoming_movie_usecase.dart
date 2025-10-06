import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetUpcomingMovie {
  final MovieRepository repository;

  GetUpcomingMovie(this.repository);

  Future<Either<Failure, List<Movie>>> call(int page) async {
    return await repository.getUpcomingMovies(page: page);
  }
}
