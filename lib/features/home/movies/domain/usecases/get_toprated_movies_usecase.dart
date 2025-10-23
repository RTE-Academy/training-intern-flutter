import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTopRatedMoviesUsecase {
  final MovieRepository repository;

  GetTopRatedMoviesUsecase(this.repository);

  Future<Either<Failure, List<Movie>>> call(int page) async {
    return await repository.getTopRatedMovies(page);
  }
}
