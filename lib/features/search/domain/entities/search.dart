import 'package:clean_architecture_tdd_course/core/models/movie_model.dart';

class Search {
  final List<MovieModel> movies;
  final int currentPage;
  final int totalPages;

  const Search({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
  });
}