// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_movies/business_logic/description_cubit.dart';
import 'package:weza_movies/presentation/screens/description_screens/recommend_screen.dart';
import 'package:weza_movies/presentation/screens/description_screens/similar_movies.dart';
import 'package:weza_movies/presentation/screens/other_screens/watching.dart';
import 'package:weza_movies/presentation/widgets/components.dart';
import 'package:weza_movies/utilities/text.dart';

class Description extends StatefulWidget {
  final String name,
      bannerUrl,
      description,
      posterUrl,
      vote,
      voteCount,
      launchOn,
      language,
      popularity;
  int id;
  bool isTv;

  Description({
    Key? key,
    required this.name,
    required this.isTv,
    required this.bannerUrl,
    required this.description,
    required this.posterUrl,
    required this.voteCount,
    required this.vote,
    required this.launchOn,
    required this.id,
    required this.language,
    required this.popularity,
  }) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  void initState() {
    BlocProvider.of<DescriptionCubit>(context).similarMovies(id: widget.id);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    similarMovies.clear();
    recommend.clear();
    print('dispose done ');
  }

  List similarMovies = [];
  List recommend = [];
  var watch;

  late String watchProviders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.black,
        body: buildDescriptionBloc());
  }

  Widget buildDescriptionBloc() =>
      BlocBuilder<DescriptionCubit, DescriptionState>(
        builder: (context, state) {
          if (state is SimilarMoviesLoaded) {
            similarMovies = state.similarMovies;
            recommend = state.recommendations;
            watch = state.watch;
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

  Widget loadedListWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    widget.bannerUrl != null
                        ? SizedBox(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: widget.bannerUrl != null
                                ? Image.network(widget.bannerUrl)
                                : Image.network(
                                    'https://i0.wp.com/www.cssscript.com/wp-content/uploads/2015/11/ispinner.jpg?fit=400%2C298&ssl=1'),
                          )
                        : Container(),
                    Positioned(
                        bottom: 10,
                        child: Row(
                          children: [
                            ModifiedText(
                              text: widget.vote != null
                                  ? "  ??? Average Rating :" + widget.vote
                                  : " ",
                              color: Colors.white,
                              size: 18,
                            ),
                            ModifiedText(
                              text: widget.voteCount != null
                                  ? "  -  ${widget.voteCount}  Vote"
                                  : '',
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            //  padding: const EdgeInsets.all(10),
            child: ModifiedText(
              text: widget.name != null ? widget.name : '',
              color: Colors.white,
              size: 24,
            ),
          ),
          Row(
            children: [
              widget.posterUrl != null
                  ? Container(
                      margin: const EdgeInsets.all(5),
                      height: 200,
                      width: 100,
                      child: widget.posterUrl != null
                          ? Image.network(widget.posterUrl)
                          : Image.network(
                              'https://i0.wp.com/www.cssscript.com/wp-content/uploads/2015/11/ispinner.jpg?fit=400%2C298&ssl=1'),
                    )
                  : Container(),
              Flexible(
                child: ModifiedText(
                  text: widget.description != null
                      ? ' Description :  ' + widget.description
                      : '',
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: ModifiedText(
              text: widget.launchOn != null
                  ? "Releasing on -" + widget.launchOn
                  : '',
              color: Colors.white,
              size: 14,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            child: widget.language != null
                ? ModifiedText(
                    text: 'Language :' + widget.language,
                    color: Colors.white,
                    size: 18,
                  )
                : const Text(''),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            child: widget.popularity != null
                ? ModifiedText(
                    text: 'popularity :' + widget.popularity,
                    color: Colors.green,
                    size: 18,
                  )
                : const Text(''),
          ),
          const SizedBox(
            height: 20,
          ),
          similarMovies != null
              ? SimilarMoviesScreen(similarMovies: similarMovies)
              : Container(),
          const SizedBox(
            height: 10,
          ),
          recommend != null
              ? RecommendScreen(recommendScreen: recommend)
              : Container(),
          watch != null
              ? Center(
                  child: ElevatedButton(
                    onPressed: () {
                      navigateTo(
                          context: context,
                          widget: WatchingScreen(
                            url: '$watch',
                          ));
                    },
                    child: const Text('Watch now'),
                  ),
                )
              : Container(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
