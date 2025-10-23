import 'package:clean_architecture_tdd_course/core/models/movie_model.dart';
import 'package:clean_architecture_tdd_course/features/search/domain/entities/search.dart';

class SearchModel extends Search {
  const SearchModel({
    required List<MovieModel> movies,
    required int currentPage,
    required int totalPages,
  }) : super(
          movies: movies,
          currentPage: currentPage,
          totalPages: totalPages,
        );

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as List;
    final movies = results.map((e) => MovieModel.fromJson(e)).toList();
    return SearchModel(
      movies: movies,
      currentPage: json['page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
    );
  }
}
