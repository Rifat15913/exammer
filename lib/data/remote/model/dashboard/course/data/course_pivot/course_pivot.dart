import 'package:json_annotation/json_annotation.dart';

part 'course_pivot.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CoursePivot {
  @JsonKey(defaultValue: null)
  late String? categoryId;

  @JsonKey(defaultValue: null)
  late String? courseId;

  CoursePivot();

  factory CoursePivot.fromJson(Map<String, dynamic> json) =>
      _$CoursePivotFromJson(json);

  Map<String, dynamic> toJson() => _$CoursePivotToJson(this);
}
