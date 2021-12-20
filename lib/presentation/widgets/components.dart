// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weza_movies/presentation/screens/descreption_tv/descriptiontv_screen.dart';
import 'package:weza_movies/presentation/screens/description_screens/description_screen.dart';
import 'package:weza_movies/utilities/text.dart';

Widget buildItem(
        {required List list,
        required int index,
        required BuildContext context}) =>
    InkWell(
        onTap: () {
          print(' id is ${list[index]['id']}');
          navigateTo(
            context: context,
            widget: Description(
              isTv: false,
              id: list[index]['id'],
              voteCount: list[index]['vote_count'].toString(),
              name: list[index]['title'] ?? 'UnKnown',
              bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                  list[index]['backdrop_path'],
              posterUrl: 'https://image.tmdb.org/t/p/w500' +
                  list[index]['poster_path'],
              description: list[index]['overview'],
              vote: list[index]['vote_average'].toString(),
              launchOn: list[index]['release_date'],
              language: list[index]['original_language'],
              popularity: list[index]['popularity'].toString(),
            ),
          );
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
              const SizedBox(height: 10, width: 10)
            ],
          ),
        ));

void navigateTo({@required context, @required widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget buildDrawer(
        {required Function() onTap,
        required String title,
        required IconData icon}) =>
    InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              ModifiedText(text: title, color: Colors.white, size: 26),
              const Spacer(),
              Icon(icon),
            ],
          ),
        ),
      ),
    );

navigateReplace({required context, required Widget widget}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

Widget buildTvItem(
        {required List list,
        required int index,
        required BuildContext context}) =>

    InkWell(
      onTap: () {
        navigateTo(
          context: context,
          widget: DescriptionTv(
            isTv: true,
            id: list[index]['id'],
            voteCount: list[index]['vote_count'].toString(),
            popularity: list[index]['popularity'].toString(),
            name: list[index]['name'],
            bannerUrl:  list[index]['backdrop_path'] != null ?'https://image.tmdb.org/t/p/w500' +
                list[index]['backdrop_path']: 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
            posterUrl:
                'https://image.tmdb.org/t/p/w500' + list[index]['poster_path'],
            description: list[index]['overview'],
            vote: list[index]['vote_average'].toString(),
            launchOn: list[index]['first_air_date'].toString(),
            language: list[index]['original_language'],
          ),
        );
      },

      child:  list[index]['backdrop_path'] != null ? Container(
        padding: const EdgeInsets.all(5),
        width: 250,
        height: 120,
        child: Column(
           mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 250,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: list[index]['backdrop_path'] != null
                      ? NetworkImage(
                          'https://image.tmdb.org/t/p/w500' +
                              list[index]['backdrop_path'],
                        )
                      : const NetworkImage(
                          'https://as2.ftcdn.net/v2/jpg/03/39/20/55/1000_F_339205513_0NhxteRqI0SDvTrhmDZoVA1jedWoWXMM.jpg'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 5),
            ModifiedText(
                text: list[index]['name'] ?? 'unknown',
                color: Colors.white,
                size: 14),
          ],
        ),
      ):Container(),
    );


