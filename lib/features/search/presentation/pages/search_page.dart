import 'package:clean_architecture_tdd_course/features/search/presentation/bloc/search_bloc.dart';
import 'package:clean_architecture_tdd_course/features/search/presentation/bloc/search_event.dart';
import 'package:clean_architecture_tdd_course/features/search/presentation/bloc/search_state.dart';
import 'package:clean_architecture_tdd_course/features/search/presentation/widgets/category_section.dart';
import 'package:clean_architecture_tdd_course/features/search/presentation/widgets/movie_grid.dart';
import 'package:clean_architecture_tdd_course/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SearchBloc>(),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SearchBloc bloc = context.read<SearchBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Search Movies',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.5,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0ea5e9), Color(0xFF8b5cf6)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1a1a2e),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search for a content',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                      onChanged: (query) {
                        if (query.isNotEmpty) {
                          bloc.add(SearchMovieEvent(query: query, page: 1));
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const CategorySection(),
                const SizedBox(height: 30),
                const Text(
                  'Results.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchInitial) {
                      return const Center(
                        child: Text('Type something to search...',
                            style: TextStyle(color: Colors.grey)),
                      );
                    } else if (state is SearchLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                            strokeWidth: 2.5,
                          ),
                        ),
                      );
                    } else if (state is SearchError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      );
                    } else if (state is SearchLoaded) {
                      final search = state.searchResults;
                      return Column(
                        children: [
                          MovieGrid(movies: search.movies),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: search.currentPage > 1
                                    ? () {
                                        bloc.add(
                                          SearchMovieEvent(
                                            query: state.query,
                                            page: search.currentPage - 1,
                                          ),
                                        );
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  disabledBackgroundColor: Colors.black,
                                ),
                                child: const Text('Previous'),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'Page ${search.currentPage} / ${search.totalPages}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed:
                                    search.currentPage < search.totalPages
                                        ? () {
                                            bloc.add(
                                              SearchMovieEvent(
                                                query: state.query,
                                                page: search.currentPage + 1,
                                              ),
                                            );
                                          }
                                        : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  disabledBackgroundColor: Colors.black,
                                ),
                                child: const Text('Next'),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
