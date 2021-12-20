import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_movies/business_logic/descretiontv_cubit.dart';
import 'package:weza_movies/business_logic/description_cubit.dart';
import 'package:weza_movies/business_logic/movies_cubit.dart';
import 'package:weza_movies/business_logic/tv_cubit.dart';
import 'package:weza_movies/presentation/screens/description_screens/description_screen.dart';
import 'package:weza_movies/presentation/screens/home_screens/home_page.dart';
import 'package:weza_movies/presentation/screens/home_screens/nowplaying_screen.dart';
import 'package:weza_movies/presentation/screens/description_screens/similar_movies.dart';
import 'package:weza_movies/presentation/screens/other_screens/search_screen.dart';
import 'package:weza_movies/presentation/screens/home_screens/top_rated.dart';
import 'package:weza_movies/presentation/screens/home_screens/trending.dart';
import 'package:weza_movies/presentation/screens/tv_screens/tv_page.dart';
import 'package:weza_movies/presentation/screens/tv_screens/popular_screen.dart';
import 'package:weza_movies/presentation/screens/home_screens/upcoming_screen.dart';
import 'constants/strings.dart';

class AppRouter {
  AppRouter() {
    String initialRoute;
  }

  late int id;

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<MoviesCubit>(
                  create: (context) => MoviesCubit(),
                  child: HomePage(),
                ));
      case tvPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<TvCubit>(
                  create: (context) => TvCubit(),
                  child: TvPage(),
                ));
      case tv:
        return MaterialPageRoute(
            builder: (_) => PopularScreen(popular: const []));
      case trending:
        return MaterialPageRoute(
            builder: (_) => TrendingScreen(
                  trending: const [],
                ));

      case description:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<DescriptionCubit>(
                  create: (context) => DescriptionCubit(),
                  child: Description(
                    id: id,
                    voteCount: '',
                    language: '',
                    name: '',
                    bannerUrl: '',
                    description: '',
                    posterUrl: '',
                    vote: '',
                    popularity: "",
                    launchOn: '',
                    isTv: false,
                  ),
                ));
      case descriptionTv:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<DescriptionTvCubit>(
                  create: (context) => DescriptionTvCubit(),
                  child: Description(
                    id: id,
                    voteCount: '',
                    language: '',
                    name: '',
                    bannerUrl: '',
                    description: '',
                    posterUrl: '',
                    vote: '',
                    popularity: "",
                    launchOn: '',
                    isTv: false,
                  ),
                ));
      case topRated:
        return MaterialPageRoute(
            builder: (_) => TopRatedScreen(topRated: const []));
      case upComingScreen:
        return MaterialPageRoute(
            builder: (_) => UpComingScreen(upComing: const []));
      case nowPlayingScreen:
        return MaterialPageRoute(
            builder: (_) => NowPlayingScreen(nowPlaying: const []));
      case searchScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<MoviesCubit>(
                  create: (context) => MoviesCubit(),
                  child: const SearchScreen(),
                ));
      case similarMoviesScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<DescriptionCubit>(
                  create: (context) => DescriptionCubit(),
                  child: SimilarMoviesScreen(
                    similarMovies: [],
                  ),
                ));
    }
  }
}
