import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_list/model/movie_detail_model.dart';
import 'package:movie_list/screens/details.dart';
import 'package:movie_list/store/movie_store.dart';

import 'title_text.dart';

class RelatedMoviesList extends StatelessWidget {
  const RelatedMoviesList({Key? key, required this.movieStore})
      : super(key: key);

  final MovieStore movieStore;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final items = movieStore.allSimilar;

      return items.isEmpty
          ? Container()
          : Container(
              height: 250,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextTitle(title: "Related Movies"),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                        itemCount: items.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(
                                        movieID: items[index].id!),
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.zero,
                              child: CachedNetworkImage(
                                  imageUrl: movieStore
                                      .getImage(items[index].posterPath!),
                                  fit: BoxFit.fill),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
    });
  }
}
