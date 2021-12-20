import 'package:flutter/material.dart';
import 'package:weza_movies/presentation/screens/description_screens/description_screen.dart';
import 'package:weza_movies/presentation/widgets/components.dart';
import 'package:weza_movies/utilities/text.dart';

class RecommendScreen extends StatelessWidget {
  final List recommendScreen;

  RecommendScreen({required this.recommendScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModifiedText(
            text: 'Recommendations ',
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
              itemCount: recommendScreen.length,
              itemBuilder: (context, index) => buildSimilarItem(
                  list: recommendScreen, index: index, context: context),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSimilarItem(
          {required List list,
          required int index,
          required BuildContext context}) =>
      InkWell(
          onTap: () {
            print(' id is ${list[index]['id']}');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Description(
                    isTv: false,
                    id: list[index]['id'],
                    voteCount: list[index]['vote_count'].toString(),
                    name: list[index]['title'] ?? 'UnKnown',
                    bannerUrl:    list[index]['backdrop_path'] !=null ?'https://image.tmdb.org/t/p/w500' +
                        list[index]['backdrop_path'] : 'https://i0.wp.com/www.cssscript.com/wp-content/uploads/2015/11/ispinner.jpg?fit=400%2C298&ssl=1',
                    posterUrl: 'https://image.tmdb.org/t/p/w500' +
                        list[index]['poster_path'],
                    description: list[index]['overview'],
                    vote: list[index]['vote_average'].toString(),
                    launchOn: list[index]['release_date'],
                    language: list[index]['original_language'],
                    popularity: list[index]['popularity'].toString(),
                  ),
                ));
          },
          child: SizedBox(
            width: 140,
            child: Column(
              children: [
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: list[index]['poster_path'] != null
                          ? NetworkImage(
                              'https://image.tmdb.org/t/p/w500' +
                                  list[index]['poster_path'],
                            )
                          : const NetworkImage(
                              'https://i0.wp.com/www.cssscript.com/wp-content/uploads/2015/11/ispinner.jpg?fit=400%2C298&ssl=1'),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                ModifiedText(
                    text: list[index]['title'] ?? 'unknown',
                    color: Colors.white,
                    size: 14),
              ],
            ),
          ));
}
