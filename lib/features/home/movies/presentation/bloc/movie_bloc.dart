import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_nowplaying_movie_usecase.dart';
import '../../domain/usecases/get_popular_movie_usecase.dart';
import '../../domain/usecases/get_toprated_movie_usecase.dart';
import '../../domain/usecases/get_upcoming_movie_usecase.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovie getPopularMovies;
  final GetTopRatedMovie getTopRatedMovies;
  final GetUpcomingMovie getUpcomingMovies;

  MovieBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
    required this.getUpcomingMovies,
  }) : super(MovieInitial()) {
    on<GetMoviesEvent>(_onGetMovies);
    on<LoadMoreMoviesEvent>(_onLoadMoreMovies);
  }

  Future<void> _onGetMovies(
      GetMoviesEvent event,
      Emitter<MovieState> emit,
      ) async {
    if (event.page == 1) {
      emit(MovieLoading());
    }

    final result = switch (event.category) {
      MovieCategory.nowPlaying => await getNowPlayingMovies(),
      MovieCategory.popular => await getPopularMovies(event.page),
      MovieCategory.topRated => await getTopRatedMovies(event.page),
      MovieCategory.upcoming => await getUpcomingMovies(event.page),
    };

    result.fold(
          (failure) => emit(MovieFailure("Failed to load ${event.category.name} movies")),
          (movies) {
        if (state is MovieLoaded) {
          final currentState = state as MovieLoaded;

          emit(currentState.copyWith(
            nowPlayingMovies: event.category == MovieCategory.nowPlaying
                ? movies
                : currentState.nowPlayingMovies,
            popularMovies: event.category == MovieCategory.popular
                ? (event.page == 1
                ? movies
                : [...currentState.popularMovies, ...movies])
                : currentState.popularMovies,
            topRatedMovies: event.category == MovieCategory.topRated
                ? (event.page == 1
                ? movies
                : [...currentState.topRatedMovies, ...movies])
                : currentState.topRatedMovies,
            upcomingMovies: event.category == MovieCategory.upcoming
                ? (event.page == 1
                ? movies
                : [...currentState.upcomingMovies, ...movies])
                : currentState.upcomingMovies,
          ));
        } else {
          emit(MovieLoaded(
            nowPlayingMovies:
            event.category == MovieCategory.nowPlaying ? movies : const [],
            popularMovies:
            event.category == MovieCategory.popular ? movies : const [],
            topRatedMovies:
            event.category == MovieCategory.topRated ? movies : const [],
            upcomingMovies:
            event.category == MovieCategory.upcoming ? movies : const [],
          ));
        }
      },
    );
  }

  Future<void> _onLoadMoreMovies(
      LoadMoreMoviesEvent event,
      Emitter<MovieState> emit,
      ) async {
    if (state is! MovieLoaded) return;

    final currentState = state as MovieLoaded;
    final result = await getPopularMovies(event.nextPage);

    result.fold(
          (failure) =>
          emit(MovieFailure("Failed to load more ${event.category.name} movies")),
          (movies) {
        final updatedPopular =
        [...currentState.popularMovies, ...movies];

        emit(currentState.copyWith(popularMovies: updatedPopular));
      },
    );
  }
}
