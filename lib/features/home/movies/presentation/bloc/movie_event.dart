import 'package:equatable/equatable.dart';

enum MovieCategory { nowPlaying, popular, topRated, upcoming}

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class GetMoviesEvent extends MovieEvent {
  final MovieCategory category;
  final int page;

  const GetMoviesEvent(this.category, {this.page = 1});

  @override
  List<Object?> get props => [category, page];
}

class LoadMoreMoviesEvent extends MovieEvent {
  final MovieCategory category;
  final int nextPage;

  const LoadMoreMoviesEvent(this.category, this.nextPage);

  @override
  List<Object?> get props => [category, nextPage];
}
