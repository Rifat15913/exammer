// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_category_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingCategoryList _$TrainingCategoryListFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['current_page', 'last_page', 'per_page']);
  return TrainingCategoryList()
    ..currentPage = json['current_page'] as int
    ..lastPage = json['last_page'] as int
    ..perPage = json['per_page'] as int
    ..data = (json['data'] as List<dynamic>?)
            ?.map((e) => TrainingCategory.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
}

Map<String, dynamic> _$TrainingCategoryListToJson(
        TrainingCategoryList instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'data': instance.data,
    };
