import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovieDetail extends MovieDetailEvent {
  final int movieId;

  const LoadMovieDetail(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class LoadMovieCredits extends MovieDetailEvent {
  final int movieId;

  const LoadMovieCredits(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class ToggleFavorite extends MovieDetailEvent {
  final int movieId;

  const ToggleFavorite(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class WatchMovie extends MovieDetailEvent {
  final int movieId;

  const WatchMovie(this.movieId);

  @override
  List<Object?> get props => [movieId];
}