
import 'dart:convert';

class Config{
  static String baseUrl = "api.themoviedb.org";

  static String apiKey = "CHANGE-WITH-YOUR-OWN-API-KEY";

  static String imageUrl(String pathImage){
    return "https://image.tmdb.org/t/p/w500" + pathImage;
  }

  static String thumbnailYoutube(String key){
    return "https://img.youtube.com/vi/$key/sddefault.jpg";
  }

  static Map<String, dynamic> queryApiKey(){
    return{"api_key": apiKey};
  }

  static Map<String, dynamic> querySearch(String search){
    return{"api_key": apiKey, "query" : search};
  }

  static Uri uriMoviePopular(){
    return Uri.https(baseUrl, "/3/movie/popular", queryApiKey());
  }

  static Uri uriMovieUpcoming(){
    return Uri.https(baseUrl, "/3/movie/upcoming", queryApiKey());
  }

  static Uri uriMoviePlaying(){
    return Uri.https(baseUrl, "/3/movie/now_playing", queryApiKey());
  }

  static Uri uriMovieLatest(){
    return Uri.https(baseUrl, "/3/movie/latest", queryApiKey());
  }

  static Uri uriSearchMovie(String search){
    return Uri.https(baseUrl, "/3/search/movie", querySearch(search));
  }
  
  static Uri uriCaster(){
    return Uri.https(baseUrl, "/3/person/popular", queryApiKey());
  }

  static Uri uriDetailMovie(int id){
    return Uri.https(baseUrl, "/3/movie/$id", queryApiKey());
  }

  static Uri uriVideoMovie(int id){
    return Uri.https(baseUrl, "/3/movie/$id/videos", queryApiKey());
  }

  static Uri uriCreditVideo(int id){
    return Uri.https(baseUrl, "3/movie/$id/credits", queryApiKey());
  }



}