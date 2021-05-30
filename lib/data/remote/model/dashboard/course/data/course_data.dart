import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/model/dashboard/course/data/course_pivot/course_pivot.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CourseData {
  @JsonKey(required: true)
  late int id;

  @JsonKey(defaultValue: defaultString)
  late String name;

  @JsonKey(defaultValue: defaultString)
  late String title;

  @JsonKey(defaultValue: null)
  late String? description;

  @JsonKey(defaultValue: null)
  late String? subjectId;

  @JsonKey(defaultValue: defaultString)
  late String coverImg;

  @JsonKey(defaultValue: null)
  late String? productId;

  @JsonKey(defaultValue: null)
  late String? createdAt;

  @JsonKey(defaultValue: null)
  late String? updatedAt;

  @JsonKey(defaultValue: null)
  late CoursePivot? pivot;

  CourseData();

  factory CourseData.fromJson(Map<String, dynamic> json) =>
      _$CourseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDataToJson(this);
}
