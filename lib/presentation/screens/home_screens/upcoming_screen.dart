import 'package:flutter/material.dart';
import 'package:weza_movies/presentation/widgets/components.dart';
import 'package:weza_movies/utilities/text.dart';

class UpComingScreen extends StatelessWidget {
  final List upComing;

  UpComingScreen ({ required this.upComing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModifiedText(
            text: 'Upcoming Movies',
            color: Colors.white,
            size: 26,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 270,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: upComing.length,
              itemBuilder: (context, index) =>
                  buildItem(list: upComing, index: index,context: context),
            ),
          )
        ],
      ),
    );
  }
}
