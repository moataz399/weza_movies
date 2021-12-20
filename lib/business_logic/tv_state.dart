part of 'tv_cubit.dart';

@immutable
abstract class TvState {}

class TvInitial extends TvState {}
class TvLoaded extends TvState {
  List popular,topRated,nowPlayingTv,airingToday;
  TvLoaded({required this.popular,required this.nowPlayingTv,required this.airingToday,required this.topRated});
}
class SearchLoaded extends TvState {
  late List search;

  SearchLoaded({required this.search});
}