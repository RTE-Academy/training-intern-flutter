import 'package:clean_architecture_tdd_course/features/detail/presentation/widgets/youtube_trailer_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../bloc/movie_detail_bloc.dart';
import '../bloc/movie_detail_event.dart';
import '../bloc/movie_detail_state.dart';

class WatchTrailerButton extends StatelessWidget {
  final int movieId;

  const WatchTrailerButton({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieDetailBloc, MovieDetailState>(
      listener: (context, state) {
        if (state is MovieDetailLoaded &&
            state.trailerUrl != null &&
            state.trailerUrl!.isNotEmpty) {
          final trailerKey = YoutubePlayer.convertUrlToId(state.trailerUrl!);
          if (trailerKey != null && trailerKey.isNotEmpty) {
            showTrailerDialog(context, trailerKey);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Không thể phát trailer.")),
            );
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00BCD4), Color(0xFF9C27B0)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton.icon(
          onPressed: () {
            context.read<MovieDetailBloc>().add(WatchMovie(movieId));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          ),
          icon: const Icon(Icons.play_arrow, color: Colors.black),
          label: const Text(
            'Watch Trailer',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
