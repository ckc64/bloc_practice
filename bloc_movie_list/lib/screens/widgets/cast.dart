import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_list/store/movie_store.dart';

class CastList extends StatelessWidget {
  const CastList({Key? key, required this.movieStore}) : super(key: key);
  final MovieStore movieStore;
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final items = movieStore.allCast;

      return items.isEmpty
          ? Container()
          : Container(
              height: 155,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cast",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                        itemCount: items.length,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (_, int index) {
                          return items[index].profilePath == null
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(41, 255, 255, 255),
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          movieStore.getImage(
                                              items[index].profilePath!),
                                        ),
                                        radius: 35,
                                      ),
                                      Text(items[index].name!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                    ],
                                  ),
                                );

                          // Container(
                          //     width: 28,
                          //     height: 28,
                          //     decoration: BoxDecoration(
                          //       color: Colors.green
                          //           .withOpacity(0.25), // border color
                          //       shape: BoxShape.circle,
                          //     ),
                          //     child: CachedNetworkImage(
                          //         imageUrl: movieStore
                          //             .getImage(items[index].profilePath!),
                          //         fit: BoxFit.fill),
                          //   );
                        }),
                  ),
                ],
              ),
            );
    });
  }
}
