import 'package:clean_architecture_tdd_course/features/detail/domain/entities/cast.dart';

class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String backdropPath;
  final String releaseDate;
  final int runtime;
  final List<Cast> cast;
  final String? trailerKey;
  final double voteAverage;

  const Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.backdropPath,
    required this.releaseDate,
    required this.runtime,
    required this.cast,
    required this.trailerKey,
    required this.voteAverage,
  });
}
