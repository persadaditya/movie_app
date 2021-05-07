
import 'package:json_annotation/json_annotation.dart';
part 'Cast.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class Cast {
  int? page;
  List<CastData>? results;
  @JsonKey(name: "total_pages")
  int? totalPages;
  @JsonKey(name: "total_results")
  int? totalResults;

  Cast({this.page, this.results, this.totalPages, this.totalResults});

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
  Map<String, dynamic> toJson() => _$CastToJson(this);
}

@JsonSerializable(explicitToJson: true, nullable: true)
class CastData {
  bool? adult;
  int? gender;
  int? id;
  @JsonKey(name: "known_for")
  List<KnownFor>? knownFor;
  @JsonKey(name: "known_for_department")
  String? knownForDepartment;
  String? name;
  double? popularity;
  @JsonKey(name: "profile_path")
  String? profilePath;

  CastData(
      {this.adult,
        this.gender,
        this.id,
        this.knownFor,
        this.knownForDepartment,
        this.name,
        this.popularity,
        this.profilePath});

  factory CastData.fromJson(Map<String, dynamic> json) => _$CastDataFromJson(json);
  Map<String, dynamic> toJson() => _$CastDataToJson(this);
}

@JsonSerializable(nullable: true)
class KnownFor {
  bool? adult;
  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  @JsonKey(name: "genre_ids")
  List<int>? genreIds;
  int? id;
  @JsonKey(name: "media_type")
  String? mediaType;
  @JsonKey(name: "original_language")
  String? originalLanguage;
  @JsonKey(name: "original_title")
  String? originalTitle;
  String? overview;
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
  @JsonKey(name: "first_air_date")
  String? firstAirDate;
  String? name;
  @JsonKey(name: "original_country")
  List<String>? originCountry;
  @JsonKey(name: "original_name")
  String? originalName;

  KnownFor(
      {this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.mediaType,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
        this.firstAirDate,
        this.name,
        this.originCountry,
        this.originalName});

  factory KnownFor.fromJson(Map<String, dynamic> json) => _$KnownForFromJson(json);
  Map<String, dynamic> toJson() => _$KnownForToJson(this);

}