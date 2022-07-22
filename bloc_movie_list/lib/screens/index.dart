// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_list/screens/details.dart';
import 'package:movie_list/store/movie_store.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  MovieStore movieStore = MovieStore();
  int? selectedIndex = 0;

  @override
  void initState() {
    movieStore.fetchPopular();
    movieStore.fetchTopRated();
    movieStore.fetchUpcomingMovies();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> movieType = ["Popular", "Top Rated", "Upcoming"];

    bool isSelected = false;
    Widget _buildChips() {
      List<Widget> chips = [];

      for (int i = 0; i < movieType.length; i++) {
        ChoiceChip choiceChip = ChoiceChip(
          selected: selectedIndex == i,
          backgroundColor: Colors.amber,
          label: Text(movieType[i]),
          labelStyle: selectedIndex == i
              ? TextStyle(color: Colors.white)
              : TextStyle(color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          selectedColor: Color.fromARGB(255, 172, 129, 1),
          onSelected: (bool selected) {
            setState(() {
              selectedIndex = i;
              movieStore.movieTypeFilter = movieType[i].toLowerCase();
            });
          },
        );

        chips.add(
          choiceChip,
        );
      }

      return ListView(
        // This next line does the trick.
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: chips,
      );
    }

    final items = movieStore.getMovieList(movieStore.movieTypeFilter);

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Observer(
        builder: (_) {
          if (items.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          var size = MediaQuery.of(context).size;

          /*24 is for notification bar on Android*/
          final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
          final double itemWidth = size.width / 1.5;
          return Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                childAspectRatio: (itemWidth / itemHeight),
                children: List.generate(items.length, (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailsScreen(movieID: items[index].id!),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.zero,
                      child: CachedNetworkImage(
                          imageUrl:
                              movieStore.getImage(items[index].posterPath!),
                          fit: BoxFit.fill),
                    ),
                  );
                }),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 25.0, // soften the shadow
                        spreadRadius: 2.0, //extend the shadow
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(top: 35),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Expanded(child: _buildChips()),
                    ],
                  )),
            ],
          );
        },
      ),
    );
  }
}
