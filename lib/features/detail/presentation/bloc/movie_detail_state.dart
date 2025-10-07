import 'package:clean_architecture_tdd_course/features/detail/domain/entities/cast.dart';
import 'package:equatable/equatable.dart';
// import '../../domain/entities/cast.dart';
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
  final bool isFavorite;
  final String? trailerUrl;

  const MovieDetailLoaded({
    required this.movieDetail,
    this.cast = const [],
    this.isFavorite = false,
    this.trailerUrl,
  });

  MovieDetailLoaded copyWith({
    MovieDetail? movieDetail,
    List<Cast>? cast,
    bool? isFavorite,
    String? trailerUrl,
  }) {
    return MovieDetailLoaded(
      movieDetail: movieDetail ?? this.movieDetail,
      cast: cast ?? this.cast,
      isFavorite: isFavorite ?? this.isFavorite,
      trailerUrl: trailerUrl ?? this.trailerUrl,
    );
  }

  @override
  List<Object?> get props => [movieDetail, cast, isFavorite, trailerUrl];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
