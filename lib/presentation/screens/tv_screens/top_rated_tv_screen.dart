import 'package:flutter/material.dart';
import 'package:weza_movies/presentation/screens/description_screens/description_screen.dart';
import 'package:weza_movies/presentation/widgets/components.dart';
import 'package:weza_movies/utilities/text.dart';

class TopRatedTvScreen extends StatelessWidget {
  final List topRated;

  TopRatedTvScreen({required this.topRated});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModifiedText(
            text: 'Top Rated Tv Shows',
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
              itemCount: topRated.length,
              itemBuilder: (context, index) =>
                  buildTvItem(context: context, list: topRated, index: index),
            ),
          )
        ],
      ),
    );
  }
}
