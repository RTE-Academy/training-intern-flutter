import 'package:clean_architecture_tdd_course/features/detail/domain/entities/cast.dart';

class MovieDetail {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final int runtime;
  final List<Cast> cast;
  final String? trailerKey;

  const MovieDetail({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.cast,
    this.trailerKey,
  });
}