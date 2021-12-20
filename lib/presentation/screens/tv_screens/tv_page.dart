// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_movies/business_logic/tv_cubit.dart';
import 'package:weza_movies/presentation/screens/home_screens/home_page.dart';
import 'package:weza_movies/presentation/screens/home_screens/nowplaying_screen.dart';
import 'package:weza_movies/presentation/screens/other_screens/search_screen.dart';
import 'package:weza_movies/presentation/screens/tv_screens/airingtoday_screen.dart';
import 'package:weza_movies/presentation/screens/tv_screens/nowplaying_tv_screen.dart';
import 'package:weza_movies/presentation/screens/tv_screens/popular_screen.dart';
import 'package:weza_movies/presentation/screens/tv_screens/top_rated_tv_screen.dart';
import 'package:weza_movies/presentation/widgets/components.dart';
import 'package:weza_movies/utilities/text.dart';

class TvPage extends StatefulWidget {
  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  List popular = [];
  List topRatedTv = [];
  List nowPlaying = [];
  List airingToday = [];

  @override
  void initState() {
    BlocProvider.of<TvCubit>(context).loadTv();
    BlocProvider.of<TvCubit>(context).getSearch(q: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                  navigateTo(context: context, widget: const SearchScreen());
              },
              icon: const Icon(Icons.search))
        ],
        title: const ModifiedText(
          text: 'Weza Tv',
          color: Colors.white,
          size: 24,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: buildBlocWidget(),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<TvCubit, TvState>(
      builder: (context, state) {
        if (state is TvLoaded) {
          popular = (state).popular;
          airingToday = state.airingToday;
          nowPlaying = state.nowPlayingTv;
          topRatedTv = state.topRated;
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
          TopRatedTvScreen(topRated: topRatedTv),
          PopularScreen(popular: popular),



        ],
      ),
    );
  }
}
