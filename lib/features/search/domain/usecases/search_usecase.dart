import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:clean_architecture_tdd_course/features/search/domain/entities/search.dart';
import 'package:clean_architecture_tdd_course/features/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchUseCase  {
  final SearchRepository repository;

  SearchUseCase(this.repository);

  Future<Either<Failure, Search>> call(String query, int page) async {
    return await repository.searchMovies(query, page);
  }
}