import 'package:clean_architecture_tdd_course/features/detail/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:clean_architecture_tdd_course/core/constant/constant_url.dart';
import 'package:clean_architecture_tdd_course/features/home/movies/domain/entities/movie.dart';

class MovieCardSearch extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;

  const MovieCardSearch({
    Key? key,
    required this.movie,
    this.onTap,
  }) : super(key: key);

  void _openMovieDetail(BuildContext context, int movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(movieId: movieId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? imageUrl =
    movie.posterPath.isNotEmpty ? '$img_url_w500${movie.posterPath}' : null;

    return InkWell(
      onTap: () => _openMovieDetail(context, movie.id),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: imageUrl != null
                    ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildErrorPlaceholder(),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                          strokeWidth: 2.5,
                        ),
                      ),
                    );
                  },
                )
                    : _buildErrorPlaceholder(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey[850],
      alignment: Alignment.center,
      child: const Icon(
        Icons.broken_image,
        color: Colors.white54,
        size: 40,
      ),
    );
  }
}
