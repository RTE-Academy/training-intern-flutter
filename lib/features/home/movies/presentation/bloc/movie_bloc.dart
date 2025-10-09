import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_nowplaying_movies_usecase.dart';
import '../../domain/usecases/get_popular_movies_usecase.dart';
import '../../domain/usecases/get_toprated_movies_usecase.dart';
import '../../domain/usecases/get_upcoming_movies_usecase.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMoviesUsecase getNowPlayingMoviesUsecase;
  final GetPopularMoviesUsecase getPopularMoviesUsecase;
  final GetTopRatedMoviesUsecase getTopRatedMoviesUsecase;
  final GetUpcomingMoviesUsecase getUpcomingMoviesUsecase;

  MovieBloc({
    required this.getNowPlayingMoviesUsecase,
    required this.getPopularMoviesUsecase,
    required this.getTopRatedMoviesUsecase,
    required this.getUpcomingMoviesUsecase,
  }) : super(MovieInitial()) {
    on<GetMoviesEvent>(_onGetMovies);
    on<LoadMoreMoviesEvent>(_onLoadMoreMovies);
    on<LoadAllMoviesEvent>(_onLoadAllMovies);
  }

  Future<void> _onGetMovies(
    GetMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (event.page == 1) {
      emit(MovieLoading());
    }

    final result = switch (event.category) {
      MovieCategory.nowPlaying => await getNowPlayingMoviesUsecase(),
      MovieCategory.popular => await getPopularMoviesUsecase(event.page),
      MovieCategory.topRated => await getTopRatedMoviesUsecase(event.page),
      MovieCategory.upcoming => await getUpcomingMoviesUsecase(event.page),
    };

    result.fold(
      (failure) =>
          emit(MovieFailure("Failed to load ${event.category.name} movies")),
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

    switch (event.category) {
      case MovieCategory.popular:
        final result = await getPopularMoviesUsecase(event.nextPage);
        result.fold(
          (failure) => emit(MovieFailure("Failed to load more popular movies")),
          (movies) {
            final updatedList = [...currentState.popularMovies, ...movies];
            emit(currentState.copyWith(popularMovies: updatedList));
          },
        );
        break;

      case MovieCategory.topRated:
        final result = await getTopRatedMoviesUsecase(event.nextPage);
        result.fold(
          (failure) =>
              emit(MovieFailure("Failed to load more top-rated movies")),
          (movies) {
            final updatedList = [...currentState.topRatedMovies, ...movies];
            emit(currentState.copyWith(topRatedMovies: updatedList));
          },
        );
        break;

      case MovieCategory.upcoming:
        final result = await getUpcomingMoviesUsecase(event.nextPage);
        result.fold(
          (failure) =>
              emit(MovieFailure("Failed to load more upcoming movies")),
          (movies) {
            final updatedList = [...currentState.upcomingMovies, ...movies];
            emit(currentState.copyWith(upcomingMovies: updatedList));
          },
        );
        break;
      case MovieCategory.nowPlaying:
      // TODO: Handle this case.
    }
  }

  Future<void> _onLoadAllMovies(
    LoadAllMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());

    try {
      final nowPlayingResult = await getNowPlayingMoviesUsecase();
      final popularResult = await getPopularMoviesUsecase(1);
      final topRatedResult = await getTopRatedMoviesUsecase(1);
      final upcomingResult = await getUpcomingMoviesUsecase(1);

      final nowPlaying =
          nowPlayingResult.fold<List<Movie>>((l) => <Movie>[], (r) => r);
      final popular =
          popularResult.fold<List<Movie>>((l) => <Movie>[], (r) => r);
      final topRated =
          topRatedResult.fold<List<Movie>>((l) => <Movie>[], (r) => r);
      final upcoming =
          upcomingResult.fold<List<Movie>>((l) => <Movie>[], (r) => r);

      emit(MovieLoaded(
        nowPlayingMovies: nowPlaying,
        popularMovies: popular,
        topRatedMovies: topRated,
        upcomingMovies: upcoming,
      ));
    } catch (e) {
      emit(MovieFailure("Failed to load all movies: $e"));
    }
  }
}
