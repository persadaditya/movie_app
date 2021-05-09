import 'package:json_annotation/json_annotation.dart';
part 'MovieVideo.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class MovieVideo {
  int id;
  @JsonKey(name: "results")
  List<MovieVideoData>? results;

  MovieVideo({required this.id, this.results});

  factory MovieVideo.fromJson(Map<String, dynamic> json) => _$MovieVideoFromJson(json);
  Map<String, dynamic> toJson() => _$MovieVideoToJson(this);


}

@JsonSerializable(nullable: true)
class MovieVideoData {
  String? id;
  String? iso6391;
  String? iso31661;
  String? key;
  String? name;
  String? site;
  int? size;
  String? type;

  MovieVideoData(
      {this.id,
        this.iso6391,
        this.iso31661,
        this.key,
        this.name,
        this.site,
        this.size,
        this.type});

  factory MovieVideoData.fromJson(Map<String, dynamic> json) => _$MovieVideoDataFromJson(json);
  Map<String, dynamic> toJson() => _$MovieVideoDataToJson(this);


}
