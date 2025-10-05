// import 'package:clean_architecture_tdd_course/features/home/movies/presentation/pages/popular_see_more_page.dart';
// import 'package:clean_architecture_tdd_course/features/home/movies/presentation/pages/toprated_see_more_page.dart';
// import 'package:clean_architecture_tdd_course/features/home/movies/presentation/pages/upcoming_see_more_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection_container.dart';
import '../../domain/usecases/get_nowplaying_movie_usecase.dart';
import '../../domain/usecases/get_popular_movie_usecase.dart';
import '../../domain/usecases/get_toprated_movie_usecase.dart';
import '../../domain/usecases/get_upcoming_movie_usecase.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import '../widgets/Movie_error.dart';
import '../widgets/home_header.dart';
import '../widgets/featured_movie.dart';
import '../widgets/movie_section.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    _movieBloc = MovieBloc(
      getNowPlayingMovies: sl<GetNowPlayingMovies>(),
      getPopularMovies: sl<GetPopularMovie>(),
      getTopRatedMovies: sl<GetTopRatedMovie>(),
      getUpcomingMovies: sl<GetUpcomingMovie>(),
    )
      ..add(const GetMoviesEvent(MovieCategory.nowPlaying))
      ..add(const GetMoviesEvent(MovieCategory.popular))
      ..add(const GetMoviesEvent(MovieCategory.topRated))
      ..add(const GetMoviesEvent(MovieCategory.upcoming));
  }

  @override
  void dispose() {
    _movieBloc.close();
    super.dispose();
  }

  void _retryLoadMovies() {
    _movieBloc
      ..add(const GetMoviesEvent(MovieCategory.nowPlaying))
      ..add(const GetMoviesEvent(MovieCategory.popular))
      ..add(const GetMoviesEvent(MovieCategory.topRated))
      ..add(const GetMoviesEvent(MovieCategory.upcoming));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider.value(
        value: _movieBloc,
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            } else if (state is MovieLoaded) {
              return SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: HomeHeader(
                        userName: widget.username,
                        avatarUrl: 'https://i.pravatar.cc/150?img=5',
                      ),
                    ),

                    // Featured Movie (Now Playing)
                    SliverToBoxAdapter(
                      child: FeaturedMovie(
                        movies: state.nowPlayingMovies,
                      ),
                    ),

                    // Popular Section
                    SliverToBoxAdapter(
                      child: MovieSection(
                        title: "Popular",
                        movies: state.popularMovies,
                        onSeeMoreTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const PopularSeeMorePage(),
                          //   ),
                          // );
                        },
                      ),
                    ),

                    // Top Rated Section
                    SliverToBoxAdapter(
                      child: MovieSection(
                        title: "Top Rated",
                        movies: state.topRatedMovies,
                        onSeeMoreTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const TopRatedSeeMorePage(),
                          //   ),
                          // );
                        },
                      ),
                    ),

                    // Upcoming Section
                    SliverToBoxAdapter(
                      child: MovieSection(
                        title: "Upcoming",
                        movies: state.upcomingMovies,
                        onSeeMoreTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const UpcomingSeeMorePage(),
                          //   ),
                          // );
                        },
                      ),
                    ),

                    const SliverToBoxAdapter(
                      child: SizedBox(height: 24),
                    ),
                  ],
                ),
              );
            } else if (state is MovieFailure) {
              return MovieError(
                message: state.message,
                onRetry: _retryLoadMovies,
              );
            }

            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          },
        ),
      ),
    );
  }
}