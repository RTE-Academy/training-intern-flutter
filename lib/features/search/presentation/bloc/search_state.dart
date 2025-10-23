import 'package:clean_architecture_tdd_course/features/search/domain/entities/search.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final Search searchResults;
  final String query;

  const SearchLoaded({
    this.searchResults = const Search(
      movies: [],
      currentPage: 1,
      totalPages: 1,
    ),
    this.query = '',
  });

  SearchLoaded copyWith({
    Search? searchResults,
    String? query,
  }) {
    return SearchLoaded(
      searchResults: searchResults ?? this.searchResults,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [searchResults, query];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
