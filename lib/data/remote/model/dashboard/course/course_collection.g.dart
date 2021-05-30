// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCollection _$CourseCollectionFromJson(Map<String, dynamic> json) {
  return CourseCollection()
    ..trending = (json['trending'] as List<dynamic>?)
            ?.map((e) => CourseData.fromJson(e as Map<String, dynamic>))
            .toList() ??
        []
    ..experts = (json['experts'] as List<dynamic>?)
            ?.map((e) => CourseData.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
}

Map<String, dynamic> _$CourseCollectionToJson(CourseCollection instance) =>
    <String, dynamic>{
      'trending': instance.trending,
      'experts': instance.experts,
    };
