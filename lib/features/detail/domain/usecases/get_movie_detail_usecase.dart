import 'package:clean_architecture_tdd_course/features/home/movies/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/movie_detail_repository.dart';

class GetMovieDetailUsecase {
  final MovieDetailRepository repository;

  GetMovieDetailUsecase(this.repository);

  Future<Either<Failure, Movie>> call(int movieId) async {
    return await repository.getMovieDetail(movieId);
  }
}
