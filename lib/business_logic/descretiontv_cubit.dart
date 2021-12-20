import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:weza_movies/constants/strings.dart';

part 'descretiontv_state.dart';

class DescriptionTvCubit extends Cubit<DescriptionTvState> {
  DescriptionTvCubit() : super(DescretiontvInitial());
  List similar = [];
  List recommendations = [];

  void similarTv({required int id}) async {
    similar = [];
    this.recommendations = [];
    TMDB _tmdb = TMDB(ApiKeys(apiKey, token),
        logConfig: ConfigLogger(
          showErrorLogs: true,
          showLogs: true,
        ));
    Map similarTv = await _tmdb.v3.tv.getSimilar(id);
    Map recommendations = await _tmdb.v3.tv.getRecommendations(id);
    Map watchProvider = await _tmdb.v3.tv.getWatchProviders(id.toString());

    similar = similarTv['results'];
    this.recommendations = recommendations['results'];
    var link = watchProvider['results']['AT']['link'] != null ?watchProvider['results']['AT']['link'] :watchProvider['results']['AR']['link']  ;
    print('link is :  ${link}');
    emit(SimilarTvLoaded(
        watch: link!= null ? link : 'https://www.google.com.eg/?gfe_rd=cr&dcr=0&ei=uDDiWejMEsjc8Af4la34DA',
        similarMovies: similar,
        recommendations: this.recommendations));
    print(this.recommendations);
  }
}
