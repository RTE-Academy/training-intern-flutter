import '../../domain/entities/movie_detail.dart';
import 'cast_model.dart';

class MovieDetailModel extends MovieDetail {
  MovieDetailModel({
    required int id,
    required String title,
    required String overview,
    required String posterPath,
    required String releaseDate,
    required int runtime,
    required List<CastModel> cast,
    String? trailerKey,
  }) : super(
    id: id,
    title: title,
    posterPath: posterPath,
    overview: overview,
    runtime: runtime,
    releaseDate: releaseDate,
    cast: cast,
    trailerKey: trailerKey,
  );

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => CastModel.fromJson(e))
          .toList() ??
          [],
      trailerKey: json['trailer_key'],
    );
  }
}
