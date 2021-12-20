part of 'description_cubit.dart';

abstract class DescriptionState {}

class DescriptionInitial extends DescriptionState {}
class SimilarMoviesLoaded extends DescriptionState {
  late List similarMovies,recommendations;
var watch ;
  SimilarMoviesLoaded({required this.similarMovies,required this.recommendations,required this.watch});



}
class VideosLoaded extends DescriptionState {
  late List videos;

  VideosLoaded({required this.videos});



}


class TrailersLoaded extends DescriptionState {
  late var trailers;

  TrailersLoaded({required this.trailers});}

  class WatchProvidersLoaded extends DescriptionState {
  late String watchProviders;

  WatchProvidersLoaded({required this.watchProviders});
  }

