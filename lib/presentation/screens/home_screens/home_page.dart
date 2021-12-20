// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_movies/business_logic/movies_cubit.dart';
import 'package:weza_movies/business_logic/tv_cubit.dart';
import 'package:weza_movies/presentation/screens/home_screens/nowplaying_screen.dart';
import 'package:weza_movies/presentation/screens/other_screens/search_screen.dart';
import 'package:weza_movies/presentation/screens/home_screens/top_rated.dart';
import 'package:weza_movies/presentation/screens/tv_screens/airingtoday_screen.dart';
import 'package:weza_movies/presentation/screens/tv_screens/popular_screen.dart';
import 'package:weza_movies/presentation/screens/tv_screens/top_rated_tv_screen.dart';
import 'package:weza_movies/presentation/screens/home_screens/upcoming_screen.dart';
import 'package:weza_movies/presentation/widgets/components.dart';
import 'package:weza_movies/utilities/text.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List trending = [];
  List topRatedMovies = [];
  List upComing = [];
  List nowPlaying = [];



  List popular = [];
  List topRatedTv = [];
  List nowPlayingTv = [];
  List airingToday = [];
  @override
  void initState() {
    BlocProvider.of<MoviesCubit>(context).loadMovies();
    BlocProvider.of<MoviesCubit>(context).getSearch(q: '');
    BlocProvider.of<TvCubit>(context).loadTv();
    BlocProvider.of<TvCubit>(context).getSearch(q: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Movies',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  'TV',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  navigateTo(context: context, widget: const SearchScreen());
                },
                icon: const Icon(Icons.search))
          ],
          title: const ModifiedText(
            text: 'Wezatix',
            color: Colors.white,
            size: 24,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: TabBarView(children: <Widget>[
          buildBlocWidget(),
          buildBlocWidgetTv(),
        ]),
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<MoviesCubit, MoviesStates>(
      builder: (context, state) {
        if (state is MoviesLoaded) {
          trending = (state).trending;
          topRatedMovies = (state).topRated;

          nowPlaying = state.nowPlaying;
          upComing = state.upComing;
          return loadedListWidget();
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }
      },
    );
  }

  Widget loadedListWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          //   TvScreen(tv: tv),

          TopRatedScreen(topRated: topRatedMovies),
          NowPlayingScreen(nowPlaying: nowPlaying),
          UpComingScreen(upComing: upComing),
        ],
      ),
    );
  }




  Widget buildBlocWidgetTv() {
    return BlocBuilder<TvCubit, TvState>(
      builder: (context, state) {
        if (state is TvLoaded) {
          popular = (state).popular;
          airingToday = state.airingToday;
          nowPlayingTv = state.nowPlayingTv;
          topRatedTv = state.topRated;
          return loadedListWidgetTv();
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }
      },
    );
  }

  Widget loadedListWidgetTv() {
    return SingleChildScrollView(
      child: Column(
        children: [
          PopularScreen(popular: popular),
          TopRatedTvScreen(topRated: topRatedTv),
          AiringTodayTv(airingToday: airingToday),

        ],
      ),
    );
  }
}
