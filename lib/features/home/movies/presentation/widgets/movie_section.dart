import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import 'movie_card.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final VoidCallback? onSeeMoreTap;
  final void Function(Movie movie)? onMovieTap;

  const MovieSection({
    required this.title,
    required this.movies,
    this.onSeeMoreTap,
    this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: onSeeMoreTap,
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return SizedBox(
                width: 140,
                child: MovieCard(
                  movie: movie,
                  onTap: () {
                    if (onMovieTap != null) {
                      onMovieTap!(movie);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
