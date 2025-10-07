import 'package:flutter/material.dart';

class MoviePosterSection extends StatelessWidget {
  final String? posterPath;
  final String? backdropPath;

  const MoviePosterSection({
    Key? key,
    this.posterPath,
    this.backdropPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = posterPath != null
        ? 'https://image.tmdb.org/t/p/original$posterPath'
        : (backdropPath != null
        ? 'https://image.tmdb.org/t/p/original$backdropPath'
        : 'https://via.placeholder.com/500x750');

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey.shade900,
                child: const Icon(
                  Icons.movie,
                  size: 100,
                  color: Colors.grey,
                ),
              );
            },
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}