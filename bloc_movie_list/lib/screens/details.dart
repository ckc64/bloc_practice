// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_list/model/movie_cast_model.dart';
import 'package:movie_list/model/movie_detail_model.dart';
import 'package:movie_list/screens/widgets/carousel_video.dart';
import 'package:movie_list/screens/widgets/cast.dart';
import 'package:movie_list/screens/widgets/related_movies_list.dart';
import 'package:movie_list/screens/widgets/title_text.dart';
import 'package:movie_list/store/movie_store.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieID;

  const MovieDetailsScreen({Key? key, required this.movieID}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieStore movieStore = MovieStore();

  @override
  void initState() {
    // TODO: implement initState
    movieStore.fetchDetailMovie(widget.movieID);
    movieStore.fetchYoutubeVideo(widget.movieID);
    movieStore.fetchSimilarMovie(widget.movieID);
    movieStore.fetchMovieCast(widget.movieID);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Initiate the Youtube player controller

    return Observer(builder: (_) {
      if (movieStore.movieDetails.isEmpty || movieStore.videoKeys.isEmpty) {
        return Center(
          child: Container(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      }
      final items = movieStore.movieDetails[0];

      return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          shrinkWrap: true,
          children: [
            HeaderImage(items: items, movieStore: movieStore),
            MovieTitle(items: items),
            TagLine(items: items),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                endIndent: 150,
                thickness: 1,
                height: 1,
                color: Color.fromARGB(242, 247, 148, 0),
              ),
            ),
            Company(items: items),
            VoteAverage(items: items), //with genre
            CastList(movieStore: movieStore),
            Overview(items: items),
            VideoSlider(items: items, movieStore: movieStore),
            RelatedMoviesList(movieStore: movieStore)
          ],
        ),
      );
    });
  }
}

class Company extends StatelessWidget {
  const Company({Key? key, required this.items}) : super(key: key);
  final MovieDetailModel items;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Text("${items.productionCompanies![0].name}",
          style: TextStyle(
              color: Colors.white38,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
    );
  }
}

class MovieTitle extends StatelessWidget {
  const MovieTitle({Key? key, required this.items}) : super(key: key);
  final MovieDetailModel items;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        items.title!,
        style: TextStyle(
            color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class TagLine extends StatelessWidget {
  const TagLine({Key? key, required this.items}) : super(key: key);
  final MovieDetailModel items;

  @override
  Widget build(BuildContext context) {
    return items.tagline!.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text('"${items.tagline}"',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          );
  }
}

class Overview extends StatelessWidget {
  const Overview({Key? key, required this.items}) : super(key: key);
  final MovieDetailModel items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitle(title: "Overview"),
          SizedBox(height: 8),
          Text(
            "${items.overview}",
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}

class VoteAverage extends StatelessWidget {
  const VoteAverage({Key? key, required this.items}) : super(key: key);
  final MovieDetailModel items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  color: Color.fromARGB(242, 247, 148, 0),
                  child: Text(
                    "${items.voteAverage}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(child: Genre(items: items))
      ],
    );
  }
}

class Genre extends StatelessWidget {
  const Genre({Key? key, required this.items}) : super(key: key);

  final MovieDetailModel items;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
          itemCount: items.genres!.length,
          itemBuilder: (_, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                items.genres![index].name!,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HeaderImage extends StatelessWidget {
  const HeaderImage({Key? key, required this.items, required this.movieStore})
      : super(key: key);
  final MovieDetailModel items;
  final MovieStore movieStore;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.30,
          child: CachedNetworkImage(
            imageUrl: movieStore.getImage(items.backdropPath!),
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
        )
      ],
    );
  }
}
