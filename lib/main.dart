// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_movies/business_logic/descretiontv_cubit.dart';
import 'package:weza_movies/business_logic/description_cubit.dart';
import 'package:weza_movies/business_logic/movies_cubit.dart';
import 'package:weza_movies/business_logic/tv_cubit.dart';
import 'package:weza_movies/constants/bloc_observer.dart';

import 'app_router.dart';
import 'constants/strings.dart';

String initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initialRoute = homePage;
  Bloc.observer = MyBlocObserver();

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key key, @required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesCubit>(
          create: (context) => MoviesCubit()..getSearch(q: ''),
        ),
        BlocProvider<TvCubit>(
          create: (context) => TvCubit(),
        ),
        BlocProvider<DescriptionCubit>(create: (context) => DescriptionCubit()),
        BlocProvider<DescriptionTvCubit>(
            create: (context) => DescriptionTvCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
        theme: ThemeData(brightness: Brightness.dark),
        initialRoute: initialRoute,
      ),
    );
  }
}
