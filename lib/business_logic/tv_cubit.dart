import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:weza_movies/constants/strings.dart';

part 'tv_state.dart';

class TvCubit extends Cubit<TvState> {
  TvCubit() : super(TvInitial());

  List popular = [];
  List topRatedTv = [];
  List nowPlaying = [];
  List airingToday = [];

  loadTv() async {

    TMDB _tmdb = TMDB(ApiKeys(apiKey, token),
        logConfig: ConfigLogger(
          showErrorLogs: true,
          showLogs: true,
        ));
    Map popular = await _tmdb.v3.tv.getPouplar();
    Map topRatedTv = await _tmdb.v3.tv.getTopRated();
    Map nowPlaying = await _tmdb.v3.tv.getOnTheAir();
    Map airingToday = await _tmdb.v3.tv.getAiringToday();


    this.nowPlaying = nowPlaying['results'];
    this.popular = popular['results'];
    this.topRatedTv = topRatedTv['results'];
    this.airingToday = airingToday['results'];
print('top rated tv   ${this.topRatedTv}');
    emit(TvLoaded(
      popular: this.popular,
      topRated: this.topRatedTv,
      nowPlayingTv: this.nowPlaying,
      airingToday: this.airingToday,
    ));
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
