import 'package:clean_architecture_tdd_course/core/error/exceptions.dart';
import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:clean_architecture_tdd_course/features/search/data/datasources/search_remote_datasource.dart';
import 'package:clean_architecture_tdd_course/features/search/domain/entities/search.dart';
import 'package:clean_architecture_tdd_course/features/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDatasource remoteDataSource;

  SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Search>> searchMovies(String query, int page) async {
      try {
        final searchModel = await remoteDataSource.searchMovies(query, page);
        return Right(searchModel);
      } catch (e) {
        throw ServerException();
      }
  }
}