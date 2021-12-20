import 'package:flutter/material.dart';
import 'package:weza_movies/presentation/widgets/components.dart';
import 'package:weza_movies/utilities/text.dart';

class NowPlayingScreen extends StatelessWidget {
  final List nowPlaying;

  NowPlayingScreen({required this.nowPlaying});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModifiedText(
            text: ' Now Playing Movies ',
            color: Colors.white,
            size: 26,
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 270,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: nowPlaying.length,
              itemBuilder: (context, index) =>
                  buildItem(list: nowPlaying, index: index, context: context),
            ),
          )
        ],
      ),
    );
  }
}
