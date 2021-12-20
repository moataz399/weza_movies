part of 'descretiontv_cubit.dart';

@immutable
abstract class DescriptionTvState {}

class DescretiontvInitial extends DescriptionTvState {}
class SimilarTvLoaded extends DescriptionTvState {
  late List similarMovies,recommendations;
var watch;
  SimilarTvLoaded({required this.similarMovies,required this.watch,required this.recommendations});



}