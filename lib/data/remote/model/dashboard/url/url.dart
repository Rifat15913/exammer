import 'package:exammer/data/remote/model/dashboard/url/course/course_url.dart';
import 'package:json_annotation/json_annotation.dart';

part 'url.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DashboardUrls {
  @JsonKey(defaultValue: null)
  late CourseUrl? course;

  DashboardUrls();

  factory DashboardUrls.fromJson(Map<String, dynamic> json) =>
      _$DashboardUrlsFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardUrlsToJson(this);
}
