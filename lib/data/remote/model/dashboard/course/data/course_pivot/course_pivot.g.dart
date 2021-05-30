// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_pivot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursePivot _$CoursePivotFromJson(Map<String, dynamic> json) {
  return CoursePivot()
    ..categoryId = json['category_id'] as String?
    ..courseId = json['course_id'] as String?;
}

Map<String, dynamic> _$CoursePivotToJson(CoursePivot instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'course_id': instance.courseId,
    };
