import 'package:exammer/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'training_category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TrainingCategory {
  @JsonKey(required: true)
  late int id;

  @JsonKey(defaultValue: defaultString)
  late String name;

  @JsonKey(defaultValue: defaultString)
  late String description;

  @JsonKey(defaultValue: null)
  late String? createdAt;

  @JsonKey(defaultValue: null)
  late String? updatedAt;

  TrainingCategory();

  factory TrainingCategory.fromJson(Map<String, dynamic> json) =>
      _$TrainingCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingCategoryToJson(this);
}
