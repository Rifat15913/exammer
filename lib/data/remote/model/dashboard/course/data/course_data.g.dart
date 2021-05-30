// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseData _$CourseDataFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return CourseData()
    ..id = json['id'] as int
    ..name = json['name'] as String? ?? ''
    ..title = json['title'] as String? ?? ''
    ..description = json['description'] as String?
    ..subjectId = json['subject_id'] as String?
    ..coverImg = json['cover_img'] as String? ?? ''
    ..productId = json['product_id'] as String?
    ..createdAt = json['created_at'] as String?
    ..updatedAt = json['updated_at'] as String?
    ..pivot = json['pivot'] == null
        ? null
        : CoursePivot.fromJson(json['pivot'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CourseDataToJson(CourseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'description': instance.description,
      'subject_id': instance.subjectId,
      'cover_img': instance.coverImg,
      'product_id': instance.productId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'pivot': instance.pivot,
    };
