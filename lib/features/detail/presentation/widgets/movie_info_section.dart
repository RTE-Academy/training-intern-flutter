import 'package:flutter/material.dart';
import '../../domain/entities/movie_detail.dart';
import '../../../../core/util/format_date.dart';

class MovieInfoSection extends StatelessWidget {
  final MovieDetail movieDetail;

  const MovieInfoSection({
    Key? key,
    required this.movieDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            movieDetail.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          _buildReleaseInfo(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildReleaseInfo() {
    final releaseDate = movieDetail.releaseDate;
    final runtime = movieDetail.runtime;
    final runtimeText = runtime != null ? '$runtime min' : '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Released',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const Text(' • ', style: TextStyle(color: Colors.grey, fontSize: 14)),
        Text(
          formatDate(releaseDate),
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        if (runtimeText.isNotEmpty) ...[
          const Text(' • ', style: TextStyle(color: Colors.grey, fontSize: 14)),
          Text(
            runtimeText,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ],
    );
  }
}