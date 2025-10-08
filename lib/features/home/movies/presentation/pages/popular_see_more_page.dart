import 'package:clean_architecture_tdd_course/core/constant/constant_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection_container.dart';
import '../../../../detail/presentation/pages/movie_detail_page.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';

class PopularSeeMorePage extends StatelessWidget {
  const PopularSeeMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (_) => MovieBloc(
        getNowPlayingMovies: sl(),
        getPopularMovies: sl(),
        getTopRatedMovies: sl(),
        getUpcomingMovies: sl(),
      )..add(const GetMoviesEvent(MovieCategory.popular)),
      child: const PopularSeeMoreView(),
    );
  }
}

class PopularSeeMoreView extends StatefulWidget {
  const PopularSeeMoreView({Key? key}) : super(key: key);

  @override
  State<PopularSeeMoreView> createState() => _PopularSeeMoreViewState();
}

class _PopularSeeMoreViewState extends State<PopularSeeMoreView> {
  int _currentPage = 1;
  bool _isLoadingMore = false;

  void _loadMore() {
    setState(() => _isLoadingMore = true);
    _currentPage++;
    context.read<MovieBloc>().add(
          LoadMoreMoviesEvent(MovieCategory.popular, _currentPage),
        );
  }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Popular Movies',
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
      body: BlocListener<MovieBloc, MovieState>(
        listener: (context, state) {
          if (state is MovieLoaded || state is MovieFailure) {
            setState(() => _isLoadingMore = false);
          }
        },
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading && _currentPage == 1) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent));
            } else if (state is MovieLoaded) {
              final movies = state.popularMovies;
              final itemCount =
                  _isLoadingMore ? movies.length + 1 : movies.length;

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
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        if (_isLoadingMore && index == movies.length) {
                          // Small loading indicator at bottom
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.blueAccent,
                                strokeWidth: 2.5,
                              ),
                            ),
                          );
                        }

                        final movie = movies[index];
                        return InkWell(
                          onTap: () => _openMovieDetail(context, movie.id),
                          borderRadius: BorderRadius.circular(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    '$img_url_w500${movie.posterPath}',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
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
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFF00BCD4), Color(0xFF9C27B0)]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoadingMore ? null : _loadMore,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: _isLoadingMore
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2.0),
                            )
                          : const Text(
                              'Load More',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              );
            } else if (state is MovieFailure) {
              return Center(
                  child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ));
            }

            return const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent));
          },
        ),
      ),
    );
  }
}
