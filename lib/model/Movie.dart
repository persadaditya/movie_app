
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'Movie.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class Movie {
  Dates? dates;
  int? page;
  List<MovieData>? results;
  @JsonKey(name: "total_pages")
  int? totalPages;
  @JsonKey(name: "total_results")
  int? totalResults;

  Movie(
      {this.dates,
        this.page,
        this.results,
        this.totalPages,
        this.totalResults});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

@JsonSerializable(nullable: true)
class Dates {
  String? maximum;
  String? minimum;

  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);
  Map<String, dynamic> toJson() => _$DatesToJson(this);
}

@JsonSerializable(nullable: true)
class MovieData {
  bool? adult;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: "genre_ids")
  List<int>? genreIds;
  int? id;
  @JsonKey(name: "original_language")
  String? originalLanguage;
  @JsonKey(name: "original_title")
  String? originalTitle;
  String? overview;
  double? popularity;
  @JsonKey(name: "poster_path")
  String? posterPath;
  @JsonKey(name: "release_date")
  String? releaseDate;
  String? title;
  bool? video;
  @JsonKey(name: "vote_average")
  double? voteAverage;
  @JsonKey(name: "vote_count")
  int? voteCount;

  MovieData(
      {this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount});

  factory MovieData.fromJson(Map<String, dynamic> json) => _$MovieDataFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDataToJson(this);

  ///to query data
  MovieData.fromMap(Map<String, dynamic> res) :
    adult = res["adult"] == 1 ? true : false, //convert integer to bool
    backdropPath = res["backdrop_path"],
    id = res["id"],
    originalLanguage = res["original_language"],
    originalTitle = res["original_title"],
    overview = res["overview"],
    popularity = res["popularity"],
    posterPath = res["poster_path"],
    releaseDate = res["release_date"],
    title = res["title"],
    video = res["video"] == 1 ? true : false,
    voteAverage = res["vote_average"],
    voteCount = res["vote_count"];

  ///to save data
  Map<String, Object?> toMap(){
    return {
      'adult' : adult == true ? 1: 0, //convert bool to integer
      'backdrop_path' : backdropPath,
      'id' : id,
      'original_language' : originalLanguage,
      'original_title' : originalTitle,
      'overview' : overview,
      'popularity' : popularity,
      'poster_path' : posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video == true ? 1 : 0, // convert bool to integer
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

}