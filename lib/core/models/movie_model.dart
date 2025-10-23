import 'package:clean_architecture_tdd_course/features/detail/data/model/cast_model.dart';

import '../../features/home/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required int id,
    required String title,
    required String overview,
    required String posterPath,
    required String backdropPath,
    required String releaseDate,
    required int runtime,
    required List<CastModel> cast,
    required String trailerKey,
    required double voteAverage,
  }) : super(
          id: id,
          title: title,
          overview: overview,
          posterPath: posterPath,
          backdropPath: backdropPath,
          releaseDate: releaseDate,
          cast: cast,
          runtime: runtime,
          trailerKey: trailerKey,
          voteAverage: voteAverage,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      cast: json['cast']?.map((cast) => CastModel.fromJson(cast)).toList() ?? [],
      trailerKey: json['trailer_key'] ?? '',
      voteAverage: json['vote_average'] ?? 0.0,
    );
  }

  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      releaseDate: releaseDate,
      runtime: runtime,
      cast: cast,
      trailerKey: trailerKey,
      voteAverage: voteAverage,
    );
  }
}
