// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:movie_list/model/movie_detail_model.dart';
import 'package:movie_list/store/movie_store.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoSlider extends StatelessWidget {
  const VideoSlider({Key? key, required this.items, required this.movieStore})
      : super(key: key);

  final MovieDetailModel items;
  final MovieStore movieStore;

  @override
  Widget build(BuildContext context) {
    List<Widget> ytPlayer = [];
    for (int i = 0; i < movieStore.videoKeys.length; i++) {
      ytPlayer.add(Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: YoutubePlayer(
            controller: YoutubePlayerController(
                initialVideoId: movieStore.videoKeys[i],
                flags: const YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                  controlsVisibleAtStart: true,
                  disableDragSeek: true,
                ))),
      ));
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            "Videos",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          CarouselSlider(
              items: ytPlayer,
              options: CarouselOptions(
                height: 280,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              )),
        ],
      ),
    );
  }
}
