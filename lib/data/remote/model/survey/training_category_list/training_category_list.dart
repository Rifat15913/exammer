import 'package:exammer/data/remote/model/survey/training_category/training_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'training_category_list.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TrainingCategoryList {
  @JsonKey(required: true)
  late int currentPage;

  @JsonKey(required: true)
  late int lastPage;

  @JsonKey(required: true)
  late int perPage;

  @JsonKey(defaultValue: [])
  late List<TrainingCategory> data;

  TrainingCategoryList();

  factory TrainingCategoryList.fromJson(Map<String, dynamic> json) =>
      _$TrainingCategoryListFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingCategoryListToJson(this);
}
