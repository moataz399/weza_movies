part of 'movies_cubit.dart';

@immutable
abstract class MoviesStates {}

class MoviesInitial extends MoviesStates {}

class MoviesLoaded extends MoviesStates {
  List trending, topRated, nowPlaying, upComing;

  MoviesLoaded(
      {required this.trending,
      required this.upComing,
      required this.topRated,
      required this.nowPlaying});
}

class SearchLoaded extends MoviesStates {
  late List search;

  SearchLoaded({required this.search});
}

class NowPlayiongLoaded extends MoviesStates {
  late List NowPlayiong;

  NowPlayiongLoaded({required this.NowPlayiong});
}
