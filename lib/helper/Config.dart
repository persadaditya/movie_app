
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

  static Map<String, dynamic> queryApiKeyPagination(int page){
    return{"api_key": apiKey, "page": page.toString()};
  }

  static Map<String, dynamic> querySearch(String search, int page){
    return{"api_key": apiKey, "query" : search, "page" : page.toString()};
  }

  static Uri uriMoviePopular(int page){
    return Uri.https(baseUrl, "/3/movie/popular", queryApiKeyPagination(page));
  }

  static Uri uriMovieUpcoming(int page){
    return Uri.https(baseUrl, "/3/movie/upcoming", queryApiKeyPagination(page));
  }

  static Uri uriMoviePlaying(int page){
    return Uri.https(baseUrl, "/3/movie/now_playing", queryApiKeyPagination(page));
  }

  static Uri uriMovieLatest(){
    return Uri.https(baseUrl, "/3/movie/latest", queryApiKey());
  }

  static Uri uriSearchMovie(String search, int page){
    return Uri.https(baseUrl, "/3/search/movie", querySearch(search, page));
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