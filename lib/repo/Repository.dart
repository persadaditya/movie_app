

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/helper/Config.dart';
import 'package:movie_app/model/Cast.dart';
import 'package:movie_app/model/CreditVideo.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/model/MovieDetail.dart';
import 'package:movie_app/model/MovieVideo.dart';

class Repository{
  Future<Movie> fetchMoviePopular() async {
    final response = await http.get(Config.uriMoviePopular());
    print("url movie: ${Config.uriMoviePopular().toString()}");

    if(response.statusCode==200){
      print('response ${response.body.toString()}');
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load headline');
    }
  }

  Future<Movie> fetchMovieUpcoming() async {
    final response = await http.get(Config.uriMovieUpcoming());
    print("url movie: ${Config.uriMovieUpcoming().toString()}");

    if(response.statusCode==200){
      print('response ${response.body.toString()}');
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load headline');
    }
  }

  Future<Movie> fetchMoviePlaying() async {
    final response = await http.get(Config.uriMoviePlaying());
    print("url movie: ${Config.uriMoviePlaying().toString()}");

    if(response.statusCode==200){
      print('response ${response.body.toString()}');
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load headline');
    }
  }

  Future<MovieData> fetchLatestMovie() async {
    final response = await http.get(Config.uriMovieLatest());
    print("url movie: ${Config.uriMovieLatest().toString()}");

    if(response.statusCode==200){
      print('response ${response.body.toString()}');
      return MovieData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load headline');
    }
  }

  Future<Movie> fetchSearchMovie(String search) async {
    final response = await http.get(Config.uriSearchMovie(search));
    print("url movie: ${Config.uriSearchMovie(search).toString()}");

    if(response.statusCode==200){
      print('response ${response.body.toString()}');
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load search movie');
    }
  }

  Future<Cast> fetchCaster() async {
    final response = await http.get(Config.uriCaster());
    print("url cast: ${Config.uriCaster().toString()}");

    if(response.statusCode==200){
      print('response ${response.body.toString()}');
      return Cast.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load search movie');
    }
  }

  Future<MovieDetail> fetchDetailMovie(int id) async {
    final response = await http.get(Config.uriDetailMovie(id));
    print("url movie detail: ${Config.uriDetailMovie(id).toString()}");

    if(response.statusCode==200){
      print('response ${response.body.toString()}');
      return MovieDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load search movie');
    }
  }

  Future<MovieVideo> fetchVideoMovie(int id) async {
    final response = await http.get(Config.uriVideoMovie(id));
    print("url movie video: ${Config.uriVideoMovie(id).toString()}");

    if(response.statusCode==200){
      print('response ${response.body.toString()}');
      return MovieVideo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load search movie');
    }
  }

  Future<CreditVideo> fetchCreditMovie(int id) async {
    final response = await http.get(Config.uriCreditVideo(id));
    print("url credit video: ${Config.uriCreditVideo(id).toString()}");

    if(response.statusCode==200){
      print('response ${response.body.toString()}');
      return CreditVideo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load search movie');
    }
  }




}