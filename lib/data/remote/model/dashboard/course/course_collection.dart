import 'package:exammer/data/remote/model/dashboard/course/data/course_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_collection.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CourseCollection {
  @JsonKey(defaultValue: [])
  late List<CourseData> trending;

  @JsonKey(defaultValue: [])
  late List<CourseData> experts;

  CourseCollection();

  factory CourseCollection.fromJson(Map<String, dynamic> json) =>
      _$CourseCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCollectionToJson(this);
}
