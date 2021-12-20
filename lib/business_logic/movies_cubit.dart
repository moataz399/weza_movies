// ignore_for_file: avoid_print

import 'package:meta/meta.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:weza_movies/constants/strings.dart';
import 'package:bloc/bloc.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesInitial());

  List trendingMovies = [];
  List topRatedMovies = [];
  List nowPlaying = [];
  List upComing = [];

  loadMovies() async {
    TMDB _tmdb = TMDB(ApiKeys(apiKey, token),
        logConfig: ConfigLogger(
          showErrorLogs: true,
          showLogs: true,
        ));
    Map trendingMovies = await _tmdb.v3.trending.getTrending();
    Map topRatedMovies = await _tmdb.v3.movies.getTopRated();
    Map nowPlaying = await _tmdb.v3.movies.getNowPlaying();
    Map upComing = await _tmdb.v3.movies.getUpcoming();

    this.nowPlaying = nowPlaying['results'];
    this.trendingMovies = trendingMovies['results'];
    this.topRatedMovies = topRatedMovies['results'];
    this.upComing = upComing['results'];

    emit(MoviesLoaded(
        upComing: this.upComing,
        nowPlaying: this.nowPlaying,
        trending: this.trendingMovies,
        topRated: this.topRatedMovies));
  }

  List search = [];

  getSearch({required String q}) async {
    this.search = [];
    TMDB _tmdb = TMDB(ApiKeys(apiKey, token),
        logConfig: ConfigLogger(
          showErrorLogs: true,
          showLogs: true,
        ));

    Map search = await _tmdb.v3.search.queryMovies(q);
    this.search = search['results'];
    emit(SearchLoaded(search: this.search));
  }

}
