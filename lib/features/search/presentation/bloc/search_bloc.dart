import 'package:clean_architecture_tdd_course/features/search/domain/usecases/search_usecase.dart';
import 'package:clean_architecture_tdd_course/features/search/presentation/bloc/search_event.dart';
import 'package:clean_architecture_tdd_course/features/search/presentation/bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase searchUseCase;

  SearchBloc({required this.searchUseCase}) : super(SearchInitial()) {
    on<SearchMovieEvent>(_onSearchMovieEvent);
  }

  Future<void> _onSearchMovieEvent(
    SearchMovieEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.page == 1) {
      emit(SearchLoading());
    }

    final result = await searchUseCase(event.query, event.page);

    result.fold(
      (failure) {
        emit(SearchError("Failed to search movies"));
      },
      (movies) {
        emit(SearchLoaded(searchResults: movies, query: event.query));
      },
    );
  }
}
