
import 'package:json_annotation/json_annotation.dart';
part 'MovieDetail.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class MovieDetail {
  bool? adult;
  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  @JsonKey(name: "belongs_to_collection")
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genres>? genres;
  String? homepage;
  int? id;
  @JsonKey(name: "imdb_id")
  String? imdbId;
  @JsonKey(name: "original_language")
  String? originalLanguage;
  @JsonKey(name: "original_title")
  String? originalTitle;
  String? overview;
  double? popularity;
  @JsonKey(name: "poster_path")
  String? posterPath;
  @JsonKey(name: "production_companies")
  List<ProductionCompanies>? productionCompanies;
  @JsonKey(name: "production_countries")
  List<ProductionCountries>? productionCountries;
  @JsonKey(name: "release_date")
  String? releaseDate;
  int? revenue;
  int? runtime;
  @JsonKey(name: "spoken_languages")
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  @JsonKey(name: "vote_average")
  double? voteAverage;
  @JsonKey(name: "vote_count")
  int? voteCount;

  MovieDetail(
      {this.adult,
        this.backdropPath,
        this.belongsToCollection,
        this.budget,
        this.genres,
        this.homepage,
        this.id,
        this.imdbId,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.productionCompanies,
        this.productionCountries,
        this.releaseDate,
        this.revenue,
        this.runtime,
        this.spokenLanguages,
        this.status,
        this.tagline,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount});

  factory MovieDetail.fromJson(Map<String, dynamic> json) => _$MovieDetailFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);

}

@JsonSerializable(nullable: true, )
class BelongsToCollection {
  int? id;
  String? name;
  @JsonKey(name: "poster_path")
  String? posterPath;
  @JsonKey(name: "backdrop_path")
  String? backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) => _$BelongsToCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);

}

@JsonSerializable(nullable: true)
class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);
  Map<String, dynamic> toJson() => _$GenresToJson(this);

}

@JsonSerializable(nullable: true)
class ProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) => _$ProductionCompaniesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCompaniesToJson(this);
}

@JsonSerializable(nullable: true)
class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries({this.iso31661, this.name});

  factory ProductionCountries.fromJson(Map<String, dynamic> json) => _$ProductionCountriesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this);

}

@JsonSerializable(nullable: true)
class SpokenLanguages {
  @JsonKey(name: "english_name")
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) => _$SpokenLanguagesFromJson(json);
  Map<String, dynamic> toJson() => _$SpokenLanguagesToJson(this);


}
