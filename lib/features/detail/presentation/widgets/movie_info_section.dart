import 'package:clean_architecture_tdd_course/features/home/movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import '../../../../core/util/format_date.dart';

class MovieInfoSection extends StatelessWidget {
  final Movie movie;

  const MovieInfoSection({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            movie.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _buildReleaseInfo(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildReleaseInfo() {
    final releaseDate = movie.releaseDate;
    final runtime = movie.runtime;
    final runtimeText = '$runtime min';
    final voteAverage = movie.voteAverage;
    final votePercent = (voteAverage * 10).toInt();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
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
            ),
          ],
        ),

        const SizedBox(width: 16),

        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(
                    value: votePercent / 100,
                    strokeWidth: 4,
                    backgroundColor: Colors.grey.shade800,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      votePercent >= 70
                          ? Colors.green
                          : (votePercent >= 40 ? Colors.yellow : Colors.red),
                    ),
                  ),
                ),
                Text(
                  '$votePercent%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Score',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}