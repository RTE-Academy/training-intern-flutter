import 'package:clean_architecture_tdd_course/features/home/movies/domain/usecases/get_toprated_movies_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection_container.dart';
import '../../../../detail/presentation/bloc/movie_detail_bloc.dart';
import '../../../../detail/presentation/bloc/movie_detail_event.dart';
import '../../../../detail/presentation/pages/movie_detail_page.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';

class TopRatedSeeMorePage extends StatelessWidget {
  const TopRatedSeeMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (_) => MovieBloc(
        getNowPlayingMovies: sl(),
        getPopularMovies: sl(),
        getTopRatedMovies: sl<GetTopRatedMoviesUsecase>(),
        getUpcomingMovies: sl(),
      )..add(const GetMoviesEvent(MovieCategory.topRated)),
      child: const TopRatedSeeMoreView(),
    );
  }
}

class TopRatedSeeMoreView extends StatefulWidget {
  const TopRatedSeeMoreView({Key? key}) : super(key: key);

  @override
  State<TopRatedSeeMoreView> createState() => _TopRatedSeeMoreViewState();
}

class _TopRatedSeeMoreViewState extends State<TopRatedSeeMoreView> {
  int _currentPage = 1;

  void _loadMore() {
    _currentPage++;
    context.read<MovieBloc>().add(
      LoadMoreMoviesEvent(MovieCategory.topRated, _currentPage),
    );
  }

  void _openMovieDetail(BuildContext context, int movieId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => MovieDetailBloc(
            getMovieDetail: sl(),
            getMovieCredits: sl(),
            getMovieVideos: sl(),
          )..add(LoadMovieDetail(movieId)),
          child: MovieDetailPage(movieId: movieId),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'TopRated Movies',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading && _currentPage == 1) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is MovieLoaded) {
            final movies = state.topRatedMovies;

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return InkWell(
                        onTap: () { _openMovieDetail(context, movie.id); },
                        borderRadius: BorderRadius.circular(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        color: Colors.grey[800],
                                        child: const Icon(Icons.broken_image,
                                            color: Colors.white70),
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00BCD4), Color(0xFF9C27B0)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _loadMore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Load More',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is MovieFailure) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          return const Center(
              child: CircularProgressIndicator(color: Colors.blue));
        },
      ),
    );
  }
}
