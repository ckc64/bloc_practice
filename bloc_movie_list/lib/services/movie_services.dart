import 'dart:convert';

import 'package:movie_list/model/movie_cast_model.dart';
import 'package:movie_list/model/movie_detail_model.dart';
import 'package:movie_list/model/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_list/model/movie_video_model.dart';
//https://api.themoviedb.org/3/movie/popular?api_key=29ab5842e862799ad7610c51a5e1e58b&language=en-US

const API_KEY = 'api_key=29ab5842e862799ad7610c51a5e1e58b';

class MovieServices {
  Future<MovieModel> fetchMovie(String movieType) async {
    var _uri = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/$movieType',
        query: '$API_KEY&language=en-US');

    final response = await http.get(_uri);

    if (response.statusCode == 200) {
      Map res = json.decode(response.body);

      var j = MovieModel.fromJson(res as Map<String, dynamic>);

      return j;
    } else {
      throw Exception(
          'STATUS CODE : ${response.statusCode} - Unable to fetch Popular API \n${response.body}');
    }
  }

  Future<MovieModel> fetchSimilarMovie(int movieID) async {
    var _uri = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/$movieID/similar',
        query: '$API_KEY&language=en-US');

    final response = await http.get(_uri);

    if (response.statusCode == 200) {
      Map res = json.decode(response.body);

      var j = MovieModel.fromJson(res as Map<String, dynamic>);

      return j;
    } else {
      throw Exception(
          'STATUS CODE : ${response.statusCode} - Unable to fetch Similar API \n${response.body}');
    }
  }

  Future<MovieCastModel> fetchMovieCast(int movieID) async {
    var _uri = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/$movieID/credits',
        query: '$API_KEY&language=en-US');

    final response = await http.get(_uri);

    if (response.statusCode == 200) {
      Map res = json.decode(response.body);

      var j = MovieCastModel.fromJson(res as Map<String, dynamic>);

      return j;
    } else {
      throw Exception(
          'STATUS CODE : ${response.statusCode} - Unable to fetch Cast API \n${response.body}');
    }
  }

  Future<MovieDetailModel> fetchMovieDetail(int movieID) async {
    var _uri = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/$movieID',
        query: '$API_KEY&language=en-US');

    final response = await http.get(_uri);

    if (response.statusCode == 200) {
      Map res = json.decode(response.body);

      var j = MovieDetailModel.fromJson(res as Map<String, dynamic>);

      return j;
    } else {
      throw Exception(
          'STATUS CODE : ${response.statusCode} - Unable to fetch Details \n${response.body}');
    }
  }

  Future<MovieVideoModel> getYoutubeId(int movieID) async {
    var _uri = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/$movieID/videos',
        query: '$API_KEY&language=en-US');

    final response = await http.get(_uri);

    if (response.statusCode == 200) {
      Map res = json.decode(response.body);

      var j = MovieVideoModel.fromJson(res as Map<String, dynamic>);

      return j;
    } else {
      throw Exception(
          'STATUS CODE : ${response.statusCode} - Unable to fetch Movie Video \n${response.body}');
    }
  }
}
