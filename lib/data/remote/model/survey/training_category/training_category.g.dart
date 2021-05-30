// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingCategory _$TrainingCategoryFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return TrainingCategory()
    ..id = json['id'] as int
    ..name = json['name'] as String? ?? ''
    ..description = json['description'] as String? ?? ''
    ..createdAt = json['created_at'] as String?
    ..updatedAt = json['updated_at'] as String?;
}

Map<String, dynamic> _$TrainingCategoryToJson(TrainingCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
