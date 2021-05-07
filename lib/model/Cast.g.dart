// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Cast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cast _$CastFromJson(Map<String, dynamic> json) {
  return Cast(
    page: json['page'] as int?,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => CastData.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalPages: json['total_pages'] as int?,
    totalResults: json['total_results'] as int?,
  );
}

Map<String, dynamic> _$CastToJson(Cast instance) => <String, dynamic>{
      'page': instance.page,
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

CastData _$CastDataFromJson(Map<String, dynamic> json) {
  return CastData(
    adult: json['adult'] as bool?,
    gender: json['gender'] as int?,
    id: json['id'] as int?,
    knownFor: (json['known_for'] as List<dynamic>?)
        ?.map((e) => KnownFor.fromJson(e as Map<String, dynamic>))
        .toList(),
    knownForDepartment: json['known_for_department'] as String?,
    name: json['name'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    profilePath: json['profile_path'] as String?,
  );
}

Map<String, dynamic> _$CastDataToJson(CastData instance) => <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for': instance.knownFor?.map((e) => e.toJson()).toList(),
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
    };

KnownFor _$KnownForFromJson(Map<String, dynamic> json) {
  return KnownFor(
    adult: json['adult'] as bool?,
    backdropPath: json['backdrop_path'] as String?,
    genreIds:
        (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
    id: json['id'] as int?,
    mediaType: json['media_type'] as String?,
    originalLanguage: json['original_language'] as String?,
    originalTitle: json['original_title'] as String?,
    overview: json['overview'] as String?,
    posterPath: json['poster_path'] as String?,
    releaseDate: json['release_date'] as String?,
    title: json['title'] as String?,
    video: json['video'] as bool?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: json['vote_count'] as int?,
    firstAirDate: json['first_air_date'] as String?,
    name: json['name'] as String?,
    originCountry: (json['original_country'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    originalName: json['original_name'] as String?,
  );
}

Map<String, dynamic> _$KnownForToJson(KnownFor instance) => <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'media_type': instance.mediaType,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'first_air_date': instance.firstAirDate,
      'name': instance.name,
      'original_country': instance.originCountry,
      'original_name': instance.originalName,
    };
