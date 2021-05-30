// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) {
  return DashboardData()
    ..feedbacks = (json['feedbacks'] as List<dynamic>?)
            ?.map((e) => Feedback.fromJson(e as Map<String, dynamic>))
            .toList() ??
        []
    ..url = DashboardUrls.fromJson(json['url'] as Map<String, dynamic>)
    ..courses =
        CourseCollection.fromJson(json['courses'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'feedbacks': instance.feedbacks,
      'url': instance.url,
      'courses': instance.courses,
    };
