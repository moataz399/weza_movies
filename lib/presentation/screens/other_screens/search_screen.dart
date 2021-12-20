import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_movies/business_logic/movies_cubit.dart';
import 'package:weza_movies/presentation/widgets/components.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List searchList;

  //var list = BlocProvider.of<MoviesCubit>(context).search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: buildSearch(context),
    );
  }

  Widget buildSearch(BuildContext context) =>
      BlocBuilder<MoviesCubit, MoviesStates>(
        builder: (context, state) {
          if (state is SearchLoaded) {
            searchList = state.search;
            return Column(
                children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    labelText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  autofocus: true,
                  onChanged: (value) {
                    BlocProvider.of<MoviesCubit>(context).getSearch(q: value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Search can not be empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              if (searchList != null)
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => buildItem(
                        list: searchList, index: index, context: context),
                    physics: const BouncingScrollPhysics(),
                    itemCount: searchList.length,
                  ),
                )
              else
                Container(),
            ]);
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
