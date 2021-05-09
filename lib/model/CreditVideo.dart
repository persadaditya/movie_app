
import 'package:json_annotation/json_annotation.dart';
part 'CreditVideo.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class CreditVideo {
  int id;
  List<CastData>? cast;
  List<CrewData>? crew;

  CreditVideo({required this.id, this.cast, this.crew});

  factory CreditVideo.fromJson(Map<String, dynamic> json) => _$CreditVideoFromJson(json);
  Map<String, dynamic> toJson() => _$CreditVideoToJson(this);


}

@JsonSerializable(nullable: true)
class CastData {
  bool? adult;
  int? gender;
  int? id;
  @JsonKey(name: "known_for_department")
  String? knownForDepartment;
  String? name;
  @JsonKey(name: "original_name")
  String? originalName;
  double? popularity;
  @JsonKey(name: "profile_path")
  String? profilePath;
  @JsonKey(name: "cast_id")
  int? castId;
  String? character;
  @JsonKey(name: "credit_id")
  String? creditId;
  int? order;

  CastData(
      {this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        this.creditId,
        this.order});

  factory CastData.fromJson(Map<String, dynamic> json) => _$CastDataFromJson(json);
  Map<String, dynamic> toJson() => _$CastDataToJson(this);


}

@JsonSerializable(nullable: true)
class CrewData {
  bool? adult;
  int? gender;
  int? id;
  @JsonKey(name: "known_for_department")
  String? knownForDepartment;
  String? name;
  @JsonKey(name: "original_name")
  String? originalName;
  double? popularity;
  @JsonKey(name: "profile_path")
  String? profilePath;
  @JsonKey(name: "credit_id")
  String? creditId;
  String? department;
  String? job;

  CrewData(
      {this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.creditId,
        this.department,
        this.job});

  factory CrewData.fromJson(Map<String, dynamic> json) => _$CrewDataFromJson(json);
  Map<String, dynamic> toJson() => _$CrewDataToJson(this);


}
