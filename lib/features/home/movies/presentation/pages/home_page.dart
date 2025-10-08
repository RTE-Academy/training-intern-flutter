import 'package:clean_architecture_tdd_course/features/home/movies/domain/usecases/get_nowplaying_movies_usecase.dart';
import 'package:clean_architecture_tdd_course/features/home/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:clean_architecture_tdd_course/features/home/movies/domain/usecases/get_toprated_movies_usecase.dart';
import 'package:clean_architecture_tdd_course/features/home/movies/domain/usecases/get_upcoming_movies_usecase.dart';
import 'package:clean_architecture_tdd_course/features/home/movies/presentation/pages/popular_see_more_page.dart';
import 'package:clean_architecture_tdd_course/features/home/movies/presentation/pages/toprated_see_more_page.dart';
import 'package:clean_architecture_tdd_course/features/home/movies/presentation/pages/upcoming_see_more_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection_container.dart';
import '../../../../detail/presentation/pages/movie_detail_page.dart';
import '../../domain/entities/movie.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import '../widgets/movie_error.dart';
import '../widgets/home_header.dart';
import '../widgets/featured_movie.dart';
import '../widgets/movie_section.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieBloc(
        getNowPlayingMovies: sl(),
        getPopularMovies: sl(),
        getTopRatedMovies: sl(),
        getUpcomingMovies: sl(),
      )..add(const LoadAllMoviesEvent()),
      child: HomeView(username: username),
    );
  }
}

class HomeView extends StatelessWidget {
  final String username;
  const HomeView({Key? key, required this.username}) : super(key: key);

  void _retryLoadMovies(BuildContext context) {
    context.read<MovieBloc>().add(const LoadAllMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          } else if (state is MovieLoaded) {
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: HomeHeader(
                      userName: username,
                      avatarUrl: 'https://i.pravatar.cc/150?img=5',
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: FeaturedMovie(movies: state.nowPlayingMovies),
                  ),
                  buildMovieSection(
                    context: context,
                    title: "Popular",
                    movies: state.popularMovies,
                    seeMorePage: const PopularSeeMorePage(),
                  ),
                  buildMovieSection(
                    context: context,
                    title: "Top Rated",
                    movies: state.topRatedMovies,
                    seeMorePage: const TopRatedSeeMorePage(),
                  ),
                  buildMovieSection(
                    context: context,
                    title: "Upcoming",
                    movies: state.upcomingMovies,
                    seeMorePage: const UpcomingSeeMorePage(),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            );
          } else if (state is MovieFailure) {
            return MovieError(
              message: state.message,
              onRetry: () => _retryLoadMovies(context),
            );
          }

          return const Center(
              child: CircularProgressIndicator(color: Colors.blue));
        },
      ),
    );
  }
}

Widget buildMovieSection({
  required BuildContext context,
  required String title,
  required List<Movie> movies,
  required Widget seeMorePage,
}) {
  return SliverToBoxAdapter(
    child: MovieSection(
      title: title,
      movies: movies,
      onSeeMoreTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => seeMorePage),
        );
      },
      onMovieTap: (movie) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailPage(movieId: movie.id),
          ),
        );
      },
    ),
  );
}
