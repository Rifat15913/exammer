import 'package:exammer/data/remote/model/dashboard/course/course_collection.dart';
import 'package:exammer/data/remote/model/dashboard/feedback/feedback.dart';
import 'package:exammer/data/remote/model/dashboard/url/url.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DashboardData {
  @JsonKey(defaultValue: [])
  late List<Feedback> feedbacks;

  @JsonKey(defaultValue: null)
  late DashboardUrls url;

  @JsonKey(defaultValue: null)
  late CourseCollection courses;

  DashboardData();

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);
}
