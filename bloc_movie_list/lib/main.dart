// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:movie_list/screens/index.dart';
import 'package:movie_list/store/movie_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieListScreen(),
    );
  }
}

// MultiProvider(
//       providers: [Provider<MovieStore>.value(value: movieStore)],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Movie List',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: MovieList(),
//       ),
//     );
