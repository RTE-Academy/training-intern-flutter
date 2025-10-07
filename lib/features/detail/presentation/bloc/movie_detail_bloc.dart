import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_movie_credit_usecase.dart';
import '../../domain/usecases/get_movie_detail_usecase.dart';
// import '../../domain/usecases/get_movie_credits_usecase.dart';
import '../../domain/usecases/get_movie_video_usecase.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetailUsecase getMovieDetail;
  final GetMovieCreditsUsecase getMovieCredits;
  final GetMovieVideoUsecase getMovieVideos;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieCredits,
    required this.getMovieVideos,
  }) : super(MovieDetailInitial()) {
    on<LoadMovieDetail>(_onLoadMovieDetail);
    on<LoadMovieCredits>(_onLoadMovieCredits);
    on<WatchMovie>(_onWatchMovie);
  }

  Future<void> _onLoadMovieDetail(
      LoadMovieDetail event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());

    final result = await getMovieDetail(event.movieId);
    result.fold(
      (failure) => emit(const MovieDetailError("Failed to load movie details")),
      (movieDetail) {
        emit(MovieDetailLoaded(movieDetail: movieDetail));

        add(LoadMovieCredits(event.movieId));
      },
    );
  }

  Future<void> _onLoadMovieCredits(
      LoadMovieCredits event, Emitter<MovieDetailState> emit) async {
    if (state is MovieDetailLoaded) {
      final currentState = state as MovieDetailLoaded;
      final result = await getMovieCredits(event.movieId);
      result.fold(
        (failure) => emit(currentState.copyWith(cast: [])),
        (castList) => emit(currentState.copyWith(cast: castList)),
      );
    }
  }

  Future<void> _onWatchMovie(
    WatchMovie event,
    Emitter<MovieDetailState> emit,
  ) async {
    if (state is! MovieDetailLoaded) return;

    final currentState = state as MovieDetailLoaded;
    final result = await getMovieVideos(event.movieId);

    result.fold(
      (failure) {
        emit(MovieDetailError("Failed to load trailer"));
      },
      (trailerKey) {
        if (trailerKey != null && trailerKey.isNotEmpty) {
          final trailerUrl = 'https://www.youtube.com/watch?v=$trailerKey';
          emit(currentState.copyWith(trailerUrl: trailerUrl));
        } else {
          emit(MovieDetailError("Trailer not available"));
        }
      },
    );
  }
}
