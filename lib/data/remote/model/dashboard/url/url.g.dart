// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardUrls _$DashboardUrlsFromJson(Map<String, dynamic> json) {
  return DashboardUrls()
    ..course = json['course'] == null
        ? null
        : CourseUrl.fromJson(json['course'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DashboardUrlsToJson(DashboardUrls instance) =>
    <String, dynamic>{
      'course': instance.course,
    };
