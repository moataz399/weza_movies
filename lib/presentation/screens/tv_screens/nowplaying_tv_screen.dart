import 'package:flutter/material.dart';
import 'package:weza_movies/presentation/screens/description_screens/description_screen.dart';
import 'package:weza_movies/presentation/widgets/components.dart';
import 'package:weza_movies/utilities/text.dart';

class NowPlayingTvScreen extends StatelessWidget {
  final List nowPlayingTv;

  NowPlayingTvScreen({required this.nowPlayingTv});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModifiedText(
            text: 'Now Playing Tv Shows',
            color: Colors.white,
            size: 26,
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: nowPlayingTv.length,
              itemBuilder: (context, index) =>
                  buildTvItem(context: context, list: nowPlayingTv, index: index),
            ),
          )
        ],
      ),
    );
  }
}
