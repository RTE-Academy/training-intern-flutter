import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';

class FeaturedMovie extends StatefulWidget {
  final List<Movie> movies;

  const FeaturedMovie({Key? key, required this.movies}) : super(key: key);

  @override
  State<FeaturedMovie> createState() => _FeaturedMovieState();
}

class _FeaturedMovieState extends State<FeaturedMovie> {
  late PageController _pageController;
  int _currentMovie = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (widget.movies.isEmpty) return;
      setState(() {
        _currentMovie = (_currentMovie + 1) % widget.movies.length;
      });
      _pageController.animateToPage(
        _currentMovie,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "New release.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                final movie = widget.movies[index];
                return GestureDetector(
                  onTap: () {
                    // TODO: Navigate to movie detail
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          movie.backdropPath != null
                              ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
                              : 'https://via.placeholder.com/500x750',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title ?? 'Unknown',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // const SizedBox(height: 4),
                              // const Text(
                              //   "Marvel Studios", // hoặc movie.productionCompany nếu có
                              //   style: TextStyle(
                              //     color: Colors.white70,
                              //     fontSize: 14,
                              //   ),
                              // ),
                              const SizedBox(height: 8),
                              // Row(
                              //   children: [
                              //     ...List.generate(
                              //       5,
                              //           (starIndex) => Icon(
                              //         Icons.star,
                              //         color: starIndex <
                              //             ((movie.voteAverage ?? 0) / 2)
                              //             ? Colors.amber
                              //             : Colors.grey.shade700,
                              //         size: 16,
                              //       ),
                              //     ),
                              //     const SizedBox(width: 6),
                              //     Text(
                              //       "From ${movie.voteCount ?? 0} users",
                              //       style: const TextStyle(
                              //         color: Colors.white70,
                              //         fontSize: 12,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
