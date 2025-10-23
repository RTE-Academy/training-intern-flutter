import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../bloc/movie_detail_bloc.dart';
import '../bloc/movie_detail_event.dart';
import '../bloc/movie_detail_state.dart';
import 'youtube_trailer_player.dart';

class WatchTrailerButton extends StatefulWidget {
  final int movieId;
  const WatchTrailerButton({super.key, required this.movieId});

  @override
  State<WatchTrailerButton> createState() => _WatchTrailerButtonState();
}

class _WatchTrailerButtonState extends State<WatchTrailerButton> {
  YoutubePlayerController? _controller;

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  void showTrailerDialog(BuildContext context, String trailerKey) {
    if (_controller == null) {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: trailerKey,
        autoPlay: true,
        params: const YoutubePlayerParams(
          showFullscreenButton: true,
          showControls: true,
          mute: false,
        ),
      );
    } else {
      _controller!.playVideo();
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => TrailerDialog(controller: _controller!),
    ).then((_) {
      _controller?.pauseVideo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MovieDetailBloc>();

    return BlocConsumer<MovieDetailBloc, MovieDetailState>(
      listener: (context, state) {
        if (state is MovieDetailLoaded && state.trailerKey != null) {
          showTrailerDialog(context, state.trailerKey!);
        } else if (state is MovieDetailError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00BCD4), Color(0xFF9C27B0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton.icon(
            onPressed: () => bloc.add(WatchMovie(widget.movieId)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            ),
            icon: const Icon(Icons.play_arrow, color: Colors.white),
            label: const Text(
              'Watch Trailer',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}
