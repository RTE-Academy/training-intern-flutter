import 'package:clean_architecture_tdd_course/features/detail/presentation/widgets/watch_trailer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection_container.dart';
import '../bloc/movie_detail_bloc.dart';
import '../bloc/movie_detail_event.dart';
import '../bloc/movie_detail_state.dart';
import '../widgets/cast_list_widget.dart';
import '../widgets/movie_poster_section.dart';
import '../widgets/top_action_buttons.dart';
import '../widgets/movie_info_section.dart';
import '../widgets/movie_overview_widget.dart';

class MovieDetailPage extends StatelessWidget {
  final int movieId;

  const MovieDetailPage({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailBloc>(
      create: (_) => sl<MovieDetailBloc>()..add(LoadMovieDetail(movieId)),
      child: const MovieDetailView(),
    );
  }
}

class MovieDetailView extends StatelessWidget {
  const MovieDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          } else if (state is MovieDetailLoaded) {
            return _buildContent(context, state);
          } else if (state is MovieDetailError) {
            return _buildError(context, state.message);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, MovieDetailLoaded state) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MoviePosterSection(posterPath: state.movieDetail.posterPath),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MovieInfoSection(movieDetail: state.movieDetail),
                    const SizedBox(height: 20),
                    MovieOverviewWidget(overview: state.movieDetail.overview),
                    const SizedBox(height: 24),
                    if (state.cast.isNotEmpty)
                      CastListWidget(cast: state.cast),
                    const SizedBox(height: 30),
                    WatchTrailerButton(movieId: state.movieDetail.id)
                  ],
                ),
              ),
            ],
          ),
        ),
        TopActionButtons(movieId: state.movieDetail.id),
      ],
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('Go Back', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
