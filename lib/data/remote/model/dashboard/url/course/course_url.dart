import 'package:exammer/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_url.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CourseUrl {
  @JsonKey(defaultValue: defaultString)
  late String coverImg;

  CourseUrl();

  factory CourseUrl.fromJson(Map<String, dynamic> json) =>
      _$CourseUrlFromJson(json);

  Map<String, dynamic> toJson() => _$CourseUrlToJson(this);
}
