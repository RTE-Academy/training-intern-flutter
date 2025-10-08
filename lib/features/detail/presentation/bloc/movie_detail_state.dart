import 'package:equatable/equatable.dart';
import '../../domain/entities/cast.dart';
import '../../domain/entities/movie_detail.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  final List<Cast> cast;
  final String? trailerKey;

  const MovieDetailLoaded({
    required this.movieDetail,
    this.cast = const [],
    this.trailerKey,
  });

  MovieDetailLoaded copyWith({
    MovieDetail? movieDetail,
    List<Cast>? cast,
    String? trailerKey,
  }) {
    return MovieDetailLoaded(
      movieDetail: movieDetail ?? this.movieDetail,
      cast: cast ?? this.cast,
      trailerKey: trailerKey ?? this.trailerKey,
    );
  }

  @override
  List<Object?> get props => [movieDetail, cast, trailerKey];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
