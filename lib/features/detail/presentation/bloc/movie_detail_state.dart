import 'package:clean_architecture_tdd_course/features/home/movies/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/cast.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final Movie movie;
  final List<Cast> cast;
  final String? trailerKey;

  const MovieDetailLoaded({
    required this.movie,
    this.cast = const [],
    this.trailerKey,
  });

  MovieDetailLoaded copyWith({
    Movie? movie,
    List<Cast>? cast,
    String? trailerKey,
  }) {
    return MovieDetailLoaded(
      movie: movie ?? this.movie,
      cast: cast ?? this.cast,
      trailerKey: trailerKey ?? this.trailerKey,
    );
  }

  @override
  List<Object?> get props => [movie, cast, trailerKey];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
