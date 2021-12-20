// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:weza_movies/constants/strings.dart';

part 'description_state.dart';

class DescriptionCubit extends Cubit<DescriptionState> {
  DescriptionCubit() : super(DescriptionInitial());

  List similar = [];
  List recommendations = [];

  var watchProvider;

  similarMovies({required int id}) async {
    similar = [];
    this.recommendations = [];
    TMDB _tmdb = TMDB(ApiKeys(apiKey, token),
        logConfig: ConfigLogger(
          showErrorLogs: true,
          showLogs: true,
        ));
    Map similarMovies = await _tmdb.v3.movies.getSimilar(id);
    Map recommendations = await _tmdb.v3.movies.getRecommended(id);
    Map watchProvider = await _tmdb.v3.movies.getWatchProviders(id);

    similar = similarMovies['results'];
    this.recommendations = recommendations['results'];
    this.watchProvider = watchProvider['results'];
    var link = watchProvider['results']['AR']['link'] != null
        ? watchProvider['results']['AR']['link']
        : 'https://jack.egybest.ltd/';
    print('watch Provider is :  ${this.watchProvider}');
    print('link is :  ${link}');

    emit(SimilarMoviesLoaded(
        watch: link,
        similarMovies: similar,
        recommendations: this.recommendations));
  }
}
